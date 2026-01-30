Return-Path: <netdev+bounces-255150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM83Gce1fGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:44:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C2BB4BB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448B130B43E0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626A3093BF;
	Fri, 30 Jan 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0bALYC4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72577080E;
	Fri, 30 Jan 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780323; cv=none; b=Gonqvprhm4+WD1cQzbvsOOUrpDtj8sCrxAKDT3O+pIrm7cpcjBNLrqehFQ8bgsHIqzdaOEKF7nWpiFjJbNf4uKjCRFm8VUSKxfYi4Hv2bYP5ZIk401xqRqSHumoDxRIbuxmoFtIoQ/tex70XlN2DMoxo8xvqjY5D0zu/PAOiTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780323; c=relaxed/simple;
	bh=PMocOKdCGO6bNS6nHdvN+kFQVrDbECuyZJg+Lq2KYvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sedTsWBY9s5lu8PrpJ4i5SjxuJ8A5vkpNAxaDvzvuqsq0aQMOvA81r0QOeIpsyIT4eN4bckDzmCxWXpqtQ/rhFo/49SV2+Sp3P+CbO+C7MvxeD4TW965YpQJbpn6vJqxXt2r52IH1oc5t6gb9MqoWjm0vToNkgYrTtUuNkMwHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0bALYC4H; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 97D671A2B3A;
	Fri, 30 Jan 2026 13:38:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63D456075A;
	Fri, 30 Jan 2026 13:38:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBF62119A885C;
	Fri, 30 Jan 2026 14:38:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769780318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8Qu/i4Y24RTbep6GsFX5lSUQ5VRcuRzfQfonCPfOdiU=;
	b=0bALYC4HvOhpsKoswIhbXZldV0mOCw1oK8p0uUq4SvfMUIkEAMoRETWyY2xNLgBYU26BWa
	UZ5euBCpReadfQ1qhAbfaVo6nBSBfJFkOY1vYxm/IV82LDMhxcaAojL+ir8Dpk8ktTmjeF
	9LE+cXpHfwPjkXvceVFDI6rz1cPeaZWjlK3fWtQs4ppLX/XES/uWimgq4rnkoc4QFcA0LA
	v5rqSWWx0TtxFmUbyNZfiCz8BqKuBERqgCAWFGUR5RkoQA6z4KZloxdB+H1o79XwoXkbRJ
	ghuPSnKYDNqxT3G2PrLaeYNjLPstvAbOk/a3jwvriMwJ3QuOKnqomIexWzBlGw==
Message-ID: <6403ac87-38b7-4d68-919a-09a8394d6209@bootlin.com>
Date: Fri, 30 Jan 2026 14:38:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/13] net: phy: phy_port: Store information
 about a MII port's occupancy
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
 <20260127134202.8208-10-maxime.chevallier@bootlin.com>
 <2338720.iZASKD2KPV@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <2338720.iZASKD2KPV@fw-rgant>
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
	TAGGED_FROM(0.00)[bounces-255150-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: BB9C2BB4BB
X-Rspamd-Action: no action



On 28/01/2026 17:08, Romain Gantois wrote:
> On Tuesday, 27 January 2026 14:41:57 CET Maxime Chevallier wrote:
>> MII phy_ports are not meant to be connected directly to a link partner.
>> They are meant to feed into some media converter devices, so far we only
>> support SFP modules for that.
>>
>> We have information about what MII they can handle, however we don't
>> store anything about whether they are currently connected to an SFP
>> module or not. As phy_port aims at listing the front-facing ports, let's
>> store an "occupied" bit to know whether or not a MII port is currently
>> front-facing (i.e. there's no module in the SFP cage), or occupied (i.e.
>> there's an SFP module).
> 
> To me, "front-facing" refers to things like user ports on a switch versus CPU-
> facing ports, I don't find it intuitive to use it to qualify a port's state of 
> being connected to an empty SFP cage.
> 
> Why not use something like "vacant" or "empty" instead?

ah 'vacant' was the term I was looking for !

OK I'll update, I like that better :)

Maxime

> 
> Thanks,
> 


