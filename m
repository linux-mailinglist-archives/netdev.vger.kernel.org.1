Return-Path: <netdev+bounces-144521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E049C7AA1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C352A1F2314E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB0201113;
	Wed, 13 Nov 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KR6hJsPO"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DE13CFBD
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520993; cv=none; b=Sk9SQyVSpEa3uQ5NnImxojCJIVIYNUsT+aGLo4pP/GcPK8BqibpyA5vclzEFDVfzcnx5412auEsJ/XoFeaarXh63d5zpKBaOR46Uv+G2mGtGybILhBjze5LBV6RmCcQdhaQrJzey1YQrsrprcMW39WwdZ7brw18zg41Goq8i7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520993; c=relaxed/simple;
	bh=2KYJSFZa2rkc4gUH/rB7zZ4YQG91sa9Zmc5etZOr//o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smb1Wkpa8NWcBpnOJZuvKFscdABmEBnV4Gy/iXZioJJWHNnVJEgDkM3KCWcM1rp0+Sa3f2vdwLlXVeNKoBYfYmSPsGO0qPS8rZSXP1q8LriWj3NK9sP0TyMkbo09+WxOFXitgM9V2dkWXweP/fxN1mu57RQYUQl3wPpWMNT7f24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KR6hJsPO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fec1ffc1-fae0-42b4-bbfc-0f034f020a52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731520988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PeLvqN3htdekg2b59KDDI4eZUFyY4TFDpxUYC3B1m4=;
	b=KR6hJsPOkitNngE0RFwLfnLlBpS6jgwAiDhOURav89u5hqTfJkqxZ2cqRTmFV/A9xfJygp
	3qX8gjERAW2wvZANpv09o9rRs5x4pyTcosjO8NuIG/A8eqCyZXmW8y5QdarwVA4Uhd3vYF
	12cLGoldtbnfAW9ti3pV4ihRXzqTq8w=
Date: Wed, 13 Nov 2024 18:02:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 6/7] octeon_ep_vf: add protective null checks in
 napi callbacks for cn9k cards
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-7-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113111319.1156507-7-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 11:13, Shinas Rasheed wrote:
> During unload, at times the OQ parsed in the napi callbacks
> have been observed to be null, causing system crash.
> Add protective checks to avoid the same, for cn9k cards.
> 
> Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - No changes
> 
> V3: https://lore.kernel.org/all/20241108074543.1123036-7-srasheed@marvell.com/
>    - Added back "Fixes" to the changelist
> 
> V2: https://lore.kernel.org/all/20241107132846.1118835-7-srasheed@marvell.com/
>    - Split into a separate patch
>    - Added more context
> 
> V1: https://lore.kernel.org/all/20241101103416.1064930-4-srasheed@marvell.com/
> 
>   drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> index 88937fce75f1..f1b7eda3fa42 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
> @@ -273,8 +273,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
>   	struct octep_vf_oq *oq;
>   	u64 reg_val;
>   
> -	oct = vector->octep_vf_dev;
> +	if (!vector)
> +		return IRQ_HANDLED;

And again, this function is irq handler, which is
called from octep_vf_ioq_intr_handler() only if ioq_vector was properly
resolved. This check makes no sense here.

The same goes to the next patch.

> +
>   	oq = vector->oq;
> +	if (!oq)
> +		return IRQ_HANDLED;
> +
> +	oct = vector->octep_vf_dev;
>   	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
>   	if (oq->q_no == 0) {
>   		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0));


