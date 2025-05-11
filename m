Return-Path: <netdev+bounces-189558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DEAB29D7
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487C71894727
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE125C835;
	Sun, 11 May 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="OX7AyRVE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16625D1F6;
	Sun, 11 May 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746983509; cv=none; b=QQAa7RxJgkSixT5frLqqqn1+EyHdjARld8cfiJwrY+Y+aFrij5ZN4M4lRmn7PNkz64fLUYqWekbxhsK6l0G+Mg0njmBNoAtkpflm0P4K0eLOGkYpryBcqBaZF6epVNNy79qZfywR6EvvWVtv+aQE/w6ieKsut+r8Fh5v0lueeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746983509; c=relaxed/simple;
	bh=4+/KxXBskIK0RDTyhCfGrQo8tmuDxH8xOQwGZDnbOPQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=faqvJaSeidday6IRAlDQxTf03/TV6HBVoZpt3EAXzlNL+CgTTYrc+2miPV7kvwL/ojrgS8VQ450floFjtshKNQLy7Od8hpi+yS9CAs7Lw3thG4lVUsNsRZv9AVS75EaJRZlpAsrKWsPbabD5voHKYwDythI1l/5UhDtVMeVJbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=OX7AyRVE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746983499; x=1747588299; i=frank-w@public-files.de;
	bh=4+/KxXBskIK0RDTyhCfGrQo8tmuDxH8xOQwGZDnbOPQ=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OX7AyRVEpFno29IwtlTF2VTBMnL6+B/hMphY9BZduRqbICI0urp+cWWCA91uWgkZ
	 xGlO2sb+/XdfxUYJuT0y/LgAhv3c417X3o4faq7ZXEYqkb1+EgBS9md17avwMXSsS
	 1FxWgHOWlQ45pqgCooptU69Idn+20S6Mt8BIeL/HEF0Bloqx4Wso8xyOht7RXd/Hl
	 aZt5EcB71LIvUHh/h6JaVJEPm679Vv1n7Oe7Gg5r6g/bd1dO5GLhiQ518y3xqPHOU
	 xadwoqn4n3g9F1dBspCuPrMm9XldMc2Vy2og9fUqoCdKHW9BEeuvgr4rpEljev62D
	 fAMyEtf3u6uXMtpNDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.84.99] ([194.15.84.99]) by
 trinity-msg-rest-gmx-gmx-live-74d694d854-64x2n (via HTTP); Sun, 11 May 2025
 17:11:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-a7d75144-e618-4e09-ab4b-42e8557adb93-1746983498805@trinity-msg-rest-gmx-gmx-live-74d694d854-64x2n>
From: Frank Wunderlich <frank-w@public-files.de>
To: andrew@lunn.ch, linux@fw-web.de
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 daniel@makrotopia.org, lorenzo@kernel.org, nbd@nbd.name,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530:
 add dsa-port definition for mt7988
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 May 2025 17:11:38 +0000
In-Reply-To: <88d93b58-84f3-4394-80ed-9adf67d525f4@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-3-linux@fw-web.de>
 <043d1a0a-1932-42f3-bcd8-17fad10c5543@lunn.ch>
 <88d93b58-84f3-4394-80ed-9adf67d525f4@lunn.ch>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:IEgHLeNpmXm8RjqZWMnrNFlf2ZQICiEArO7hSHNKwiHWYLtBLg/DWUlg1cBIYLoCCfipT
 UZLgTYfr0qJOwNc1fcYe45/v7asWaMd0+3Z8htRjIf3oFfEVPXxi96WPvAbUCqKagU1CguYfJyGv
 NwviTo/6uLvP4wYdr6ck8N77JeBjgdDXlSUIleVJ6utOXEvHiWDwhDauu5JQ3ybh5g7Ktr7L5dzS
 eYyYzY8DSsUeh0HJPEtbfMgeAVY5KCC9f+l8oNVNHQe52ybkw6ZR7VFIHLeeYtGRsG4lPvL9b/tr
 n1ntMXXuJDyMAjXDTekZB+66Ps4yMppb3I1fEhQRlqaRk7fSed7nw7U+oW2GYliShc=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LzP0Bc1axNI=;228SBXE+fpIqt/AekccYzb43SZD
 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
Content-Transfer-Encoding: quoted-printable

> Gesendet: Sonntag, 11. Mai 2025 um 18:45
> Von: "Andrew Lunn" <andrew@lunn.ch>
> Betreff: Re: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530: ad=
d dsa-port definition for mt7988
>
> On Sun, May 11, 2025 at 06:34:30PM +0200, Andrew Lunn wrote:
> > On Sun, May 11, 2025 at 04:19:18PM +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >=20
> > > Add own dsa-port binding for SoC with internal switch where only phy=
-mode
> > > 'internal' is valid.
> >=20
> > So these internal PHYs don't have LEDs?
>=20
> Ah, i got that wrong, sorry.
>=20
> What i don't know about here is if you should be defining your own
> ds-port binding, or taking the existing binding and add a constraint.

Hi Andrew

thank you for first review.

this patch is only for allowing the phy-mode 'internal' and corrects the w=
rong mapping to mt7530-das-port which allows rgmii and sgmii which are inv=
alid on mt7530.
i splitted the changes in binding to not squash different changes.

the phys with leds are on the builtin mt7530 internal mdio-bus which i add=
 in patch 3.

regards Frank

