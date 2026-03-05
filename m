Return-Path: <netdev+bounces-264205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFPLLvU0qWlH3AAAu9opvQ
	(envelope-from <netdev+bounces-264205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:47:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED320CDD2
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 730FF301F68B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14006237A4F;
	Thu,  5 Mar 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="b3QSoVjE"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D81C68F;
	Thu,  5 Mar 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696814; cv=none; b=at1lzoqxx120j4oJGpEEOIGalF8vzoHDaIVXFmNm4DNHxprmdtkiKLQr/Ax0EV/55ecMs7rULTz+Ft/Lw7wtg0Os9P94T/dEhQR77yG5/gvvmkmQvd9OurxdZRA2YaIII20gx9NeJqUwZkl9OxYH7hkUe2as1XYLBlG0iuz0S0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696814; c=relaxed/simple;
	bh=T9M4kmgYIEUsMmHiFm4ub7yYAzYSB9MqA6xImAgioyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkEesxCYlpdRKbMywusvdJ5zQd5waYG1FtcfnoSF14XbvGSvF2fJffMzg5OWg/RSN5CCN12dBYr2sFTLvwK/ye8eGDN959ArM/4xKrfx4E6V7Aw7h4yc6CUBM4vsNIoggSU9uQojOMkKBms0mdZktRiX43yfReOVzYhHWItPzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=b3QSoVjE; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1772696802; x=1773560803; bh=T9M4
	kmgYIEUsMmHiFm4ub7yYAzYSB9MqA6xImAgioyY=; b=b3QSoVjEeT+wGsxfbvyT
	JMTj4V8V/n9qaxTyRdnh9+VAJlxd61ZPykJb8TGQk64EnNA+ZyjU1bjn2CYcqAFm
	o2MNSswZLiGs+4KnrPA8pBI0t7NU3osrSIqjY4kZSvlNhE1+D4LRG+GfZEBpUqME
	xrFAE2q5qqWTODZ+V/aQ8cS0RaV+TXURl5C3ngMiVihZL5i9SGBF6OspBVXds8Cy
	7suHd5tK4SVsLPaIbxhvOT59DUu9Qsa70PasBAkeSTG0xUpWR/1QTDnnvFe4+fKy
	bgDNDP5nMhyCpnTQ1d5ZnvKfAink69GLW5SyV/4vo9GZpMcikU5HZG62pQviP0aG
	PA==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 05 Mar 2026 08:46:39 +0100 (CET)
Date: Thu, 5 Mar 2026 08:46:38 +0100
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 1/8] xfrm: add missing
 __rcu annotation to nlsk
Message-ID: <aak03kiz8eOw2R_g@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <9e8623132cb8001bce5bdf97e0c4591101b6dff9.1769509131.git.antony.antony@secunet.com>
 <aaB93d-GoW2eREHa@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaB93d-GoW2eREHa@krikkit>
X-Rspamd-Queue-Id: A8ED320CDD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264205-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Antony2201.local:mid,phenome.org:dkim]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:07:41PM +0100, Sabrina Dubroca via Devel wrote:
> 2026-01-27, 11:42:01 +0100, Antony Antony wrote:
> > The nlsk field in struct netns_xfrm is RCU-protected, as seen by
> > the use of rcu_assign_pointer() and RCU_INIT_POINTER() when updating
> > it.
> > However, the field lacks the __rcu annotation, and most read-side
> > accesses don't use rcu_dereference().
> > 
> > Add the missing __rcu annotation and convert all read-side accesses to
> > use rcu_dereference() for correctness and to silence sparse warnings.
> > 
> > Sparse warning reported by NIPA allmodconfig test when modifying
> > net/xfrm/xfrm_user.c. The warning is a pre-existing issue in
> > xfrm_nlmsg_multicast(). This series added a new call to this function
> > and NIPA testing reported a new warning was added by this series.
> > 
> > To reproduce (requires sparse):
> > make C=2 net/xfrm/
> > net/xfrm/xfrm_user.c:1574:29: error: incompatible types in comparison
> > expression (different address spaces):
> > net/xfrm/xfrm_user.c:1574:29:    struct sock [noderef] __rcu *
> > net/xfrm/xfrm_user.c:1574:29:    struct sock *
> 
> BTW, after this, sparse will complain about the other accesses to nlsk
> in net/xfrm/xfrm_user.c (in the nlmsg_unicast(net->xfrm.nlsk, ...)
> calls).

Indeed there are more sparse warning. I am glad to hear you working on a 
borader patch!

I stayed focused on this one since it was directly triggered by my patch
series, and I couldn't find much guidance on the others easily.

> 
> I have a patch adding this __rcu annotation, and fixing the warnings
> that it causes. It's part of the series I'm planning to submit very
> soon, which fixes a lot of rcu-related warnings in net/xfrm/*.

I am looking forward to this. I'll keep my patch for now as a fix. If your 
series lands first, I'm happy to drop mine.

-antony

