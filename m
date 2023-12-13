Return-Path: <netdev+bounces-57026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B029D811A16
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA5B21147
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15035F0F;
	Wed, 13 Dec 2023 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="iYqRh1lE"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCDAC;
	Wed, 13 Dec 2023 08:51:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A636B60006;
	Wed, 13 Dec 2023 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1702486316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO+XQgFKSsBWJhVaHsjNWAi6FsCEUTPXzosA6TLpkG0=;
	b=iYqRh1lE0vFH0qsU/MBWMTVw3nOznRswNPqjqKsuzFOzVOJjA3wKelXxC/ez3kzfJDIokT
	nOcHnJt5czuN/T8cHOgcLc3G7m31L8TfhSWJdHPU4rDq+DzyHsB97pgB7AwmbeQAbOQcxN
	I7ijsXFuXmk4wDBuYcLvsqBWPjRoiVn1f/0u+4dFBw5TzI/ihaTfmNo4H2tUPjIT8weoUU
	kDDpeXBIaMThHWPHgqlAyHA0acPk4Mdu2QbqXYUFBRiMO/qrdCnUtgwukNnJdMYPxqswYA
	psvrxd1eYzqxZIlzi8nsSJwYkoN3RXmMhNOQHqGzAxh9TFGNamRUxIYssv62Iw==
Message-ID: <fe48082e-1545-4cb6-a29a-79b4f6276c91@arinc9.com>
Date: Wed, 13 Dec 2023 19:51:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>
 <20231213151910.hr3n4px7a4upc372@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231213151910.hr3n4px7a4upc372@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 13.12.2023 18:19, Vladimir Oltean wrote:
> Hi Arınç,
> 
> On Sat, Dec 02, 2023 at 11:52:13AM +0300, Arınç ÜNAL wrote:
>> Can I receive reviews for patches 6, 12, 13, 14, and 15?
>>
>> Thanks.
>> Arınç
> 
> Sorry, I don't have time to look at this old thread anymore.
> 
> Please repost the series with the feedback you got so far addressed.
> Also, you can try to split into smaller, more cohesive groups of
> patches, that have higher chances of getting merged.

Thanks Vladimir. I've been fighting a bad fever with sore throat. I'll
submit the first 7 patches after working on your reviews.

Thanks a lot for your attention to my patches that's been going on for more
than half a year now.

Arınç

