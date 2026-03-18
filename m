Return-Path: <netdev+bounces-269075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COkLNfPFumlobwIAu9opvQ
	(envelope-from <netdev+bounces-269075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:34:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E502BE4DC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E48C631019EC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559AC3E5EE8;
	Wed, 18 Mar 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl03cYgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5B3DE431;
	Wed, 18 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846759; cv=none; b=qJqea9Zigty8pXYUA4rb1Is2oSKj1Bk/n7AP35wBg+8pzVmJ38zOXbH6TC5vTQYJfwogR45mUR7vvMkg80IaKASY00CtuV+pbt5E/+HqgAof24Ymqxd9gXJvEhfdfcDk+wxmDMwL+mFKhRW74HzA06dc6kgX8rqWtSkjSv39doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846759; c=relaxed/simple;
	bh=yllZcPZ0CoQKyH5ytBASmVnL7HpV0y9/4wnzkZf6P9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAJBXsgTBqDj+n55SZiVq5CKuK59B/ZdgaYuYbQMAkb1EEO8rB+S7dEhnw2/yjirJEoG+kk+3SXdEj9MFURXl9XEdystj8yc+s/cGYQFCoPc6LMj0HzMsItvxL/qS6TnM6p9WUX6NsLuxnSWfQx6fFbvXL9J8nt6TzoJkpCHGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl03cYgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C7DC19421;
	Wed, 18 Mar 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773846759;
	bh=yllZcPZ0CoQKyH5ytBASmVnL7HpV0y9/4wnzkZf6P9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rl03cYguj14jWSffT0gRy2mS1QJ3hYZ55WLmGcVciM6rL5uC3bwMVuxVuqm/clYrz
	 i8ph9OYHYL2DuwTYmREKPspxohmxiJzmQkyUVuy1ILUxspgdqtg4ePy4snqkUJHF/5
	 ihf6QD3pSdrgB+x6egCOz0dy/j/gjqHuIBAyXdOwwev72FyxPC21FE1qYFIytJTzTT
	 /xmQTDKMOnZ9f1AXIE3UDLq4Y3rva7cULU25lw9idqWYMV00duqDXovPCyIN9YSfWR
	 1OiFPnI6j1Nx5b2TGnBrs8cgjyC3bkCaSCTDKvjktaQffAllQ0I3Wuf1twkKfs1L+g
	 ytFoJJqJgqiSQ==
Date: Wed, 18 Mar 2026 15:12:34 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 4/4] octeontx2-pf: cn20k: Use unified Halo
 context
Message-ID: <20260318151234.GC1753385@horms.kernel.org>
References: <1773665859-4036-1-git-send-email-sbhatta@marvell.com>
 <1773665859-4036-5-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1773665859-4036-5-git-send-email-sbhatta@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269075-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E2E502BE4DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 06:27:39PM +0530, Subbaraya Sundeep wrote:
> Use unified Halo context present in CN20K hardware for
> octeontx2 netdevs instead of aura and pool contexts.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/cn20k.c    | 190 +++++++++---------
>  .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
>  .../marvell/octeontx2/nic/otx2_common.h       |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +
>  4 files changed, 107 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

...

> -	/* Enable backpressure for RQ aura */
> -	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
> -		aq->aura.bp_ena = 0;
> -		/* If NIX1 LF is attached then specify NIX1_RX.
> -		 *
> -		 * Below NPA_AURA_S[BP_ENA] is set according to the
> -		 * NPA_BPINTF_E enumeration given as:
> -		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
> -		 * NIX0_RX is 0x0 + 0*0x1 = 0
> -		 * NIX1_RX is 0x0 + 1*0x1 = 1
> -		 * But in HRM it is given that
> -		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
> -		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
> -		 * enumerated by NPA_BPINTF_E."
> -		 */
> -		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
> -			aq->aura.bp_ena = 1;
> -
> -		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);

With this change cn20k_aura_bpid_idx is now unused and probably
should be removed.

Flagged by W=1 builds.

> -		aq->aura.bpid = pfvf->bpid[bpid_idx];
> -
> -		/* Set backpressure level for RQ's Aura */
> -		aq->aura.bp = RQ_BP_LVL_AURA;
> -	}
> -
> -	/* Fill AQ info */
> -	aq->ctype = NPA_AQ_CTYPE_AURA;
> -	aq->op = NPA_AQ_INSTOP_INIT;
> -
> -	return 0;
> -}
> -
> -static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
> +static int cn20k_halo_aq_init(struct otx2_nic *pfvf, u16 pool_id,
>  			      int stack_pages, int numptrs, int buf_size,
>  			      int type)
>  {

...

-- 
pw-bot: changes-requested

