Return-Path: <netdev+bounces-301071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id As5JJHIeOWp5nAcAu9opvQ
	(envelope-from <netdev+bounces-301071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:37:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DC6AF25E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=APoEj4Ny;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301071-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9777D300E90B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B942C11F3;
	Mon, 22 Jun 2026 11:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37D2C0260;
	Mon, 22 Jun 2026 11:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128065; cv=none; b=iX7VI4CIwb0Tdcl7ARtETtJCGuG5xi+NKPw395e7uuOg83pFb1rzAwUFAj3GRS9HzYj/PhfLAhEeNkOhZiBeVR8N9u2KMuLNK13BRK8GAIF/rKbQGo6ADIz/oiDTV3d+6IQJXk+SFSFU+asGU0LWMw29JAFgzsk0MVPqVkJAzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128065; c=relaxed/simple;
	bh=8GsnyOIFXzb4TqaaDS3uXsdYZCjWxu0esHdTEhXVSOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ta2nSDsLYu8oEXh+fhwXjqu4IldTP92VzEaIza6WCfwEwmpoITupxzY4mWFfyGWmxwCNsbisO7ZhEtSCLX/D4XChLQk2nHp+f4hL1ROC9YTI0VG0y3/K54P8+EV7xEB2+oa2tbkn2YYbkFu9XYXIiAJLEDDKI7dlAR7p2tXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APoEj4Ny; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E091F000E9;
	Mon, 22 Jun 2026 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782128063;
	bh=/A3vADDqKy+2FXKvl4UZBKYzGOCuP5pisLV8KH9oGEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=APoEj4Ny+oUijEwR5iQnNPsmgnr7A9+H2T9EYrWGL4bhcRUv9XZQK8/kuZfvBlbxJ
	 evBaShc0E7egTC/wkPQGhWmlTIjHu+f/gCSTbkStVCPEBPjn3kcBW1dvEPgNMJeRSC
	 WzuHTbnSZHy4yqpqFs7uaiPatVvvM/OQhLRZ3wXND3HMTx3XTwt1OOvQwIq8l2/Fts
	 2Bpc4pAGrovDHNLgEhdvGlXBy6pbszG+nO+tvw34tF3vp6DHSgyWTLtC83h1Av6zws
	 Ic8WzOyiP1oHuPSL/AvPnqw8T2uGHwsBORfoOWOYzexVRieHtqakDXyBN/AK/0jt84
	 hJUYioRxYpMyg==
Date: Mon, 22 Jun 2026 12:34:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net v2] octeontx2-af: npc: cn20k: Fix subbank free list
 indexing for search order
Message-ID: <20260622113419.GB827683@horms.kernel.org>
References: <20260619095100.1864440-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619095100.1864440-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D7DC6AF25E

On Fri, Jun 19, 2026 at 03:21:00PM +0530, Ratheesh Kannoth wrote:
> subbank_srch_order[i] is the physical subbank at search-order slot i,
> so each subbank's arr_idx must be i (its slot), not
> subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
> and broke allocation traversal order.
> 
> Populate arr_idx and xa_sb_free in a single pass over the search
> order after subbank structs are initialized.
> 
> Fixes: 7ac9d4c4075c ("octeontx2-af: npc: cn20k: add subbank search order control")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v1 -> v2: Addressed simon comments
> 	https://lore.kernel.org/netdev/20260619091341.918165-1-horms@kernel.org/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I think the issue flagged in the AI-generated review of this
patch on sashiko.org can be treated in the context of possible follow-up.
I don' think it should impede the progress of this patch.


