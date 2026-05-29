Return-Path: <netdev+bounces-293045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMu/OhJLGWrzuQgAu9opvQ
	(envelope-from <netdev+bounces-293045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:15:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88745FF0D4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7BF3021D2A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8083ACEFE;
	Fri, 29 May 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CKY7stOc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E82EC0B0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042055; cv=none; b=dIFM1C3jLXJtjtWepJz7YEvKpdmqmeWNQsGk9AScvOjyZG1+9OAbcxKEGr3ik5hx7mv8fA9KMaFUUf04Wl9wRLxyOuOHsIcC/3ObhAamJiHdTV2GDpmbciSr0BgemTKppW5x4JGAS+SpBCo2Oz8CYVzPIDNdw9gzlme+HI1733M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042055; c=relaxed/simple;
	bh=vPRRXaXjoTYY9dJCQ1fK2GUOqj9LWdoMZQW4RpFc89I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYQUEOG4+2kV20z8//LFnP2vpO2ROODta+NzJk+AqmGqjGwnAaOgu7qpqJNT84RTIwSRDEDOOzacHstBmgz7Dfd85srxKBed9G1TJhbsEp2PwLpzce7WeIOTRfk04hfpsMV2utkKGXs54wk+K9DhaDRxGjBcSSk0z8/JK0NMJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CKY7stOc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 280024E42D83;
	Fri, 29 May 2026 08:07:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8FC1601FA;
	Fri, 29 May 2026 08:07:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5936C10888CCC;
	Fri, 29 May 2026 10:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780042034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jGlRn1W5ouwjxABCkERxBzbsQlWsYNZ5t3xkrUTSUSY=;
	b=CKY7stOcVz7q/LljMtLpxhEAP7WzWgJXglKSaenuFWf0om19acmrvNnk3PZCYYPSdBQtOH
	VqWuH71AU/wjkGCV7drwxgZ4/NqYqHYLiwdMUg390ZugntlcUm1f+ChVI3amuuX+/Cim38
	wJcUQgmrkHSNQqdnj/LUy4RL8twalD0U3WWsKmDr5ZpvOVcTKUFRTHixnLcoskRaeXi0VF
	SPV31NqaGzZzKwm20sPCOykc25qYL0V5T64wc6fggVbK4p4Ubb1kb6xaYrOxMQrv7waKqt
	qp6EzIvRFFQB2IXDBDK65Dl3AOSb+diN/+lSnEOW6UEkuHe8E/fS2+i9b4KaOA==
Message-ID: <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
Date: Fri, 29 May 2026 10:07:02 +0200
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
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293045-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: E88745FF0D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 03:15, Andrew Lunn wrote:
>> +A.1 : Sanity Checks
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +Pause autoneg is set to off::
>> +
>> +  ethtool -A <iface> autoneg off
>> +
>> +The 'supported' fields retrieved using the ETHTOOL_MSG_LINKMODES_GET includes
>> +a "Pause" bit and an "Asym" bit.
>> +
>> +The ETHTOOL_MSG_PAUSE_GET command returns the currently configured pause modes
>> +in the "tx" and "rx" attributes.
> 
> What you have left unspecified here is the state a link autoneg,
> 
> ethtool -s <iface> autoneg on|off
> 
> At minimum, it should be specified. I've not read the other tests yet,
> but we may also want to run this basic test with both possible
> setting.

True ! With a more formalized test description, it should be easier to
get non-ambiguous starting conditions here.

> 
> One possible bug which we are trying to detect is that pause autoneg
> is off, the values are forced, but -s autoneg is on, it completes, and
> overwrites the forces values with negotiated values.

I'm trying to cover that on the latter tests indeed

> 
> 
>> +A.2 : Half-duplex operation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Pause settings as exposed with the ethtool API only concern full-duplex modes.
>> +
>> +Test scenario:
>> +--------------
>> +
>> +Set the interface under test in half-duplex mode with::
>> +
>> +  ethtool -s <iface> duplex half
>> +
>> +Expected behaviour::
>> +
>> + - ethtool <iface>
>> +
>> +shows no Pause settings advertised.
> 
> Since we are talking about advertisement of pause, i think you actually want
> 
> ethtool -A <iface> autoneg on
> ethtool -s <iface> duplex half autoneg on
> 
> If -s autoneg is off, nothing should be advertised. So we need that
> turned on. And if -A autoneg is off, no pause values should be
> advertised, so you need that turned on as well.
> 
> Also, since we expect this to trigger an autoneg, we probably want a
> sleep(2) in there before looking at the results, to ensure autoneg has
> completed.
> 
> There is also the possibility that the link does not come up, because
> the link peer does not support half duplex. This is quite common for
> 1G interfaces. It could also be the local interface does not support
> 1G half. So maybe
> 
> ethtool -s <iface> duplex half speed 100 autoneg on

I think that

   ethtool -s <iface> duplex half autoneg on

should be enough, the link should still establish at 100M, I've tested
that on a 1G/FULL 100MHalf+Full interface and this is the result we
get :)

That said I've tested the following on mcbin, and it seems that acually
nothing in the code currently deals with Half duplex / Pause 
interaction, and we don't get any EOPNOTSUPP.

So the broader question is, should we reflect the current behaviour or
an ideal one ?

And if we reflect the current one, the canonical behaviour is probably
the phylink one ?

> 
> Or let it first autoneg unrestricted, look at both the local and LP
> values, and pick a half duplex link mode both support and set it to do
> that?
> 
> The tests defined so far also don't cover all the possible settings of
> -A autoneg and -s autoneg. There are combinations:
> 
> Link autoneg with pause autoneg
> Link autoneg with forced pause
> Force link, with forced pause
> 
> It would be good to consider what can be tested for these three. Maybe
> nothing can be tested with forced link, because that it likely to
> result in no link, when only the local side can be configured.
> 
>> +B : Combined devices testing
>> +============================
>> +
>> +Requirements : The interface under test must be connected to a link-partner that
>> +can be actively configured during the tests. It must at least support full-duplex
>> +modes, and optionally (but ideally) symmetric and asymmetric flow-control, as
>> +well as autonegotiation of the Pause parameters.
> 
> and forced link parameters.
> 
>> +
>> +B.1 : Autoneg advertising
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Goal: Validate that the *advertised* Pause and AsymDir bits match the configured
>> +pausemarams.
> 
> typo.
> 
>> +
>> +The link-level autonegotiation must be enabled::
>> +
>> +  ethtool <iface> autoneg on
>> +
>> +Pause parameters are set with::
>> +
>> +  ethtool -A <iface> rx <val> tx <val> autoneg on
>> +
>> +Pause advertising is retrieved with::
>> +
>> +  ethtool <iface>
>> +
>> +Case 1
>> +------
>> +
>> +Pause parameters : rx **off** tx **off**
>> +
>> +Expected advertisement : **None** (Pause = 0, AsymDir = 0)
>> +
>> +Case 2
>> +------
>> +
>> +Pause parameters : rx **off** tx **on**
>> +
>> +Expected advertisement : **Transmit-only** (Pause = 0, AsymDir = 1)
>> +
>> +Case 3
>> +------
>> +
>> +Pause parameters : rx **on** tx **off**
>> +
>> +Expected advertisement : **Symmetric receive-only** (Pause = 1, Asymdir = 1)
>> +
>> +Case 4
>> +------
>> +
>> +Pause parameters : rx **on** tx **on**
>> +
>> +Expected advertisement : **Symmetric** (Pause = 1, Asymdir = 0)
> 
> We should consider here what happens when the local side only supports
> symmetric pause. We would expect EOPNOTSUPP, or maybe EINVAL. If
> ethtool report:
> 
> 	Supported pause frame use: Symmetric Receive-only
> 
> not getting an error for the asymmetric settings would be a bug.

Ack, I think all test cases will need to account for the local device
support

> 
>> +
>> +B.2 : Autoneg resolution
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Goal: Validate that the Pause and AsymDir negotiation translates to the right
>> +TX and RX pause parameters.
>> +
>> +The following table, from the 802.3 standard, exposes the autoneg resolution
>> +result for the advertised pause parameters by each link partner.
>> +
>> ++-------------+--------------+--------------------------+
>> +|Local device | Link partner | Pause settings resolution|
>> ++------+------+-------+------+-----------+--------------+
>> +|Pause | Asym | Pause | Asym | RX        | TX	        |
> 
> There is a tab vs space issue here.
> 
> 
>> ++======+======+=======+======+===========+==============+
>> +| 0    | 0    | Any   | Any  | No        | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +| 0    | 1    | 0     | Any  | No        | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +| 0    | 1    | 1     | 0    | No        | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +| 0    | 1    | 1     | 1    | No        | Yes          |
>> ++------+------+-------+------+-----------+--------------+
>> +| 1    | 0    | 0     | Any  | No        | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +| 1    | Any  | 1     | Any  | Yes       | Yes          |
>> ++------+------+-------+------+-----------+--------------+
>> +| 1    | 1    | 0     | 0    | No        | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +| 1    | 1    | 0     | 1    | Yes       | No           |
>> ++------+------+-------+------+-----------+--------------+
>> +
>> +The mapping between the configured pause parameters and advertised modes follow
>> +the following truth table :
>> +
>> ++----+----+-------+---------+
>> +| tx | rx | Pause | AsymDir |
>> ++====+====+=======+=========+
>> +| 0  | 0  | 0     | 0       |
>> ++----+----+-------+---------+
>> +| 0  | 1  | 1     | 1       |
>> ++----+----+-------+---------+
>> +| 1  | 0  | 0     | 1       |
>> ++----+----+-------+---------+
>> +| 1  | 1  | 1     | 0       |
>> ++----+----+-------+---------+
>> +
>> +We can boil that down to the following cases to test, keeping the number small
>> +to avoid dealing with the whole combinatory::
> 
> Why not do the whole set of combination? There are 16 combinations,
> autoneg takes a little over 1 second, so we are probably talking 32
> seconds in total. That is a reasonable runtime for a test.

True, I'll describe the whole set then :)

> 
>> +Case 1
>> +------
>> +
>> +Local device : rx **off**, tx **off**
>> +Remote device : rx **on** tx **on**
>> +
>> +Expected result on local device after autonegotiation completes :
>> +        rx negotiated **off**
>> +        tx negotiated **off**
>> +
> 
> ...
> 
>> +Case 7
>> +------
>> +
>> +Local device : rx **on** tx **on**
>> +Remote device : rx **off** tx **off**
>> +
>> +Expected result on local device after autonegotiation completes :
>> +        rx negotiated **off**
>> +        tx negotiated **off**
>> +
>> +Case 8
>> +------
>> +
>> +Local device : rx **on** tx **on**
>> +Remote device : rx **off** tx **on**
>> +
>> +Expected result on local device after autonegotiation completes :
>> +        rx negotiated **on**
>> +        tx negotiated **off**
> 
> what also needs to be considered here is:
> 
> What if the local side only supports symmetric pause?
> What if the LP only supports symmetric pause?
> 
> The expect results should take this into account, that the
> configuration fails, but that is not a test failure, just a hardware
> limitation.
> 
>> +
>> +B.3 : Pause Autoneg
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +Goal: Validate that the Pause autonegotiation flag correctly toggles the
>> +advertised Pause and AsymDir link parameters.
>> +
>> +Test scenario:
>> +--------------
>> +
>> + - Enable pause autoneg and at least rx or tx pause::
>> +
>> +        ethtool -A <iface> rx on tx on autoneg on
>> +
>> + - Check the Advertised pause frame use::
>> +
>> +        ethtool <iface>
>> +
>> +        ...
>> +        Advertised pause frame use: Symmetric Receive-only
>> +
>> + - Disable pause autoneg::
>> +
>> +        ethtool -A <iface> autoneg off
>> +
>> + - Check the Advertised pause frame use, which must be 'No'::
>> +
>> +        ethtool <iface>
>> +
>> +        ...
>> +        Advertised pause frame use: No
> 
> Please describe configuration for both sides. This is needed for all
> the tests when there are two devices involved.
> 
> Also, when local pause advertisement is turned off, check what the
> link partner is reporting it received from its link partner.

Very well, I'll add this.

Thanks for the extensive feedback Andrew,

Maxime

