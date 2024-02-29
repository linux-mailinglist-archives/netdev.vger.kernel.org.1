Return-Path: <netdev+bounces-76098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00086C513
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E381F21C8D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB045B5D8;
	Thu, 29 Feb 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ra1/njjT"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFF5A103
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198852; cv=none; b=LIFzwOmVdDF8KZrhIjIrLwsRvjIYoFe1vEehl7VfFCNvZ3yRgUSMmCTGXtzbecPKet331YRTp9jAn6HS/DJiCGUpsrSUBpQLvkaBQJmWC0MOoXAgzg1BNaP1s9TQu+ozuxROysGGpSgbAYIpdso3gWWmliwU51OXunxJvineLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198852; c=relaxed/simple;
	bh=0SPq13OgUipRfdOPYl+SKSbQna1CNgdVmEQ5Vo5gwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8NvSxEA/Q41OUblTO6HCpVUFABJzFNes2rYrRo5eHRbW8E/qqu/J6U/nkr4ognLoz8TDZavP2MznNaxHxxFBNYeBsbtPf38oxaty+K+GZdqTkr3BwLCSHF7MpZ1BvOIM2qEdT7nGHLhpR/MzzWw6ufVqc3AqQ32M6zUdXv9T6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ra1/njjT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66cb6a54-8735-4f67-9aff-0048156e0902@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709198848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edbtz+f6tlHV/vi1hnDkS0KKS0V7t22PYAY0szn92QM=;
	b=ra1/njjT/cLnWurWgFPkt23hlSY+uFOkePCnkShKzuf8UNh8mpndd37j4CLKpAsazhDzqz
	Qn5f1dcvYbJMZQT+PRhEfW4NbpS+57wFR/udblXzYPfIarCLFlu83S86hX80C9SzJLZSzY
	aOJRKGSd98Zeiwdhxx6wcodI31FNaxI=
Date: Thu, 29 Feb 2024 09:27:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 andrew.gospodarek@broadcom.com, jiri@resnulli.us, richardcochran@gmail.com
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240229070202.107488-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/02/2024 07:02, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Sometimes, the current 1ms value that driver waits for firmware
> to obtain a tx timestamp for a PTP packet may not be sufficient.
> User may want the driver to wait for a longer custom period before
> timing out.
> 
> Introduce a new runtime driver param for devlink "ptp_tx_timeout".
> Using this parameter the driver can wait for up to the specified
> time, when it is querying for a TX timestamp from firmware.  By
> default the value is set to 1s.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 42 +++++++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  1 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  3 ++
>   3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index ae4529c043f0..0df0baa9d18c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -652,6 +652,7 @@ static const struct devlink_ops bnxt_vf_dl_ops;
>   enum bnxt_dl_param_id {
>   	BNXT_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>   	BNXT_DEVLINK_PARAM_ID_GRE_VER_CHECK,
> +	BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
>   };
>   
>   static const struct bnxt_dl_nvm_param nvm_params[] = {
> @@ -1077,6 +1078,42 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
>   	return rc;
>   }
>   
> +static int bnxt_dl_ptp_param_get(struct devlink *dl, u32 id,
> +				 struct devlink_param_gset_ctx *ctx)
> +{
> +	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
> +
> +	if (!bp->ptp_cfg)
> +		return -EOPNOTSUPP;
> +
> +	ctx->val.vu32 = bp->ptp_cfg->txts_tmo;
> +	return 0;
> +}
> +
> +static int bnxt_dl_ptp_param_set(struct devlink *dl, u32 id,
> +				 struct devlink_param_gset_ctx *ctx)
> +{
> +	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
> +
> +	if (!bp->ptp_cfg)
> +		return -EOPNOTSUPP;
> +
> +	bp->ptp_cfg->txts_tmo = ctx->val.vu32;
> +	return 0;
> +}
> +
> +static int bnxt_dl_ptp_param_validate(struct devlink *dl, u32 id,
> +				      union devlink_param_value val,
> +				      struct netlink_ext_ack *extack)
> +{
> +	if (val.vu32 > BNXT_PTP_MAX_TX_TMO) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "TX timeout value exceeds the maximum (%d ms)",
> +				       BNXT_PTP_MAX_TX_TMO);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
>   				 struct devlink_param_gset_ctx *ctx)
>   {
> @@ -1180,6 +1217,11 @@ static const struct devlink_param bnxt_dl_params[] = {
>   			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>   			     bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
>   			     NULL),
> +	DEVLINK_PARAM_DRIVER(BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
> +			     "ptp_tx_timeout", DEVLINK_PARAM_TYPE_U32,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     bnxt_dl_ptp_param_get, bnxt_dl_ptp_param_set,
> +			     bnxt_dl_ptp_param_validate),
>   	/* keep REMOTE_DEV_RESET last, it is excluded based on caps */
>   	DEVLINK_PARAM_GENERIC(ENABLE_REMOTE_DEV_RESET,
>   			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> index cc07660330f5..4b50b07b9771 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -965,6 +965,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
>   		spin_unlock_bh(&ptp->ptp_lock);
>   		ptp_schedule_worker(ptp->ptp_clock, 0);
>   	}
> +	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
>   	return 0;
>   
>   out:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> index fce8dc39a7d0..ee977620d33e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> @@ -22,6 +22,8 @@
>   #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
>   #define BNXT_HI_TIMER_MASK	0xffff00000000UL
>   
> +#define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */

I'm not happy with such huge timeout, but looks like other vendors do
expect the same timeouts, I'm ok.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> +#define BNXT_PTP_MAX_TX_TMO	5000 /* ms */
>   #define BNXT_PTP_QTS_TIMEOUT	1000
>   #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
>   				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
> @@ -120,6 +122,7 @@ struct bnxt_ptp_cfg {
>   
>   	u32			refclk_regs[2];
>   	u32			refclk_mapped_regs[2];
> +	u32			txts_tmo;
>   };
>   
>   #if BITS_PER_LONG == 32


