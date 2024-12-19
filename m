Return-Path: <netdev+bounces-153337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8E9F7B4C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DDB169719
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA81224AE2;
	Thu, 19 Dec 2024 12:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26B2248AC;
	Thu, 19 Dec 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611409; cv=none; b=TYdCiFJBBEN6Evq33w7lztqFpmr6Dlr6oDBN91M5VCNYzbYCN5XTyb+8d0Jah7iDWNCf2b/LIuxJXZTnnnMl0PL4prh9c9L3sjVyHcEtceUnfyIVSncSJ685IE2MySeD13OG51DV8QZ2ot3fzaNvCpAbnIAnXK5faDfKI8gt06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611409; c=relaxed/simple;
	bh=U0odsYw1Ce7tVoBc6QflHBSzxDVw7Swh/FxE+OlLt64=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AyA1UKZi0by2xtQlSWKeSBc1esWfKZM38N0UTgHat6Ux6bR+frmpsmd/Nbs0e7hRCrb4SKvSucgKXsv7ZM1XXziWvt+5p5l4NXhcnae+dbDJDSBp5/E9MTC5vEBsr9lM1t7ZQeHBOZRwOa+FRMQT2pKLvmqFZditZuSsmJWauu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YDVH749Lcz1JFnH;
	Thu, 19 Dec 2024 20:29:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6790C140202;
	Thu, 19 Dec 2024 20:30:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 20:30:02 +0800
Message-ID: <fa410af0-e4b0-4199-8f2a-960399e54d82@huawei.com>
Date: Thu, 19 Dec 2024 20:30:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] net: hisilicon: hns: Remove unused enums
To: <linux@treblig.org>, <salil.mehta@huawei.com>, <shenjian15@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20241218163341.40297-1-linux@treblig.org>
 <20241218163341.40297-5-linux@treblig.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241218163341.40297-5-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/19 0:33, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The enums dsaf_roce_port_mode, dsaf_roce_port_num and dsaf_roce_qos_sl
> are unused after the removal of the reset code.
>
> Remove them.

Thanks,

Reviewed-by: Jijie Shao<shaojijie@huawei.com>


>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../ethernet/hisilicon/hns/hns_dsaf_main.h    | 23 -------------------
>   1 file changed, 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> index bb8267aafc43..653dfbb25d1b 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> @@ -42,29 +42,6 @@ struct hns_mac_cb;
>   
>   #define HNS_MAX_WAIT_CNT 10000
>   
> -enum dsaf_roce_port_mode {
> -	DSAF_ROCE_6PORT_MODE,
> -	DSAF_ROCE_4PORT_MODE,
> -	DSAF_ROCE_2PORT_MODE,
> -	DSAF_ROCE_CHAN_MODE_NUM,
> -};
> -
> -enum dsaf_roce_port_num {
> -	DSAF_ROCE_PORT_0,
> -	DSAF_ROCE_PORT_1,
> -	DSAF_ROCE_PORT_2,
> -	DSAF_ROCE_PORT_3,
> -	DSAF_ROCE_PORT_4,
> -	DSAF_ROCE_PORT_5,
> -};
> -
> -enum dsaf_roce_qos_sl {
> -	DSAF_ROCE_SL_0,
> -	DSAF_ROCE_SL_1,
> -	DSAF_ROCE_SL_2,
> -	DSAF_ROCE_SL_3,
> -};
> -
>   #define DSAF_STATS_READ(p, offset) (*((u64 *)((u8 *)(p) + (offset))))
>   #define HNS_DSAF_IS_DEBUG(dev) ((dev)->dsaf_mode == DSAF_MODE_DISABLE_SP)
>   

