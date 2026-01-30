Return-Path: <netdev+bounces-255148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPvMMH2zfGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:34:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993BBB159
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58869303E2EE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26292F6594;
	Fri, 30 Jan 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g0UYjyQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECE41C72;
	Fri, 30 Jan 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779932; cv=none; b=HRdjkHSU/5zzLga72JCCpKB+yZbMKoKVeiCRigRrRPrVxI8CGM7f72jMuY4Rt8Qn4LDUn8TKfMmf5GSe46vWhp6TC6GuvRFWZyWjeFpUcN6enZO7AoT8NaHI9Qs6PD/ehvaglqHlD14Qe6DkbeJt2mHdeittpFqoyhO4Vw4ATGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779932; c=relaxed/simple;
	bh=2Fe+uvebW57QddhLioe+sV7wWoWwZ9mpzRQAzut+Qz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWtLa08defOg3NumsW0Rhjo11C92s3pIqpA77O27nrOV4sEgkEc/JqvxY4lF8MTngwFh1TPm3TPdUTZUffTWutkBo8ie/q4p0gZ9iGh/cMPMAeO3zAK6MQzHS21rCKuCCLAeCf3SvlsyLensyB8cYgMLJHZ7v6+Ahsfqn9deYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g0UYjyQ/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 415BC4E42352;
	Fri, 30 Jan 2026 13:32:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0FED06075A;
	Fri, 30 Jan 2026 13:32:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46EE1119A885C;
	Fri, 30 Jan 2026 14:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769779928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kUdDAdEQ5dB1+T9hRpD64DsMUALWrPi1blB69+scbXY=;
	b=g0UYjyQ//wUGpvWs6x4xZ326HeIw4/nX+h67nk9Hrx8ur4md1G3gdwFOK0+cKJNkdDqU7q
	v/SrY/CgQt1WhLRwFZ9Tl3r4ezNQ/wt6DqO2agZwalKh07xhRAnqOqBPUdjJURqna/1+uu
	LGqzc60xF9L48M8B7vFjdhHbnjcpn0XNo/BiVNrS2/c1W4YTKHbE+XSjvkVTeKfQw7//UO
	ZLgdXbZqzh0vtKPm8M+ToB6jwZzWxT8uKuna4/67TLh15Dd4N3XsZ5tVThT1c9KNiBQP27
	WIkaUEWIMaGW21VNz1XdwaT1QgvKdjfDtpczmKa/3ZROjn65iPCE0e3A5GYIig==
Message-ID: <2b7b7c5b-53a4-4a1a-a98d-eac6190b0b55@bootlin.com>
Date: Fri, 30 Jan 2026 14:32:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/13] net: phy: Represent PHY-less SFP modules
 with phy_port
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
 <20260127134202.8208-8-maxime.chevallier@bootlin.com>
 <5045774.GXAFRqVoOG@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5045774.GXAFRqVoOG@fw-rgant>
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
	TAGGED_FROM(0.00)[bounces-255148-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2993BBB159
X-Rspamd-Action: no action



On 28/01/2026 16:54, Romain Gantois wrote:
> On Tuesday, 27 January 2026 14:41:55 CET Maxime Chevallier wrote:
>> Now that th SFP bus infrastructure notifies when PHY-less modules are
> 
> There's a typo here.

Ack

> 
>> connected, we can create a phy_port to represent it. Instead of letting
>> the SFP subsystem handle that, the Bus' upstream is in charge of
>> maintaining that phy_port and register it to the topology, as the
>> upstream (in this case a phy device) is directly interacting with the
>> underlying net_device.
>>
>> Add a phy_caps helper alongside to get the achievable modes on this
> 
> Alongside what?

Alongside this patch ?

I'll reword.

Maxime

> 
> Thanks,
> 


