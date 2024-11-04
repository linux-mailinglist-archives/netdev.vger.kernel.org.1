Return-Path: <netdev+bounces-141467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2A9BB0D6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438C21C21538
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B681AB526;
	Mon,  4 Nov 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CzWRbvj8"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA581494B1;
	Mon,  4 Nov 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715533; cv=none; b=H+MTlAKwR/W+b5cmoUeptRvrSrfKcWaVivXgO9QMnBveFqf011v/ySLzTU87UYor92triorPSHF4y8cbcWKE/ta8Yg6HTOCnN78wyBtw/j5LaPM1NvEXIOHZH0t/jwluDjqatW+ZCrZmMEbhdiaruEAYnFF8NUMARMG3+DW67j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715533; c=relaxed/simple;
	bh=/BqvSMpzIqUrh5h8PydNqYZk+71Ku8Hj2PODCROFwpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQOoPrpWSXc0CVpqa5skP4OmiWSisIZAeeEsSP+Hng6bzClx8uZsMYCfojwqtRZcdxwN8FVJvhmsHEe4wstrAuuHa2B+7M3sK1tbsKggddKyrxe6YAfE8RRC+CXvgygXpX6EoRKcUQ74MS0+wAmfbiW5WI1J8NXjqR4MzJvGuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CzWRbvj8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730715530;
	bh=/BqvSMpzIqUrh5h8PydNqYZk+71Ku8Hj2PODCROFwpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CzWRbvj8/pyD1ZMGCxhxWd7tLZTkAJdm6ZqhdISZcqc3Of8hl7ClnfCJ9uNK29czu
	 8qjJMjbf5L1ZAhAoNZhFfL4kdMsaSg9XYJfqUABwQgaFVEG+buPWl+uSMrhcDucnC6
	 40Pwfvei/3WemTpOZRCRDi5GAo797qNEvZbbmNK2z1plwGdxckWhjdGvKeCL2/NrbR
	 npqhZAEk5SIfyr4ksowGlfrFu9YBIvHaQnNNdjM81FCfLBf/QIg9GZBoLxaH29gpdg
	 Yf8V060wqDVEK0istqFXnnYmQmJbF6pncJ9H/QfhC+m0LrITeVLX/LiYYc35E3RNFt
	 drkQCwiPEF9KQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C1D017E1541;
	Mon,  4 Nov 2024 11:18:49 +0100 (CET)
Message-ID: <9a1ce320-e1ce-4d2f-a8d1-7680155ef71f@collabora.com>
Date: Mon, 4 Nov 2024 11:18:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: stmmac: dwmac-mediatek: Fix inverted logic for
 mediatek,mac-wol
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Biao Huang <biao.huang@mediatek.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/11/24 16:20, Nícolas F. R. A. Prado ha scritto:
> This series fixes the inverted handling of the mediatek,mac-wol DT
> property while keeping backward compatibility. It does so by introducing
> a new property on patch 1 and updating the driver to handle it on patch
> 2. Patch 3 adds this property on the Genio 700 EVK DT, where this issue
> was noticed, to get WOL working on that platform. Patch 4 adds the new
> property on all DTs with the MediaTek DWMAC ethernet node enabled
> and inverts the presence of mediatek,mac-wol to maintain the
> current behavior and have it match the description in the binding.
> 

Actually, I'm sure that all of these boards *do* need MAC WOL and *not* PHY WOL.

The only one I'm unsure about is MT2712, but that's an evaluation board and not
a retail product with "that kind of diffusion".

I think you can just fix the bug in the driver without getting new properties
and such. One commit, two lines.

Cheers,
Angelo

> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Nícolas F. R. A. Prado (4):
>        net: dt-bindings: dwmac: Introduce mediatek,mac-wol-noninverted
>        net: stmmac: dwmac-mediatek: Handle non-inverted mediatek,mac-wol
>        arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet MAC WOL
>        arm64: dts: mediatek: Add mediatek,mac-wol-noninverted to ethernet nodes
> 
>   Documentation/devicetree/bindings/net/mediatek-dwmac.yaml     | 11 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   |  2 ++
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  |  2 ++
>   arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts         |  1 +
>   arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts        |  2 +-
>   arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts |  2 ++
>   arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts         |  2 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c          |  9 ++++++---
>   8 files changed, 26 insertions(+), 5 deletions(-)
> ---
> base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
> change-id: 20241101-mediatek-mac-wol-noninverted-198c6c404536
> 
> Best regards,



