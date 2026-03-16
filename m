Return-Path: <netdev+bounces-268052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ8YMCm/t2n5UwEAu9opvQ
	(envelope-from <netdev+bounces-268052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:28:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD94296236
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6D9B300647A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16088372ED2;
	Mon, 16 Mar 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ER312L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC8372B5D
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649702; cv=none; b=QxCoIdj4HjE1jnBqc5GmJG+qsfFj6bQXwLQp9SNuIR/bGjWnxUB9SUQ0++gkn2zWutTsBMp9DQLDeN8inLz8s3/AV/bdGpBSwrI6Iqf6jahibuJs5WLFY4qom/+3l6scPguHyatOQm5qB+WRC1J6SPe11R2Qu3dDvyfizQXJb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649702; c=relaxed/simple;
	bh=0J3y0IVZqh1BHNCtlTy05Hxtl91NRHnn6YjIoAdL7xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRGDuQuk+BY/yUqCGI34epqsmBeoSJzSyhmVQzFXKkb7PaW1/gNUmb7qTVMID0eg1YDJGkZzE/uLTBQDRoL1pcb96NB2i9FTTy0rD/MvrIXrnhTo07KXg1vbDlg/C2jyMTUioF3+v6GBJ4i5Yy6+E6zBFz4kXCN5JZKC8ZqPkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ER312L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E20AC19421;
	Mon, 16 Mar 2026 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773649701;
	bh=0J3y0IVZqh1BHNCtlTy05Hxtl91NRHnn6YjIoAdL7xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6ER312Lpu6WqfeQN3Hp6ACP4D+61Z653Fy/SCZmCGkIcnCB8RxbGo4peX7Vk9L4E
	 mtVCWLHxSrbgL9xne/KJynM+7IaQjTSVurJ/WP1dkTEF+fnxMgSPYta6lEXSwNewuW
	 +WN+fr64viHup9tscgRz2MXS5qCcH8apJfzEJRXa9y6RjAcyaVt6kGEh9wo/U9cAvk
	 8xowXdOp6R9tH1yn5JA6wL3W3zPGb2zdlv7eZ+7pH9uxG4Krqh8n4nIuuvCkdkv00f
	 IeR3UkA1BgjBVUT3NSxaT1Sbg1uo2dXp6F49B8tWz+dANp9fQnEI4GvryOQmPwe43R
	 C2QIrH5a+jcWg==
Date: Mon, 16 Mar 2026 08:28:17 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v3] i40e: PTP: set supported flags in
 ptp_clock_info
Message-ID: <20260316082817.GC1369074@kernel.org>
References: <20260313135802.499837-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313135802.499837-1-przemyslaw.korba@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268052-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4DD94296236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 02:54:10PM +0100, Przemyslaw Korba wrote:
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
> requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the additional
> flags will be rejected by the kernel automatically.
> 
> Set supported flags field so we can set extts pins.
> 
> Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

I don't think it is particularly important, but the AI generated review
points out that citing the following commit may be more appropriate,
as this patch deals with extts_flags rather than perout_flags.

7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")

Also, as this is for iwl-next I do wonder if there should be a fixes tag
at all. I do see that Paul asked for one in v1. But is this fixing a bug?
And if so, should it be targeted at iwl-net?

> ---
> v3:
> - remove unnecessary flag checks for newer kernels and update commit
> message

Thanks for the update.

> v2:
> - add fixes tag
> - remove old TODO comment
> v1: https://lore.kernel.org/intel-wired-lan/20260309141220.343224-1-przemyslaw.korba@intel.com/

FTR, the AI generated review also notes that the TODO covers both EXTTS and
PEROUT, while the patch only deals with the later. But I agree with Dawid's
review of v1. And that it is best to remove the TODO entirely.

> 
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..e7c4f871beec 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -598,7 +598,6 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>  	enum ptp_pin_function func;
>  	unsigned int chan;
>  
> -	/* TODO: Implement flags handling for EXTTS and PEROUT */
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_EXTTS:
>  		func = PTP_PF_EXTTS;
> @@ -1340,7 +1339,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
>  	pf->ptp_caps.n_ext_ts = 2;
>  	pf->ptp_caps.pps = 1;
>  	pf->ptp_caps.n_per_out = 2;
> -
> +	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
> +					     PTP_FALLING_EDGE |
> +					     PTP_STRICT_FLAGS;
>  	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
>  					       pf->ptp_caps.n_pins);
>  	if (!pf->ptp_caps.pin_config)
> 
> base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
> -- 
> 2.43.0
> 

