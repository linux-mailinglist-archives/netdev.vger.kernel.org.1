Return-Path: <netdev+bounces-232143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A7C01B72
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD621A01EE5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21626329C65;
	Thu, 23 Oct 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qNgKvpU2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373B329C44;
	Thu, 23 Oct 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229171; cv=none; b=fP0uxA0sw1/757oQnarCpNphJwaSxJAMEVwO0J11Es+LSo72EaYQDdSXtkfetf+P6zYGuAGjWTrZzO0xWBkm/W1nu90t/psUPHLqBR44boH8E3lR//0Dki1DeEB4uH0WfOxH1wPP53dt0TkGQeTgEOI1uyLFgEmsXErkTBKYDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229171; c=relaxed/simple;
	bh=HzqfBrlXW6O7F5EtXwkrAduCbaf4snx4zKoGIjdlgf4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=nUUsveo9Aa+HTiW+SH5E1Lis0nBqNiE0dqCRYJfux2jTBBT+5gxVKixjPeQtwbngnJhXg/gUvYyRQ/c1HJIz9pVQt8HTky7P+l7gfpJY5bSLHoLBI0EitoHq/ntPdQxBnklvr4j14bIgNVriSThTcaj3wd6PE3//tUs3vwKidi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qNgKvpU2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E44C01A1617;
	Thu, 23 Oct 2025 14:19:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B63326068C;
	Thu, 23 Oct 2025 14:19:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89A30102F2469;
	Thu, 23 Oct 2025 16:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761229164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HzqfBrlXW6O7F5EtXwkrAduCbaf4snx4zKoGIjdlgf4=;
	b=qNgKvpU2CjPJtQSwjcNfl3i9yQmN0DMrwzKhlKuzSSJkzQ4EV5jDSqQCVZqMA1W3sp6PiO
	ETXodZ91r7/aOSn28IpGGNP1/uqsIyUgvOFzIz3E08R3hOdcKbTEZ8NKgUWWHHwgo+JeyZ
	f7utcJj1XoBoSG+IMd8/dQH2XNG69Vj931NiL57TbTOGxCFWSYa+F9jZtP8NVW2LVY3S+1
	5wHnY8YpGOE2EblVzOPJ2wTazIbPuc9EZfD1ctm/7P10QyekbUd3QcCLDW0i9syTz4GWz0
	/nK/zbExk4Dek+76fBVpfVtiJGnvu6s4sOpYokxnhhkv3xnKEP4c7R5+SszR0g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 16:19:07 +0200
Message-Id: <DDPRMKIPAO90.3RFDT36LZP7CE@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 2/5] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>
To: "Andrew Lunn" <andrew@lunn.ch>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-2-7c140abb0581@bootlin.com>
 <7950f287-f025-40d9-b182-c1002d955a5b@lunn.ch>
In-Reply-To: <7950f287-f025-40d9-b182-c1002d955a5b@lunn.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Oct 22, 2025 at 9:27 PM CEST, Andrew Lunn wrote:
> On Wed, Oct 22, 2025 at 09:38:11AM +0200, Th=C3=A9o Lebrun wrote:
>> If HW is RSC capable, it cannot add dummy bytes at the start of IP
>> packets. Alignment (ie number of dummy bytes) is configured using the
>> RBOF field inside the NCFGR register.
>>=20
>> On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
>> be done if those dummy bytes are added by the hardware; notice the
>> skb_reserve() is done AFTER writing the address to the device.
>>=20
>> We cannot do the skb_reserve() call BEFORE writing the address because
>> the address field ignores the low 2/3 bits. Conclusion: in some cases,
>> we risk not being able to respect the NET_IP_ALIGN value (which is
>> picked based on unaligned CPU access performance).
>>=20
>> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
>
> Is this a real fix? You should not mix new development with
> fixes. Either post this patch to net, or drop the Fixes: tag for
> net-next.

No, it isn't fixing any platform that currently uses the driver.
Dropped the "Fixes:" trailer for next revision.

Thanks Andrew,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


