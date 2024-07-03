Return-Path: <netdev+bounces-108762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C0925457
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF8282B6C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E31134415;
	Wed,  3 Jul 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="QLU8n0pp"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8813247D;
	Wed,  3 Jul 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990204; cv=none; b=IY30j9bsXbH9BxrxN9SuchAZybBiIfMSECJczj8pVtKYHvpuhRd/AFQcBnvyHCX8IOFkM1ifUbe9oXJ6+8ykXZxxoDJwtnaJI1fx78bvU5nrBTMw7yvrX0hs2QE9noKLKwa+NvtUYlCFK7XwfHm+xH8LxjFL4GPAxNhZYBErCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990204; c=relaxed/simple;
	bh=lvDGTesE/6toPU38panrJWuJ6j/xQ7PKrBsKsuWdeGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=svMaSEJiZU5S7DVvzja99WZahLAc/A+ubz+ClYuVZbRCs4jG8iPnofLH0SCkQmUEjNlzhd8q6q1IKAm5GA7hSOhF3Qlb4SQRULf0jfCNfwnWvS0EoDFYh8gNOmP78VK4nqAS0g6E7GRBaX0pdOIroMax/ExeqaPUxnPhetP3NdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=QLU8n0pp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E3A940008;
	Wed,  3 Jul 2024 07:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719990194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBX2/MGaOS1ZkS0ejeTXdSBLBk8fKts4uFWqlOjCCxY=;
	b=QLU8n0pp4oKXT2jnEnw/2NUh5RoMDi+EnE/qwfSgtYP3e49V46R183fl57FUe4yyrtm2j0
	xZ3gX54HYsBb5ZzK4KQIjQl6nNayGvWhOEVqUFuzPEadVNSwnxrpIaTBH6AVevCOmz+GQa
	DRNh3Veg72O7SnHljex3H2G5ECbKNiB/+yzP+D1P0HOsqPN/gW2kYu+V8+WvdUWRSXaMzZ
	Ca+3mlMJlQdMl/xD/nB3dd9csjM45OJwqEhrfkxFIo4vhkAjJXzDsqw/Xf92vL6k1BV9EP
	obgXugHip14iaC35LvDWSSWkvlveobMkbIa2EDaOX2WjsAprOPsenCl3TiWmlQ==
Message-ID: <d3ac5584-8e52-46e0-b690-ad5faa1ede61@arinc9.com>
Date: Wed, 3 Jul 2024 10:03:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 regressions@lists.linux.dev
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 03/07/2024 02:44, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
> switch is wrongly stated in the device tree as 0 (while in reality it is
> 31), warn the user about such broken device tree and make a good guess
> what was actually intended.
> 
> This is imporant also to not break compatibility with older Device Trees
> as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> switch from device tree") the address in device tree will be taken into
> account, while before it was hard-coded to 0x1f.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Only tested on BPi-R3 (with various deliberately broken DT) for now!
> 
> Changes since v2 [2]:
>   - use macros instead of magic numbers
>   - introduce helper functions
>   - register new device on MDIO bus instead of messing with the address
>     and schedule delayed_work to unregister the "wrong" device.
>     This is a slightly different approach than suggested by Russell, but
>     imho makes things much easier than keeping the "wrong" device and
>     having to deal with keeping the removal of both devices linked.
>   - improve comments
> 
> Changes since v1 [1]:
>   - use FW_WARN as suggested.
>   - fix build on net tree which doesn't have 'mdiodev' as member of the
>     priv struct. Imho including this patch as fix makes sense to warn
>     users about broken firmware, even if the change introducing the
>     actual breakage is only present in net-next for now.
> 
> [1]: https://patchwork.kernel.org/project/netdevbpf/patch/e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org/
> [2]: https://patchwork.kernel.org/project/netdevbpf/patch/11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org/

Works on standalone MT7530, MT7621's MCM MT7530, and MT7531. From MT7621's
MCM MT7530:

[    1.357287] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
[    1.364065] mt7530-mdio mdio-bus:00: [Firmware Warn]: impossible switch MDIO address in device tree, assuming 31
[    1.374303] mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -14
[...]
[    1.448370] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
[    1.477676] mt7530-mdio mdio-bus:1f: configuring for fixed/rgmii link mode
[    1.485687] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
[    1.493480] mt7530-mdio mdio-bus:1f: configuring for fixed/trgmii link mode
[    1.502680] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
[    1.513620] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
[    1.519671] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
[    1.533072] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
[    1.545042] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
[    1.557031] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)

I'm not fond of the use of the non-standard term, MDIO address, instead of
"PHY Address" as described in 22.2.4.5.5 of IEEE Std 802.3-2022.
Regardless:

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

