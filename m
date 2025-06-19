Return-Path: <netdev+bounces-199490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E97AE0818
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C2717911B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3C28B40D;
	Thu, 19 Jun 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2HxNJ/Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB327FB0D;
	Thu, 19 Jun 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341488; cv=none; b=okOoq/7Q7RaDeuYtF6EZ6YJKLA4ZRvqIOJNz2ER4CTnWb1PmEm63Fvu5cXZqeRw7IasaWJXJJEhpd5UjP0KlWmXaK3G7X6/a2mpjH2/NDaWL16gOzjJU5MZpx/P/dYVabE7urENsLd7JVAgMuFVnuZdVWbAEeC5USnXRV4rWvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341488; c=relaxed/simple;
	bh=51tEkTYlIRjDqvVQ6pMecWySb1QTpaujgIcrSO6Od6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFNIX7lqlAkeZcH/kPCKhTta+Ija6jbjxk3XSLeKTg+U1Yo6wAJ8uSzfkm3+47Jgc3WnTLdh+hMZOahMpSdBNonruCOFoq5yRSBZ7+CqWVIhFaw7s+zHB1xRVbtukA6Rq93xxfh++0tDWer56csJVyE6xVmGEZ6mZccJMx1WJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2HxNJ/Q; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <018346fd-3a7c-4cb2-8456-61a03ee435b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750341483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0RazkvfCndL6C37pQiQrqBGLLNsGH9XpNPBc5PPnp4=;
	b=B2HxNJ/Q2tTjZxduUSxgo9di4Zydr1YCyel2taluhjKlRzO5k7Zox+FjsvZ9pZ/gtTFzvV
	FI7T2wzYOfC16k81Wu2G9SDtj5E26wVpSFLj00v6e30zD6Q6FIx58CrbGlnS3M5UzKAafl
	t6TPIg1dIOEnl81Tk2utcwT/TGpLmjg=
Date: Thu, 19 Jun 2025 14:57:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 09/10] bng_en: Initialize default configuration
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-10-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-10-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Query resources from the firmware and, based on the
> availability of resources, initialize the default
> settings. The default settings include:
> 1. Rings and other resource reservations with the
> firmware. This ensures that resources are reserved
> before network and auxiliary devices are created.
> 2. Mapping the BAR, which helps access doorbells since
> its size is known after querying the firmware.
> 3. Retrieving the TCs and hardware CoS queue mappings.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---

[...]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index 577ac5dcdd9b..ffdec285948e 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -647,3 +647,57 @@ int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd)
>   
>   	return rc;
>   }
> +
> +#define BNGE_CNPQ(q_profile)	\
> +		((q_profile) ==	\
> +		 QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSY_ROCE_CNP)
> +
> +int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
> +{
> +	struct hwrm_queue_qportcfg_output *resp;
> +	struct hwrm_queue_qportcfg_input *req;
> +	u8 i, j, *qptr;
> +	bool no_rdma;
> +	int rc = 0;

The initialization is not needed. The very next line re-assigns the
value of rc.

> +
> +	rc = hwrm_req_init(bd, req, HWRM_QUEUE_QPORTCFG);
> +	if (rc)
> +		return rc;
> +
> +	resp = hwrm_req_hold(bd, req);
> +	rc = hwrm_req_send(bd, req);
> +	if (rc)
> +		goto qportcfg_exit;
> +
> +	if (!resp->max_configurable_queues) {
> +		rc = -EINVAL;
> +		goto qportcfg_exit;
> +	}
> +	bd->max_tc = resp->max_configurable_queues;
> +	bd->max_lltc = resp->max_configurable_lossless_queues;
> +	if (bd->max_tc > BNGE_MAX_QUEUE)
> +		bd->max_tc = BNGE_MAX_QUEUE;
> +
> +	no_rdma = !bnge_is_roce_en(bd);
> +	qptr = &resp->queue_id0;
> +	for (i = 0, j = 0; i < bd->max_tc; i++) {
> +		bd->q_info[j].queue_id = *qptr;
> +		bd->q_ids[i] = *qptr++;
> +		bd->q_info[j].queue_profile = *qptr++;
> +		bd->tc_to_qidx[j] = j;
> +		if (!BNGE_CNPQ(bd->q_info[j].queue_profile) || no_rdma)
> +			j++;
> +	}
> +	bd->max_q = bd->max_tc;
> +	bd->max_tc = max_t(u8, j, 1);
> +
> +	if (resp->queue_cfg_info & QUEUE_QPORTCFG_RESP_QUEUE_CFG_INFO_ASYM_CFG)
> +		bd->max_tc = 1;
> +
> +	if (bd->max_lltc > bd->max_tc)
> +		bd->max_lltc = bd->max_tc;
> +
> +qportcfg_exit:
> +	hwrm_req_drop(bd, req);
> +	return rc;
> +}

[...]

