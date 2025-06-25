Return-Path: <netdev+bounces-200981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0763EAE79DD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5690E165C50
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACE20F08E;
	Wed, 25 Jun 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mGBN/kkY"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41020C476;
	Wed, 25 Jun 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839650; cv=none; b=EKrMFzT6BZS4SvE7GWHP2p59UMLbAVH98yq5qgmVeAG7DGcLaAgDaA9J/q6oTqV3nkzAV9G/R5OcRVT/2p1x79r/Huk1/d5/SKQo4od1r/kDQDitHVQk3NwCKRAhwgOddDrgA6K46fdNU5T0uZPrp0UIgHa8DjW3g+mWdYwd+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839650; c=relaxed/simple;
	bh=X7oTNFrJswgIHuNpvVbuXC5hVcIhk6YzrRYWyDXt1A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cml/NMpXnRUCSMN5So/6myrLKAP85zNkhROQsaksy4Aie+2dUF1vncWmtwt8A48r1TH8umtrD+8H4GKBAWpmSEytWg3q7ckTuuOXkT+gZt1rp9nDKaMpKXdOuI46Xm0msk9lKewyRxiH8Rpzd7b9TaPf8CK0yn5LkH/LdQAmtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mGBN/kkY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750839641;
	bh=X7oTNFrJswgIHuNpvVbuXC5hVcIhk6YzrRYWyDXt1A8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mGBN/kkYxKPsfPV+wFXdq2SphIgBlVWTcC6D7AJkr1jrcYwLwCmKVKxiT01KjqaGK
	 6pEpbEje9rU2Y0ybrbmIkuZVuyvMIZUlNgvTjgvXN7LgdH22O7GO6pLLJU4lLe+U+x
	 A7jL5tVuJZ1dAZ5JPxsoGf3P6yolap74oUjuPYbSd4WWF60bcr/uy1yTW4cm1pvtw5
	 8Ixf4l0SWw1US/srSN3EoE4Tjevca1Mgfhs4N77XXLavkctZ8/OV//1IUDt9Sb5XQC
	 jHHkoux7D1n49f93d2U6Ngd0z3/m87sXwbx4g9p8JqrGmNHDuJp/iFzO6DctlvQ84b
	 THjvTrOCv/nkg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CC9F17E0DD0;
	Wed, 25 Jun 2025 10:20:40 +0200 (CEST)
Message-ID: <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
Date: Wed, 25 Jun 2025 10:20:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/29] dt-bindings: clock: mediatek: Describe MT8196
 peripheral clock controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, Laura Nao
 <laura.nao@collabora.com>, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-10-laura.nao@collabora.com>
 <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/06/25 18:02, Krzysztof Kozlowski ha scritto:
> On 24/06/2025 16:32, Laura Nao wrote:
>> +  '#reset-cells':
>> +    const: 1
>> +    description:
>> +      Reset lines for PEXTP0/1 and UFS blocks.
>> +
>> +  mediatek,hardware-voter:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>> +      MCU manages clock and power domain control across the AP and other
>> +      remote processors. By aggregating their votes, it ensures clocks are
>> +      safely enabled/disabled and power domains are active before register
>> +      access.
> 
> Resource voting is not via any phandle, but either interconnects or
> required opps for power domain.

Sorry, I'm not sure who is actually misunderstanding what, here... let me try to
explain the situation:

This is effectively used as a syscon - as in, the clock controllers need to perform
MMIO R/W on both the clock controller itself *and* has to place a vote to the clock
controller specific HWV register.

This is done for MUX-GATE and GATE clocks, other than for power domains.

Note that the HWV system is inside of the power domains controller, and it's split
on a per hardware macro-block basis (as per usual MediaTek hardware layout...).

The HWV, therefore, does *not* vote for clock *rates* (so, modeling OPPs would be
a software quirk, I think?), does *not* manage bandwidth (and interconnect is for
voting BW only?), and is just a "switch to flip".

Is this happening because the description has to be improved and creating some
misunderstanding, or is it because we are underestimating and/or ignoring something
here?

Cheers,
Angelo

> 
> I already commented on this, so don't send v3 with the same.
> 
> Best regards,
> Krzysztof




