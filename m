Return-Path: <netdev+bounces-109308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ACF927D44
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2671C22B3C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBE40BF5;
	Thu,  4 Jul 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="a9fBAGlz"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E72F23;
	Thu,  4 Jul 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118740; cv=none; b=nYqUsJ7Jb+jqmIE6+G4CihJur7y8uBLMrvIA/2QSRQtZfbwiG3t+3amXRXZIPt2PtOJ7nMXgbf9XC4h4l11Z2SP9sHrS68diJ57F5JDfVnGkVmS0eCds2f73IKfECu53AL96Om334kEYGwhAvNdj+mkcPw72PU3NPWUzZsk4wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118740; c=relaxed/simple;
	bh=FnX7KH7JCEhdAe0IU//y4JvexhfTris0susPp/B70kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsDeRefZA1U/APiPd7hn5KCIpXGqoTEb9lrj1vVjFBX/376RvX+ekMX/ODjLCVGV/qXoXd4rrPDz3PPXEFhSvomVorLQlgofU9yQe1ofkEemExW+6qpwL7Sj/2MJ/xirYABFyb0PoULZnkGRKuVwb1AVJNqzn2+S2Q49hW38jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=a9fBAGlz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4F59C0008;
	Thu,  4 Jul 2024 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1720118729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNOwyJfeFW+rZWEfskpZ4fSkCUgp0l0+Lt+tt17+jPQ=;
	b=a9fBAGlz/l8UtJponmhZWr5KHT+kH0qCfBjhofSQ1Bb24ju6JNhMv01pScmzIfiV97Vj8v
	X2GIojfgOL4hbD+sMWmuFmieJsExHJZ0Qk3MoCjsmVXT/RheXjPK4hnDlxFULGUvxfZ+F+
	sLeqMF9qZJPe/uD2A7m74u9NKgP0rmUrN70iqmddtuQ08PJVEcNPeHhS40qrHanIDMrm7q
	IH7eZNOzEkCeA43Y8WT2KZK7XNkTZIRUd4WEdjQgpkfxr7q2us5ucBz4Um967DOSW0IRWw
	PQOInov0/7+wuKCpAOh8KIxY1Bmxc7zTPq9AzG0g2L+FpqlDqH46fUH704iMcg==
Message-ID: <11d18c59-c995-4520-9d37-a7879c53bafb@arinc9.com>
Date: Thu, 4 Jul 2024 21:45:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
To: Daniel Golle <daniel@makrotopia.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org>
 <20240704171604.3ownsxasch5hokty@skbuf> <ZobgcXm9-am7xX6f@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZobgcXm9-am7xX6f@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 04/07/2024 20:48, Daniel Golle wrote:
> Hi Vladimir,
> 
> On Thu, Jul 04, 2024 at 08:16:04PM +0300, Vladimir Oltean wrote:
>> On Thu, Jul 04, 2024 at 04:08:22PM +0100, Daniel Golle wrote:
>>> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
>>> using bootstrap pins. However, there are only 4 possible options for the
>>> switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
>>> switch is wrongly stated in the device tree as 0 (while in reality it is
>>> 31), warn the user about such broken device tree and make a good guess
>>> what was actually intended.
>>
>> Zero is the MDIO broadcast address. Doesn't the switch respond to it, or
>> what's exactly the problem?
> 
> No, MT7530 main device (ie. the switch itself, not the built-in PHYs
> which on MT7530 can also be exposed on the same bus) only responds to
> address 31 (default), 7, 15 or 23 (the latter 3 via non-default
> bootstrap configuration).
> 
> MT7531 always uses address 31 by default and also doesn't respond on
> address 0.
> 
> See also https://lkml.org/lkml/2024/5/31/236

To address my incorrect "0x0 is just another PHY address" remark there; in
22.2.4.5.5 of IEEE Std 802.3-2022, it is described that a PHY that is
connected to the station management entity via the mechanical interface
defined in 22.6 shall always respond to transactions addressed to PHY
Address zero <00000>. A station management entity that is attached to
multiple PHYs has to have prior knowledge of the appropriate PHY Address
for each PHY.

The MT7530 switch has the function to make its PHYs appear on the MDIO bus
which the switch also listens on. This feature is controlled by the
relevant bootstrap pin or by modifying the relevant bit on the modifiable
trap register. The MT7530 DSA subdriver currently configures the modifiable
trap register to enable this function. So one of the switch PHYs listens at
the PHY address 0x0. I don't know whether the switch would respond to
transactions addressed to the PHY address 0x0, if this function was
disabled. Finding this out doesn't seem too relevant to this topic.

>>> as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
>>> switch from device tree") the address in device tree will be taken into
>>> account, while before it was hard-coded to 0x1f.
>>>
>>> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
>>
>> I fail to understand the logic behind blaming this commit. There was no
>> observable issue prior to 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY
>> address of switch from device tree"), was there?
> 
> Please see the lengthy debate here:
> 
> https://lore.kernel.org/linux-arm-kernel/af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com/T/#mc967f795a062f6aaedea7375a3be104266e88cc4

This thread may not directly answer the question. The understanding Daniel
and I have come to is that the fact that the issue appeared after commit
868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch from
device tree") doesn't make it the commit to blame. But rather, the commit
that introduced a hardcoded 0x1f PHY address which, in result, allowed
broken device trees to work is to blame.

> 
> I should have provided a reference to that in the commit message or
> cover letter.

I agree, it would be a good idea to put it in the commit message.

Arınç

