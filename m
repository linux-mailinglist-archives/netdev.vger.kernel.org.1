Return-Path: <netdev+bounces-263297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFDqLpUFp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:00:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B61F31E7
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97E2B304EA5C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF13492529;
	Tue,  3 Mar 2026 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ggDR9wFY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D43597B;
	Tue,  3 Mar 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553557; cv=none; b=GUSydA+LxFcP2fXxElKqjth4vZsK4ZLtIV7dBrcHg60dmM2ZfiFfmJLcoWakSw+tW/Rfxybf5/7OIdLYB+jTDPNtuwRE37o7PbfxZCE0rF25CFW1CRUlPw5KGnP6FHR+09FrWcbI2nyQW13S8zDYdZblb2xQJ54WYhO0gL6Stp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553557; c=relaxed/simple;
	bh=2Znm2hKjnv23W5ZRgd7ir3fctbTedgRdOChcu0QH9A8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGhtFd2mNqGzVIZuHFUgW0kiVqcuG6bUKa8EzsRPK+unYPG0zCrPOuGhCPkaXUZxVHancZRxVnGfwZATgqPC/kEpY7GK/wZQhLomMqLFxd31zTsCUxfjPhWl/kijvB66g77BCP5HE07PclsKBlr3uhlZEom2ppZ0ubKYBVEo0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ggDR9wFY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772553556; x=1804089556;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2Znm2hKjnv23W5ZRgd7ir3fctbTedgRdOChcu0QH9A8=;
  b=ggDR9wFYcL7oQ8ijHOEH2dY9gi2dftJpFYVCyinJ6IAk9gmq8rNBXyOJ
   bMep+1WDapY4Vn8T5geAjfIDHxh4VDaRVaKFaEcJ1AymFQCRdhrUxPYYZ
   rnja/89KY+lFyhNgKekU45TT1tNPnKC5b9BYAU9mapCy4uLA43w2ZETHb
   sUPQwn6wiEoYRpD1B+creb61NoddAPz5zUpTfr45iP8HLXwpxXbz26syk
   zK+ytuEk0eSqVD7U3srsWNtDpTV14lVmdyfJu/RQml3YhUAIFZ7qQmWpG
   yQYCyHNxXyurvdR9+w5j6dh7z6udhq00vLeC7XuTHmb1EQy99aZN5CEjM
   g==;
X-CSE-ConnectionGUID: 9GrmsO/UR6GTr11tFUNC4A==
X-CSE-MsgGUID: agjHm55oSKid2moc5j8eLQ==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="53407437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 08:59:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 08:58:52 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 08:58:48 -0700
Message-ID: <1ceeb7fb0abc89f4b384c9d73b7d29c73bb8d53b.camel@microchip.com>
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Tue, 3 Mar 2026 16:58:48 +0100
In-Reply-To: <c0213890-ef36-435c-aa73-869ee5e849d5@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
	 <c0213890-ef36-435c-aa73-869ee5e849d5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 335B61F31E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263297-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 15:13 +0100, Andrew Lunn wrote:
>=20
> > +#define LAN9645X_VALIDATE_FIELD(_fld, _fld_sz)                        =
       \
> > +do {                                                                 \
> > +     BUILD_BUG_ON_MSG((_fld_sz) > 32, "IFH field size wider than 32.")=
;\
> > +     BUILD_BUG_ON_MSG((_fld_sz) =3D=3D 0, "IFH field size of 0.");    =
   \
> > +     BUILD_BUG_ON_MSG((_fld) + (_fld_sz) > LAN9645X_IFH_BITS,        \
> > +                      "IFH field overflows IFH");                    \
> > +} while (0)
> > +
> > +#define LAN9645X_IFH_GET(_ifh, _fld) \
> > +({ \
> > +     LAN9645X_VALIDATE_FIELD(_fld, _fld##_SZ);\
> > +     lan9645x_ifh_get((_ifh), (_fld), _fld##_SZ); \
> > +})
> > +
> > +#define LAN9645X_IFH_SET(_ifh, _fld, _val) \
> > +({ \
> > +     LAN9645X_VALIDATE_FIELD(_fld, _fld##_SZ);\
> > +     lan9645x_ifh_set((_ifh), (_val), (_fld), _fld##_SZ); \
> > +})
>=20
> If you change the BUILD_BUG_ON_MSG() to static_assert(), you can do
> the checks in global scope, rather than in a function call.  You can
> then call lan9645x_ifh_set() directly, without the macro.
>=20

Do you mean global scope static_assert() for all fields, and then remove
the SET/GET macros? My idea here was to get the validation for the fields
used, provided the macros are used at least. Can I do something similar
with static_assert or would I have to do all the fields globally up front?

> > +static inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos, size=
_t length)
>=20
> These functions are big enough i would place them into the .c file.
> Then, normally, i would say, please don't use inline in a C file. But
> here we are in the fast path. Have you tried this with and without the
> inline? How does it change the object size and performance?
>=20

I did test performance back when I first implemented this. I had some issue=
s
getting gcc to inline the functions, and that hurt performance quite a bit.
But I did not look at object size though. I moved them to the header so I c=
ould
add the inline. I can move them to the .c file in the next version.

> > diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> > index 5ed8c704636d..8592cccde7ff 100644
> > --- a/net/dsa/Kconfig
> > +++ b/net/dsa/Kconfig
> > @@ -211,4 +211,14 @@ config NET_DSA_TAG_YT921X
> >         Say Y or M if you want to enable support for tagging frames for
> >         Motorcomm YT921x switches.
> >=20
> > +config NET_DSA_TAG_LAN9645X
> > +     tristate "Tag driver for Lan9645x switches"
> > +     help
> > +       Say Y or M if you want to enable NPI tagging for the Lan9645x s=
witches.
> > +       In this mode, the frames over the Ethernet CPU port are prepend=
ed with
> > +       a hardware-defined injection/extraction frame header.
> > +       On injection a 28 byte internal frame header (IFH) is used. On
> > +       extraction a 16 byte prefix is prepended before the internal fr=
ame
> > +       header. This prefix starts with a broadcast MAC, to ease passag=
e
> > +       through the host side RX filter.
>=20
> The sorting in DSA is a bit hit and miss. The Kconfig file is however
> sorted. Please insert before the Lantiq tag driver.
>=20

I will move it before the Lantiq (NET_DSA_TAG_GSWIP) in the next version.

> >  endif
> > diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> > index bf7247759a64..dddcd85c81ce 100644
> > --- a/net/dsa/Makefile
> > +++ b/net/dsa/Makefile
> > @@ -42,6 +42,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) +=3D tag_trailer.o
> >  obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) +=3D tag_vsc73xx_8021q.o
> >  obj-$(CONFIG_NET_DSA_TAG_XRS700X) +=3D tag_xrs700x.o
> >  obj-$(CONFIG_NET_DSA_TAG_YT921X) +=3D tag_yt921x.o
> > +obj-$(CONFIG_NET_DSA_TAG_LAN9645X) +=3D tag_lan9645x.o
>=20
> Also sorted.
>=20
>         Andrew

I will move this before the MTK in the next version.

Thanks,
Emil

