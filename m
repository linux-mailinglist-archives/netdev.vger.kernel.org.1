Return-Path: <netdev+bounces-302020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9H7HBIlRPWrx1AgAu9opvQ
	(envelope-from <netdev+bounces-302020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A133B6C7475
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:04:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=O1CuqApn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17CFE302A4DA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C723E8338;
	Thu, 25 Jun 2026 16:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA683E6DC6;
	Thu, 25 Jun 2026 16:04:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403461; cv=none; b=khbrr7HBKhtQCZQbE4C6hB/TQ4BKZEsBGPT6XW1Jo3JK0rAO/H0V+OEjAmWBcNjCtEkWTbk5c35QcD0EW81OwxGqEnRwZB6FRZb10Na+kYB/9q5Qac1INXvO77K7lP5sBK5LdKEVKGd9gCU2jKSdquym5wdbBWYjWt8LEvOF0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403461; c=relaxed/simple;
	bh=XW3SzIEXudbXYq7PqSSb1LBoVhsyZbg4Bfj+ybVG9kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnLpG6kqdj4yP+0IGgrUIuGcqSC046u/lQE1Fx3NPjogqN3Z21B6Cju0CnuHiitOxeLB/5GIKDNTFzNtFo7L+Nf+dLuKg0KuDdkpyDY78n84FEZYuXjkYn5kj/8qfVqwd4glxNeovIYq99FN+A7nV5tzDkalSSfF/8z8vVrJtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O1CuqApn; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1FEFC5CD54;
	Thu, 25 Jun 2026 16:04:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37CA960220;
	Thu, 25 Jun 2026 16:04:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC886104C974F;
	Thu, 25 Jun 2026 18:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782403448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rj4K5nBqdL50bEj1X13u+dnWAqWMlIUbG7uN0Y70STY=;
	b=O1CuqApnXCMMrvrHYXL1wRPyPgifoZSIg3AMIdGY6ee1lLC2yxnQkrTUu27eWupa3VdrSj
	0VxUp6cPCDNusNd8CuUnj9wtYOeMvDlWFNzvua+93+jmHoiYW8dAjKzuVBa/o6d/ANaUwj
	wShZhnK5YAMzURy66mXbBXIuI8MwtuJMK4JjMfLgXx84uSgWJRVQn5+FRkSohcjM1ah18d
	Mxs3uzffS3xzDti6moRmT8W37djHQ5roZ8A8HsuME+/z33Nmsj2c68u8mgY1kSzlghn/2a
	Wr1tqntjb7ZbEcvvw6mxKY/C9Vzh8ixGBtHQNHbMLbxr5YBps4bm1QvIs2LIVQ==
Message-ID: <a343776c-02ea-475c-a354-7cdfc647afeb@bootlin.com>
Date: Thu, 25 Jun 2026 18:03:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
 <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
 <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
 <7a88fee8-bbb3-480f-9c93-677b7270a940@bootlin.com>
 <dfee1484-fa2a-4b98-af5a-1e67ac716905@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <dfee1484-fa2a-4b98-af5a-1e67ac716905@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302020-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A133B6C7475


> 
> Does it even make sense to advertise this when in HD? But i don't
> think we need to consider this now. I consider HD low priority, i
> doubt it is actually used very often. We should concentrate on FD
> testing.

That's fine by me as well, let's keep it simple, we may revisit that if
we really need to.

> 
>> # ethtool -a eth2
>> Autonegotiate:	on
>> RX:		off
>> TX:		off
>> RX negotiated: on
>> TX negotiated: on
>>
>>
>> Sure, pause and HD don't make sense, however what I find confusing to some
>> extent is that the only place we have information about the *actual* pause
>> settings is the "link is Up" log in dmesg.
> 
> Maybe we should extend ksetting get to return the resolved pause
> parameters? But i'm not sure how much that actually gives us. Anything
> using phylink will just ask phylink to fill in the ksettings
> information, and it seems unlikely phylink gets it wrong. What we are
> really trying to test is drivers which don't user phylink, those are
> the ones which are generally broken, and they are not going to
> implement anything new in ksettings.

Correct yes. If the MAC driver uses phylink and a test fails, it very likely
means that the PHY driver is doing shady stuff (and some are/were for pause)

> So i think the test has to look
> at:
> 
>> 	Advertised pause frame use: Symmetric Receive-only
>> 	Link partner advertised pause frame use: Symmetric Receive-only
> 
> and check these match what we expect.

All good for me :) thanks for you feedback,

Maxime

