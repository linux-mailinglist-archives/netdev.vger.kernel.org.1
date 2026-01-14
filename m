Return-Path: <netdev+bounces-249762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BEFD1D3FE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52F7E3008753
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0537F8B7;
	Wed, 14 Jan 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="riZk/AC7"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9237F75A;
	Wed, 14 Jan 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380689; cv=none; b=hq1dYHjGfMk/4cytURT2M2tglgFhduc+GJbp1l9vO3QWSNMPy03CRQdty8BXiMU24VFx2z2wXF7tjpZvoCWyF0SpIaWHC3QAvi815GnKHmw6tpMkQ1NYWyzmOfw3WTcxTorywDja4OIZgC8op5rXQGrzkiVihs2E4Taj/HNQK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380689; c=relaxed/simple;
	bh=ckAHCtX4z9qVXj2exEVsLwWtteiUpbA7MbHIaXQZHh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqWYeIm3BUXDRx1LXjeNS2JWQvCeL8oQEoZqK56zXt1pg+krCQPSsJg7qi4HgzNZNvRp2QaKs0CH7YFD8UBhvUwIwjiTP4GAiK+ML0NmSLrXkQW3dHQbmMUk4P65wPWaYY5VGo5ZkI8fe4pWSHbSJLdoPE7L0E5aTj5p3EKIi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=riZk/AC7; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=By3yw5t159xs4JBTSYSDV8WJ7v4eKZ4OTI4enesKBlg=;
	b=riZk/AC7lC1oJy6v6vexPqOAq2lwm+G6BirVpt2N38iKATc4Is4CDehL+1hIc1vu8bB1oOuRi
	ig39CAz8ObsirwpyuUIr/5a2BFllMlZCl/2knkH5kLoSi3U3yEr1HPWufj/rsSJYT0WTbFwdupd
	DpcS1JmcDrWMf8BP/pLuXdU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4drfrr2DcMz1K96v;
	Wed, 14 Jan 2026 16:47:56 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CB6C840565;
	Wed, 14 Jan 2026 16:51:13 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 16:51:12 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <marco.crivellari@suse.com>
CC: <andrew+netdev@lunn.ch>, <bigeasy@linutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <frederic@kernel.org>, <gongfan1@huawei.com>,
	<jiangshanlai@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<mhocko@suse.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tj@kernel.org>
Subject: Re: [PATCH] hinic3: add WQ_PERCPU to alloc_workqueue users
Date: Wed, 14 Jan 2026 16:51:08 +0800
Message-ID: <20260114085108.2361-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260113151433.257320-1-marco.crivellari@suse.com>
References: <20260113151433.257320-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

>  drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c   | 2 +-
>  drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
> index 01686472985b..1ecc2aca1e35 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
> @@ -655,7 +655,7 @@ int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
>  	hwdev->aeqs = aeqs;
>  	aeqs->hwdev = hwdev;
>  	aeqs->num_aeqs = num_aeqs;
> -	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM,
> +	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
>  				      HINIC3_MAX_AEQS);
>  	if (!aeqs->workq) {
>  		dev_err(hwdev->dev, "Failed to initialize aeq workqueue\n");
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> index 95a213133be9..3696ab3f1a1b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> @@ -472,7 +472,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
>  		goto err_free_hwdev;
>  	}
>  
> -	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM,
> +	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
>  				       HINIC3_WQ_MAX_REQ);
>  	if (!hwdev->workq) {
>  		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");

Thanks for your change.

Reviewed-by: Fan Gong <gongfan1@huawei.com>

