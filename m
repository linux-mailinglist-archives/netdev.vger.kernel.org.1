Return-Path: <netdev+bounces-199468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30715AE0673
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5168D3A6D3F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73520225408;
	Thu, 19 Jun 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OolaYUpv"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3C21421F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338148; cv=none; b=X+FSmkVgy2juPpkzX1t+rUTBlMJCJuW4R2G4Eh49jNQSq/lX8K6YPhTZDpW2Y8UsqJuGStJtVxIFFnxgBQB16MIjAUggcHPrXw+C/GiuYnwufPsWAbovn9c/i0j7IHs37y0NX/1GeMq49uaXdl9XuabnSFkhJAVRyHcO6Pxt/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338148; c=relaxed/simple;
	bh=eZMzhthG7v0kVN7foQixUTLeTkvgxd3BLRUYRuYNQX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlqqSWoN8tZXJ6YOa1MQXz4F0Z2aYCAsK/eHW5qnaCx2Ht/3X5y09mvUdYinvoWiGUr49JoqK4kPnIyCeMaOAB/dq8C0HkZo9m9mM1OppC8jx7FBbOJSAqdw421pzCDSt7TCXmm28n2f7ZaMn8H5/XwSkku3VW7VZteH4rsLdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OolaYUpv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <decb802a-7327-4a9a-8a4a-74970474f42c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750338144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jZ8WdhZHaOyA1DYGMlXylsEBW858kdyzukOT/0m8kA=;
	b=OolaYUpvX+smaXce0nznD40UC2Ljr0P7nfRz66KggSrhUK/9tCXbsr9jtiaiCXKemodskd
	8Bp2CQhqnbKi/cdQS+wfw1QZyAnicAgAdIUjt1CRbUcAV3yyuZ8eKgY6Zn9L1L40Y6pBB4
	zNc2wBt/TaVrSCunhfYZiKpnNAN/grk=
Date: Thu, 19 Jun 2025 14:02:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 06/10] bng_en: Add backing store support
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-7-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-7-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Backing store or context memory on the host helps the
> device to manage rings, stats and other resources.
> Context memory is allocated with the help of ring
> alloc/free functions.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/bnge.h     |  18 +
>   .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 168 +++++++++
>   .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   4 +
>   .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 337 ++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_rmem.h    | 153 ++++++++
>   5 files changed, 680 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index 60af0517c45e..01f64a10729c 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -9,6 +9,7 @@
>   
>   #include <linux/etherdevice.h>
>   #include "../bnxt/bnxt_hsi.h"
> +#include "bnge_rmem.h"
>   
>   #define DRV_VER_MAJ	1
>   #define DRV_VER_MIN	15
> @@ -52,6 +53,13 @@ enum {
>   	BNGE_FW_CAP_VNIC_RE_FLUSH			= BIT_ULL(26),
>   };
>   
> +enum {
> +	BNGE_EN_ROCE_V1					= BIT_ULL(0),
> +	BNGE_EN_ROCE_V2					= BIT_ULL(1),
> +};
> +
> +#define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
> +
>   struct bnge_dev {
>   	struct device	*dev;
>   	struct pci_dev	*pdev;
> @@ -89,6 +97,16 @@ struct bnge_dev {
>   #define BNGE_STATE_DRV_REGISTERED      0
>   
>   	u64			fw_cap;
> +
> +	/* Backing stores */
> +	struct bnge_ctx_mem_info	*ctx;
> +
> +	u64			flags;
>   };
>   
> +static inline bool bnge_is_roce_en(struct bnge_dev *bd)
> +{
> +	return bd->flags & BNGE_EN_ROCE;
> +}
> +
>   #endif /* _BNGE_H_ */
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index 567376a407df..e5f32ac8a69f 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -10,6 +10,7 @@
>   #include "../bnxt/bnxt_hsi.h"
>   #include "bnge_hwrm.h"
>   #include "bnge_hwrm_lib.h"
> +#include "bnge_rmem.h"
>   
>   int bnge_hwrm_ver_get(struct bnge_dev *bd)
>   {
> @@ -211,3 +212,170 @@ int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd)
>   		return rc;
>   	return hwrm_req_send(bd, req);
>   }
> +
> +static void bnge_init_ctx_initializer(struct bnge_ctx_mem_type *ctxm,
> +				      u8 init_val, u8 init_offset,
> +				      bool init_mask_set)
> +{
> +	ctxm->init_value = init_val;
> +	ctxm->init_offset = BNGE_CTX_INIT_INVALID_OFFSET;
> +	if (init_mask_set)
> +		ctxm->init_offset = init_offset * 4;
> +	else
> +		ctxm->init_value = 0;
> +}
> +
> +static int bnge_alloc_all_ctx_pg_info(struct bnge_dev *bd, int ctx_max)
> +{
> +	struct bnge_ctx_mem_info *ctx = bd->ctx;
> +	u16 type;
> +
> +	for (type = 0; type < ctx_max; type++) {
> +		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
> +		int n = 1;
> +
> +		if (!ctxm->max_entries)
> +			continue;
> +
> +		if (ctxm->instance_bmap)
> +			n = hweight32(ctxm->instance_bmap);
> +		ctxm->pg_info = kcalloc(n, sizeof(*ctxm->pg_info), GFP_KERNEL);
> +		if (!ctxm->pg_info)
> +			return -ENOMEM;

It's a bit hard to be absolutely sure without full chain of calls, but
it looks like some of the memory can be leaked in case of allocation
fail. Direct callers do not clear allocated contextes in the error path.

> +	}
> +
> +	return 0;
> +}
> +

