Return-Path: <netdev+bounces-22521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BD767E08
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B611C20A78
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6E125B8;
	Sat, 29 Jul 2023 10:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B47C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B231AC433C7;
	Sat, 29 Jul 2023 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690625450;
	bh=0mZQVW2vbt1ay2W0qJ+pcf3lu40KCDjItFHk8MIbO1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFxOR42mKmw8/dz0qTeBEjZyEDoGmoHVyaVBqoCdYvsA0GhjakaME9lKMPHELRSVX
	 E50rWRHyEhCfwTmsdopACbX7x7kyYYDU9h0eA+rZRlk9yaZLn62/SPZ0GbUFgWTDZh
	 lul1D9qBYqREZMuzs3f3MJFpen3bNMAY8VYFcqlumy2hRHYqPLsQovy0ioOuUmzgLZ
	 sAVxbaS1cK+DtWb0GowYiPSdsfeIhwDU67nOKEcjkYnCz6OrYHteQe2kECgPqfMzGi
	 9Q4ha0aSN5KHwhXQlpNWY465kXPf1fUuskgvRFVhoC7ispok4497n0MzvA8B0ahPl9
	 N4itIPqXKigZg==
Date: Sat, 29 Jul 2023 11:10:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mt76: support setting per-band MAC
 address
Message-ID: <20230729-stingy-amiss-74bd459e2c59@spud>
References: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OVpYLz7Xm1cZxqHs"
Content-Disposition: inline
In-Reply-To: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>


--OVpYLz7Xm1cZxqHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 03:50:47AM +0100, Daniel Golle wrote:
> Introduce support for setting individual per-band MAC addresses using
> NVMEM cells by adding a 'bands' object with enumerated child nodes
> representing the 2.4 GHz, 5 GHz and 6 GHz bands.
>=20
> In case it is defined, call of_get_mac_address for the per-band child
> node, otherwise try with of_get_mac_address on the main device node and
> fall back to a random address like it used to be.
>=20
> While at it, add MAC address related properties also for the main node
> and update example to use EEPROM via nvmem-cells instead of deprecated
> mediatek,mtd-eeprom property.

Could you mark that deprecated then please?

> +patternProperties:
> +  '^band@[0-2]+$':
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      address: true
> +      local-mac-address: true
> +      mac-address: true
> +
> +      nvmem-cells:
> +        description: NVMEM cell with the MAC address
> +
> +      nvmem-cell-names:
> +        items:
> +          - const: mac-address

You should not need the items list if you only have one item.

0

--OVpYLz7Xm1cZxqHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMTlpAAKCRB4tDGHoIJi
0vHeAPsH03gK8BH5fVJvQhH6H6InP+CbgNqslVeXnNjQNdJRJAEA/wonPwNJqvjk
KOAfQUkd5f5Yn8fk376EPvQxAbRotgY=
=b6/F
-----END PGP SIGNATURE-----

--OVpYLz7Xm1cZxqHs--

