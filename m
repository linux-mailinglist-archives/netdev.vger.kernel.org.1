Return-Path: <netdev+bounces-292474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oChcK2R9F2qqGggAu9opvQ
	(envelope-from <netdev+bounces-292474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1E65EAEB1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D766304AB6C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114F3C1977;
	Wed, 27 May 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A40xT658"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729B17A30A;
	Wed, 27 May 2026 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924319; cv=none; b=oJ8pfsuJb3DhmK/6WPmNMs2q1ESuZay7yKFLfDsmiYFLGajlIXRvZQW/WkUKpUXw5f+z8cqWF9JtPHI/B9MgM/LQP1RuoQermNzdpSTBlCWDpC2C+JI/IZ35ojlGuW6TrajtwT5I2+f/N2qEaEpbUGVo1Jxdy3G7ilqhal3tgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924319; c=relaxed/simple;
	bh=2hJqmrjVo1Ub22tHWHUamoVv4hSTnD73CY/DjVaQx2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2MKxGSeNyDFeSLxFQ+bJj9dC+NAGThbXuFZNDV+6/csFQx4BsDI6dEkDY0MMd7R1tZBLcFhyDyZkAXShpK5Crp0WwqdIUfd/X/SDG07QCFf3coB4pLA0cBV7EavF4wVzn/axIgZ/eiz2mkJfR5NNGStpbKPIHtTb3wl8NnBVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A40xT658; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD681F000E9;
	Wed, 27 May 2026 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924318;
	bh=7tGhATUL6W+mywwi5EEt8P/hkJmuKfnUYR+T0g5mgtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A40xT658D+du0rL7Zyxf3j/wzr2fsYZTku3GAuwu2fKJKMYAcHomlquLpizZOamYw
	 yB5WM0GnnF/wVh+uYteNsF+vLW6wFdWvUTfL2KP1hv48Cbd63G41PGOAx9GveSFgbz
	 EOSQQWIBKz0MWYshv1fVfB8klWmhIaFvHGzW6dsq+C1e4Pcm1rOMeaJNgTPcM6LT/7
	 5bZeJy4qkn0JzGj47GYoR0Ph5y0kUui0SdMCvUlpBWC6UqrOUT5Et5MV3O1qt/ZwC2
	 Q7b3BYHhL2+c+CQy9lqZaq6IDbX/wJ58/vWIEpEuWS2GD+7qtQqYH4L8bz+b2tOkvr
	 Ldq8pQVBCbJrw==
Date: Wed, 27 May 2026 16:25:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Florian Fainelli <f.fainelli@gmail.com>,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260527162516.0d012503@kernel.org>
In-Reply-To: <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
	<20260526172447.10ca4b9e@kernel.org>
	<5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E1E65EAEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 04:47:47 +0200 Andrew Lunn wrote:
> > It'd be great to hear from others but IMHO in the current form this is
> > not suitable for Documentation/networking/ We can commit the "knowledge"
> > part but enumerating the test cases seems odd for Documentation/.  
> 
> Sorry, not looked too deeply at the actual content yet.
> 
> What i was thinking was a python file, which sphinx can ingest to
> produce documentation, and place holders were code would be added to
> implement the actual test during the next phase.
> 
> This is how i've done testing in the past. I would be the evil one who
> thought up the tests and described them in detail using sphinx markup
> in a python test template file. After some review they got passed off
> to a python developer for implementation. And when they got run and
> failed, sometimes the feature developer, the test developer and myself
> got together to figure who made the error.
> 
> I'm not sure we even need sphinx. What i find important is that the
> test is documented. What kAPI calls should be made with what
> parameters. What results we are expected and why? So that when a test
> fails, a developer has the information they need to fix their
> code. The Why? is important, and often missing from the kernel tests.

All makes sense. The question is primarily how we fit that into 
the existing project layout we have in the kernel :(

The python tests can be hacked up to print the test case docstring
before the failure.

But I think for human and AI reviewer consumption it may be nice
to keep the condensed knowledge / common mistakes in Documentation/
If we had the ability to exercise the submissions it'd be a different
story test output would be a sufficient signal and/or could be fed into
the review. But for AI making a guess at whether the submitted driver is
correct purely from the driver source - knowledge is useful.

