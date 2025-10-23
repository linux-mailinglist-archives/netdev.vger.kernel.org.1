Return-Path: <netdev+bounces-232144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4EC01B85
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18693188CA9F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D5329C54;
	Thu, 23 Oct 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PkZlHRgh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DB2C08BA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229224; cv=none; b=rCYlK1uVqJERfCXpbC4wPaNg2c77fxVQuTY+COn31/WVeeyWxmYEQxWoLF0RNIhrNk16TO6J00PO3x8bCwLWKtD14aUKrpR+INLn4upSoeicqQ9aWyuwiWNKonoFrUyNXd/SPNqHqkSYcd9SCLAHSr6cmSxsC3Cu6JjpdVLVDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229224; c=relaxed/simple;
	bh=t4XAMtlQ87nQTynvcekkQhTGmcfXyfcCovczOm0sFp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=u+2i0ezaPEVoGippc1uQdEBtCHh9NbU2801EiokXuCXB9ztDBT1MkJgN8BUI3EWXffr9W249FWBwEVqmZppUu8zd90MmMDHNWgqNsKHvOK4POUV5QpPC3D00Ppx77O4+fvhs6bgW8r6ZfyanVUQwaho6NS1xCKJ72mnl3msnJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkZlHRgh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 12C544E41295;
	Thu, 23 Oct 2025 14:20:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DAF436068C;
	Thu, 23 Oct 2025 14:20:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95066102F2467;
	Thu, 23 Oct 2025 16:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761229219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t4XAMtlQ87nQTynvcekkQhTGmcfXyfcCovczOm0sFp8=;
	b=PkZlHRghL79Owhl/cu3HX506BAbg9Ulr67THDScpepEFLIyIBSX8QZ6wjhov7HI3MkhflN
	YbNKiCbCXUmuH00e5dIQQvFIl74MSCulsjRB1L7W42oLGMKu7ymEPTF/9tiauPI0BzNHRK
	nOIiWenY8PIitQUtDl1ICo+fOoAjZ18BO6cVs3oDs9uN1wrwC1p5kE7RZ1BHoDVxRpy8hs
	j3+wbOK/PQxzQ+hLCJKzK5PvXJRT5ouuuotfkDdL5xEcO0xtwJTdihBuOTRGIzj+LQ8kfk
	98JXEzm8nqU2JZhyj0EDfYpSSCelX/AFFwjSt8+t115//coe18INk75gCdtIsw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 16:20:16 +0200
Message-Id: <DDPRNG6XVUMS.3RIOD71L748WE@bootlin.com>
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Russell King" <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
 <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
 <51833ec4-e417-4ba3-a6d1-c383ee9ea839@lunn.ch>
In-Reply-To: <51833ec4-e417-4ba3-a6d1-c383ee9ea839@lunn.ch>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Oct 22, 2025 at 9:33 PM CEST, Andrew Lunn wrote:
> On Wed, Oct 22, 2025 at 10:09:49AM +0200, Maxime Chevallier wrote:
>> Hi,
>>=20
>> On 22/10/2025 09:38, Th=C3=A9o Lebrun wrote:
>> > Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, usin=
g
>> > compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
>> > that must grab a generic PHY and initialise it.
>> >=20
>> > We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding =
a
>> > phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
>> > the first users of bp->phy that use it in non-SGMII cases.
>> >=20
>> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>>=20
>> This seems good to me. I was worried that introducing the unconditionnal
>> call to phy_set_mode_ext() could trigger spurious errors should the
>> generic PHY driver not support the requested interface, but AFAICT
>> there's only the zynqmp in-tree that use the 'phys' property with macb,
>> and the associated generic PHY driver (drivers/phy/phy-zynqmp.c) doesn't
>> implement a .set_mode, so that looks safe.
>
> I was thinking along the same lines, is this actually safe? It would
> be good to add something like this to the commit message to indicate
> this change is safe, the needed code analysis has been performed.

Sure, will integrate a summary similar to my reply to Maxime's message.
https://lore.kernel.org/lkml/DDOQYH87ZV1H.1QZH1R36WMIC6@bootlin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


