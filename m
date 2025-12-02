Return-Path: <netdev+bounces-243199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2194C9B633
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63BCD3433D8
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD1311C21;
	Tue,  2 Dec 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=frankwu@gmx.de header.b="IXZvYuOU"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFE2288F7;
	Tue,  2 Dec 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676390; cv=none; b=FR1RryBwWqhzuZbMhN+aTEifg3mZdOQfSm659Q87tRkYnR02J1IWbPssht+faUT8kUHhNGNaWVu6rEOkUw7yVD4I88ZnZdNbH0/slWQMB7ytN2Eg0ga7M/bfqo8uHohkvI2bSNE2fatntNpa6bwh6xASwkWdRrAX8Z/DghFlozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676390; c=relaxed/simple;
	bh=vOEDWTc25t7GeWBCHWzSh7CWU+UCU7SlHz3TtAiTroM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHl8K4GaVZtHRDTSowNN5glt3y9VSE0TTRZUVwjcTXRZg/D84kiW/TbAM6OgzIeVV5cdv33jXgbSZK+lTzR5aoZzEn5ZK8VJTS2ob+BYmu789hFGLC03OE0DXOvpScSr57oRDt2LnYyNWJko/bkX8imrx8zqzvsvrTYE0W56BR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=frankwu@gmx.de header.b=IXZvYuOU; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764676367; x=1765281167; i=frankwu@gmx.de;
	bh=ZKK8fuFr9gnz0qBnyFzmVbIPQhya3mmpV5DTDhWJQII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IXZvYuOU9O1zKV7IBDnyb9fkJ47dsG9Kpd1LFVXV9IdO7fzCkpXNJpmofYOtXhZD
	 Pk/NmzqXMHto/jSLjLdb7ABG6eFALptUNBJSyZuYtojMMLCWv6B0BWm1jqyFCqkJt
	 2naxzW015Pqhz5aDwVsYtIyPh4TR6IK80UWn1ugwfNxTIIHqnIXD1i3LYi5b4KKQL
	 6DW7es6Vj0BMNmTQtAc+pCdTdGb5ZL35YUxqvvthS+yE6PlldTKK39myvsqw2DkXY
	 ARhUUzYzPYevNDuJTXGdhB6aQniB3ZL4mbg1FcF5VpaJ7HvetWhqOIdTx3cKMbF3B
	 4vQoy7mM2hyoWqvp1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.21] ([217.61.154.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1vqhHL20Zs-00ZJ41; Tue, 02
 Dec 2025 12:52:47 +0100
Message-ID: <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
Date: Tue, 2 Dec 2025 12:52:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
Content-Language: en-US
From: Frank Wunderlich <frankwu@gmx.de>
In-Reply-To: <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yhcrH/hXSf4oD3RbBC/vdPi1/zgONn9HfKrwoRg/3mSAhJ9Joch
 6/vgao+SgLSSOwXE3rKrZKVbyoS+Z0e0y56ZJ1rKMu7mxmkvE+XRmwD9v3pYgKe1XsiJIk5
 lZF21C+8ny26t4hn9E9HI4WZW5c9hno9cH60GyedFHgt/oPVNpVJybWxt0cKaejGN+fxH5p
 QYqgJfJXJ8B/jR0OuAnzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aBrF2WwBXlg=;/I8mK5WiGgEJNQfH3ODNFrKKvak
 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

Hi,

Am 01.12.25 um 08:48 schrieb Krzysztof Kozlowski:
> On 30/11/2025 21:17, Andrew Lunn wrote:
>> On Sun, Nov 30, 2025 at 10:07:31AM +0200, Vladimir Oltean wrote:
>>> On Sun, Nov 30, 2025 at 02:11:05AM +0100, Andrew Lunn wrote:
>>>>> -		gpiod_set_value_cansleep(priv->reset, 0);
>>>>> +		int is_active_low =3D !!gpiod_is_active_low(priv->reset);
>>>>> +		gpiod_set_value_cansleep(priv->reset, is_active_low);
>>>> I think you did not correctly understand what Russell said. You pass
>>>> the logical value to gpiod_set_value(). If the GPIO has been marked a=
s
>>>> active LOW, the GPIO core will invert the logical values to the raw
>>>> value. You should not be using gpiod_is_active_low().
>>>>
>>>> But as i said to the previous patch, i would just leave everything as
>>>> it is, except document the issue.
>>>>
>>>> 	Andrew
>>>>
>>> It was my suggestion to do it like this (but I don't understand why I'=
m
>>> again not in CC).
>>>
>>> We _know_ that the reset pin of the switch should be active low. So by
>>> using gpiod_is_active_low(), we can determine whether the device tree =
is
>>> wrong or not, and we can work with a wrong device tree too (just inver=
t
>>> the logical values).
>> Assuming there is not a NOT gate placed between the GPIO and the reset
>> pin, because the board designer decided to do that for some reason?
jumping in because i prepare mt7987 / BPI-R4Lite dts for upstreaming=20
when driver-changes are in.
With current driver i need to define the reset-gpio for mt7531 again=20
wrong to get it
working. So to have future dts correct, imho this (or similar) change to=
=20
driver is needed.

Of course we cannot simply say that current value is wrong and just=20
invert it because of
possible "external" inversion of reset signal between SoC and switch.
I have to look on schematics for the boards i have (BPI-R64, BPI-R3,=20
BPI-R2Pro) if there is such circuit.
Maybe the mt7988 (mt7530-mmio) based boards also affected?
But not changing driver imho results in future broken devicetrees or can=
=20
this
avoided somehow?
Nethertheless the driverchange needs to be done before dts change.

regards Frank
> Yeah, I cannot imagine how this could possibly support old and new DTS
> without breaking some users, unless people over-simplified and discarded
> some cases. But then this should clearly mark these broken cases instead
> of falsely claim that impossible task of rewriting the flag is done
> correctly.
>
> BTW, the code clearly does not handle such cases, so "we can determine
> whether the device tree is wrong or not" statement is obviously not true=
.
>
> Best regards,
> Krzysztof
>


