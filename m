Return-Path: <netdev+bounces-189560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A58AB29E7
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7522F1896709
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D831725D534;
	Sun, 11 May 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Utga2vAW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993922D7A3;
	Sun, 11 May 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984596; cv=none; b=KjzxNwujtTt7WtvN0KGiybtAXCMmNEKAqI5gHQGKknVRqZLkga3zcr2yaS6KKmPwACZ0NEnhuV/c6UA3Ex9sZrp2YBFik0dXPYQ0WsmMjXhBkh4o1/SDougaNYkFPEDeqXxC/cH5WV/OUH3X0rT73P8lOQiGPOhZwRgNvhshFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984596; c=relaxed/simple;
	bh=Xm54b7FIxn9EmGzhkoS0Bqyh419hbVPbhxOdmUpi8Eg=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=pS/nnF9qL3jt9VinPC7LbaQZglUkDvYfAuFIjePT7jLuIv94ey0ANgcMKP84Va0bW7BATQ18poWFGgg8p7wgIOeELKV9pw4DSWQ8inakNj9rT8/oOtdS970EIP2GQX/oNEN3vhAXAZCaMKxsXfQR6VlMt7WPXAuVWeEkNIg46MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Utga2vAW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746984592; x=1747589392; i=frank-w@public-files.de;
	bh=XOICA0kRmRSeeiiMWejN54dns8o6sstPqVt44YaHJeY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Utga2vAWbEwZB5tCvJ//8evLCeQJdAGBT0/WdCddSpCWykGzGt+DrgHFW9jrInFv
	 X4VA71H+HzPNJGG09lnhAVSouYFG+kBvttju6vKZUF/ZYc1Rd2ZJFgbp0ffWZm+uB
	 fB8ECScB6T5cRofW9rnFVCJxfdVS/ZgbhK0O+vCp7yAmgv4mpk22fh2Y+vOjwSXr/
	 FoYMeNFMuZ6rjwm+ziJDNZItPRwZl08RK9jzz31a3Rz1kd2lnGudj+ZLGIcNn6vQc
	 P9y7Y9sLcbYM1F4iv9FBaIVYjtXxdR9tSUq/LVzDKNlZg/uPetRVwu8cEkEiSzfNw
	 W9ZhInXV8e+THxdZLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.84.99] ([194.15.84.99]) by
 trinity-msg-rest-gmx-gmx-live-74d694d854-ls6fz (via HTTP); Sun, 11 May 2025
 17:29:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-0edcdb4e-bcc9-47bb-b958-a018f5980128-1746984591926@trinity-msg-rest-gmx-gmx-live-74d694d854-ls6fz>
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
Subject: Aw: Re: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch
 node
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 May 2025 17:29:52 +0000
In-Reply-To: <bfa0c158-4205-4070-9b72-f6bde9cd9997@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-10-linux@fw-web.de>
 <bfa0c158-4205-4070-9b72-f6bde9cd9997@lunn.ch>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:xDJuZkbJ3YvLYfk69h+JQf9MgwT1/EB0aqp6/XrIY4Sl5VLzsRm0mP3iqdn4GInbSCyS8
 tbaA51t47s9kxyUzSOGKhyYaAY+/yjZIZsrpvJUv3sn4MwT5FILgyd1wlpqhd2ayW7tuohHhou8A
 SL6Ocrg+LoqF2kuHTrSz6Te1PnZ0iVt3kwOO4VdYXlO0emZp8BLExcZubgiKIakqNVFvs6Mt8p+d
 T0kQhMmsCT1/h6y6QiEB0IloHZs/vFlbgknGKBjC/oO67tB4OfIsaPsDC8W9GNvoPTa1asj6NFK0
 YHSu/+v8fOSugdnyNUsPpq2qzqpdxw2YdhH/5NxkDJQNusNXRPumeoEtQGH8uSmKWc=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TyDEBoQdtoY=;ff6mg+UXFWYPsI/gmV2+q/fTvcr
 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
 xvLe4IEUiBz7UrUXGpg==
Content-Transfer-Encoding: quoted-printable


> Gesendet: Sonntag, 11. Mai 2025 um 18:42
> Von: "Andrew Lunn" <andrew@lunn.ch>
> Betreff: Re: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch n=
ode
>
> On Sun, May 11, 2025 at 04:19:25PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Add mt7988 builtin mt753x switch nodes.
> >=20
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 166 +++++++++++++++++++++=
+
> >  1 file changed, 166 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt7988a.dtsi
> > index aa0947a555aa..ab7612916a13 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> > @@ -5,6 +5,7 @@
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/pinctrl/mt65xx.h>
> >  #include <dt-bindings/reset/mediatek,mt7988-resets.h>
> > +#include <dt-bindings/leds/common.h>
> > =20
> >  / {
> >  	compatible =3D "mediatek,mt7988a";
> > @@ -742,6 +743,171 @@ ethsys: clock-controller@15000000 {
> >  			#reset-cells =3D <1>;
> >  		};
> > =20
> > +		switch: switch@15020000 {
> > +			compatible =3D "mediatek,mt7988-switch";
> > +			reg =3D <0 0x15020000 0 0x8000>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <1>;
> > +			interrupt-parent =3D <&gic>;
> > +			interrupts =3D <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > +			resets =3D <&ethwarp MT7988_ETHWARP_RST_SWITCH>;
> > +
> > +			ports {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +
> > +				gsw_port0: port@0 {
> > +					reg =3D <0>;
> > +					label =3D "wan";
>=20
> I would expect the label to be in the board .dts file, since it is a
> board property, not a SoC property.

i will move that into the board dtsi file in v2 because "normal" bpi-r4 an=
d 2g5 variant are same here.

regards Frank

