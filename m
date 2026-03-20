Return-Path: <netdev+bounces-269907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBRUDTJAvWn28AIAu9opvQ
	(envelope-from <netdev+bounces-269907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:40:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0102DA662
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29D233016B9F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC53B2FDB;
	Fri, 20 Mar 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QntPnDxZ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7737E312;
	Fri, 20 Mar 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010403; cv=none; b=kLyqmaZr36Q2vi3ejAOPRIPM5UuqCVMasnXRBE0FDZFOvvV/DJGnm25rEiJitzbV7CKlSuV54hATJ8Ilcr9jcgenLrisgpX74abjEB1Vvr7kVZbKB4fmeupM1xlSvMM6Z/XKkWBUjLkPMUl/2f/ZGWdHr75IC5bEjvAEHErJKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010403; c=relaxed/simple;
	bh=ovUo3pQgtlbbD+fTGPV8EJisFQ5aT4XfKwBH2JzRlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE4jHKrPezmXUXL+2dx6RCwLfPNPbJY9tuV1Xj3o+2WP3BvHHmCVkNapoVK3hRt1pZ5LirUzhoXqOVw/FBTVD7NuIyJ4m7QtqScAGl+eOIDzmrN89wEuwHDeBhjlTfk5reI0AuUi9yQQDiPqkNlW1j2uUs9Aj2GKXc+foqswrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QntPnDxZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ovUo3pQgtlbbD+fTGPV8EJisFQ5aT4XfKwBH2JzRlXo=; b=QntPnDxZH9Jkq8ETTV6L9lOYgW
	41c77KHiFc1ab/gDsSnU8AE6DDeS3kenBeoh/pMYrfg1OsMQZJqDVVmxU6LnqTwJvbMUXbr53puZk
	JF7aaKZjC9BS2zf61CWuTj66oSPFER3nKT/108w8vIbNDfLcwZvKNMZ/5rghT7fiHrUQWrvJyV8D4
	VOEo3K7eP4EBXiiYFoJpEkmlnljJA+gf46Ex0J30dwzYiFsT5sE9dqO5nQ0R3xltR4Old5ZmpdaQD
	+yVdSVwDoG2dmdQdtwJyN15ET9Jb3CPXI6X3WrsL6djP+pGeTSLkJTMbkgsQjKUBYR/g3QmFDGD1D
	6bChJiRQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w3Z8i-005DB4-S9; Fri, 20 Mar 2026 12:39:43 +0000
Date: Fri, 20 Mar 2026 05:39:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, hch@infradead.org, 
	jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <ab0_Pg-iGhTCKpbl@gmail.com>
References: <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
 <C6V44SxiJH8NxRosmbshR-sfcBisrA5yWQpDmfQXe5vOX3uI6SM-r7wwUr7WxfPMS5ETUQ9GYDlptRs911A_Qg==@protonmail.internalid>
 <aYTWbElo_U_neJZi@deathstar>
 <87qzquuqsx.fsf@t14s.mail-host-address-is-not-set>
 <aYnnHJ2TQEcD_xMS@gmail.com>
 <877bsjvhqv.fsf@t14s.mail-host-address-is-not-set>
 <aYxL7d4MxbepGnKb@gmail.com>
 <87o6kirb61.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6kirb61.fsf@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269907-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.957];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,wbinvd.org,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE0102DA662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Andreas,

On Fri, Mar 20, 2026 at 12:29:58PM +0100, Andreas Hindborg wrote:
>
> Hi Breno,
>
> Breno Leitao <leitao@debian.org> writes:
>
> > On Wed, Feb 11, 2026 at 08:53:12AM +0100, Andreas Hindborg wrote:
> >> Breno Leitao <leitao@debian.org> writes:
> >>
> >> > On Mon, Feb 09, 2026 at 11:58:22AM +0100, Andreas Hindborg wrote:
> >> >> Perhaps we should discuss this at a venue where we can get some more
> >> >> people together? LPC or LSF maybe?
> >> >
> >> > Certainly, I agree. I've submitted my subscription to LSFMMBPF with the main
> >> > goal to discuss this topic. I wasn't planning to present it this, given it was
> >> > a "overkill"?, but I'm happy to do so if that is the right direction.
> >>
> >> I'd appreciate if we can get some people in a room and force them to
> >> think about this. I think it is a good idea if you submit a topic. If we
> >> don't get a slot, we can see what we can do in the hallway, and if that
> >> does not work out we are forced to make a decision between the 4 of us
> >> participating on list. At least nobody can say we did not try to collect
> >> input and opinions then.
> >
> > That is an excellent follow-up and direction, let me submit a topic in there.
>
> I did not see a topic on list, did you submit?

Unfortunately, I haven't submitted a topic and won't be able to attend.
My daughter is due around the same time as the conference, and I didn't
realize the conflict until recently. :-|

> At any rate, I did not receive an invitation for LSF this year, so I
> will not be able to meet up in that venue.

Perhaps it would be best to continue the discussion on the mailing list?

