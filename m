Return-Path: <netdev+bounces-257370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFG6J8UxhWlV9wMAu9opvQ
	(envelope-from <netdev+bounces-257370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:11:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C0F8843
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301F83013EDE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C14315F;
	Fri,  6 Feb 2026 00:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70222BCFC
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336706; cv=none; b=LaoT03QLs0is8a7bVeJeAJ6OARCKnkQFdVYmp3FNxFtE3ufYIkgxrfEqCTzqkCtvn2zcP6AC9FKFSmtIhGXzsSoKMx5JvsV6W4t48BiiJeh0vrdw0Lvb1RT5MTvbGnDWvEP34Qgc6r+uEBPgYd7GZ89BqfhzWZR8qxcJxlNtfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336706; c=relaxed/simple;
	bh=9kO/NWkYF1rob5AYSRizwCBiokSaOYElw+slzY0IJOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzALdcsHXg3rCo69VEEsX/3j4xMez8RRMZubjiXsDOCeoWLYshVOXGzL3pqtG1ucrwCafsUnPMDC1orByy3sTa5mk4RbelkNfrKomwzFWxJvauskukj5N644621Ehvh2ewuMzqb7mj9hLHmV+mln7CVsXYNup1r5r6PkuWAi0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AC06A605E7; Fri, 06 Feb 2026 01:11:37 +0100 (CET)
Date: Fri, 6 Feb 2026 01:11:37 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH] xfrm: reduce struct sec_path size
Message-ID: <aYUxubug67eqQ6aH@strlen.de>
References: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257370-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 340C0F8843
X-Rspamd-Action: no action

Paolo Abeni <pabeni@redhat.com> wrote:
> The mentioned struct has an hole and uses unnecessary wide type to
> store a MAC length.

Good catch.

> struct sec_path {
> 	int                        len;
> 	int                        olen;
> 	struct xfrm_offload        ovec[1];
> 	int                        verified_cnt;

Why not s/int/u8/ while at it?

> 	struct xfrm_state *        xvec[6];

len is xvec, olen is the offload length which can only be 0 or 1 at this time.

verified_cnt also refers to xvec[].

>  	/* Used to keep whole l2 header for transport mode GRO */
> -	__u32			orig_mac_len;
> +	__u16			orig_mac_len;

Matches mac_len in sk_buff; I think this change is fine.

