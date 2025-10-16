Return-Path: <netdev+bounces-229937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE12BE23A3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D34F8C90
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086530BB8B;
	Thu, 16 Oct 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEpdiWMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBA30B530;
	Thu, 16 Oct 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604663; cv=none; b=tcTm8mHjqxRAxQRoLDTfSLKl1awCeJXR6wVHW9oLgYvhCv1FKVmCdBtlBncXaCnBKI0C+GGd62zsDm7tEmM0oBpTJgQDnn0rAAM01eEeEt6KBmFTPVOp2rzqhh0kRkPYlkJk2UJUJ9oeHKEy7XYfVxEXlh4feamv2G/khsuu9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604663; c=relaxed/simple;
	bh=koW1mtyWEV/9nGXq0ft96CzBEM4wcxSxPZ7e/TfT/EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8HpdYkYcnQX6GOegESaxLNf+yAb7H2Ea5qXLf1PoYDpY1Lx6VDuWXy7KEkhieYcDA7CxO5fPXWB0GvWGosaeMvAmQ+nzeH91xyQL4cerjXYTymWHtOs5O7CE1E7yk6nh3qW9+T9PPorUISRvaWi3wXg+aJeZOVY3POEHUeySgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEpdiWMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D8EC116B1;
	Thu, 16 Oct 2025 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760604663;
	bh=koW1mtyWEV/9nGXq0ft96CzBEM4wcxSxPZ7e/TfT/EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEpdiWMqRmp2xMTf47ahEHRYc/qm/JhOfrqZWWkQDLeH+jWySKsWrUtIpnjjldzQR
	 C2Wb7EqNcPxRXQGryLLOgwVy/05DYboRnewGfthosAddKV6MrYwVBCSLcdgQxF1ME8
	 gxtVHsUJI3E+pv+TkHnU/5w/XWDJ9tQngKggz2FmjM0IJTd2dKYlzFIStvZhmqK5YO
	 gNpqFmXs5JfcEIhmUBuvOl0B65Ag11rL4pkdS5Jn9gn+TrlTida6kBH2sCFFqVQUlR
	 d/tuSbjKC5Q6rn7UQxPPqjVtK55dMb9x3HKA8qQLhr+cRnSWAsB+vqaoYDy2+lAHdG
	 8yJ+aCPBlA/Tg==
Date: Thu, 16 Oct 2025 10:51:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: airoha: Select default ppe cpu port
 in airoha_dev_init()
Message-ID: <aPCx9dvYfxRoc1VB@lore-desk>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-10-064855f05923@kernel.org>
 <aO_Dwn9r_32-U72N@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7ChpTZEVr/Bj1tf"
Content-Disposition: inline
In-Reply-To: <aO_Dwn9r_32-U72N@horms.kernel.org>


--h7ChpTZEVr/Bj1tf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 15, Simon Horman wrote:
> On Wed, Oct 15, 2025 at 09:15:10AM +0200, Lorenzo Bianconi wrote:
> > Select PPE default cpu port in airoha_dev_init routine.
> > For PPE2 always use secondary cpu port. For PPE1 select cpu port
> > according to the running QDMA.
>=20
> Hi Lorenzo,
>=20
> I think this could benefit from a few words around 'why?'.

Hi Simon,

ack. I will do it in v2.

Regards,
Lorenzo

>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...

--h7ChpTZEVr/Bj1tf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPCx9QAKCRA6cBh0uS2t
rDjbAQCyZUZ+AGx+0t5mlhcr/wn0mB+6DKuep4ewNRmoYnyr/gD+K6LdpaOBgRPi
Rp32H0CGkNzsfZVTiKA5T12MoC7Vrwo=
=4yyA
-----END PGP SIGNATURE-----

--h7ChpTZEVr/Bj1tf--

