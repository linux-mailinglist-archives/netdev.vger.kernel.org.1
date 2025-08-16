Return-Path: <netdev+bounces-214304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC9B28E2E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56781B00C5F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60F2E717C;
	Sat, 16 Aug 2025 13:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B370810;
	Sat, 16 Aug 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351669; cv=none; b=qqwva0O8T454oj7syTJFbKFtcghzfwRPEIqUCSvNTqvqv763OiPPkscFZeOgqVJet4Zw7CQNtgqu2rPHkc7hNpIiiBIP9hrArKXACdTUXlPOneRJIeCyEcU/sXkWrrHQvu+03LEFGmyKJz/31DyfY7owDKWHZvyxk4UGPx/cEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351669; c=relaxed/simple;
	bh=qHJ0WUe5nzH3mm8Exh0PJFERowSQ8j41wC5UO/cuu6Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ULnMELgV2tEwU0yrD1zCbx/UNAJZUZ2+TmYIoPRzmrs5oYlZwq7CAuJMZ8pwq3i7xXNG9s3HZYlmdNtde344He1Jb6r4lKdp+pBPWN14oaaeQYj3YpPb41FgqG0VBAY4krbptexNUUXyRpxU2iw4MCA29ylYu25Myfo8wLMuS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 707CD4338A;
	Sat, 16 Aug 2025 13:40:57 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Aug 2025 15:40:57 +0200
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
In-Reply-To: <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
Message-ID: <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeileelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdejuedtgefgtdfhgfdugefgffffteetteffuddtgfefheekgedvtdekvddvtdeknecukfhppedutddrvddttddrvddtuddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvtddtrddvtddurdduledphhgvlhhopeifvggsmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvf
 idonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-16 02:18, Andrew Lunn wrote:
>> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both 
>> MDC
>> and MDIO pins connected, however I suspect that nothing really
>> configures it, and it simply runs on default register values (which
>> allow for valid operation in 100Mb/s mode, it seems). I doubt there is
>> another IP core to handle MDIO, as this SoC design is optimized for
>> minimal utilization of FPGA blocks. Does it make sense to you that a 
>> MAC
>> could run without any access to an MDIO bus?
> 
> It can work like that. You will likely have problems if the link ever
> negotiates 10Mbps or 100Mbps half duplex. You generally need to change
> something in the MAC to support different speeds and duplex. Without
> being able to talk to the PHY over MDIO you have no idea what it has
> negotiated with the link peer.

Thanks for the explanation. I just confirmed that there is no activity
on the MDIO bus from board power on, up to the jcore_emac driver start
(and past it), so most likely this SoC design does not provide any
management interface between MAC and PHY. I guess once/if MDIO is
implemented, we can distinguish between IP core revision compatibles,
and properly switch between netif_carrier_*()/phylink logic.

Cheers,
Artur

> 
> 	Andrew

