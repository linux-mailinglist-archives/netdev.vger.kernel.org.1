Return-Path: <netdev+bounces-255152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ3fCkW2fGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:46:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA0BB50B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1294F301E94F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550A2D8DC8;
	Fri, 30 Jan 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OshYGjNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D003EBF04
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780492; cv=none; b=OJIvYWD69Vi2pk9qofOs3j9Y72rIvFShMAWHe0UW1pET4TPBFG9isdfOmiDciR+wFdOCe46nT7HNSBBQMJ36KlCOvwgw8FPHD0zfZ6HUzsDJZ9Eyqb/h6OyZCGbmVsGaIgB1hOr5Jflh173F76zE3h9+6DslOYb6ZqU3Oq7VTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780492; c=relaxed/simple;
	bh=6FsHRzd7wh8PvCwk7n6nKCZEIEPbDL/cQG0WAumT5iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6WdcbxErpV/NUhyqTP8wYxBjLiphR0g+uTfm7hN+suEbDzGJMOhtPAXuAX1bihf/mhiKzdwU0RDJ+W3LI7orLBUiKlCyW0e9WIDKvXxytBvzlAEtyGp8k4nOEz1GEEeSWEc5kLEMsAVNYU09y1SCkOZUiQsPwiqfNHAfIFvXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OshYGjNO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 53B1D1A2B3A;
	Fri, 30 Jan 2026 13:41:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 246C26075A;
	Fri, 30 Jan 2026 13:41:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C4DE119A885C;
	Fri, 30 Jan 2026 14:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769780488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TxIA3Fag8gqy+7Gr2vgkUxxZMZWgXcdj2sE3kyvxrtM=;
	b=OshYGjNOI8uT264Wv8fROQ5dotDBe4P5mpasX/mFCf3HgmQozru5SyFyKDy3vhucSH6yAk
	tTQLsYjxAT9Ie11untOl64hQsbD6Ekb5QLngiwWrhG+JQUlzU25n1zZz1Mb4l3+tGAEKV9
	Jb4MmSVxq6fnbh3LGP6jkUaT1dF75YK/keSKD3g92ouQBwbCWJEZ3hl7jzqxSuQwmkqYFS
	UaGs9XL37nhuQP0UWxryU+6O7nsN7YPeMyp70lUeVP5joMlkPlfh1MU8vDs9V9YSVrNq6r
	OJLnJRFlGnU2xjvfLjVyVJaa0CcVsGO9b2C1wTeQ5raZ0wF3wzlQ4viD36d2rQ==
Message-ID: <874d4b28-754d-47b8-a207-9b73db403dba@bootlin.com>
Date: Fri, 30 Jan 2026 14:41:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper
 to retrieve ports
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-11-maxime.chevallier@bootlin.com>
 <7904208.EvYhyI6sBW@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <7904208.EvYhyI6sBW@fw-rgant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ECA0BB50B
X-Rspamd-Action: no action



On 28/01/2026 17:10, Romain Gantois wrote:
> On Tuesday, 27 January 2026 14:41:58 CET Maxime Chevallier wrote:
>> In order to allow netlink access to phy_ports, let's add a helper to
>> retrieve them. When handling a port coming from phy_link_topology, the
>> caller must hold rtnl until it's done with it.
> 
> Why not use rtnl-specific lockdep annotations to make this more explicit?

While this makes sure the call-site holds the lock as it should, it
doesn't guarantee the caller won't release it too early.

Doesn't hurt to add it though :)

Maxime

> 
> Thanks,
> 


