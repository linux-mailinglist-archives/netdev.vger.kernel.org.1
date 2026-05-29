Return-Path: <netdev+bounces-293120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDKFO4uTGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3C602CEB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B375C3050C90
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82432ED29;
	Fri, 29 May 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYX4w9xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7832B12F;
	Fri, 29 May 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060831; cv=none; b=gXLj6O57e03tqxWePRjoLSw0031F4OUkWpWaPD2imkjlr/ZxCFi3D4CQvrnpz8FTLKuuqoMUwjHELTLhnOc6wrXyIDBo3M3KYXJVt3eZuPeKStAsauiVnjcDMedWpfQ92cMh9jt9meLsYkeOowpC0QA7l7CP0nRD18BPMekxxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060831; c=relaxed/simple;
	bh=1uzMhR3bJtbMNHekAoRuuTpuHLn8hbeLZLlH6OxhlZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jR8Mmuvz+vNvRk9zsrONom+k4sDQESS41XRPlURcTF7PYgNb80kR53CAc8Tq1dDElZs+0uRylvL7cdBI7YDC1M4DYHA3MILx9G89ek2w4BMFUN4XY/YA7KaBi548RMWUD+kc8vXq2N3AZt6zYG/jZaH9WvWD4spzWMQZAVMggQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYX4w9xd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AB4821A3737;
	Fri, 29 May 2026 13:20:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E7D8601FA;
	Fri, 29 May 2026 13:20:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2FF110888244;
	Fri, 29 May 2026 15:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780060825; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bCAAPrlwJxq0MC6d9Ux1eRB29n5MQsEyAgQNN0bZdZU=;
	b=XYX4w9xduWOTYWkqcKsFZefM43MaWMq90eh8emIc1k0Nkxqrp8HCJByyY8A0dk5CWtOyTa
	GKyoGwLDQJxveA2DgnRS/qBT3HK51pKXT+vgihvOBvZJCVgjjzJNIUdad6YKTz0MO9tcd5
	L15oKynNRVR28vLEJy8KeQwqENonlpRGDxf6NrxdU7fhKenrL+4o9E4c1B4ARuMMygjEBr
	LpjKTbVmBHm5TWLwLPWDBv9MDRe1L6RoXhiBLMIQHTmP7pulFPW7z6/TD/xMFeUXb+/+ve
	jO93endsaXSIIIu+gfwdd8U6Gs0YfTJ0A3B7iWTcz9ag+tXrx5WvYykURzVW+g==
Message-ID: <1dd49a4a-612f-4e07-beb1-c2955a8a4002@bootlin.com>
Date: Fri, 29 May 2026 15:20:13 +0200
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
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293120-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 50F3C602CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/29/26 14:59, Andrew Lunn wrote:
>> I think that
>>
>>    ethtool -s <iface> duplex half autoneg on
>>
>> should be enough, the link should still establish at 100M, I've tested
>> that on a 1G/FULL 100MHalf+Full interface and this is the result we
>> get :)
> 
> Nice.
> 
> But i still think the test should check the autoneg result and do
> something sensible if the link does not come up. This probably applies
> to all cases where we trigger auto neg.

Yes indeed, we need some sets of helpers to deal with link management, 
especially for this kind of ethtool tests, with ways to recover a known
working configuration.

> 
>> That said I've tested the following on mcbin, and it seems that acually
>> nothing in the code currently deals with Half duplex / Pause interaction,
>> and we don't get any EOPNOTSUPP.
>>
>> So the broader question is, should we reflect the current behaviour or
>> an ideal one ?
> 
> What 802.3 says. 

Ok, this is what I've been using to define the documented cases so far:)

> If we come across cases where phylib/phylink is
> broken, let me know, and i will fix it. But we will leave driver bugs
> to individual driver developers.
> 
> But we also need to consider that for some APIs, we have decided that
> a configuration can be set now, which does not actually apply in our
> current conditions, but it will be stored away for when conditions
> change and it is applicable. The half duplex case could fit that. When
> the link is currently half duplex, you can configure pause, but you
> don't expect it to actually change the current behaviour. It only
> kicks in when the link renegotiates to full duplex sometime in the
> future. We have to also consider this the other way around. The link
> is full duplex and pause is configured by the user. Something happens
> with the LP and the link renegotiates to half duplex. The local end
> should not throw away the configuration, it simply cannot apply it
> given the current situation.
> 

True, so the end result is that we must not error out when changing the
pause params while the link is in half duplex, but store the user intent.

Maybe an exception is if we only advertise HD modes ? i.e. HW can't do
FD, or user forced HD modes ? even then, ethtool will show that we
aren't advertising any Pause modes, so maybe that's enough.

OK maybe in the end the best course of action is to leave this 
discussion here and I followup with :

  - Well defined test cases in a machine-readable (or human readable but
    with much more details) format, including start conditions, a
    decision tree based on the "supported" fields

   - A list of identified corner cases that may be ill-defined (such as
    this HD topic) that we can openly discuss and potentially followup
    with code fixes

  - Human readable doc for developpers and AI to ingest

Maxime



