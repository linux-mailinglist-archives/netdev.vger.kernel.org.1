Return-Path: <netdev+bounces-197734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0920AD9B70
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0416D3B8539
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77BE1F4295;
	Sat, 14 Jun 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="b6XWLLvp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6F38384;
	Sat, 14 Jun 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749890349; cv=none; b=jVjwcRw158STzojMJEeLoGFDMbNIeDFhp6cQeomDskpsoE1/OBgyIJm1sAhbJwUJZ2ZfuL97V1EBTpJiP/gPFy7clxfuisrB+X7QtGZbNuv6QhNuaY+pcTBRddea9BTLP0l2sfO1owmlKo4om6hYGBD90eSv7ydyv0SkedPvWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749890349; c=relaxed/simple;
	bh=y53vcfzBA/QLo9DPgUEzYxoqQBapXTxQQEW5PJv4IwU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KQPPUiMSqWz3OevJILpJIf/MfPzFLxxkb59kdFzYA7wFY1Fias3fy3ykPjkdUVY9M1egzV0zKwE7qFxBccamQMvYMR3U1Z9pPbgnBN8EdPfZg7r4tugVpBaFHGuWPPYmVUMgo8r9sPzFIprfFHR4CHHNzQLvJKDLF9GXhm1Js+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=b6XWLLvp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749890314; x=1750495114; i=frank-w@public-files.de;
	bh=9TEZAlxDa5acq01LkdKBavZd5R2cJglwAlEtuKPbdhw=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b6XWLLvpxRRTsTMRLcvZYMJgXxX7kjINssuIoBGMmhx3foxTEDx6mmFGRLLVoKCP
	 fW2VOKo2yh3Siv/zZXZjLMWn7FdW+ZD8E8xMGgGkVB8Hctxciy4obcUoMq9uLXyEA
	 yYGKywXSTtjwPVuCLi/O79ejcT5KRJndtwPoZH92hFVRx8H6YkodTRWyVOPhaU6w4
	 VTiNcMrz4ftrOp99nrLnl02nYd0ylfMQFDYflYGR83Z748i7zm7HvywW4XelaOZCD
	 xCoFjL1PxxLd7valEDwRCjBRhbsALraIR8oOeWxsJaRV3tx6EltBDgrW+iEyp5bib
	 QqbLqFBUk1oDlCbyFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.76.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1utOnC3FFr-014PR0; Sat, 14
 Jun 2025 10:38:33 +0200
Date: Sat, 14 Jun 2025 10:38:28 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Frank Wunderlich <linux@fw-web.de>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org
Subject: Re: [net-next v1] net: ethernet: mtk_eth_soc: support named IRQs
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <aE0pav5c8Ji1Q7br@lore-rh-laptop>
References: <20250613191813.61010-1-linux@fw-web.de> <aE0pav5c8Ji1Q7br@lore-rh-laptop>
Message-ID: <E6B6CB88-4B47-455D-9554-DE9BFC209454@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrsbjBGKMLoUdsIVKIdsdqQcm6qpyk4B31BbV7S4fPZu//cUl8L
 bKal6c09RHgy6BMsl4qTcr4MykN42AZ5qAqgwBfze5B9g4ZtfwKwC/B2xU6xHNxpaCq8px/
 9mLj4heIYgyGi/FqypAGm9EXPI+EX8ugIxmk5+2IUqiaHURvZuBrKNSmzS1c7ampIwXoupK
 ijiHJbP6ouhIoCa+iP1Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ECGvj57vr6I=;c0DD0gTvw/5BlGkR573YNjwkx+N
 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
 OOA2lc1DIeKpK5Q3

Am 14=2E Juni 2025 09:48:58 MESZ schrieb Lorenzo Bianconi <lorenzo@kernel=
=2Eorg>:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add named interrupts and keep index based fallback for exiting devicetr=
ees=2E
>>=20
>> Currently only rx and tx IRQs are defined to be used with mt7988, but
>> later extended with RSS/LRO support=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec | 24 +++++++++++++------=
--
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc=2Ec
>> index b76d35069887=2E=2Efcec5f95685e 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec
>> @@ -5106,17 +5106,23 @@ static int mtk_probe(struct platform_device *pd=
ev)
>>  		}
>>  	}
>> =20
>> -	for (i =3D 0; i < 3; i++) {
>> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
>> -			eth->irq[i] =3D eth->irq[0];
>> -		else
>> -			eth->irq[i] =3D platform_get_irq(pdev, i);
>> -		if (eth->irq[i] < 0) {
>> -			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
>> -			err =3D -ENXIO;
>> -			goto err_wed_exit;
>> +	eth->irq[1] =3D platform_get_irq_byname(pdev, "tx");
>> +	eth->irq[2] =3D platform_get_irq_byname(pdev, "rx");
>
>Hi Frank,
>
>doing so you are not setting eth->irq[0] for MT7988 devices but it is act=
ually
>used in mtk_add_mac() even for non-MTK_SHARED_INT devices=2E I guess we c=
an reduce
>the eth->irq array size to 2 and start from 0 even for the MT7988 case=2E
>What do you think?

Hi Lorenzo,

Thank you for reviewing my patch

I had to leave flow compatible with this:

<https://github=2Ecom/frank-w/BPI-Router-Linux/blob/bd7e1983b9f0a69cf47cc9=
b9631138910d6c1d72/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec#L5176>

Here the irqs are taken from index 1 and 2 for
 registration (!shared_int else only 0)=2E So i avoided changing the
 index,but yes index 0 is unset at this time=2E

I guess the irq0 is not really used here=2E=2E=2E
I tested the code on bpi-r4 and have traffic
 rx+tx and no crash=2E
 imho this field is not used on !shared_int
 because other irq-handlers are used and
 assigned in position above=2E

It looks like the irq[0] is read before=2E=2E=2Ethere is a
 message printed for mediatek frame engine
 which uses index 0 and shows an irq 102 on
 index way and 0 on named version=2E=2E=2Ebut the
 102 in index way is not visible in /proc/interrupts=2E
So imho this message is misleading=2E

Intention for this patch is that irq 0 and 3 on
 mt7988 (sdk) are reserved (0 is skipped on=20
!shared_int and 3 never read) and should imho
 not listed in devicetree=2E For further cleaner
 devicetrees (with only needed irqs) and to
 extend additional irqs for rss/lro imho irq
 names make it better readable=2E

>Regards,
>Lorenzo
>
>> +	if (eth->irq[1] < 0 || eth->irq[2] < 0) {
>> +		for (i =3D 0; i < 3; i++) {
>> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
>> +				eth->irq[i] =3D eth->irq[0];
>> +			else
>> +				eth->irq[i] =3D platform_get_irq(pdev, i);
>> +
>> +			if (eth->irq[i] < 0) {
>> +				dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
>> +				err =3D -ENXIO;
>> +				goto err_wed_exit;
>> +			}
>>  		}
>>  	}
>> +
>>  	for (i =3D 0; i < ARRAY_SIZE(eth->clks); i++) {
>>  		eth->clks[i] =3D devm_clk_get(eth->dev,
>>  					    mtk_clks_source_name[i]);
>> --=20
>> 2=2E43=2E0
>>=20


regards Frank

