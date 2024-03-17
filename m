Return-Path: <netdev+bounces-80260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11587DDB6
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A90B20C3F
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A81C28F;
	Sun, 17 Mar 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMGvCfT3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA5634;
	Sun, 17 Mar 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687814; cv=none; b=nkwm2qDq8Bf7GGoChT6ziUGYrZBAOY+po6vfQbO+3qujbyGdiEU3boYDTli+g2Oj0cORteVp4hyj74XO2QF4eYLzrVvvxIfxYGD6FiPLj7NPQdUE1RTSvsB6d+k8WqAF9DEta34qnapMDNSHSkErUXqrHp6FNeMMbyO36V5h0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687814; c=relaxed/simple;
	bh=hIzJScsStQ+qJgZV4R5d8h/hjo3IdmTMTwiG5arFAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRStXy/GOq8QvSbwef8MjXj9OPL8GmdtNMolfrrKEkeeSmAbweK2JU22RinElyjBOJQpayVmpruAGIu+o0F9r0sN9E9YUHvt7cFXHXIk9Y4fiej16uju7JPE9BeGHMlcpfmtor9PYlirdrgBaG9mgQuPaSfzTXXwzsyG94WnsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMGvCfT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ED2C433F1;
	Sun, 17 Mar 2024 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687813;
	bh=hIzJScsStQ+qJgZV4R5d8h/hjo3IdmTMTwiG5arFAf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMGvCfT3uMv96iUBmejFXTRPsELK29trzxNOdfB5GD8T67Mb1qwnf3fxHOwAMs9kP
	 M59q9OJWDbBNtDnJD4zFDGRxIHT/GoYsR+6FoPzbsB1JTpvMHHhXJPcQZOS5msdseD
	 sl3Y49++8QOqFvhqetf7EuodPKUufgurthfBxqw78BIs30qCPwhth08E0VMgX3nFgd
	 iVz/OQKPmxxyrUku8SwI7FeUKIbXm0fuwbiHvNTW12tOwb2DD9sMh+Y2IUJMt9DWsk
	 27XWKycLSLreLb3GlKhj0+rKCTYDCoUct4+lrLeZaPOg4CoS/KXsNNQS7R2o5f/jcO
	 OPEiuLWK6u8XA==
Date: Sun, 17 Mar 2024 15:03:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-bluetooth@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW43439
 DT binding
Message-ID: <20240317-spotter-imminent-1a29a152648b@spud>
References: <20240309031609.270308-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S9kGg1ZUWkfhKrRo"
Content-Disposition: inline
In-Reply-To: <20240309031609.270308-1-marex@denx.de>


--S9kGg1ZUWkfhKrRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2024 at 04:15:12AM +0100, Marek Vasut wrote:
> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
> This chip is present e.g. on muRata 1YN module. Extend the
> binding with its DT compatible.

How come there's no fallback here? Looking at the binding patch there's
no device-specific handling done, what's incompatibly different between
this device and some of the other ones supported by the hci_bcm driver?

>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yam=
l b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> index cc70b00c6ce57..670bff0078ed7 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> @@ -27,6 +27,7 @@ properties:
>        - brcm,bcm4335a0
>        - brcm,bcm4349-bt
>        - cypress,cyw4373a0-bt
> +      - infineon,cyw43439-bt
>        - infineon,cyw55572-bt
> =20
>    shutdown-gpios:
> --=20
> 2.43.0
>=20

--S9kGg1ZUWkfhKrRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcGQAAKCRB4tDGHoIJi
0j+LAQCS1wtlfo5rzqLE7nDIU4mQ0wG38sXHJHmisXx4EXiNaAD/TSPL/iLN22d9
ZrLgiLyNz4mxN0entxh7hbzgniN4sgc=
=T/ZU
-----END PGP SIGNATURE-----

--S9kGg1ZUWkfhKrRo--

