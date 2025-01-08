#!/bin/bash 

export PYTHONPATH=`pwd`:`pwd`/../gym-so100
export DISPLAY=:0
export MUJOCO_GL=egl
export JOB_NAME=tdmpc_so100_kp

python lerobot/scripts/train.py \
    hydra.job.name=$JOB_NAME \
    hydra.run.dir=outputs/train/$(date +'%Y-%m-%d/%H-%M-%S')_${JOB_NAME} \
    env=so100 \
    env.gym.observation_mode=state \
    env.gym.render_mode=rgb_array \
    policy=tdmpc_pushcube_so100 \
    training.log_freq=1000 \
    training.eval_freq=50000 \
    training.offline_steps=0 \
    training.online_steps=100000 \
    training.online_rollout_n_episodes=200 \
    training.online_rollout_batch_size=10 \
    training.online_steps_between_rollouts=10000 \
    training.online_buffer_capacity=1000000 \
    training.online_buffer_seed_size=0 \
    training.online_sampling_ratio=1.0 \
    training.do_online_rollout_async=false \
    training.save_freq=50000 \
    training.save_checkpoint=true \
    training.num_workers=4 \
    training.batch_size=2048 \
    eval.batch_size=16 \
    eval.n_episodes=16 \
    eval.use_async_envs=true \
    device=cuda \
    use_amp=true \
    wandb.enable=true \
    wandb.disable_artifact=true \
    resume=false
