Return-Path: <netdev+bounces-228137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352BBC2A9B
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 22:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93B243475D7
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506F6225762;
	Tue,  7 Oct 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VajO108n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22153218AB4;
	Tue,  7 Oct 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869610; cv=none; b=mH9SYJ/DlwsZXHL0pEGBzmAUmQeC1EjBTUXmdsYp+aIy8FWuyr2OfsiVZmcGZ6CZ/8oe/mzftayk0ZetAhvCFgNAkYZpTp186dtyp0LAU3/KPJg8uO+thEF4xF88KW073zKjMMz9Ytx5DZW7q9GYVR9X0ufQLLjkBEdLd8AH7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869610; c=relaxed/simple;
	bh=WjOlGE690Cju9uez8gCAXio7GQ+uSNWuP+sUwijBUsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhTWI/me7pXBJNAyfLrwPuPQWjbhq/EMcdw1S8rLPu4Zs6SUYEseqHZ8LWv/9PUbl6VnY3vPAx1HZNSmwH91WHDZFitZiVgfHLaXPrOF+7x7FEJRFyExs/HFrS7nb7dXBE52ZhNz2XDcUgR+UzdxUd/weaMWgfldYeSYJ6OJfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VajO108n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8621C4CEFE;
	Tue,  7 Oct 2025 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759869608;
	bh=WjOlGE690Cju9uez8gCAXio7GQ+uSNWuP+sUwijBUsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VajO108nCDRTBoEksmGItunqsCqZy5Mif++sFX3CjQt5cvoQSPN49IDstfKSlgj4K
	 j6JyjHtVPmxDRH03FrfvTOD8hj3vCbROPEr36y/9584idFEZVi41Hnmrlg31PKNtMH
	 7e6wQM+yuDpAmrRw/s7EizcNFsGKodn4e1PmA70VmIo6T7kgx4UdIVUslOk8NvJFVm
	 8oBtoH23DirdYaww93SuTJcHYbZZ6gQYxXYHO/GZZXNxmeCALr+uhJp0aiEoLDKd0Q
	 yVypmteZz4Tb5TF8Sww4sBzslzx1pw8IFfkfSB6/uOm+8ic/IPJwssc/uyjLvO3+vd
	 G6UDegOb51FjA==
Date: Tue, 7 Oct 2025 21:40:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <20251007-stipulate-replace-1be954b0e7d2@spud>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z9ytksPVlhkGPYpP"
Content-Disposition: inline
In-Reply-To: <20251004180351.118779-8-thomas@wismer.xyz>


--Z9ytksPVlhkGPYpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 08:03:53PM +0200, Thomas Wismer wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> Add the TPS23881B I2C power sourcing equipment controller to the list of
> supported devices.

Missing an explanation for why a fallback compatible is not suitable
here. Seems like it is, if the only difference is that the firmware is
not required to be refreshed, provided that loading the non-B firmware
on a B device would not be problematic.

>=20
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> ---
>  Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yam=
l b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> index bb1ee3398655..0b3803f647b7 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - ti,tps23881
> +      - ti,tps23881b
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--Z9ytksPVlhkGPYpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOV6owAKCRB4tDGHoIJi
0oFTAQDWK3RLnS1dd804AcyEPm0D/tSzKkHQ49oSwoC2VwaP/QEA7TJUT3vu7/NY
whEhmbz2E3Fdscuy2U8mlpCMGnk+xQc=
=Oby5
-----END PGP SIGNATURE-----

--Z9ytksPVlhkGPYpP--

