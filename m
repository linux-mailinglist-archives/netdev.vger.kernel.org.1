Return-Path: <netdev+bounces-214204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B447CB2876B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97BA3B2212
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D523D7E3;
	Fri, 15 Aug 2025 20:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFA26AF3;
	Fri, 15 Aug 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291141; cv=none; b=sDcxltmiqmmSfRVD3oxAa/VcKHBusTLljFwKEtBjH0pre3AUL5z16bJu2vgVPgqZlls9qIl88hSJjIaASjb7cd+NEP9zV4n4+1mrNVZj2Y3oaZ+jxw0810fN4EZ9/ibJYVcKHAwJ79BfXV5umjvxLeotmgIga4mGI6+f6/KPyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291141; c=relaxed/simple;
	bh=3/t9Nj77xUmviwQe4XdqVzXk0hYy88KvnKXP+2T3MaU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qOQ/tU5CRF+/kAKRmlygIF/zmSY63/HmDT8RCfWHkL8abHxxACn732MpP7x0N5tjFaw25YG6e1K2h/6U9cU92sNIrlh5sVkMlXmkcOpBHsibdx663rRX4j+0oKkTlcsS+pXZHF3aSl6JfwBiGdjPvm9pvWnrMbmfrd1/WmTc2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 095071F47A;
	Fri, 15 Aug 2025 20:52:04 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Aug 2025 22:52:04 +0200
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
In-Reply-To: <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
Message-ID: <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdejuedtgefgtdfhgfdugefgffffteetteffuddtgfefheekgedvtdekvddvtdeknecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvf
 idonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-15 22:16, Andrew Lunn wrote:

Hi Andrew,
thanks for the review!

>> +static irqreturn_t jcore_emac_irq(int irq, void *data)
>> +{
>> +	struct jcore_emac *priv = data;
>> +	struct net_device *ndev = priv->ndev;
>> +	struct sk_buff *skb;
>> +	struct {
>> +		int packets;
>> +		int bytes;
>> +		int dropped;
>> +		int crc_errors;
>> +	} stats = {};
>> +	unsigned int status, pkt_len, i;
> 
> netdev uses 'reverse christmas tree' for local variables. They should
> be sorted longest to shortest. This sometimes means you need to move
> assignments into the body of the function, in this case, ndev.
> 
>> +	jcore_emac_read_hw_addr(priv, mac);
>> +	if (is_zero_ether_addr(mac)) {
> 
> It would be more normal to use !is_valid_ether_addr()
> 
> What support is there for MDIO? Normally the MAC driver would not be
> setting the carrier status, phylink or phylib would do that.

 From what I can tell, none. This is a very simple FPGA RTL
implementation of a MAC, and looking at the VHDL, I don't see any MDIO
registers. Moreover, the MDIO pin on the PHY IC on my dev board also
appears unconnected. Perhaps Rob L. or Jeff can shine more light on this
design wise.

Cheers,
Artur

> 
>     Andrew
> 
> ---
> pw-bot: cr

