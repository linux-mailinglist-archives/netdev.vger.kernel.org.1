Return-Path: <netdev+bounces-287069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NliH5sAA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:27:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D305551E894
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D8B3028EE8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B383395AF9;
	Tue, 12 May 2026 10:26:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17F395AEF;
	Tue, 12 May 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581600; cv=none; b=iHuXedn+K0qdOK+0cpwKSiEqh1xQI2AdComLphlqHNDGPLUNf0vYE30QjNmDNuCnSUWtQixBxmmsSPU/j9ztk7EnuyOXLagyMhAeVYMG21F+zN3Mh4qEvP9MPIZAf5N7/dUZaz4f5Pg2n3zUdUryU2y8TJzWjcKRFDxhjMKypO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581600; c=relaxed/simple;
	bh=clSdzz0nLHGAJMx8KEW3gEaUo7hFByVfHdgHJoGvTTI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tlt+PXoRz5kGLYFNtkQPHdiPLJPmv84oDJriHvpJYwn4WsN/9WJkbAA14yz13Cc2NTWSYpMm7+JMtiyu1jBKzQNTve5Yu1CC5O/kVlcHOxDIC5S/I9LQaQP7B4mToIuCbeQJ51wIWJWbkiJnAxsj+ohjrO1g2JnI+kaj+WcmcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8615792009D; Tue, 12 May 2026 12:26:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7FFB992009C;
	Tue, 12 May 2026 11:26:37 +0100 (BST)
Date: Tue, 12 May 2026 11:26:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
In-Reply-To: <20260511162044.45494456@kernel.org>
Message-ID: <alpine.DEB.2.21.2605120123260.46195@angie.orcam.me.uk>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org> <20260509230519.57607-2-enelsonmoore@gmail.com> <alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk> <20260510085841.243bdd7e@kernel.org>
 <CADkSEUj3qUFDG-Hc3_RNZjm6=h8wJF63OOcHWsZGumG18VdLkA@mail.gmail.com> <20260511162044.45494456@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D305551E894
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Action: no action

On Mon, 11 May 2026, Jakub Kicinski wrote:

> > > Sorry, must have missed it or forgotten.
> > > Could you point me to the report of these driver being used?  
> > 
> > Here:
> > https://lore.kernel.org/all/alpine.DEB.2.21.2604240004280.28583@angie.orcam.me.uk/
> 
> Maciej, what's the relevance of your machine in the lab?

 It's one of my test machines for the defxx driver, specifically the EISA 
binding.  The Ethernet link served by the 3c509 driver is for Internet 
access, FDDI is intranet.

> Does the platform or any component that you test on this
> platform have actual users?

 I believe the defxx driver does, yes; unsure about the EISA binding.

> If the answer is no / unsure please fix the driver up to
> follow modern coding standards and submit the patch.

 I don't mind updating for our coding standards, though such a change 
might be considered just irritating noise that interferes with `git blame' 
(though with the removal of the code upstream, this got broken already 
anyway).  NB it's the reason why I have hesitated to reformat the defxx 
driver for decades now, which obviously has much more serious issues here 
such as the assumption of 4-character tabs.

 I think the re-addition needs to be done in two stages, first being a 
plain revert so that no code change comes unrecorded in git, followed by 
the actual formatting cleanup.  Sadly this won't fix `git blame', but at 
least the diff will be empty between the repo states as at respectively 
the removal and the re-addition.

 Does it answer your questions and seem like a reasonable course of 
action?

  Maciej

