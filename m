Return-Path: <netdev+bounces-28352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C297F77F27B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760461C212D0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00622FC05;
	Thu, 17 Aug 2023 08:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4822C9C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D813C433C9;
	Thu, 17 Aug 2023 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692262392;
	bh=kEXsWw+/VJM6IN0aDrK9PQ5r8Y/Ps1Rs0C5CdwEVDUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYCaopFbJeZhNGKhUObKp9EccLUIE3fL0oxAuBbW1/veBA+AZGeHi0oJtBjgzn4fl
	 wjBU2+XXL0fHspvSDvQsFOgYbCsjp07/svOcbGTXpYvPznrNA19akUM24BF4dELCN0
	 emB5QxFhiTRz6WHYqe7HfOlSIw2qLkNHGV8kLbtjzXK/ubY/f5UHSpd3uIpkSEzeW0
	 u6qxlWefSXRnoUu0DazxqXLBbGU4519Iuz15gcDTboXVvlbQtLNN/JkNnGCPll6Bba
	 v1DARtt40Cg21MwpFcLyeR/o7ZVDYX6QLCp137Y0cXze1fh/gwLwqZ5val/IqbP9Tg
	 RLy3QWjZP0wNw==
Date: Thu, 17 Aug 2023 09:53:06 +0100
From: Conor Dooley <conor@kernel.org>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230817-wrecking-rely-5c760b7090f9@spud>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-4-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JM/EsoxX1wDbny1U"
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-4-nick.hawkins@hpe.com>


--JM/EsoxX1wDbny1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:52:18PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
> interface for sending and receiving networking data from both of the
> UMACs on the system.
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> ---
>=20
> v3:
>  *Remove MDIO references
>  *Modify description for use-ncsi

Thanks for the description update. This seems good to me, thanks.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--JM/EsoxX1wDbny1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3f8gAKCRB4tDGHoIJi
0kJ+AQDIO38WjzyeoxuE3G1jBNGxfmTLEYg5UNnGFaKfo/3NhwEAl3eF5cI/YmvA
SfNmlmI6AKvpiW4MTLKbwTdm02Uxwg4=
=Pm9W
-----END PGP SIGNATURE-----

--JM/EsoxX1wDbny1U--

