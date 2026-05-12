Return-Path: <netdev+bounces-287225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LINATNOA2pq3AEAu9opvQ
	(envelope-from <netdev+bounces-287225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AECCC524395
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DB73083AA0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F23B8139;
	Tue, 12 May 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6MR8EU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA53905E7;
	Tue, 12 May 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601184; cv=none; b=t8ZkIc6AVaTfRfIsk0/BwdWcOGGZB7Dy+nHGnB8TFXTk40DUH54QtLcvSJioAYFRru8SunHFcOlvROeSIrCVycNwzTADemsvGI8GjjBdED/YfmgUd3f2Q6dCesLmhgDLoEcNzuC7JvNCxLpRT+4wG/AaWqVCil5mNEZSk+tq5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601184; c=relaxed/simple;
	bh=+A6RU+3DA3OxZ4iB9Ss03OoR1eraZj8TU5tTdmq4D8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQzuA+Xch6hvLP2rK5oFsPiS5VJhuFO+kdvaQnj+WNYQObZvoAbRDv8AMgCrRYoRkCR/4MwInxtEJQLVTSok5MS8LW8xc7O+4jtG5mZn6diSkM5GlJVSHlgvuhyua2+W2tpD0k+PVByzkdlIJCSBaPkOwCGfX3WGkBx5t8sI7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6MR8EU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A093C2BCB0;
	Tue, 12 May 2026 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601183;
	bh=+A6RU+3DA3OxZ4iB9Ss03OoR1eraZj8TU5tTdmq4D8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h6MR8EU30uldPZH2L/gkkWTPKN210PZs/Dzp3UirV62WyFlMoTbasbowHOU+7Flq1
	 aS6eSIg5gheeIaPERQByxDVVCyPUyiAbOnaytN2JMhYEqSgK0MQ+Zg3oNNVOD8CjhP
	 SRyYLQFULt5tRTnuwDRsSJEsnKgVgmCDwCP8wAWf2XplEB+J2enOWnEDCj3Q0s2SbJ
	 ts/mQe5zfzO9J4WomL2GT9+8AYbuYrREfjOUYMFuc0rPaesKZ9Wh8QoqWKUVdL6s4j
	 mFtyEx/fLl+74i6w8NtsHumdEZG9L16Y9Wdb95UdSgOm/+hrdsBVCEm55GfIHSWvqH
	 4HM1+XuuG7mwA==
Date: Tue, 12 May 2026 08:53:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <20260512085302.53cca49a@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605120123260.46195@angie.orcam.me.uk>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
	<20260509230519.57607-2-enelsonmoore@gmail.com>
	<alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
	<20260510085841.243bdd7e@kernel.org>
	<CADkSEUj3qUFDG-Hc3_RNZjm6=h8wJF63OOcHWsZGumG18VdLkA@mail.gmail.com>
	<20260511162044.45494456@kernel.org>
	<alpine.DEB.2.21.2605120123260.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AECCC524395
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 11:26:37 +0100 (BST) Maciej W. Rozycki wrote:
> On Mon, 11 May 2026, Jakub Kicinski wrote:
> > > Here:
> > > https://lore.kernel.org/all/alpine.DEB.2.21.2604240004280.28583@angie.orcam.me.uk/  
> > 
> > Maciej, what's the relevance of your machine in the lab?  
> 
>  It's one of my test machines for the defxx driver, specifically the EISA 
> binding.  The Ethernet link served by the 3c509 driver is for Internet 
> access, FDDI is intranet.
> 
> > Does the platform or any component that you test on this
> > platform have actual users?  
> 
>  I believe the defxx driver does, yes; unsure about the EISA binding.
> 
> > If the answer is no / unsure please fix the driver up to
> > follow modern coding standards and submit the patch.  
> 
>  I don't mind updating for our coding standards, though such a change 
> might be considered just irritating noise that interferes with `git blame' 
> (though with the removal of the code upstream, this got broken already 
> anyway).  NB it's the reason why I have hesitated to reformat the defxx 
> driver for decades now, which obviously has much more serious issues here 
> such as the assumption of 4-character tabs.
> 
>  I think the re-addition needs to be done in two stages, first being a 
> plain revert so that no code change comes unrecorded in git, followed by 
> the actual formatting cleanup.  Sadly this won't fix `git blame', but at 
> least the diff will be empty between the repo states as at respectively 
> the removal and the re-addition.

Right, since it was already removed the git blame is going to point
to the re-addition. Hence it's an opportunity for a cleanup.

>  Does it answer your questions and seem like a reasonable course of 
> action?

Sounds fine, I'd squash them, but as long as the patches come in one
series - either way works!

