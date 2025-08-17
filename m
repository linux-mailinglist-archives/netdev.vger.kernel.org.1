Return-Path: <netdev+bounces-214370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E46B292E3
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3801A1964DC9
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98719229B12;
	Sun, 17 Aug 2025 12:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3C1F4171;
	Sun, 17 Aug 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755432260; cv=none; b=ujspTMM3h7pBrrRVM0hAVDp8TXHGcaUjaU4QHJd+4CrKYKvpHv4wukUIHmlayc4lpQdzs+I3vCb09i5+6xD6k6jypuNM++jHUjZaiTYUwDzVwiYRmOinDZplD3ISZxqFwH6s9Wz4sk/Stw6Cns0Z8fQ3rdfmlmPIwSouLiZ5fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755432260; c=relaxed/simple;
	bh=KXv5kHvWuWXqgZhKsdaeb5EOVo/7DJAvYBHzVbHPz/I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PqtwDjQuxZVlncyq9pZAVpYwdP3J7h1UAT3prg+EXmg5Tyf2kzYKG//9rW5CbxgbhCn+u4LzKFLBlbNNo2JWbfXMW/4J7fk6hHNsbpJ/gKj22Z056afAhP2Y5PlvzK14ShZV85AhRc8FToRYXjgjx2ALHVomrZ0I22HDmQD3tHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id D502B4385D;
	Sun, 17 Aug 2025 12:04:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Aug 2025 14:04:11 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
In-Reply-To: <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
 <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
Message-ID: <b6dd9b94e3a43d98bacdcd22f536a10c@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepvdeiveekkeelieehfedvvedvheetffekuddtheeljeetieeiiefhjeekvdffleelnecuffhomhgrihhnpehophgvnhgtohhrvghsrdhorhhgnecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesg
 hhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-16 17:04, Andrew Lunn wrote:
> On Sat, Aug 16, 2025 at 03:40:57PM +0200, Artur Rojek wrote:
>> On 2025-08-16 02:18, Andrew Lunn wrote:
>> > > Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both
>> > > MDC
>> > > and MDIO pins connected, however I suspect that nothing really
>> > > configures it, and it simply runs on default register values (which
>> > > allow for valid operation in 100Mb/s mode, it seems). I doubt there is
>> > > another IP core to handle MDIO, as this SoC design is optimized for
>> > > minimal utilization of FPGA blocks. Does it make sense to you that a
>> > > MAC
>> > > could run without any access to an MDIO bus?
>> >
>> > It can work like that. You will likely have problems if the link ever
>> > negotiates 10Mbps or 100Mbps half duplex. You generally need to change
>> > something in the MAC to support different speeds and duplex. Without
>> > being able to talk to the PHY over MDIO you have no idea what it has
>> > negotiated with the link peer.
>> 
>> Thanks for the explanation. I just confirmed that there is no activity
>> on the MDIO bus from board power on, up to the jcore_emac driver start
>> (and past it), so most likely this SoC design does not provide any
>> management interface between MAC and PHY. I guess once/if MDIO is
>> implemented, we can distinguish between IP core revision compatibles,
>> and properly switch between netif_carrier_*()/phylink logic.
> 
> How cut down of a SoC design is it? Is there pinmux and each pin can
> also be used for GPIO?

It's pretty limited - there is no MMU or DMA, for example. There does
appear to be a GPIO controller, however I'm not sure if it is of pinmux
variety (whether pins used by an IP core can be multiplexed to PIO), or
if it has its own pool of general purpose pins, that don't overlap with
PHY. In any case, there is no Linux driver for it (I have interest to
eventually write one), and I don't know if the design for it is even
included in the bitstream on my board.

> Linux has software bit-banging MDIO, if you can
> make the two pins be standard Linux GPIOs, and can configure them
> correctly, i _think_ open drain on MDIO. It will be slow, but it
> works, and it is pretty much for free.

This is a clever idea! It does however sound like Jeff & co. will
eventually add a proper MDIO interface to this MAC. I will halt upstream
of this driver for now and see what happens first (that, or me
experimenting with GPIO). Thanks for the review of this series thus far!

Cheers,
Artur

> 
> MDIO itself is simple, just a big shift register:
> 
> https://opencores.org/websvn/filedetails?repname=ethmac10g&path=%2Fethmac10g%2Ftrunk%2Frtl%2Fverilog%2Fmgmt%2Fmdio.v
> 
> 	Andrew

