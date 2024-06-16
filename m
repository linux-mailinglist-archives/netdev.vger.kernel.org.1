Return-Path: <netdev+bounces-103832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4D909BFF
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771BA1C212C9
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 07:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FC16D338;
	Sun, 16 Jun 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Fxl4nyA4"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5949637;
	Sun, 16 Jun 2024 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718521344; cv=none; b=h4r7o36CE639ZG/DihtEmg+WXQdQBx1ffG4F10Ie6izluMm00mbPsFbMJo2aDiQ7bLhEdhjdigI0py1945lW7knbW8Y6k/XFM4Y/ZyPZfQF/1c1cE1X9gX6VdbqHbFyHgy4W3lDALEvHGRw5znOiBa0i2Sz/mR4+u4d5ZlW0BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718521344; c=relaxed/simple;
	bh=LjGJ6rl2oueZLAlynoI5JEGa4MCNl25bPqTugdvjyO8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YeEY3cSdKOVzAcx55PzaW2k8BNklIJQvA1yo/wuu0US6qCQHcV53A/m3pmf9enmvDd0gfU/CjcUUOavdqcE63rdQelxKmun+GV6CbRXnoH47Y+b79TgFHbJhbiGCKnxx853FdR6e5zmWitzR4PzkvOdAGtibd8Jp3PbtPGP+r5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Fxl4nyA4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6199FF807;
	Sun, 16 Jun 2024 07:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718521334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHz5wWhoZB1ZJeF9u59vMYelSxXRAN9/WTQXNh1hnWA=;
	b=Fxl4nyA4ZCgqZk95/mvKKdJtM4ECl69KDa8YCAkBIloYtViECzDT0Qq2V1X7wGxEnyR/DE
	ex4DX6U1UQVvrYTIPE9R0bCymIZx4EmTJFITn25L+e4Xqpdu+vsDcWzsrBGjaMi7tnNWmO
	Ybjp2JtqunDz3byfF63exkXFkVjQj9muqhN1qkux+X8PMZED2rVctNRnUIf6CRvjNd0v2M
	gEfMQhmoqXaoc4wT/sI1zphW+eqmzcopTWYuveFlg4ey00cWIXJ4uvO3/CP/OGUrScfnpK
	W/wZFygCw77USSld8qXWNC7gWnkkkbHYeUU98CATAEMp76kVNl0JP2bewk+UEA==
Message-ID: <6f70da58-b68b-4a93-b369-2cc86e9158d4@arinc9.com>
Date: Sun, 16 Jun 2024 10:02:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
Content-Language: en-US
In-Reply-To: <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16/06/2024 09:52, Arınç ÜNAL wrote:
> On 15/06/2024 01:21, Matthias Schiffer wrote:
>> Remove a pair of ports from the port matrix when both ports have the
>> isolated flag set.
>>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>> ---
>>   drivers/net/dsa/mt7530.c | 21 ++++++++++++++++++---
>>   drivers/net/dsa/mt7530.h |  1 +
>>   2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index ecacaefdd694..44939379aba8 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -1303,7 +1303,8 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>>   }
>>   static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>> -                      const struct net_device *bridge_dev, bool join)
>> +                      const struct net_device *bridge_dev,
>> +                      bool join)
> 
> Run git clang-format on this patch as well please.
> 
>>       __must_hold(&priv->reg_mutex)
>>   {
>>       struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
>> @@ -1311,6 +1312,7 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>>       struct dsa_port *cpu_dp = dp->cpu_dp;
>>       u32 port_bitmap = BIT(cpu_dp->index);
>>       int other_port;
>> +    bool isolated;
>>       dsa_switch_for_each_user_port(other_dp, priv->ds) {
>>           other_port = other_dp->index;
>> @@ -1327,7 +1329,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
>>           if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
>>               continue;
>> -        if (join) {
>> +        isolated = p->isolated && other_p->isolated;
>> +
>> +        if (join && !isolated) {
>>               other_p->pm |= PCR_MATRIX(BIT(port));
>>               port_bitmap |= BIT(other_port);
>>           } else {
> 
> Why must other_p->isolated be true as well? If I understand correctly, when
> a user port is isolated, non isolated ports can't communicate with it
> whilst the CPU port can. If I were to isolate a port which is the only
> isolated one at the moment, the isolated flag would not be true. Therefore,
> the isolated port would not be removed from the port matrix of other user
> ports. Why not only check for p->isolated?

The concept of port isolation is that the isolated port can only
communicate with non-isolated ports so the current implementation looks ok.

Which switch models did you test this on; MT7530, MT7531, MT7988 SoC
switch? I will test it on MT7530 and MT7531 tomorrow evening.

Arınç

