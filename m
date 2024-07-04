Return-Path: <netdev+bounces-109309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF4927D48
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03302842B5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5336EB7D;
	Thu,  4 Jul 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="RM4d7OgO"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03B364A1;
	Thu,  4 Jul 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119130; cv=none; b=MYoxWFHarui0fAkXaBj/wQnO/Q5IallNR+Dec1APC7jhpUyRkJmPmHu29JWDe87KYe5cZ6Ebuw8Ll4rhWszkQO9sBuSJ6e09+2QnOlQIil6x9Q2Ax8HD5ejPtPet+q8Z4HQ6rGuj62Pv9H+LGEwZf/gTF7mFGV+XYYCYZtqrsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119130; c=relaxed/simple;
	bh=rOiNFRjFbsjEYyVjdLFWoHQguJR1w1G3QXWED0fZyEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ct8LzG2M49eoFRqWM2XDlEq1xWQqIkKYNiYODSQ0dlkrfgg4yeKktM7Sj5Xb2DGZGr0ZHbxvKf8pDsfcG+3rkbvfUVBKOKUtOwfKaXc+LDrpyLDDo1Zcw0zm/dYxCfLwe8UaLEVMvNGeyduWm19EbjxkErmXv2uUHeVFGEtVqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=RM4d7OgO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B42861BF204;
	Thu,  4 Jul 2024 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1720119126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gy8AH0XBcf7dpV5Zm5VUIvD/5OEaKpGMnkFSxXObV2s=;
	b=RM4d7OgO35orTuUrSmobImrl4SjstNMZ3iYSeI0nJ2I/C33xMNK+kNMCzJQuDkYt4cSCrA
	XVyhcSNOPrQ/Wo0FYV2pYggCDZky4jXo7ob9jpOxE/IXuTUcowpRpyqkflU4ZEfcMphxa9
	dCzTjfNr2KniWE5X+ulSzYbFN8wRveP0fd6NNXCjh+vvR1QswDG+PHzKWLV+4KAoc6I17K
	h7F1XLel6TqlPbyu8ATAte3XQB8fShsPmsLrIRhe4VJ1i0GKediW/zGi5prSas5L0+3ZCI
	vzFjZQHIzHTWzVeRQ2Yn+OwFOo02jO/bTrBZpFdA6SJ4zpmLP/1RnzcyjaukXw==
Message-ID: <884b94a6-3488-4ddf-b096-4f445902875e@arinc9.com>
Date: Thu, 4 Jul 2024 21:52:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 regressions@lists.linux.dev
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
 <d3ac5584-8e52-46e0-b690-ad5faa1ede61@arinc9.com>
 <20240704172154.opqyrv2mfgbxj7ce@skbuf>
 <a57dd43e-0798-4dab-853f-da84a19ee153@arinc9.com>
Content-Language: en-US
In-Reply-To: <a57dd43e-0798-4dab-853f-da84a19ee153@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 04/07/2024 21:19, Arınç ÜNAL wrote:
> On 04/07/2024 20:21, Vladimir Oltean wrote:
>> On Wed, Jul 03, 2024 at 10:03:09AM +0300, Arınç ÜNAL wrote:
>>> Works on standalone MT7530, MT7621's MCM MT7530, and MT7531. From MT7621's
>>> MCM MT7530:
>>>
>>> [    1.357287] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
>>
>> Why is the device corresponding to the first print located at address 1f,
>> then 0?
> 
> Because mdio_device_register() in mt7530_reregister() runs with new_mdiodev
> after dev_warn() runs with mdiodev.

I meant before. mdio_device_register() with the new_mdiodev argument is
called before dev_warn() is called with the mdiodev argument.

> 
>>
>>> [    1.364065] mt7530-mdio mdio-bus:00: [Firmware Warn]: impossible switch MDIO address in device tree, assuming 31
>>> [    1.374303] mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -14
>>> [...]
>>> [    1.448370] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
>>> [    1.477676] mt7530-mdio mdio-bus:1f: configuring for fixed/rgmii link mode
>>> [    1.485687] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [    1.493480] mt7530-mdio mdio-bus:1f: configuring for fixed/trgmii link mode
>>> [    1.502680] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
>>> [    1.513620] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [    1.519671] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
>>> [    1.533072] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
>>> [    1.545042] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
>>> [    1.557031] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)
> 
> Arınç

Arınç

