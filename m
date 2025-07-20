Return-Path: <netdev+bounces-208435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF1B0B698
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ABF1899F7A
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AB20E71C;
	Sun, 20 Jul 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q+0+oRmv"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED31F1905
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024389; cv=none; b=JYB089qgSy5OXgvgZ4OzY8q0tvmDBb1sHgc63sfU1nAv5K4v1RINcz1IsV+eLXkrHrZiksQp4cIJ1aYInB8eOuq9iD3b8W7E/cToKXfyceHpeCDH/TdY5PvRjYEWENZ06nAj8HqlVz67IUA1Gpz3/BZ+1T37C8peAg/jhdiV0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024389; c=relaxed/simple;
	bh=j+5PipX2uCp1eQ3zPCHGPX+iKYWA/MlPZh0y17TYziw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EaubNuYX8Dsuc5bd5wduqBYGU07NVHfNrQiq+0m2NB/fYw8fSipN/JHI9b5ngO7QNA4N6IzYeN1F4yqyeex793ZnzRPT7OS8A0Ks/dOQ29YpZ4Kj026pfECJ/eJipfEwjtx0NuT9p6NiCObEgA3TZ3b8RCw0VMEInga/tZoxCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q+0+oRmv; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <905996ee-9901-4419-b545-35ea9027044c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753024374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdTEk5k6r7pnAKdegfuyWpMNe4/g5VNDoAD++Q+QfD4=;
	b=Q+0+oRmvpvwTjtzPozpTVd94LWQ9fUyizpQP95Kk2tg8T+EAVNx1IjbY+8Ya95c7bvYR/a
	c06VzoPXH6D7t4SIMhPpwatPwVA65HcWkAZg3okyVYDgO4rOQrrqkj0h10oX+5wFUKfio5
	77nXRCwTp7QjQLP/hl1pUbR/4xlPg5w=
Date: Sun, 20 Jul 2025 08:12:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 rdma-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Tariq Toukan <ttoukan.linux@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250711030359.4419-1-yanjun.zhu@linux.dev>
 <00c14908-a7d1-4832-a4bb-2a42dd55e602@linux.dev>
 <86099d0a-4a21-4854-a426-210caf534c0e@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <86099d0a-4a21-4854-a426-210caf534c0e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/7/20 3:07, Tariq Toukan 写道:
>
>
> On 18/07/2025 7:19, Zhu Yanjun wrote:
>> Gently ping
>>
>> Zhu Yanjun
>>
>> 在 2025/7/10 20:03, Zhu Yanjun 写道:
>>> When building, the following warnings will appear.
>>> "
>>> pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
>>> pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger 
>>> than 1024 bytes [-Wframe-larger-than=]
>>>
>>> pci_irq.c: In function ‘mlx5_irq_request_vector’:
>>> pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger 
>>> than 1024 bytes [-Wframe-larger-than=]
>>>
>>> eq.c: In function ‘comp_irq_request_sf’:
>>> eq.c:897:1: warning: the frame size of 1080 bytes is larger than 
>>> 1024 bytes [-Wframe-larger-than=]
>>>
>>> irq_affinity.c: In function ‘irq_pool_request_irq’:
>>> irq_affinity.c:74:1: warning: the frame size of 1048 bytes is larger 
>>> than 1024 bytes [-Wframe-larger-than=]
>>> "
>>>
>>> These warnings indicate that the stack frame size exceeds 1024 bytes in
>>> these functions.
>>>
>>> To resolve this, instead of allocating large memory buffers on the 
>>> stack,
>>> it is better to use kvzalloc to allocate memory dynamically on the 
>>> heap.
>>> This approach reduces stack usage and eliminates these frame size 
>>> warnings.
>>>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>> v1 -> v2: Add kvfree to error handler;
>>>
>>> 1. This commit only build tests;
>>> 2. All the changes are on configuration path, will not make difference
>>> on the performance;
>>> 3. This commit is just to fix build warnings, not error or bug 
>>> fixes. So
>>> not Fixes tag.
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 24 +++++++----
>>>   .../mellanox/mlx5/core/irq_affinity.c         | 19 +++++++--
>>>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 
>>> +++++++++++++------
>>>   3 files changed, 60 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/ 
>>> net/ethernet/mellanox/mlx5/core/eq.c
>>> index dfb079e59d85..4938dd7c3a09 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>>> @@ -873,19 +873,29 @@ static int comp_irq_request_sf(struct 
>>> mlx5_core_dev *dev, u16 vecidx)
>>>   {
>>>       struct mlx5_irq_pool *pool = 
>>> mlx5_irq_table_get_comp_irq_pool(dev);
>>>       struct mlx5_eq_table *table = dev->priv.eq_table;
>>> -    struct irq_affinity_desc af_desc = {};
>>> +    struct irq_affinity_desc *af_desc;
>>>       struct mlx5_irq *irq;
>>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>>> +    if (!af_desc)
>>> +        return -ENOMEM;
>>> +
>>>       /* In case SF irq pool does not exist, fallback to the PF irqs*/
>>> -    if (!mlx5_irq_pool_is_sf_pool(pool))
>>> +    if (!mlx5_irq_pool_is_sf_pool(pool)) {
>>> +        kvfree(af_desc);
>>>           return comp_irq_request_pci(dev, vecidx);
>>> +    }
>>> -    af_desc.is_managed = false;
>>> -    cpumask_copy(&af_desc.mask, cpu_online_mask);
>>> -    cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
>>> -    irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
>>> -    if (IS_ERR(irq))
>>> +    af_desc->is_managed = false;
>>> +    cpumask_copy(&af_desc->mask, cpu_online_mask);
>>> +    cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
>>> +    irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>>> +    if (IS_ERR(irq)) {
>>> +        kvfree(af_desc);
>>>           return PTR_ERR(irq);
>>> +    }
>>> +
>>> +    kvfree(af_desc);
>>>       cpumask_or(&table->used_cpus, &table->used_cpus, 
>>> mlx5_irq_get_affinity_mask(irq));
>>>       mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs 
>>> on this irq\n",
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c 
>>> b/ drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>>> index 2691d88cdee1..82d3c2568244 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>>> @@ -47,29 +47,40 @@ static int cpu_get_least_loaded(struct 
>>> mlx5_irq_pool *pool,
>>>   static struct mlx5_irq *
>>>   irq_pool_request_irq(struct mlx5_irq_pool *pool, struct 
>>> irq_affinity_desc *af_desc)
>>>   {
>>> -    struct irq_affinity_desc auto_desc = {};
>>> +    struct irq_affinity_desc *auto_desc;
>>>       struct mlx5_irq *irq;
>>>       u32 irq_index;
>>>       int err;
>>> +    auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
>>> +    if (!auto_desc)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>>       err = xa_alloc(&pool->irqs, &irq_index, NULL, 
>>> pool->xa_num_irqs, GFP_KERNEL);
>>> -    if (err)
>>> +    if (err) {
>>> +        kvfree(auto_desc);
>>>           return ERR_PTR(err);
>>> +    }
>>> +
>>>       if (pool->irqs_per_cpu) {
>>>           if (cpumask_weight(&af_desc->mask) > 1)
>>>               /* if req_mask contain more then one CPU, set the 
>>> least loadad CPU
>>>                * of req_mask
>>>                */
>>>               cpumask_set_cpu(cpu_get_least_loaded(pool, 
>>> &af_desc->mask),
>>> -                    &auto_desc.mask);
>>> +                    &auto_desc->mask);
>>>           else
>>>               cpu_get(pool, cpumask_first(&af_desc->mask));
>>>       }
>>> +
>>>       irq = mlx5_irq_alloc(pool, irq_index,
>>> -                 cpumask_empty(&auto_desc.mask) ? af_desc : 
>>> &auto_desc,
>>> +                 cpumask_empty(&auto_desc->mask) ? af_desc : 
>>> auto_desc,
>>>                    NULL);
>>>       if (IS_ERR(irq))
>>>           xa_erase(&pool->irqs, irq_index);
>>> +
>>> +    kvfree(auto_desc);
>>> +
>>>       return irq;
>>>   }
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/ 
>>> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>>> index 40024cfa3099..48aad94b0a5d 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>>> @@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct 
>>> mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
>>>   struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
>>>   {
>>>       struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
>>> -    struct irq_affinity_desc af_desc;
>>> +    struct irq_affinity_desc *af_desc;
>>>       struct mlx5_irq *irq;
>>> -    cpumask_copy(&af_desc.mask, cpu_online_mask);
>>> -    af_desc.is_managed = false;
>>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>>> +    if (!af_desc)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    cpumask_copy(&af_desc->mask, cpu_online_mask);
>>> +    af_desc->is_managed = false;
>>>       if (!mlx5_irq_pool_is_sf_pool(pool)) {
>>>           /* In case we are allocating a control IRQ from a pci 
>>> device's pool.
>>>            * This can happen also for a SF if the SFs pool is empty.
>>>            */
>>>           if (!pool->xa_num_irqs.max) {
>>> -            cpumask_clear(&af_desc.mask);
>>> +            cpumask_clear(&af_desc->mask);
>>>               /* In case we only have a single IRQ for PF/VF */
>>> -            cpumask_set_cpu(cpumask_first(cpu_online_mask), 
>>> &af_desc.mask);
>>> +            cpumask_set_cpu(cpumask_first(cpu_online_mask), 
>>> &af_desc- >mask);
>>>           }
>>>           /* Allocate the IRQ in index 0. The vector was already 
>>> allocated */
>>> -        irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
>>> +        irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
>>>       } else {
>>> -        irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
>>> +        irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>>>       }
>>> +    kvfree(af_desc);
>>> +
>>>       return irq;
>>>   }
>>> @@ -548,16 +554,26 @@ struct mlx5_irq 
>>> *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
>>>   {
>>>       struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>>>       struct mlx5_irq_pool *pool = table->pcif_pool;
>>> -    struct irq_affinity_desc af_desc;
>>> +    struct irq_affinity_desc *af_desc;
>>>       int offset = MLX5_IRQ_VEC_COMP_BASE;
>>> +    struct mlx5_irq *irq;
>>> +
>>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>>> +    if (!af_desc)
>>> +        return ERR_PTR(-ENOMEM);
>>>       if (!pool->xa_num_irqs.max)
>>>           offset = 0;
>>> -    af_desc.is_managed = false;
>>> -    cpumask_clear(&af_desc.mask);
>>> -    cpumask_set_cpu(cpu, &af_desc.mask);
>>> -    return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
>>> +    af_desc->is_managed = false;
>>> +    cpumask_clear(&af_desc->mask);
>>> +    cpumask_set_cpu(cpu, &af_desc->mask);
>>> +
>>> +    irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
>>> +
>>> +    kvfree(af_desc);
>>> +
>>> +    return irq;
>>>   }
>>>   static struct mlx5_irq_pool *
>>
>>
>
> Thanks for your patch.
> You're targeting the wrong branch.
>
> For mlx5_core patches, please target net-next.

Thanks a lot. I will send out the latest patch based on net-next.

Zhu Yanjun

-- 
Best Regards,
Yanjun.Zhu


