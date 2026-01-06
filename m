Return-Path: <netdev+bounces-247267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F0CF6582
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CC91302FA18
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF0305976;
	Tue,  6 Jan 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSIu/08T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9C2F4A14;
	Tue,  6 Jan 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663646; cv=none; b=IlWk++OOJSlBTdHk3azihSo832OMDkLtdoNc81c4SSqps+v6PaCK0jwaEWCUr/uT538nXv/+M7f5LSy+pqvEfy4BXarYaUWo2uFnhZPAr7/7qgdCdoGBmjdT5g0bSmY+rWk5Hc/6WHuOwu0go+wktdxFPDIIFy6hd6lRwXi6sEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663646; c=relaxed/simple;
	bh=MiO0RDJKgdO1s44EJmn/1ChzLwDRt3aO6tHdyCQH5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/ncHoqgUNCmVJtQx3UYCHoOTBzs0ruz7UUauUivQHqNwD9P5i7IqMyqySaB0Vauk6vIT5uz5NkAu1HWTGVQoCAlEPm2Q89mnRaLPvuXvummCQ4WyoD5dF/Y7/SSXhJV246TTAMeZH/skaMRWKIPoUB2idjXr68d5BX0V7AdIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSIu/08T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B2C116D0;
	Tue,  6 Jan 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663646;
	bh=MiO0RDJKgdO1s44EJmn/1ChzLwDRt3aO6tHdyCQH5iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSIu/08TSKHu9TwKdJWN+ywNeeg8yoeJnEj6SdKgrHl5EVPlnHOs4nYDVnJwaz/cm
	 fefRiql+BLYjP440jzI/haiRsAKSKO4BdfeIcXQJaR/5IIJlOrzvbjgaVAk1n3CEFt
	 hpOmPvzVpcc/PVVR+QMZWO/EjOyGZR+hynGTgfBJB22jOMOQJX/oe9mT3Oxauu3t65
	 KQ5djh1hcC4ZUnPEDvuOPzD6i549cScXKQhovP8vTnjXOQPn4+sGLv8+RqzRGosujH
	 hM4m3RyzRLKvcHB8iRS63Ov8+GM/3sA4EfFLaFHFyIh4oqm7q3QWQuC6nc5/XXCx6R
	 YW0ZO3VZCk5bA==
Date: Mon, 5 Jan 2026 17:40:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v08 7/9] hinic3: Add adaptive IRQ coalescing
 with DIM
Message-ID: <20260105174044.3da6585d@kernel.org>
In-Reply-To: <4c3ebb442eacab854679702873e6b72091f78a7b.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
	<4c3ebb442eacab854679702873e6b72091f78a7b.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

AI code review points out:

> @@ -150,6 +236,9 @@ int hinic3_qps_irq_init(struct net_device *netdev)
>  			goto err_release_irqs;
>  		}
>
> +		INIT_WORK(&irq_cfg->rxq->dim.work, hinic3_rx_dim_work);
> +		irq_cfg->rxq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
> +
>  		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
>  						irq_cfg->msix_entry_idx,
>  						HINIC3_SET_MSIX_AUTO_MASK);
> @@ -164,6 +253,9 @@ int hinic3_qps_irq_init(struct net_device *netdev)
>  		q_id--;
>  		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
>  		qp_del_napi(irq_cfg);
> +
> +		disable_work_sync(&irq_cfg->rxq->dim.work);
> +
>  		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
>  				      HINIC3_MSIX_DISABLE);

The error path in hinic3_qps_irq_init() calls disable_work_sync() to cancel
the DIM work before cleanup. However, hinic3_qps_irq_uninit() does not have
a corresponding cancel_work_sync() or disable_work_sync() call.

The DIM work is scheduled via net_dim()->schedule_work() from hinic3_poll().
If the interface is closed while DIM work is pending or running,
hinic3_rx_dim_work() could access rxq->netdev and rxq->q_id after the
queues have been torn down in hinic3_close_channel()->hinic3_qps_irq_uninit().

Should hinic3_qps_irq_uninit() call cancel_work_sync() for the DIM work
to prevent a potential use-after-free?

