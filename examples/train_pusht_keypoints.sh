#!/bin/bash 

export PYTHONPATH=.
export HYDRA_FULL_ERROR=1

export MUJOCO_GL=glfw
JOB_NAME=tdmpc_pusht_kp

python lerobot/scripts/train.py \
    hydra.job.name=$JOB_NAME \
    hydra.run.dir=outputs/train/$(date +'%Y-%m-%d/%H-%M-%S')_${JOB_NAME} \
    env=pusht \
    env.gym.obs_type=environment_state_agent_pos \
    policy=tdmpc_pusht_keypoints \
    training.log_freq=1 \
    training.eval_freq=10000 \
    training.offline_steps=0 \
    training.online_steps=1000000 \
    training.online_rollout_n_episodes=10 \
    training.online_rollout_batch_size=10 \
    training.online_steps_between_rollouts=1000 \
    training.online_buffer_capacity=40000 \
    training.online_buffer_seed_size=0 \
    training.online_sampling_ratio=1.0 \
    training.do_online_rollout_async=false  \
    training.save_freq=50000 \
    training.save_checkpoint=true \
    training.num_workers=1 \
    eval.batch_size=50 \
    eval.n_episodes=50 \
    eval.use_async_envs=false \
    device=mps \
    use_amp=true \
    wandb.enable=false \
    wandb.disable_artifact=true \
    resume=false
