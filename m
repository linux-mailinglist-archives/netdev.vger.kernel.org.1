Return-Path: <netdev+bounces-266292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ab+KhVisGloigIAu9opvQ
	(envelope-from <netdev+bounces-266292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191A25660C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD88E30692C4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58142DC32C;
	Tue, 10 Mar 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM5mjNlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21832DB794
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167102; cv=none; b=S4Mnn6OnHI8k9idsJVI2oyKrUP4fa3UZziibd2klX5uRyVZI6OlPpA08rramK9JZfVcZZSPytObjTfiADY8ap7wbucIuUpx+p7q41T3kam8H6mI2KNH4VYhB3ckon34BisaZa3Y7uvV1v9vCme6R8e8y4PD6sv0Cyl3/a7Ckv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167102; c=relaxed/simple;
	bh=FufTTTyj6nE6kLLvLgpYODGCqdonXtgXIyVvkY561zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keF6TxjUJM9TgPnBQ2ZSmLFzxZs5jVCebMlmxh+2eY/zXWC0LB3IIZ+ERZMcIiEtk97YaqJFwswqDW+qaEUWWz99mLQiZMD+DX1rYqcufRPXsnVzZdrCmGG8Se3BbHPPazPAgl2VOOpsYgKrKg/ZXlrcqHvWaM1sX+1tIRicwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM5mjNlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072E9C19423;
	Tue, 10 Mar 2026 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773167102;
	bh=FufTTTyj6nE6kLLvLgpYODGCqdonXtgXIyVvkY561zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jM5mjNlBkhQHJj/Xl5Ib8cqlKZFktR0CkRbLZPMhRha5PtkBQhpDpgg3ESN9bJPHI
	 HVellEu05213sD9RVAKAJrZL3Me5HRUcWOCfAyEyVTgXo6BhnkNVPx0PhudGhUq74T
	 9J1yXFu3MsknDLe2348D9Pp2cw5pYKEbALrHppu3ejl1/bFYYTxp1I2DiQXwp3uM6U
	 JngcgdVZvx+Z41NtS9ig2534VSaGHu7MXNYBnCpQgR72KhrRrUaSlTmSSYM5Ik06fN
	 B0Q3W3lVkj07vfT2X6FcaSjfQbijE4aMZT6DhdUVe1HN54jS9AZ5qIR78xuPOwL9Zv
	 v+PvngQNGQ5UA==
Date: Tue, 10 Mar 2026 18:24:58 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
Message-ID: <20260310182458.GQ461701@kernel.org>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309141220.343224-1-przemyslaw.korba@intel.com>
X-Rspamd-Queue-Id: 3191A25660C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

+ Jacob

On Mon, Mar 09, 2026 at 03:11:51PM +0100, Przemyslaw Korba wrote:
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
> requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the additional
> flags will be rejected by the kernel automatically.
> 
> i40e does not support perout flags, so reject any request with perout
> flags.
> 
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..8d7958692235 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>  	/* TODO: Implement flags handling for EXTTS and PEROUT */
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_EXTTS:
> +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> +					PTP_RISING_EDGE |
> +					PTP_FALLING_EDGE |
> +					PTP_STRICT_FLAGS))
> +			return -EOPNOTSUPP;
> +
>  		func = PTP_PF_EXTTS;
>  		chan = rq->extts.index;
>  		break;
>  	case PTP_CLK_REQ_PEROUT:
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
>  		func = PTP_PF_PEROUT;
>  		chan = rq->perout.index;
>  		break;

I am a little confused.

My understanding of the cited patches is that they add checking
of flags to the code. So code like the above isn't needed in drivers.

> @@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
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

