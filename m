Return-Path: <netdev+bounces-214302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F686B28D8D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F415C7B8534
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED511248F4E;
	Sat, 16 Aug 2025 12:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8222083;
	Sat, 16 Aug 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346000; cv=none; b=puihdnTHhupvp9HOb+LUnb/qhjGgamGwdTirBEm57yP7+iYUo6ctXAJJOEBmNywkha/v12vMze91IO4cJyZEpaEaEX1OTQUqKOWsJnAdCEVeobSIkLFjj7HP+FsFi39BCoagNBq25e1soglYSXHdXArhx3EzoJG+dth5ADjHMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346000; c=relaxed/simple;
	bh=pxKL/i5KZ3St1r+nCO3dem3IEbdpNgPCz0cfdIjoFtE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pkbrB3ScMYXHK+mKhIPeqI3n4rBNpc8bkuCSJJsMQRLEgf4twJkVe894s8bGrosQ6zPECvA2wLzBWGtF8UITsoEWwTTbT6ew2dP4yscZjxbSNv7DrzslCoX5JJryh8+6fMhGhdRoQWs42MYqagG24wA2L2ctvxMk2fCozp3W5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42CE343203;
	Sat, 16 Aug 2025 12:06:34 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Aug 2025 14:06:34 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
In-Reply-To: <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
Message-ID: <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeikeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdeugfelveeuvedtfffhledttddthefhuedufffguedtveehieeukeejgfejgefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhenucfkphepuddtrddvtddtrddvtddurdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvddttddrvddtuddrudelpdhhvghlohepfigvsghmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdru
 ggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-16 10:19, Krzysztof Kozlowski wrote:
> On 15/08/2025 21:48, Artur Rojek wrote:
>> Add a documentation file to describe the Device Tree bindings for the
>> Ethernet Media Access Controller found in the J-Core family of SoCs.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  .../devicetree/bindings/net/jcore,emac.yaml   | 42 
>> +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/net/jcore,emac.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/net/jcore,emac.yaml 
>> b/Documentation/devicetree/bindings/net/jcore,emac.yaml
>> new file mode 100644
>> index 000000000000..a4384f7ed83d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/jcore,emac.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/jcore,emac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: J-Core Ethernet Media Access Controller
>> +
>> +description: |
>> +  This node provides properties for configuring the Ethernet MAC 
>> found
>> +  in the J-Core family of SoCs.
>> +
>> +maintainers:
>> +  - Artur Rojek <contact@artur-rojek.eu>
>> +
>> +properties:
>> +  compatible:
>> +    const: jcore,emac
> 
> You need SoC-based compatibles. And then also rename the file to match 
> it.

Given how the top-most compatible of the bindings [1] of the board I am
using has "jcore,j2-soc", this driver should probably go with
"jcore,j2-emac".

But as this is an FPGA design, I don't know how widespread the use is
across other jcore derived SoCs (if any?).
I will wait for Jeff (who's design this is) to clarify on that.

PS. Too bad we already have other IP cores following the old pattern:

> $ grep -r "compatible = \"jcore," bindings/ | grep -v "emac"
> bindings/timer/jcore,pit.yaml:        compatible = "jcore,pit";
> bindings/spi/jcore,spi.txt:	compatible = "jcore,spi2";
> bindings/interrupt-controller/jcore,aic.yaml:        compatible = 
> "jcore,aic2";

Cheers,
Artur

[1] 
https://raw.githubusercontent.com/j-core/jcore-soc/refs/heads/master/targets/boards/turtle_1v1/board.dts

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +allOf:
>> +  - $ref: ethernet-controller.yaml#
>> +
>> +additionalProperties: false
> 
> unevaluatedProperties instead
> 
>> +
>> +examples:
>> +  - |
>> +    ethernet@10000 {
>> +      compatible = "jcore,emac";
>> +      reg = <0x10000 0x2000>;
>> +      interrupts = <0x11>;
> 
> That's not hex...
> 
>> +    };
> 
> 
> Best regards,
> Krzysztof

