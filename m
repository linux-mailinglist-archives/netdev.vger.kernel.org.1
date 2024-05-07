Return-Path: <netdev+bounces-93968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77D8BDC5F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F955B20B3A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6F13B59E;
	Tue,  7 May 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dVkAKfMa"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFD3D0BD;
	Tue,  7 May 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066768; cv=none; b=RbDrXTD416neAdw/l4JU6c+deAKSAS6kSGoVTIzrkYqpCGxzeVuyp87WPdOncMKmK0QanRqt08f2MzqihrtvRnznZty3DRWR+efdVItPTXSaMmIxrvJ9cH4lH9kWuVCp5o1prSjjxJX99E1E6vu22jdyrxSz+X9gUOveyNXIhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066768; c=relaxed/simple;
	bh=vWZiVhVZ4VfRJh+PvQIE2PH5QuO7XoyvlqA2pDGVzDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZFi3+kvQMKVMXw8YbGC6ZrUiU81DdXCnsIIxlw/bINB0wonlxdNr9V3AgxCOGI5OqBxHRY0qQMp/QqIrNlHie6EpKYWSjXQzS5bNLSgCL52bykxlpRQcUimkz3SuGGW3M3Jr8aEgxDn8fF7x1GLT36+5yQ4nO8/uBSCio0BB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dVkAKfMa; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD86D1C000B;
	Tue,  7 May 2024 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1715066763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4v7M/MN8aqackQkVc3/4p8TWYBtdQ4GtrVcP+9uGN+o=;
	b=dVkAKfMa8MHTQynPcQ3YAVbZrgfRh6T4busyc3WHCkNHdQkwOBeaIP1lU8DpDJvToT7dDo
	QH4c4lQ7H3wvZ0aG6tibjt3GzxGQBiCEtnAWqev8m4WwMo58OvBxJhY8Z4DOP9SiChMfmB
	aULtIe7z/hBie94nnxmZteRvu4XfMEJFc+OKw+pKoMADu/0nz3TupUYORdC5L/srw3Yuc/
	J5r94ZvX3q2sGmJai2zDFkXHbb5WBu5+B6W0/+uTCMbATLvU4kr7NObbtmailB+iKXCwjt
	/soagSRjRZ6dgMubU7zcvW3GiPhfyBnSmDN7RtqRduQYodG+ErBeGtVI9UhQgw==
Message-ID: <904e5bd2-4495-4c1b-a172-ffcd737e6ee3@arinc9.com>
Date: Tue, 7 May 2024 10:25:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: detect PHY muxing when PHY
 is defined on switch MDIO bus
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240430-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v2-1-9104d886d0db@arinc9.com>
 <Zji94d4yfEBaHlzt@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zji94d4yfEBaHlzt@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 06/05/2024 14:24, Daniel Golle wrote:
> On Tue, Apr 30, 2024 at 08:01:33AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
>> direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
>> bus the switch listens on. The PHY muxing feature makes use of this.
>>
>> This is problematic as the PHY may be attached before the switch is
>> initialised, in which case, the PHY will fail to be attached.
>>
>> Since commit 91374ba537bd ("net: dsa: mt7530: support OF-based registration
>> of switch MDIO bus"), we can describe the switch PHYs on the MDIO bus of
>> the switch on the device tree. Extend the check to detect PHY muxing when
>> the PHY is defined on the MDIO bus of the switch on the device tree.
>>
>> When the PHY is described this way, the switch will be initialised first,
>> then the switch MDIO bus will be registered. Only after these steps, the
>> PHY will be attached.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> 
>> ---
>> Changes in v2:
>> - Address the terminology on the patch log.
>> - Link to v1: https://lore.kernel.org/r/20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v1-1-1f775983e155@arinc9.com
>> ---
>>   drivers/net/dsa/mt7530.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 2b9f904a98f0..6cf21c9d523b 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2483,7 +2483,8 @@ mt7530_setup(struct dsa_switch *ds)
>>   			if (!phy_node)
>>   				continue;
>>   
>> -			if (phy_node->parent == priv->dev->of_node->parent) {
>> +			if (phy_node->parent == priv->dev->of_node->parent ||
>> +			    phy_node->parent->parent == priv->dev->of_node) {
> 
> I had some concerns about missing check for phy_node->parent != NULL,
> but it's impossible in practise. If phy_node exists, it will have a parent
> node as well.
> 
> To be super extra safe, maybe doing
> phy_node->parent && phy_node->parent->parent == priv->dev->of_node
> would be better.

At the current state of this driver where the hardware probes on OF, I
don't see any benefit of doing this so I'm going to pass on this for now.

Arınç

