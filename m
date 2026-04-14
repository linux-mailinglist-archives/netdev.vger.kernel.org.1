Return-Path: <netdev+bounces-278522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEygH29i3mldDgAAu9opvQ
	(envelope-from <netdev+bounces-278522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BD3FC23E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5879307AAD2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE953ECBF6;
	Tue, 14 Apr 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="CL5i3FQn"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCF3EC2FA;
	Tue, 14 Apr 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181760; cv=none; b=bcZI/5AmLz0wZor6/Mw5060eRU7tsarmKvKq+jR5N2KXkpvplKZ9NUntk/WGHMLJMmKUB8fKot2eNqNs1fDWA2sJ0n1NfdNfVfpaQS0AEAQxg7dEfuTvViRoBYF5vZx4cQ/900dYq/NzHfeSP9JnyTOlsq/oU2dsSxM11Qmb88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181760; c=relaxed/simple;
	bh=lCtbOIY4WtxwClhypFofTw2wPt/GmiDkQL/0RA9f+NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl7TBioilgxGM1x3npuCSN7nNpR6fNk1MJjMYEhrsqI9cHthYpB4L7x8PpRyrrR5dc3JRn1KJMiC9HhuTzGAddo6DBRU6Rq/AgsiPGgyQrcBhOAmPf3zC10uYkQF8cqxF6140SQGkB4Fag8sHzYMY3UtEj0lrjc2TlLSY8CSe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=CL5i3FQn; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17C7D10B258;
	Tue, 14 Apr 2026 17:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776181753;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KOlGm6LIMwIz0TDouH+mGysqykstlOHvUrCwPiHKjxA=;
	b=CL5i3FQn/1db1IoitpoghjEeggFo3hMh1M4wTD55/CC9GXBCWNNKSKe8+MxtbbcXQSUgjr
	MWAxVR1lBSQCPw7KL56diJXd020o5IaOvu+/fg2r7Y3UgXFIKbd7uidaKjkvVX+g2XSfbS
	rFeDTNUdAX4XCVERNgXU8cWSB976YhkAwLuq4It+rZg/dcIV8XamwaVyJnFWLkWyrAxEMq
	56tZtYV4QO/cJIOurHqRH8NXwDkYwg8lKO+MMk9Y9CzTa5SA/ROSP/0teCb5kf9Y7O1fTs
	nOS8mN4zhzKc4omPqlBkEU2I0hvbSVoatXJMwtaEGGUHSuFM2KRzzlRxomL23A==
Message-ID: <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
Date: Tue, 14 Apr 2026 17:49:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278522-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 259BD3FC23E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 2:40 PM, Andrew Lunn wrote:
> On Tue, Apr 14, 2026 at 01:05:49PM +0200, Marek Vasut wrote:
>> On 4/14/26 11:12 AM, Fidelio Lawson wrote:
>>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>>> Microchip document DS80000687C for KSZ87xx switches.
>>>
>>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>>> where the PHY receiver equalizer may amplify high-amplitude signals
>>> excessively, resulting in internal distortion and link establishment
>>> failures.
>>>
>>> KSZ87xx devices require a workaround for the Module 3 low-loss cable
>>> condition, controlled through the switch TABLE_LINK_MD_V indirect
>>> registers.
>>>
>>> The affected registers are part of the switch address space and are not
>>> directly accessible from the PHY driver. To keep the PHY-facing API
>>> clean and avoid leaking switch-specific details, model this errata
>>> control as vendor-specific Clause 22 PHY registers.
>>>
>>> A vendor-specific Clause 22 PHY register is introduced as a mode
>>> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
>>> translate accesses to these bits into the appropriate indirect
>>> TABLE_LINK_MD_V accesses.
>>>
>>> The control register defines the following modes:
>>> 0: disabled (default behavior)
>>> 1: EQ training workaround
>>> 2: LPF 90 MHz
>>> 3: LPF 62 MHz
>>> 4: LPF 55 MHz
>>> 5: LPF 44 MHz
>> I may not fully understand this, but aren't the EQ and LPF settings
>> orthogonal ?
> 
> What is the real life experience using this feature? Is it needed for
> 1cm cables, but most > 1m cables are O.K with the defaults? Do we need
> all these configuration options? How is a user supposed to discover
> the different options? Can we simplify it down to a Boolean?

The report I got was, that if the device is cooled down AND the user 
used special short low-loss CAT6 cable, then there was packet loss until 
the communication completely broke down.

With the LPF set to 62 MHz and DSP EQ initial value set to 0, that 
situation improved and there was still up to 0.14% packet less, but it 
is better than total breakdown of communication. We couldn't get the 
packet loss down to 0% no matter which tuning we applied.

> Ethernet is just supposed to work with any valid length of cable,
> KISS. So maybe we should try to keep this feature KISS. Just tell the
> driver it is a short cable, pick different defaults which should work
> with any short cable?

I think the user should be able to configure the LPF bandwidth and DSP 
EQ initial value as needed. While the short cable improvement settings 
are "LPF set to 62 MHz bandwidth and DSP EQ initial value to 0", there 
might be future configurations which require different settings.

I think the ideal setup would be if those two settings were configurable 
separately, with a bit of documentation explaining the two currently 
known good settings:
- Default (LPF 90 MHz BW, DSP EQ initial value as needed)
- Short cable (LPF 62 MHz BW, DSP EQ initial value 0)
But if the user needs to reduce the BW further e.g. to improve noise 
resistance further, they shouldn't be prevented from doing so.

> A boolean should also help with making this tunable reusable with
> other devices. It is unlikely any other devices have these same
> configuration options, unless it is from the same vendor.
Could the LPF PHY tunable simply take integer as a parameter ? Then it 
would be portable across other PHYs I think ?

The DSP EQ initial value can also be an integer tunable.

