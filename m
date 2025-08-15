Return-Path: <netdev+bounces-214206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE37B28787
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4729567F4A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079C23FC41;
	Fri, 15 Aug 2025 21:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DC218AAA;
	Fri, 15 Aug 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292462; cv=none; b=qefwn90CgCCu/9roct5hVsSCbHkJXNYHiLzyWlGBtPcEXRTrY8OquOkFPz220YkQDOkOVWG8Yow3bAK+FCAC9uMxcHh/2FLEXypP9q9FUjII0FBFnqScp48yMCYsHVHrlKNRh2nsf6whdbuaEMETt2AWn2xOe4YVXBNSyMmij5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292462; c=relaxed/simple;
	bh=9p9okCGYvGPHo8sJcrzTn4FAmsxYbsgLB6jhERDRiP0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B+DF0oCQjTFGNd3sByqqZZ5egQyOLncqMSL0stCW7wU1XZ8ZjZKSH78WPIkF7xGARWxQSkrliXiDBMy0lYEg0joPQUj5ZClzZ1c0S8MkyN4QD9am12YuWUFTVcy4h/jrPpd+T1vNgHnP29CgNtPqc2gkCH+c73+rt+dJUprLFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16AF041DE2;
	Fri, 15 Aug 2025 21:14:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Aug 2025 23:14:08 +0200
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
In-Reply-To: <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
Message-ID: <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdejuedtgefgtdfhgfdugefgffffteetteffuddtgfefheekgedvtdekvddvtdeknecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvf
 idonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-15 22:52, Artur Rojek wrote:
> On 2025-08-15 22:16, Andrew Lunn wrote:
> 
> Hi Andrew,
> thanks for the review!
> 
>>> +static irqreturn_t jcore_emac_irq(int irq, void *data)
>>> +{
>>> +	struct jcore_emac *priv = data;
>>> +	struct net_device *ndev = priv->ndev;
>>> +	struct sk_buff *skb;
>>> +	struct {
>>> +		int packets;
>>> +		int bytes;
>>> +		int dropped;
>>> +		int crc_errors;
>>> +	} stats = {};
>>> +	unsigned int status, pkt_len, i;
>> 
>> netdev uses 'reverse christmas tree' for local variables. They should
>> be sorted longest to shortest. This sometimes means you need to move
>> assignments into the body of the function, in this case, ndev.

Should I move the struct stats members into stand alone variables as
well? Or is below sorting acceptable with regards to stats vs skb:

> 	unsigned int status, pkt_len, i;
> 	struct jcore_emac *priv = data;
> 	struct net_device *ndev;
> 	struct {
> 		int crc_errors;
> 		int dropped;
> 		int packets;
> 		int bytes;
> 	} stats = {};
> 	struct sk_buff *skb;

>> 
>>> +	jcore_emac_read_hw_addr(priv, mac);
>>> +	if (is_zero_ether_addr(mac)) {
>> 
>> It would be more normal to use !is_valid_ether_addr()
>> 
>> What support is there for MDIO? Normally the MAC driver would not be
>> setting the carrier status, phylink or phylib would do that.
> 
> From what I can tell, none. This is a very simple FPGA RTL
> implementation of a MAC, and looking at the VHDL, I don't see any MDIO
> registers.

> Moreover, the MDIO pin on the PHY IC on my dev board also
> appears unconnected.

I spoke too soon on that one. It appears to be connected through a trace
that goes under the IC. Nevertheless, I don't think MDIO support is in
the IP core design.

> Perhaps Rob L. or Jeff can shine more light on this
> design wise.
> 
> Cheers,
> Artur
> 
>> 
>>     Andrew
>> 
>> ---
>> pw-bot: cr

