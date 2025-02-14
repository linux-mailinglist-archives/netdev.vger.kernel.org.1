Return-Path: <netdev+bounces-166468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94239A361C2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2241B189231B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0197262D33;
	Fri, 14 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAOM1XOk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A321F92A;
	Fri, 14 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547120; cv=none; b=ufLja5FSXOPsPhA1pEvaTMUnl0Qi6DIHazee8AO9GfxSVSVRr7SJNvNfOATqtOoRuPibI1f91pX5XHEvtQEzPOoYqiejeU5H+HjlVQ9/WdWHdT5ZZv5kgKJIdvbMeKwiUGrjDPQy4zXx/SQfYITv7i9pUE5bvXqwXOEZEMAEWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547120; c=relaxed/simple;
	bh=KCDFKHc9ZM5Ox9QzR1rz3yyEmfiZGegSVP6n+hKiNTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcCZRLVWiRu9BrDmCdjLysHhsKHzPdEYsIhqtyulNKcQ2qvfDy7/iz4E/QQIMvtSw8WMvxGQD1tWLYOR0SmVJNW4ksKUL2wBANaFJ4CcEEFlR/PKLLGdsncLBr3g1y2/3rbMMltuOCrX/UGPRF3u1r/j+NPHAZyg3CE3Us5e/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAOM1XOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E4C4CED1;
	Fri, 14 Feb 2025 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547119;
	bh=KCDFKHc9ZM5Ox9QzR1rz3yyEmfiZGegSVP6n+hKiNTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mAOM1XOkaSwGMmCZJF0siuvK027HA4akMrVHBw/HNJ1G/YlovIjCYRalILudDt17Q
	 OkfJUPQrzyisirDB+2R8GCuC4ELSipKb9i0yIMXHQbzzeOtJhrGOCOtaLBCfWCH4jf
	 Tos5hlYEyQNysU2O+Bsai9OyYGn8KXyJrzufSnHhZM40WhVpr2HEHIURouXK/WW6Bo
	 QmkjDDwn3ZYRIoceel598tbcLov6pHWXSZ6vWosyXvE8tQTJh0oWLkjDuMKlwkdCiV
	 IOQCRYZsGTOXsD4SxUy9dxWeE6EZ4hXHis8ha95tpYe6ckNgFchy11yRpykSFDjr41
	 2UIYtRRdvp59g==
Message-ID: <6dac6db1-60ef-4a14-8998-7da44c26690f@kernel.org>
Date: Fri, 14 Feb 2025 16:31:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
To: =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "dqfext@gmail.com" <dqfext@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc: =?UTF-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
 <df2a463c-102c-4eb1-905d-96dbd926db7e@kernel.org>
 <e58dabed4915e5c2dcece5f047e045ca08f836b6.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <e58dabed4915e5c2dcece5f047e045ca08f836b6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2025 14:23, SkyLake Huang (黃啟澤) wrote:
> On Thu, 2025-01-16 at 13:45 +0100, Krzysztof Kozlowski wrote:
>>
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 16/01/2025 02:21, Sky Huang wrote:
>>> +
>>> +static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
>>> +{
>>> +     struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
>>> +     void __iomem *mcu_csr_base, *pmb_addr;
>>> +     struct device *dev = &phydev->mdio.dev;
>>> +     const struct firmware *fw;
>>> +     struct device_node *np;
>>> +     int ret, i;
>>> +     u32 reg;
>>> +
>>> +     if (priv->fw_loaded)
>>> +             return 0;
>>> +
>>> +     np = of_find_compatible_node(NULL, NULL, "mediatek,2p5gphy-
>>> fw");
>>
>> There is no such compatible. You cannot just add undocumented
>> bindings.
>>
>> Also, devices should not just look for some random compatibles.
>> Express
>> proper relationships with phandles or node hierarchy.
>>
> Hi Krzysztof,
>   OK. I'll add dt-bindings' document in next version.

Carefully read the comment instead. Anyway, if you come with response to
the comment after one month (nice disproportion between received review
and responding to feedback), my entire context is gone.

Best regards,
Krzysztof

