Return-Path: <netdev+bounces-214369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B581B292DD
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98B5484D91
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A21E5B88;
	Sun, 17 Aug 2025 11:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDE137E;
	Sun, 17 Aug 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755431429; cv=none; b=kWQtY1BQAkw9wRxFoiPmFtvVX0+LxmR2knUl07y9GXekTyXsdy0qkqOFN/IVyZ8p0P3PSs/DPlpyCkVWjLZvBGTKwcu20+tmhbflqM9+z7HaenoQW2/wJhzwihVjPcn3uoh7eF5gUlGhcmv6enm4Azp+xO7RWopawreAtetDhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755431429; c=relaxed/simple;
	bh=hccIm5eCUK43zVJAwZT+w4a7yLLZQ4mUmhPY/6ewFmg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OdDKBHi25W8SHjQEDlfnL/tKyWoQtWnsB5ccYmjBQVy7CP7uZMmocK574O/5HxCUpSsxTvBxA7/9+/gOIHTQzzFwdh42JGQ4bqqOPiHpmBXgPlmFpS7JfINgIZhAgIXlOK0sp/tcsMwOXa8JATAnLN/FwT3V9mS5+oRnAj2nNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id E007F431EB;
	Sun, 17 Aug 2025 11:50:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Aug 2025 13:50:15 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: "D. Jeff Dionne" <jeff@coresemi.io>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Landley <rob@landley.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
In-Reply-To: <DC855B2C-37F3-4565-8B6F-B122F7E16E25@coresemi.io>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
 <DC855B2C-37F3-4565-8B6F-B122F7E16E25@coresemi.io>
Message-ID: <93f21de744ea0c4d2b6ddb435e21f6aa@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthekjhdttddtjeenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhephffhkeekteejteevgfevtddttefhlefggfehjeehtdeugeetueevtdefgfevkeefnecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjvghffhestghorhgvshgvmhhirdhiohdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvf
 idonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-17 06:29, D. Jeff Dionne wrote:
> On Aug 16, 2025, at 22:40, Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> The MDIO isn’t implemented yet.  There is a pin driver for it, but it 
> relies on
> pin strapping the Phy.  Probably because all the designs that SoC base 
> is in
> (IIRC 10 or so customer and prototype designs, plus Turtle and a few
> derivatives), the SoC was designed in conjunction with board.  A bit 
> lazy.
> 
> But they all have the MDIO connected, so we should add it (it’s very 
> simple).

Hi Jeff,
thanks for the elaboration. It sounds to me then that I should wait with
the driver upstream until the MDIO interface is implemented.

At least I gave you guys a little bit of a nudge :-)

Cheers,
Artur

> 
> Cheers,
> J.
> 
>> On 2025-08-16 02:18, Andrew Lunn wrote:
>>>> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both 
>>>> MDC
>>>> and MDIO pins connected, however I suspect that nothing really
>>>> configures it, and it simply runs on default register values (which
>>>> allow for valid operation in 100Mb/s mode, it seems). I doubt there 
>>>> is
>>>> another IP core to handle MDIO, as this SoC design is optimized for
>>>> minimal utilization of FPGA blocks. Does it make sense to you that a 
>>>> MAC
>>>> could run without any access to an MDIO bus?
>>> It can work like that. You will likely have problems if the link ever
>>> negotiates 10Mbps or 100Mbps half duplex. You generally need to 
>>> change
>>> something in the MAC to support different speeds and duplex. Without
>>> being able to talk to the PHY over MDIO you have no idea what it has
>>> negotiated with the link peer.
>> 
>> Thanks for the explanation. I just confirmed that there is no activity
>> on the MDIO bus from board power on, up to the jcore_emac driver start
>> (and past it), so most likely this SoC design does not provide any
>> management interface between MAC and PHY. I guess once/if MDIO is
>> implemented, we can distinguish between IP core revision compatibles,
>> and properly switch between netif_carrier_*()/phylink logic.
>> 
>> Cheers,
>> Artur
>> 
>>> Andrew

