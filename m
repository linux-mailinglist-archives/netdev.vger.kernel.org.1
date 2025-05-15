Return-Path: <netdev+bounces-190615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3BAB7D15
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4177AE091
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925329550B;
	Thu, 15 May 2025 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="dpNdBDw9"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF1291144;
	Thu, 15 May 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287654; cv=none; b=FmsiYmUrPIEGEUYoiHHojo6++PaASdcKKW3+LHHE0KlvW6P/y0xSndrJMRg9ve1k+KNp274QqiE7DrXrO0mJ6KWp4X8bOa8BlLc9lswNZQ6MbIJWIN5F81PzWAjpsbqRwXX50zk18brkwaFuumu+qltJCdFMTXE/LGiEbK9VGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287654; c=relaxed/simple;
	bh=FTS2jaigmRTuHNQ47Uh4PLqADBQhy/Rl6ysLNcuYP7c=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=CrNUqN3j44MByjmWEoPiN04rSpfPhLbf+w0OjYH+ZRSb4Gj0VIYykn4HHo1JlcwyCeBrRcfFewF12Py50S5KVf4+C6CaxB6Jxlvni05ZcuePaQcYYCw5fckFwfi1c70lKHvWDGSSXA2YL7lCUdoZI7Pym8HXzxTH5/o7f06ylLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=dpNdBDw9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1747287649; x=1747892449; i=frank-w@public-files.de;
	bh=1xplXiwnlFIAnXDQ0/5PHPSai2MVO8w5tVWi4Ozreu8=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dpNdBDw9B/Ba3UG4n6oHa87o/k+AtNaXPxr6Cq6BDJ+qvfB+Xd5icgE5GxzN6r6U
	 nFvEQEghXrfIdbVEC+dNBWn4cXx9HpN0ChsnjJ+AkRrbOE7TVSamDC5s7t1b+0MVS
	 BuE6d5/279HmJMXLe80vKL7585pX06Arznu1p99hrF3UuhzKrdJFtT3NQ/aVMB7BA
	 2ibSriBe04SWdCIyHjqAoy8azk8r/sff2IfcDs2Kbr+VA96Xh5BuLRWPiWao8H0mk
	 QmFROpcPK4FImmfJBbp/SMxmQ/OZUMkcLMLSWF29GKKo7y1XRryOF3/APcVdFzhLs
	 c6WLcYey/ju6VgOuOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.64.173.0] ([100.64.173.0]) by
 trinity-msg-rest-gmx-gmx-live-f4858f84-4zhfg (via HTTP); Thu, 15 May 2025
 05:40:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-59d5f7b7-741b-4cd0-80c5-45191f6918e4-1747287649179@trinity-msg-rest-gmx-gmx-live-f4858f84-4zhfg>
From: Frank Wunderlich <frank-w@public-files.de>
To: robh@kernel.org, linux@fw-web.de
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 daniel@makrotopia.org, lorenzo@kernel.org, nbd@nbd.name,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v1 03/14] dt-bindings: net: dsa: mediatek,mt7530:
 add internal mdio bus
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 05:40:49 +0000
In-Reply-To: <20250514211810.GA3051536-robh@kernel.org>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-4-linux@fw-web.de>
 <20250514211810.GA3051536-robh@kernel.org>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:JLO4bbfcQ3tQEcfdI0XXkRq5uuMltQ58woFM9Lbw3ADVJkpk/bzZ09XVSI35MbbHUnRRr
 FoCHc7tAobvhLPlAtlxL3kmnVgX2H6Ic8R9TahCxqP4lk9s/s/SQYyhEhvIfpMiPMOoD8qsWpNzV
 OeQL4uMCEixugTTUkeceDVdY3sNtFMIPIA2mHmHUn8rImwIPb/Z+zSNMWadeThONvIS6uoNJEYpD
 uRmdyWKtonX0dlGQ9U7bEIjBQ2VArQeY+01rW/5KxQY6iePDzFmSpi3WUz+KBvjKscqfwBtoNRoi
 x10auMjDUgiUb3WRb5t0V9UcIwVQdTXicDev5bFEPelBPLbumPm3jiwoWqzG0iNBfM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/8YkwxI58Z0=;OjW/cXXxAlHNZispu+PcdzyOv3w
 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
 wHoy2t
Content-Transfer-Encoding: quoted-printable

Hi Rob,

thanks for review

> Gesendet: Mittwoch, 14. Mai 2025 um 23:18
> Von: "Rob Herring" <robh@kernel.org>
> Betreff: Re: [PATCH v1 03/14] dt-bindings: net: dsa: mediatek,mt7530: ad=
d internal mdio bus
>
> On Sun, May 11, 2025 at 04:19:19PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Mt7988 buildin switch has own mdio bus where ge-phys are connected.
> > Add related property for this.
> >=20
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml | 3 ++=
+
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530=
.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > index bb22c36749fc..5f1363278f43 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> > @@ -156,6 +156,9 @@ properties:
> >      maxItems: 1
> > =20
> >  patternProperties:
> > +  "^mdio(-bus)?$":
>=20
> Really need 2 names?

no, i only tried to stay close to definition in mdio.yaml ;) there are som=
e mt7988 boards floating around
where i do not know the dts. But i can make only "mdio" to be changed late=
r if needed.

> > +    $ref: /schemas/net/mdio.yaml#
>=20
>        unevaluatedProperties: false

ok, then i need to add 'mediatek,pio' subproperty in next round...would be=
 ok in this way?

  "^mdio(-bus)?$":
    $ref: /schemas/net/mdio.yaml#
    unevaluatedProperties: false

    properties:
      mediatek,pio:
        $ref: /schemas/types.yaml#/definitions/phandle
        description:
          Phandle pointing to the mediatek pinctrl node.

regards Frank

