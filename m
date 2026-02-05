Return-Path: <netdev+bounces-257366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE+gLj0phWkk9QMAu9opvQ
	(envelope-from <netdev+bounces-257366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:35:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AEF85DC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA685300A8E8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EB33BBA4;
	Thu,  5 Feb 2026 23:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539433AD9B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334523; cv=none; b=EssJzpohhSqky6b8QCWdrAxjRppDrOxXbCS2zdaAlAkI08I3x06MBEr6pdCqFX+dTpSQmaknIIhe8/p6KZF78gksPoU+aSqmPuoJYAIU0JoBnEVXW8D991cPHtPyu4okJLXF6GMLkraN9j2X48QUoCLpKE+7hfikzAA6AM4YF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334523; c=relaxed/simple;
	bh=3dsoa4wt4NnQP5anDikopV1IhR2EJ35uBDTYEfhieJQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HMLtUsts5d/IXkjolJ6r7N6AJr3GAxzACDGE7OgFoZBO38jtncbsI66eYAznxBB+Xu3hI6+Gd4nSCTYnwCgmBZyXcSJbK5G2nocaHXcgSDlXXohGLH4PfpqXyKMKpk7aS2MppCWcFVH5l7wiixopOnC3DDaibiU+Qymmb9+1XKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D4E3992009C; Fri,  6 Feb 2026 00:35:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C8FCF92009B;
	Thu,  5 Feb 2026 23:35:14 +0000 (GMT)
Date: Thu, 5 Feb 2026 23:35:14 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: OnesuchDev <enelsonmoore@gmail.com>
cc: andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>, 
    edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
    pabeni@redhat.com, pcnet32@frontier.com, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
In-Reply-To: <20260205004420.13667-1-onesuchdev@gmail.com>
Message-ID: <alpine.DEB.2.21.2602052244160.17548@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2602050003510.12532@angie.orcam.me.uk> <20260205004420.13667-1-onesuchdev@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,frontier.com,alpha.franken.de];
	TAGGED_FROM(0.00)[bounces-257366-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.962];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B4AEF85DC
X-Rspamd-Action: no action

On Wed, 4 Feb 2026, OnesuchDev wrote:

> It was not my intention to spread FUD - I had simply forgotten the 
> previous conversation when I sent this follow-up.

 I did think it was unintentional, but then someone unfamiliar with the 
situation could get misled.  Please be more careful in the future.  I tend 
to be forgetful of things too and address that by double-checking stuff.

> Do you have any issues with short stalls under high network load, like I 
> do in QEMU?

 Hard to say authoritatively.  I can't recall any issues, but then I have 
not stressed the interface recently and the load here would be different, 
as my main use for the platform is remote GNU toolchain verification for 
the MIPS target, over SSH and NFS both at a time for control and data 
respectively.  This does put a high load on the network link, especially 
as the attribute cache has to be disabled as well.

 I tend to run that over FDDI nowadays though, both to separate traffic 
and to keep the FDDI stack verified as well across platforms, of which I 
have many.  I have no GNU toolchain verification scheduled for the MIPS 
target in the near future, but can try to remember to run it over Ethernet 
instead next time.

 I would suspect QEMU though, having had used pcnet32 for 20+ years now 
and having seen all kinds of odd issues with QEMU too (and fixed some as 
well).  It's a simulator after all, and then not a very accurate one in 
terms of timings.

  Maciej

