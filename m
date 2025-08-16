Return-Path: <netdev+bounces-214299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B8B28CF0
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D6EB61194
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA882244666;
	Sat, 16 Aug 2025 10:35:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16021C16E;
	Sat, 16 Aug 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340504; cv=none; b=foX5nayeNeKGEzm/zCR7SDoFcM4IqdlZpGcSBrVOcHnghahZjXOdq4UtXdgPMnr7YqTBWH55r+WEAx50ZbceEHdOH0Wli6VcIewqggp+t8DHzJPryp/aJEzjQYk27bHCI6FO/u11qYHa7ZL0d0XUpp9BqzEgtX68ZG23GxqWCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340504; c=relaxed/simple;
	bh=OmY6f0GIf80Xge8EjX6EkI9/4YhDXdqsz9WqOsI9brI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Gw+2NYI4FLS3rU2p+xD5AmzHoGCxkfvWEiHCncbgyYVI99HbjZX2xo118vLA9H3ZgjikrDz3vTpAV3JE6lIaxlmsT5L4ayLJQeTOwN3mCjo6GRqTWZ9qphCS5de8Q+QSvXhZdMV/TYjbeAHzqcimdkP6Kc6jS7o/bqu1Rgj5KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72EFD43212;
	Sat, 16 Aug 2025 10:34:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Aug 2025 12:34:51 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley
 <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Document J-Core
In-Reply-To: <f9903242-beec-4506-af20-2f8fc94d53cc@kernel.org>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-2-contact@artur-rojek.eu>
 <68a6d0a7-b245-456d-9c7e-60fbf08c4b32@kernel.org>
 <CAMuHMdVj8r_voaXqVdt07fRT5mdJJ4B2NFiK9=XhtYDCuRgz1g@mail.gmail.com>
 <f9903242-beec-4506-af20-2f8fc94d53cc@kernel.org>
Message-ID: <35bba6dd1d6faf1b977f7d5eb74be7c4@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeiieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgigtgfesthejjhdttddtvdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepfffhkeeuvdegvdeuhfefffeiiedvtdeiffegieffkeetfedvtefgiefgueffueetnecuffhomhgrihhnpehjqdgtohhrvgdrohhrghenucfkphepuddtrddvtddtrddvtddurdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvddttddrvddtuddrudelpdhhvghlohepfigvsghmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhin
 hdruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: contact@artur-rojek.eu

On 2025-08-16 11:40, Krzysztof Kozlowski wrote:
> On 16/08/2025 10:22, Geert Uytterhoeven wrote:
>> Hi Krzysztof,

Hi Krzysztof,
thanks for the review!

>> 
>> On Sat, 16 Aug 2025 at 10:18, Krzysztof Kozlowski <krzk@kernel.org> 
>> wrote:
>>> On 15/08/2025 21:48, Artur Rojek wrote:
>>>> J-Core is a clean-room open source processor and SoC design using 
>>>> the
>>>> SuperH instruction set.
>>>> 
>>>> The 'jcore' prefix is in use by IP cores originating from this 
>>>> design.
>>>> 
>>>> Link: https://j-core.org
>>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> 
>>> How is it possible if this is v1? If this is not v1, where is 
>>> changelog
>>> and why isn't it marked as vx?
>> 
>> The patch series had several iterations (v0, v-1, v-2 ;-), with a 
>> limited
>> audience.
> 
> Thanks, would be nice to see it reflected somewhere.

I mentioned it in the cover letter.

For the record:
v1: capitalize Open Processor
v0: new patch

Cheers,
Artur

> 
> Best regards,
> Krzysztof

