Return-Path: <netdev+bounces-302162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A9o/OlN3Pmp3GgkAu9opvQ
	(envelope-from <netdev+bounces-302162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:57:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 666716CD398
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:57:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=EolFRQOJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B4E3110B2F
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B303B71CA;
	Fri, 26 Jun 2026 12:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D72E738E;
	Fri, 26 Jun 2026 12:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478327; cv=none; b=lOZthbXFbpBRLGx5hh961nIUOFzdo88NjsiZ64TftwgoxEktSL0IJbFIrUqgnNCIIJzVTBHWAYrzeVjc8C44YYFD1BgGcWHLro2iQySZ9vSo72yUXD+L9vCmdv2VHmU7NIGzN4A/eJmcIq3upUSRDa6RwDOWASF02JNOHH6GbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478327; c=relaxed/simple;
	bh=tTqDR7zOiM2qyNd7uZJAKMTtun+yfIRh2Kyn9T78VKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COMIXY+DHozgD2eJRFzuwMUOTFpFrYZBw9Xv9HNZ6QOMZdNGl4e/AkQj7O/nZQNhAcl/FpM5ErSVjtZPlpMO7RytV1rPiFKCB9v8swwCzwM/HTE7Ate+jmHi+zxmNpN+XCbG08lYVaxFTy/Gig+ztE0xawSgFXVWeN7ODth3Fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EolFRQOJ; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B76614E40963;
	Fri, 26 Jun 2026 12:52:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E1BE60232;
	Fri, 26 Jun 2026 12:52:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 368B7104C832E;
	Fri, 26 Jun 2026 14:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782478321; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=i2vO7fCC7nzlP0MVLA0H+E4XsCLIQhR+6gSjUhWAc/s=;
	b=EolFRQOJslKVvd3W0wvTp6SYPSpXDQBYwnMmtW9sUtX8M2OGEdSqLg5Nb2NwJhBpbdhfPH
	UR+Qz2wW7IqAryHj4lkSbOoTTdQk7wVtLPqaBLHiZ/nYlnKyQw6Avu/O5qNoldIl6yOMon
	7P/S1Sisg1w/899lHdu7Dvsf2vCD+KZtXpeBwFcUME9Ud9DtEtDlGAZVCnAmp+5o27VtMU
	O5bEBxMomaNIB3ta6YzPLZcD/elS+YTkS0PK7I9G+kWS+YqeE9MFmN1PcoS0hNiu5n2FP1
	C57tY7EGiLOKRg0Tk19G2Z/wuhkDSPoK20SA6gxh+NTZLmpcR59HGE4TLDBMcg==
Message-ID: <d3faecf2-86f4-49e7-9fcf-fb5b48f45c1a@bootlin.com>
Date: Fri, 26 Jun 2026 14:51:55 +0200
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
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
 <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
 <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
 <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,bootlin.com:server fail,vger.kernel.org:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 666716CD398

Hi,

On 6/26/26 14:39, Andrew Lunn wrote:
> On Fri, Jun 26, 2026 at 10:33:50AM +0200, Maxime Chevallier wrote:
>>
>>> Sphinx follows pythons object orientate structure. So you could have a
>>> class test_ethtool_pause_advertising, with class documentation. And
>>> then methods within the class which are individual tests.  The
>>> commented out section would then be method documentation.
>>
>> Good point, so maybe something along these lines :
>>
>>  - A class for the test
>>  - methods for indivitual tests
>>  - For readability, I've written what the internal test helper would look
>>    like (_adv_test), and how a test would look like without the helper in
>>    adv_rx_on_tx_on().
>>
>> I'm already diving into coding, but it helps me a bit in the definition of the
>> "description" format :)
>>
>> this is what the class would look like :
> 
> I like this :-)

Great :)

> 
>>
>>
>>     @ksft_ethtool_needs_supported_allof([Pause])
>>     def adv_rx_on_tx_on(cfg, peer) -> None:
> 
> Using decorators is a nice idea. Since it is not a C concept, please
> give the decorator a good comment explaining what it does. We should
> not assume driver developers know python.

No problem, I'll add that

> 
>>         """Advertising test with rx on tx on
>>
>>         - run 'ethtool -A ethX rx on tx on autoneg on'
>>         - FAIL if the return isn't 0
>>         - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
>>           "Pause" or contains "Asym_Pause"
>>         - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
>>           "Asym_Pause"
>>         - Succeed otherwise
>>         """
>>         ret = cfg.run('ethtool -A ethX rx on tx on autoneg on')
>>         ksft_eq(ret, 0)
>>
>>         linkmodes = cfg.get_advertising()
>>         ksft_in('Pause', linkmodes, "rx on tx on must advertise Pause")
>>         ksft_not_in('Asym_Pause', linkmodes, "rx on tx on must not advertise Asym_Pause")
>>
>>         remote_linkmodes = peer.get_lp_advertising()
>>         ksft_in('Pause', linkmodes, "PHY does not advertise Pause")
>>         ksft_not_in('Asym_Pause', linkmodes, "PHY incorrectly advertises Asym_Pause")
> 
> There should be a sleep in here somewhere, to allow the autoneg to
> complete.

Indeed, I think in the end this will be wrapped by some ksft_ethtool_* helper we'll add,
that will also deal with the case where autoneg doesn't succeed and the link stays down.

That's both for error detections, but I also expect there might be cases we'll want to test
that autoneg does not actually succeed.

Good to see we're closing in on a definition, I'll spin V2 based on that format :)

Maxime


