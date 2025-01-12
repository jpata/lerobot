#!/bin/bash 

export PYTHONPATH=`pwd`:`pwd`/../gym-so100
export DISPLAY=:0
export MUJOCO_GL=egl
export JOB_NAME=tdmpc_so100_$(date +'%Y-%m-%d_%H-%M-%S')_$(hostname)

#    hydra.job.name=tdmpc_so100_2025-01-10_11-07-37_joosep-desktop-work \
#    hydra.run.dir=outputs/train/tdmpc_so100_2025-01-10_11-07-37_joosep-desktop-work \
python lerobot/scripts/train.py \
    hydra.job.name=$JOB_NAME \
    hydra.run.dir=outputs/train/${JOB_NAME} \
    env=so100 \
    env.gym.observation_mode=state \
    env.gym.render_mode=rgb_array \
    policy=tdmpc_pushcube_so100 \
    training.log_freq=100 \
    training.eval_freq=1000 \
    training.offline_steps=0 \
    training.online_steps=1000000 \
    training.online_rollout_n_episodes=100 \
    training.online_rollout_batch_size=5 \
    training.online_steps_between_rollouts=1000 \
    training.online_buffer_capacity=1000000 \
    training.online_buffer_seed_size=0 \
    training.online_sampling_ratio=0.5 \
    training.do_online_rollout_async=true \
    training.save_freq=10000 \
    training.save_checkpoint=true \
    training.num_workers=8 \
    training.batch_size=1024 \
    eval.batch_size=5 \
    eval.n_episodes=20 \
    eval.use_async_envs=true \
    device=cuda \
    use_amp=true \
    wandb.enable=true \
    wandb.disable_artifact=true \
    resume=false
