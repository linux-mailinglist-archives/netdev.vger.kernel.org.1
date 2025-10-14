Return-Path: <netdev+bounces-229347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C963BDAE18
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A3C3E5014
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716C275AE4;
	Tue, 14 Oct 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWMSoGUB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C37083C;
	Tue, 14 Oct 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464975; cv=none; b=aUvDGj7vymn+CgdsJFpZim/KTCSl2QSMgkupAe5TFYg8HqPuoIl4XWYTDp4io2C5N0ylk5n8+VfWBup0eqZnHa//6qyORO5PGSEIgPIrbGEBs8JwcG77umXZR0LEKtFdgLjhr4MPrpEicNSV8mkHOGNtsN3QEmhv08YudnrIPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464975; c=relaxed/simple;
	bh=3aJGCCas08m3S7gHD19HqzqscSuOVpUV8AM+dynP93Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHwVCBh4M9OE3n2dZSXHg4TWao60JAmFM0DxIKN5rUooVhmii/x8eUSB6kIT2hY+lSzf1OK8IK1JG3p5AoEWHLsOvxV25P3y83t4HfRWpE+5v2KX9CsXOzU2uQn6ZUQY7O9CNl79IXuPtm9MOvh4fKGl+8X/t8PP5Nt6j0I3Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWMSoGUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D7FC4CEE7;
	Tue, 14 Oct 2025 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760464974;
	bh=3aJGCCas08m3S7gHD19HqzqscSuOVpUV8AM+dynP93Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWMSoGUB1e/WSomPhcYiyYvbLWHEpOmsOHF0giBDglwt5DfNkSpTu2Zh/fghnWBwU
	 Oi+mBZKmgEBxu80YN1PSbImf5zrKW6oalp/WwaIz2dh+cPyE2kX3LwIn++7HJjJtAK
	 rf2R1Zl126Z7wuyAj0+2dlUpGoFpRUXZpvMfiN1dPco4RAwCrEAdl6MjZcwxsgoWNE
	 KT7lDpUuXin7GuO8lZraIIHuQGVnFOGA0AfJbzaAuyEXVS14PSxpVqbPEnUV7TEklQ
	 r8x35HeMJPDH3ByFMlZo8ddwPp68Ou6YuNFPu1dATXIZK2vUwPsQHpQlc2+HL19VWc
	 xM5juQ7DWwKqQ==
Date: Tue, 14 Oct 2025 19:02:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014-flattop-limping-46220a9eda46@spud>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dn3+JVL4O4laIKgw"
Content-Disposition: inline
In-Reply-To: <20251010183418.2179063-1-Frank.Li@nxp.com>


--Dn3+JVL4O4laIKgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote:
> Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): U=
nevaluated properties are not allowed ('clocks' was unexpected)
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Dn3+JVL4O4laIKgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO6QSQAKCRB4tDGHoIJi
0sXUAP9LYKTUydtydHeuxkp9yARH73uLXSVZLOOXNdGjZzAUjgEAout6dmnqQlgt
w6mijUTOOjkghVoJPa0/PMpqZLVnegw=
=fep+
-----END PGP SIGNATURE-----

--Dn3+JVL4O4laIKgw--

