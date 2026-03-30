Return-Path: <netdev+bounces-273091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLYND7EwymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163E356F41
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6E13009B0A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF013AC0FE;
	Mon, 30 Mar 2026 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocr8hkDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFC3A874F;
	Mon, 30 Mar 2026 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858069; cv=none; b=S8HvH3D4nD5V7dMfydkb5MMNUC5oHN79iqLZTClFhN1J3ts9fmN/VPnE+idZqCI2pEic3DF9/rC55EW3xcz+LF7VMTxIUzc6EEsqugcE5/FfsXIPaWhf4M2bVLfO2P5HMqYTAh3lv0GW/BhYyGuwkgFdAGkUfZ7A73OWjbF1EoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858069; c=relaxed/simple;
	bh=YhNcAxwi7k4UThTvxQ3mLuHi5PSHDChCgtFuITbLbxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvPt4KBn9f6Q5ey6eRJ2R6lLRGd5f2we03XIoOhBFi+RnMX/P9BRNBLDeYhMpXLh57O8TS8fmRGwLEP8KJs1iRvF7cviB10w93TM9EPmo+S604wYnQXMdnQrS/LoDO5D7hkcaiFck/FZbVevRvuUc7miykzWw1uLLmNUkKTyf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocr8hkDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875BCC4CEF7;
	Mon, 30 Mar 2026 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774858069;
	bh=YhNcAxwi7k4UThTvxQ3mLuHi5PSHDChCgtFuITbLbxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocr8hkDAXhQiBAHS4RwFz7yPOX50Khybw4gy4m2Tvv6g54XAgLfTroOxeOOUAagmK
	 KuGvlMRF5zgVqt5c8jPuXNaTG+9Mmoz/lZ+YgWlIrJGLK4ENxAGo/V1tgwAyDh4jBZ
	 3d/SN8TWYdM5qOUqpF/ojAf8qwsiTT7Uub2IK0PzsV0+iQBLF4NefjfN3mk4wC9lUw
	 sphCkssq4RwBuOqfkwlB4fA704W/eMm5C2JxpKieDIF4I40Y+ymJYQ/ZxtIoVabL+2
	 enWEde+7ek9RyhJeW9wVMpKG3d1DJg5gRI1b1CLvoD1fwvgme1QNfhmweHLz7jqjby
	 9GoYF9e0vDhHg==
Date: Mon, 30 Mar 2026 10:07:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 00/10] net: airoha: Support multiple net_devices
 connected to the same GDM port
Message-ID: <acovUgndujK08H-4@lore-desk>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
 <a64e0f7e-7073-4355-a3de-e8d93e2c795c@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FhnmY9eF5tpPTJI"
Content-Disposition: inline
In-Reply-To: <a64e0f7e-7073-4355-a3de-e8d93e2c795c@genexis.eu>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9163E356F41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2FhnmY9eF5tpPTJI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi.

Hi Ben,

>=20
> On 29/03/2026 15:07, Lorenzo Bianconi wrote:
> > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw multiplexer that
> > manages the traffic in a TDM manner.
>=20
> I think the word for this is arbiter. I think the common use of mux is as=
 a
> more fixed data path selector.


ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > As a result multiple net_devices can
> > connect to the same GDM{3,4} port and there is a theoretical "1:n"
> > relation between GDM ports and net_devices.
> >
> >             =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
> >             =E2=94=82                                 =E2=94=82    =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >             =E2=94=82                         P1 GDM1 =E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BAMT7530=E2=94=82
> >             =E2=94=82                                 =E2=94=82    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >             =E2=94=82                                 =E2=94=82      ET=
H0 (DSA conduit)
> >             =E2=94=82                                 =E2=94=82
> >             =E2=94=82              PSE/FE             =E2=94=82
> >             =E2=94=82                                 =E2=94=82
> >             =E2=94=82                                 =E2=94=82
> >             =E2=94=82                                 =E2=94=82    =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >             =E2=94=82                         P0 CDM1 =E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BAQDMA0=E2=94=82
> >             =E2=94=82  P4                     P9 GDM4 =E2=94=82    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >             =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
> >                =E2=94=82                         =E2=94=82
> >             =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=90                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >             =E2=94=82 PPE =E2=94=82                 =E2=94=82   MUX   =
=E2=94=82
> >             =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98                 =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98
> >                                       =E2=94=82     =E2=94=82
> >                                    =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=
=E2=94=80=E2=94=80=E2=94=90=E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90
> >                                    =E2=94=82 ETH =E2=94=82=E2=94=82 USB=
 =E2=94=82
> >                                    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98
> >                                     ETH1   ETH2
>=20
> A more representative picture is like the following and in the GDM2 path
> there is a real mux present(not relevant for this patch series though). T=
hus
> I think it is important to have the distinction between mux and arbiter.
> (Feel free to reuse the following illustration freely).
>=20
>                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
>                 =E2=94=82                                 =E2=94=82    =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82                         P1 GDM1 =
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BAMT7530=E2=94=82
>    =E2=94=82   MUX   =E2=94=9C=E2=94=80=E2=94=80=E2=94=82 P2 GDM2        =
                 =E2=94=82    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98
>    =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=98  =E2=94=82                                 =
=E2=94=82      ETH0 (DSA conduit)
>      =E2=94=82     =E2=94=82    =E2=94=82                                =
 =E2=94=82
>   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=90=E2=94=
=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=90=E2=94=82         =
     PSE/FE             =E2=94=82
>   =E2=94=82 PON =E2=94=82=E2=94=82 PON =E2=94=82=E2=94=82                =
                 =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=82         =
                        =E2=94=82
>    ETH5   XPON  =E2=94=82                                 =E2=94=82    =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                 =E2=94=82                         P0 CDM1 =E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BAQDMA0=E2=94=82
>                 =E2=94=82  P4      P3 GDM3        P9 GDM4 =E2=94=82    =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                 =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
>                    =E2=94=82          =E2=94=82              =E2=94=82
>                 =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                 =E2=94=82 PPE =E2=94=82  =E2=94=82   ARB   =E2=94=82    =
=E2=94=82   ARB   =E2=94=82
>                 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98  =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=AC=E2=94=80=E2=94=98    =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98
>                            =E2=94=82     =E2=94=82        =E2=94=82     =
=E2=94=82
>                         =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=
=94=80=E2=94=90=E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=90=E2=94=
=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                         =E2=94=82PCIE0=E2=94=82=E2=94=82PCIE1=E2=94=82 =
=E2=94=82 ETH =E2=94=82=E2=94=82 USB =E2=94=82
>                         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                           ETH3   ETH4    ETH1   ETH2
>=20
> MvH
> Benjamin Larsson

--2FhnmY9eF5tpPTJI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCacovUgAKCRA6cBh0uS2t
rIc2AP4wwRA1B4MtxFvfeaVVQ3m/NwmSTe6UHrO8PddiwUqlPgEAt83FeDeOn8S4
2P1sF5r1gm8DzYCyZnJKsEyMVQAGBgo=
=4iqG
-----END PGP SIGNATURE-----

--2FhnmY9eF5tpPTJI--

