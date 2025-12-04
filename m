Return-Path: <netdev+bounces-243634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEECA4A05
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B7FD302008A
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E134844F;
	Thu,  4 Dec 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftGKXrNe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99255347FEE;
	Thu,  4 Dec 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866946; cv=none; b=pB5Kb+FHQPYeTP4ChPAg/YeXKaP7BykVqHt5fd+rMiWTxsLJX3hJQZUy9n2ILBGBZo2t9InvnsmS8wxQc9Vk65iOlti82J/UqFO38eMkn3Ga0YiEdGmx0YPEw1htW+UG85VFxNI5/QR6YJtv8CIZImmGMzgWuNCZjTJJIUpjkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866946; c=relaxed/simple;
	bh=s/jCJ2FpUP11SPYO8fzMlmRQfnOVawPPT6/iEbGbJgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdqOzp1r1ERWJsxN4ibCQluhWirz63F1juoqzer1OM6bSEMZPW1V627/DrP3hHbSkBE3Cg18ZBfddQjT5S3MzWU/P99wb9VqZChG5gFeyLQo9fZdUbIod9WWuwmFJLveqMsQr3LcRTZnschThqbTZWLWdowjXjfezV4I9jmzSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftGKXrNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A99C4CEFB;
	Thu,  4 Dec 2025 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764866944;
	bh=s/jCJ2FpUP11SPYO8fzMlmRQfnOVawPPT6/iEbGbJgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ftGKXrNeYQ1po2piaPKUeDZLuQnVyRpTPq6K+3sZBQXbxanU6cohAuPxppl3YF6be
	 74WjFWEFuqAf6m8ukmUuAKAUfjosXj1p/I/cL2DXvV4YpvZNnPnzoIxZMZ3F4iUpcR
	 ZQ+w5Fc959ptz8BoYeoe7mM/t1ds4JR1/NfJhwMttDPIClXQtiAk76cr7GTn1HhZW+
	 afDxEKUmf8Te0PUCMFK6NiIE9P9kbIYUCQZTpMbyMtlGN5muEV6SGlJ20GOnEESW2i
	 bVtRWNuchIk6g3xwwpJ9XxoIjNEfsluUc+hk/HDi3v9GoaWCKPXyCIAmzj9bS3O843
	 wjdy5KCVy6BEg==
Message-ID: <c7cbdaaa-e786-4842-9346-e2fde998fde5@kernel.org>
Date: Thu, 4 Dec 2025 17:48:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?B?TWFyZWsgQmVo4oia4oirbg==?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-6-vladimir.oltean@nxp.com>
 <20251124200121.5b82f09e@kernel.org> <aS1T5i3pCHsNVql6@vaman>
 <69ac21ea-eed2-449a-b231-c43e3cd0bdc0@kernel.org>
 <20251204153401.tinrt57ifjthw55r@skbuf>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251204153401.tinrt57ifjthw55r@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 16:34, Vladimir Oltean wrote:
> On Mon, Dec 01, 2025 at 09:41:21AM +0100, Krzysztof Kozlowski wrote:
>> On 01/12/2025 09:37, Vinod Koul wrote:
>>> On 24-11-25, 20:01, Jakub Kicinski wrote:
>>>> On Sat, 22 Nov 2025 21:33:37 +0200 Vladimir Oltean wrote:
>>>>> Add helpers in the generic PHY folder which can be used using 'select
>>>>> GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
>>>>> enable GENERIC_PHY.
>>>>>
>>>>> These helpers need to deal with the slight messiness of the fact that
>>>>> the polarity properties are arrays per protocol, and with the fact that
>>>>> there is no default value mandated by the standard properties, all
>>>>> default values depend on driver and protocol (PHY_POL_NORMAL may be a
>>>>> good default for SGMII, whereas PHY_POL_AUTO may be a good default for
>>>>> PCIe).
>>>>>
>>>>> Push the supported mask of polarities to these helpers, to simplify
>>>>> drivers such that they don't need to validate what's in the device tree
>>>>> (or other firmware description).
>>>>>
>>>>> The proposed maintainership model is joint custody between netdev and
>>>>> linux-phy, because of the fact that these properties can be applied to
>>>>> Ethernet PCS blocks just as well as Generic PHY devices. I've added as
>>>>> maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
>>>>> "GENERIC PHY FRAMEWORK".
>>>>
>>>> I dunno.. ain't no such thing as "joint custody" maintainership.
>>>> We have to pick one tree. Given the set of Ms here, I suspect 
>>>> the best course of action may be to bubble this up to its own tree.
>>>> Ask Konstantin for a tree in k.org, then you can "co-post" the patches
>>>> for review + PR link in the cover letter (e.g. how Tony from Intel
>>>> submits their patches). This way not networking and PHY can pull
>>>> the shared changes with stable commit IDs.
>>>
>>> How much is the volume of the changes that we are talking about, we can
>>> always ack and pull into each other trees..?
>>
>> That's just one C file, isn't it? Having dedicated tree for one file
>> feels like huge overhead.
> 
> I have to admit, no matter how we define what pertains to this presumed
> new git tree, the fact is that the volume of patches will be quite low.
> 
> Since the API provider always sits in drivers/phy/ in every case that I
> can think about, technically all situations can be resolved by linux-phy
> providing these stable PR branches to netdev. In turn, to netdev it
> makes no difference whether the branches are coming from linux-phy or a
> third git tree. Whereas to linux-phy, things would even maybe a bit
> simpler, due to already having the patches vs needing to pull them from
> the 3rd tree.
> 
> From my perspective, if I'm perfectly honest, the idea was attractive
> because of the phenomenal difference in turnaround times between netdev
> and linux-phy review&merge processes (very fast in netdev, very slow and
> patchy in linux-phy). If there's a set like this, where all API consumers
> are in netdev for now but the API itself is in linux-phy, you'd have to
> introduce 1000 NOP cycles just to wait for the PR branch.
> 
> In that sense, having more people into the mix would help just because
> there's more people (i.e. fewer points of failure), even though overall
> there's more overhead.
> 
> IDK, these are my 2 cents, I can resubmit this set in 2 weeks with the
> maintainership of the PHY common properties exclusive to linux-phy.


Jakub supported the idea, so I also do not oppose, and if that helps you
folks, then go ahead.

Best regards,
Krzysztof

