Return-Path: <netdev+bounces-294852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C4coFhZhIGoO2QAAu9opvQ
	(envelope-from <netdev+bounces-294852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1463A17E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:15:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="EI//1kYd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294852-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BB83111E1C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765183E9C08;
	Wed,  3 Jun 2026 17:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0383DB306;
	Wed,  3 Jun 2026 17:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506485; cv=none; b=jkziW5NaRgx3gsroYiYBL8uUrKZiha2Ei/IgH4CPzryiNu5/oF0diXhy93TbVoRZDoAhsWSqBptBvSsa7I/DaHIed/9ucuZHAU8xx4ghkhgIGFz+Ak5N9gz+LIbqcp4NLi7W3d9IkTrJ6T4ViefEYN5xKqHbntyCBVQP7+nsDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506485; c=relaxed/simple;
	bh=f/GuwNGqohtlLxfuVLLktLiOGG+KpgR16OkRRZfJESw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7/Qk6SxNCDPFyAO9hpS5qlvK+W7YKJBvBIjCIK26Qn698aKRMiXKbGKXlFjRoKIuIMGBcAM631Sa+Qrhku2y3ABfxUmVw14ixwTAlfu3XWSrds0xLbMcNM3W3bWO/gza3xBUJaAhmk06j5LAK2HEicGVaGWzXn5Ctq6sN4lXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI//1kYd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94541F00893;
	Wed,  3 Jun 2026 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780506484;
	bh=huDaivPqv4ZW0PS9fPDbWytOLKxzFql4FZG4RRJto2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EI//1kYdrvDTeWsDTfgbKhQIVGY3A5jz+riYPbGje/YEJKoJqr0Rc3DI3lHZTGWVB
	 /emBDAzK1v91bICv9dlhg/ywPBn7XRRKyzwN5Oq2FyB3+NHIE71lEZCn/s63RZ9QmM
	 oMCVkqSFiHzgfp4vTaF/XB5nzT3B6WepXHbdMipMmk6aI6Lba6nkyXgZXZPQWYvAn7
	 pJDqXa0lgsG9R8v/u0Kho0a5na8RMsvCEiCQicvXKWtgGxvJDHIXKLNOh4JeV+8U2d
	 Z4Pu0j/j2EZSS4wvqKfYNJthztvwqNRGjeFj0nRKyp0jW6AlyJQnI73JUZazfx+bhv
	 bTExQs5PcDoKA==
Date: Wed, 3 Jun 2026 18:07:59 +0100
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260603170759.GG3766816@horms.kernel.org>
References: <1780054645-17142-1-git-send-email-sbhatta@marvell.com>
 <20260603165945.3828939-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603165945.3828939-2-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DA1463A17E

On Wed, Jun 03, 2026 at 05:59:46PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, my tooling isn't helping me much today.
There was supposed to be some commentary in my previous email.
Let me add it.

> ---
> octeontx2-af: Validate NIX maximum LFs correctly
> 
> This patch changes the validation condition for setting the maximum
> number of NIX LFs via devlink. It replaces the check for assigned MCAM
> entries with a check for assigned NIX LFs to determine if resizing
> is allowed.
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > index 6494a9ee2f0dd..8ba4b5ba9d2c7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> [ ... ]
> > @@ -1521,11 +1523,18 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
> >  	/* Do not allow user to modify maximum NIX LFs while mcam entries
> >  	 * have already been assigned.
> >  	 */
> > -	mcam = &rvu->hw->mcam;
> > -	if (mcam->bmap_fcnt < mcam->bmap_entries) {
> > -		NL_SET_ERR_MSG_MOD(extack,
> > -				   "mcam entries have already been assigned, can't resize");
> > -		return -EPERM;
> 

The issue below looks like it should be looked at in the context of this
patch.

> [Severity: High]
> Does removing the check for MCAM entries allow the devlink parameter
> set operation to silently destroy active MCAM tracking state?
> 
> The .set callback unconditionally calls npc_mcam_rsrcs_deinit() and
> npc_mcam_rsrcs_init(), which frees and reallocates the mcam->bmap. Since
> MCAM entries can be allocated independently of NIX LFs (e.g. during
> rvu_switch_enable() or default switchdev/PTP rules), could this cause
> resource leaks and use-after-free bugs when untracked rules are later
> accessed?

> 
> > +	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> > +	while (blkaddr) {
> > +		block = &rvu->hw->block[blkaddr];

While the one below seems like it can be assessed in the context
of possible follow-up.

> [Severity: High]
> This is a pre-existing issue, but does this locklessly read the resource
> states?
> 
> It appears that the devlink validate and set callbacks execute without
> holding the driver's resource locks (rvu->rsrc_lock or mcam->lock).
> Could a concurrent mailbox request allocate an LF immediately after this
> lockless validation check succeeds, leading to a race where the .set
> callback frees structures that are actively being used?
> 
> > +
> > +		free_lfs = rvu_rsrc_free_count(&block->lf);
> > +		if (free_lfs != block->lf.max) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "mcam entries have already been assigned, can't resize");
> 

The one below seems less important. But perhaps it would be good
to address if there is a v2 of this patch.

> [Severity: Medium]
> Since the validation logic was updated to evaluate NIX LF allocations,
> should this error message and the comment above be updated as well? The
> message still states that "mcam entries have already been assigned", which
> might confuse users since it's actually evaluating NIX LFs.
> 
> > +			return -EPERM;
> > +		}
> > +
> > +		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> >  	}

