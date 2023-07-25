Return-Path: <netdev+bounces-21009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAC762249
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B9F281391
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76080263D8;
	Tue, 25 Jul 2023 19:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86E1D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C09EC433C7;
	Tue, 25 Jul 2023 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690313456;
	bh=cSoVzaXL/Fs6an9grHNYTptMHglao78l58IxAdtohxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z49gSj/rgKrKHNHcyT8AXzy91LhjCBNazZP3ccVSQWYcYsCRyBjM95CjWyI7QSImR
	 SJvbWYGC2kVybNd4Rjtnu3ETf7wX4hdI5aoHz49GnoEKwKncQJhp203nIIbrjpXO9l
	 W+RaTaG7zTPh5YAcA9nZOz/UqzXXIzOUDoUDacM1UmcU499q4LxY9QQP5xYCNrKCK5
	 w4/FKaP1Bqi6AB2iB0rZAB08I33uaLdp8i6ASsDxIjDhlNklVXftRcbfV3w7A2BWY4
	 GCILZP2CnhdRu87A9CIC0HvsHCRvppQ6WOLvs2loEiSIfRFLLNj3NpdUgVovBVfDC4
	 amjI4bdkFDFZQ==
Date: Tue, 25 Jul 2023 20:30:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
 defaults in schema
Message-ID: <20230725-sulphuric-syndrome-3eaace57ef43@spud>
References: <20230725155254.664361-1-eugen.hristev@collabora.com>
 <20230725161156.22uscijrot7gbnvj@mercury.elektranox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hNlqjw351EVDd4gT"
Content-Disposition: inline
In-Reply-To: <20230725161156.22uscijrot7gbnvj@mercury.elektranox.org>


--hNlqjw351EVDd4gT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:11:56PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jul 25, 2023 at 06:52:54PM +0300, Eugen Hristev wrote:
> > The defaults are specified in the description instead of being specified
> > in the schema.
> > Fix it by adding the default value in the `default` field.
> >=20
> > Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-=
schema")
> > Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> > ---
>=20
> Maybe also fix the allowed range while at it? I.e.
>=20
> minimum: 0x00
> maximum: 0x7F

Beat me to it! Please do.

--hNlqjw351EVDd4gT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAi6wAKCRB4tDGHoIJi
0vL5AQD8BuidIynoyj33cY6xqSwkDbogVJO15KjdNiTQNkRSVQEA74iQMUfeoN34
jQtR5vFXPxgj7VEzcVIMqN35ErvrCQI=
=ORDo
-----END PGP SIGNATURE-----

--hNlqjw351EVDd4gT--

