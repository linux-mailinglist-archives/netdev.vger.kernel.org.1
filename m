Return-Path: <netdev+bounces-117217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1594D22A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D6A2819FC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0E196DA4;
	Fri,  9 Aug 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfghTdRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886ED196C86;
	Fri,  9 Aug 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213665; cv=none; b=m0p+MBQMekmqm7uB/W9JBxtG9MMhtzMMf4LruuDhEpTqD62/LEqgqZMP7ppuFZ05Rbp0VlejvEALtL/PAB64OeaXtMAarMr6W/NhVw6xtTSoquTGUb6yXSqaqw2nbGS3H8cVrmKIHGMCYIX3ZFdjDlQypmB55PUKh5/MDAG41kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213665; c=relaxed/simple;
	bh=1sezwIwh7kKFBKweTgaKaEhSJ1YJX9Lv4186ymCppII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj55mJO3G9+4kMqWoAz9GoYvkZ3QC/L3NDMt2K6U1METHmHZc9bOVmv+g+7bhydCFY4963KmLJT8tLGhU5ms6+itSgRuIqZ+pc/4Yraz+oxiWZTSMbaWbTFU9nKVkGvuutUsb1DlRMS+thu1ALUTHShtcg77NhqPM2Gf0f7eJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfghTdRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA63C4AF0B;
	Fri,  9 Aug 2024 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213665;
	bh=1sezwIwh7kKFBKweTgaKaEhSJ1YJX9Lv4186ymCppII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfghTdRzqqGgn6XPsRfg1+xnC32+hKgGbwqWcDb8ZuPKKG+MbKBWIzT0dDIx0Rr3S
	 cY5JHMlYtFaidd53Yu1P422QYVTq7kjpRqCVVmGL8KHZHJ5CFZHpvcrJ/wJfE7lYUB
	 +SP7tx4UzPTzSxYteXJ6PE+i62abc/PIi1bBblSEjMJkAP0WgrbK64vPcnt/n1ST20
	 OAAcEVz8Bs78ccg1gQSEl2eInK43HFZe+BSZM5PdT9Tn1gP4qqqk3a+Tcbkqf1UAEU
	 XdJy2VMvdyGdzJMmaW4HZxNf26tk8Eps0/yIGodyiiBS/HjT+SFGqFD+itajYz9aHw
	 YIcaGiJObUW0A==
Date: Fri, 9 Aug 2024 15:27:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <20240809-bunt-undercook-3bb1b5da084f@spud>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <20240809094804.391441-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7FsjSU6MVBrt+SNB"
Content-Disposition: inline
In-Reply-To: <20240809094804.391441-2-francesco@dolcini.it>


--7FsjSU6MVBrt+SNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 11:48:02AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add fsl,pps-channel property to specify to which timer instance the PPS
> channel is connected to.

In the driver patch you say "depending on the soc ... might be routed to
different timer instances", why is a soc-specific compatible
insufficient to determine which timer instance is in use?
I think I know what you mean, but I'm not 100%.

That said, the explanation in the driver patch is better than the one
here, so a commit message improvement is required.

Cheers,
Conor.

>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v3: added net-next subject prefix
> v2: no changes
> ---
>  Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documen=
tation/devicetree/bindings/net/fsl,fec.yaml
> index 5536c06139ca..24e863fdbdab 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -183,6 +183,13 @@ properties:
>      description:
>        Register bits of stop mode control, the format is <&gpr req_gpr re=
q_bit>.
> =20
> +  fsl,pps-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description:
> +      Specifies to which timer instance the PPS signal is routed.
> +    enum: [0, 1, 2, 3]
> +
>    mdio:
>      $ref: mdio.yaml#
>      unevaluatedProperties: false
> --=20
> 2.39.2
>=20

--7FsjSU6MVBrt+SNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYnWwAKCRB4tDGHoIJi
0o7nAQCoG8xRR0Q1yI7Vxm3adWd7/zneP67fwwbXJl3gQ9x+EgEA7ng0ZXOEU3QM
ygVk7mmPAEkedodM08yXueYthxfVuQs=
=aUPU
-----END PGP SIGNATURE-----

--7FsjSU6MVBrt+SNB--

