Return-Path: <netdev+bounces-256416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P2XKpA6gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:12:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1DDD60D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 842FC30498FB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49D39E6F7;
	Tue,  3 Feb 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vs2LDm6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953332693F;
	Tue,  3 Feb 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142348; cv=none; b=prIaCKvmBaBm32Aa68Jx63CMVNZhI2TcjsNwqN7myAm074GVG7MHc05HDI5quVmTmNPv8YnnO3Xo+ys9WRG1JVDCjG40eEOu5E7s9kFYwdYyMxIUlbIl8kVQDZlc6HA9gsL2QaPU7vq6r50AgKAQYjXQAtk/yFSa8n9rxg+iwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142348; c=relaxed/simple;
	bh=y5GsAopZikx1vLw5N6IlLqyBOY8W9lcRaURsuG275sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKY0b+58TvCwSEoftBhJh7E1qWkQZFoCSjr4mMdCLk2wwGJGsIuFhdzFQ5X8w+ATUthZ2erCz62NZCYoy8hHwnLwf7ZhBxada7Ni7zitJ5KfB49TOxyD4RXnnqoJrBqXrdkz+VDtY/rT7Sq9pKc67pG1oJjNgxRkkahexN7rSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vs2LDm6c; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0DC44E423E4;
	Tue,  3 Feb 2026 18:12:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7855360728;
	Tue,  3 Feb 2026 18:12:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B848119A8888;
	Tue,  3 Feb 2026 19:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j9eEii8CtOD3T3WlH803AHmufnrBS1E6wpf/iOVv4YQ=;
	b=vs2LDm6c2Y7xYpHssTc2VXg/W8y3z32+63+Gmv15wlDyTDUUDRGCXqWxwRqyGssZgRmXM8
	zK96lJrkVRzn8Rigz8iLMLZ68XdIw29jM3Ij+Xxu0ygHJc7E6bjUVIi9DVsm0FfBTSh6SC
	slqENv90TXbeh8t64m8TbVdJ1uxgLRFjaiNVZaWLMWl/N8ALt7CEkkFOBnGz1iDxJ8R4Z1
	EJKYDCx15Nd/iWpzSsOXyavIM9YQLEp/R6hKVzaH9Zns6nYRnHhJwg9qr3SaJ7gndTMQqH
	GlkFG33f7DKywsqTrSEUZ1TQqFl4we5IG2vG5MLnOBFwLC29sJwrj38fc27pNw==
Message-ID: <849815af-9f8f-4703-bab3-167b65cd7b69@bootlin.com>
Date: Tue, 3 Feb 2026 19:12:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,05/11] net: phy: Create SFP phy_port before
 registering usptream
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, edumazet@google.com,
 o.rempel@pengutronix.de, andrew@lunn.ch, christophe.leroy@csgroup.eu,
 kuba@kernel.org, pabeni@redhat.com, thomas.petazzoni@bootlin.com,
 nicveronese@gmail.com, kory.maincent@bootlin.com, mwojtas@chromium.org,
 daniel@makrotopia.org, dimitri.fedrau@liebherr.com,
 herve.codina@bootlin.com, linux@armlinux.org.uk, vladimir.oltean@nxp.com,
 kabel@kernel.org, romain.gantois@bootlin.com, f.fainelli@gmail.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org
References: <20260201151249.642015-6-maxime.chevallier@bootlin.com>
 <20260203180311.2175469-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260203180311.2175469-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,pengutronix.de,lunn.ch,csgroup.eu,kernel.org,redhat.com,bootlin.com,gmail.com,chromium.org,makrotopia.org,liebherr.com,armlinux.org.uk,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41E1DDD60D
X-Rspamd-Action: no action

Hi Simon,

On 03/02/2026 19:03, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: Create SFP phy_port before registering usptream
> 
> This commit moves the creation of the SFP phy_port to occur before
> registering the SFP upstream ops. This reordering allows passing
> the phy_port along with the upstream information to the SFP bus.
> 
>> net: phy: Create SFP phy_port before registering usptream
> 
> This isn't a bug, but there's a typo in the subject line: "usptream"
> should be "upstream".

That's aleady addressed in V4 :)

Maxime

