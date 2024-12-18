Return-Path: <netdev+bounces-152924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1E9F656C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C79D16DF75
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42E1A0AE1;
	Wed, 18 Dec 2024 11:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B919F422;
	Wed, 18 Dec 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523092; cv=none; b=NugkAKuUN3jdBAYzvrLe0FDs9SZFrJu58QJWKtT07Ji08xUAhCYadm048y+cMX7vbURo+JGruuSqgkun2OphaCoAW6RdDK4OllDRVNBRukQytgYWOaxB6YlSFZ3tAS/QbPy9LBbWsTMR59vwEtKPXBNQOA6Ty3iGadBQNQjf3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523092; c=relaxed/simple;
	bh=EAnyg44bc5X50AIbEYTrPKtqShTc5lDAgEa+nBxLaGo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tqQUuSfaOy3f37HLmX5BkmzLnLwqRO0rkEY1KUK0Bo6kNHVUGztSvTKe3BPmIedZFFygJyeSdjmAVcmzeRhziUhbUd3jfLhLabM+kdGooNMlZzYnBne8f7alv7JmeRPdqSNdmD+Q+qa77u7x5dn4qJ3byuaaupKvdu+8/xlhdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YCsZC48XGz2DjBs;
	Wed, 18 Dec 2024 19:55:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5485F140391;
	Wed, 18 Dec 2024 19:58:06 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Dec 2024 19:58:05 +0800
Message-ID: <c12c521e-a47c-46a0-ac1d-ff669c24605b@huawei.com>
Date: Wed, 18 Dec 2024 19:58:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: hisilicon: hns: Remove unused
 hns_rcb_start
To: <linux@treblig.org>, <salil.mehta@huawei.com>, <shenjian15@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20241218005729.244987-1-linux@treblig.org>
 <20241218005729.244987-3-linux@treblig.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241218005729.244987-3-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/18 8:57, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> hns_rcb_start() has been unused since 2016's
> commit 454784d85de3 ("net: hns: delete redundancy ring enable operations")
>
> Remove it.

Thanks,
Reviewed-by: Jijie Shao<shaojijie@huawei.com>

>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 5 -----
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 1 -
>   2 files changed, 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> index 46af467aa596..635b3a95dd82 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> @@ -195,11 +195,6 @@ void hns_rcb_ring_enable_hw(struct hnae_queue *q, u32 val)
>   	dsaf_write_dev(q, RCB_RING_PREFETCH_EN_REG, !!val);
>   }
>   
> -void hns_rcb_start(struct hnae_queue *q, u32 val)
> -{
> -	hns_rcb_ring_enable_hw(q, val);
> -}
> -
>   /**
>    *hns_rcb_common_init_commit_hw - make rcb common init completed
>    *@rcb_common: rcb common device
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> index 0f4cc184ef39..68f81547dfb4 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> @@ -116,7 +116,6 @@ int hns_rcb_buf_size2type(u32 buf_size);
>   int hns_rcb_common_get_cfg(struct dsaf_device *dsaf_dev, int comm_index);
>   void hns_rcb_common_free_cfg(struct dsaf_device *dsaf_dev, u32 comm_index);
>   int hns_rcb_common_init_hw(struct rcb_common_cb *rcb_common);
> -void hns_rcb_start(struct hnae_queue *q, u32 val);
>   int hns_rcb_get_cfg(struct rcb_common_cb *rcb_common);
>   void hns_rcb_get_queue_mode(enum dsaf_mode dsaf_mode,
>   			    u16 *max_vfn, u16 *max_q_per_vf);

