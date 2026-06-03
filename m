Return-Path: <netdev+bounces-294845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZ2QKHdhIGpN2QAAu9opvQ
	(envelope-from <netdev+bounces-294845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A127963A1B0
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:16:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m0VARX6g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294845-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294845-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 701753001064
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5783E6DFA;
	Wed,  3 Jun 2026 17:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191893E3C5F;
	Wed,  3 Jun 2026 17:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506120; cv=none; b=RqhW2Ro7XscXtDcSgrRK32yRmIfvdWenoy3LE2Ln/dUjwX16QZXWxnUsi0XfARQkSuEjW0EhgtAS6jXyksWJ/E/958bDA76h+1r7OQxwbDplOVcMkqso+UyvfLU84hNAMYk0gnOGB5FRbEJ4TTmnS2JXqAGkhzOSnFO5yHZdZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506120; c=relaxed/simple;
	bh=NjWDnYr8xr1qGacrrORdUH3VJR3iSMpcttw3HKtu1rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo1SvgdQNv189qcQwCSZAP72xsxCYlFg+kW9mlnqkPb+ekFDtqdjEH15NTA4ed55L7UhnySF2vtaY7exIypzkeP0bphmgkVKA1cfLWd5JN1wELi08MKQjmk4EvdEts8igXaIYJvrZyoMVfkp3XwlaWHlumxXl1F1wzByeWbl7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0VARX6g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784571F00893;
	Wed,  3 Jun 2026 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780506118;
	bh=aFw+9LpIa/N4iQuvj1Fr/+taECBsisDHaSCL04bigJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m0VARX6gYPZpOqJr2HFT9aEJEEZsyZaJSf/rt7t/5GmKYN0AOdjLlrufXMQgBr3Vk
	 NOt4YNUr1K3sfZQqXv9Kg916palK12BkKPOWYmrh016V5qLfqeninhrmjiRmjWS+6m
	 nsKMmca+DMx5MlMRaWH43Btumur3D4Q93nkIQ75P5Lsz1+4VVIwpU3qI7KO5GhpKaf
	 G1q5ZX5zTue9NTEAh17hKhsQwSvYtkMTa8Y2WVTHQx8TWNvVLRHSuHOcYCYRoNum4J
	 sXj+GNjshKOuExvUy64yL3jLyhRFDyKHhyoISd5QiJlp8ylgITT/JVFHPcynBeFPUL
	 DhCZC0WNsOlMw==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: Validate NIX maximum LFs correctly
Date: Wed,  3 Jun 2026 17:59:46 +0100
Message-ID: <20260603165945.3828939-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1780054645-17142-1-git-send-email-sbhatta@marvell.com>
References: <1780054645-17142-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294845-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A127963A1B0

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
octeontx2-af: Validate NIX maximum LFs correctly

This patch changes the validation condition for setting the maximum
number of NIX LFs via devlink. It replaces the check for assigned MCAM
entries with a check for assigned NIX LFs to determine if resizing
is allowed.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 6494a9ee2f0dd..8ba4b5ba9d2c7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
[ ... ]
> @@ -1521,11 +1523,18 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
>  	/* Do not allow user to modify maximum NIX LFs while mcam entries
>  	 * have already been assigned.
>  	 */
> -	mcam = &rvu->hw->mcam;
> -	if (mcam->bmap_fcnt < mcam->bmap_entries) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "mcam entries have already been assigned, can't resize");
> -		return -EPERM;

[Severity: High]
Does removing the check for MCAM entries allow the devlink parameter
set operation to silently destroy active MCAM tracking state?

The .set callback unconditionally calls npc_mcam_rsrcs_deinit() and
npc_mcam_rsrcs_init(), which frees and reallocates the mcam->bmap. Since
MCAM entries can be allocated independently of NIX LFs (e.g. during
rvu_switch_enable() or default switchdev/PTP rules), could this cause
resource leaks and use-after-free bugs when untracked rules are later
accessed?

> +	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> +	while (blkaddr) {
> +		block = &rvu->hw->block[blkaddr];

[Severity: High]
This is a pre-existing issue, but does this locklessly read the resource
states?

It appears that the devlink validate and set callbacks execute without
holding the driver's resource locks (rvu->rsrc_lock or mcam->lock).
Could a concurrent mailbox request allocate an LF immediately after this
lockless validation check succeeds, leading to a race where the .set
callback frees structures that are actively being used?

> +
> +		free_lfs = rvu_rsrc_free_count(&block->lf);
> +		if (free_lfs != block->lf.max) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "mcam entries have already been assigned, can't resize");

[Severity: Medium]
Since the validation logic was updated to evaluate NIX LF allocations,
should this error message and the comment above be updated as well? The
message still states that "mcam entries have already been assigned", which
might confuse users since it's actually evaluating NIX LFs.

> +			return -EPERM;
> +		}
> +
> +		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
>  	}

