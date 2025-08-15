Return-Path: <netdev+bounces-214222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24DEB288B4
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A03AC25AE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941B2D3229;
	Fri, 15 Aug 2025 23:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30826B77B;
	Fri, 15 Aug 2025 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300344; cv=none; b=mTMLO0NApqvcbnMuj2Vr9UYORr0gbUofGGK9UV15fqaNe6Bj8G7TYHgRZvfb7/D8GMUS0eqWBdNZj1ixYmBuEpEqKH00zA3UvAaMGPoHhiAck8ETuvwuZMX82nJT1bKSU/WtT3/IJubCQCXX12IY+Vx/mYrPOo7tum5QZheKEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300344; c=relaxed/simple;
	bh=/hE7QNk/5+Tt00teL4xp4lzAjrCbUsYq+lnG1cQIaxk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=L+Vu2TxTaF1uX92hyqObLRsxs+96X4Qt0t/YR3ro1TXbPiMV2F/V1GmwvEVknV8g6IkZQBTXXmZ8ZwSRcOy166MlHEG0AtpCwke5EBwd4rWOmYERKgUnuf7uFwtyxC30pGzVZ/u4/cI1MABhz7UJz2ymEQmPrzLCk3trgoFmK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 721554318A;
	Fri, 15 Aug 2025 23:25:36 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Aug 2025 01:25:36 +0200
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
In-Reply-To: <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
Message-ID: <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepheejjedtjedvvdekueefjeelleehieeiieelieethefhueeiteekgeegvefhkedvnecuffhomhgrihhnpehmihgtrhhoshdrtghomhdrphhlnecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesg
 hhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-16 00:38, Andrew Lunn wrote:
> On Fri, Aug 15, 2025 at 11:14:08PM +0200, Artur Rojek wrote:
>> On 2025-08-15 22:52, Artur Rojek wrote:
>> > On 2025-08-15 22:16, Andrew Lunn wrote:
>> >
>> > Hi Andrew,
>> > thanks for the review!
>> >
>> > > > +static irqreturn_t jcore_emac_irq(int irq, void *data)
>> > > > +{
>> > > > +	struct jcore_emac *priv = data;
>> > > > +	struct net_device *ndev = priv->ndev;
>> > > > +	struct sk_buff *skb;
>> > > > +	struct {
>> > > > +		int packets;
>> > > > +		int bytes;
>> > > > +		int dropped;
>> > > > +		int crc_errors;
>> > > > +	} stats = {};
>> > > > +	unsigned int status, pkt_len, i;
>> > >
>> > > netdev uses 'reverse christmas tree' for local variables. They should
>> > > be sorted longest to shortest. This sometimes means you need to move
>> > > assignments into the body of the function, in this case, ndev.
>> 
>> Should I move the struct stats members into stand alone variables as
>> well? Or is below sorting acceptable with regards to stats vs skb:
> 
> I would pull the structure definition out of the function. Then just
> create one instance of the structure on the stack.

Makes sense, thanks.

> 
>> > > What support is there for MDIO? Normally the MAC driver would not be
>> > > setting the carrier status, phylink or phylib would do that.
>> >
>> > From what I can tell, none. This is a very simple FPGA RTL
>> > implementation of a MAC, and looking at the VHDL, I don't see any MDIO
>> > registers.
>> 
>> > Moreover, the MDIO pin on the PHY IC on my dev board also
>> > appears unconnected.
>> 
>> I spoke too soon on that one. It appears to be connected through a 
>> trace
>> that goes under the IC. Nevertheless, I don't think MDIO support is in
>> the IP core design.
> 
> MDIO is actually two pins. MDC and MDIO.
> 
> It might be there is a second IP core which implements MDIO. There is
> no reason it needs to be tightly integrated into the MAC. But it does
> make the MAC driver slightly more complex. You then need a Linux MDIO
> bus driver for it, and the DT for the MAC would include a phy-handle
> property pointing to the PHY on the MDIO bus.
> 
> Is there an Ethernet PHY on your board?

Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both MDC
and MDIO pins connected, however I suspect that nothing really
configures it, and it simply runs on default register values (which
allow for valid operation in 100Mb/s mode, it seems). I doubt there is
another IP core to handle MDIO, as this SoC design is optimized for
minimal utilization of FPGA blocks. Does it make sense to you that a MAC
could run without any access to an MDIO bus?

If neither Rob L. or Jeff clarify on this topic, I'll hook up a logic
analyzer to the MDIO bus and see if anything (e.g. loader firmware)
touches it at any point.

Cheers,
Artur

[1] https://www.micros.com.pl/mediaserver/info-uiip101a.pdf

> 
> 	Andrew

