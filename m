Return-Path: <netdev+bounces-185197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94600A99349
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE04645EB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C302BE7B2;
	Wed, 23 Apr 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnymkdvU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C1298CB5;
	Wed, 23 Apr 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422434; cv=none; b=XpUqmd4yaecgg2n/gkewpCsQ8FWgBxDBV7Z3u/lcNc/17u6xCDyEZQmeEjxlICVNnIpKt05p+4tuOtxFwHn5JgtTe5NJf+sDTcCj5XmQZv1GxCy2snKQURO+3EsoClPHFen0flhav6rsBxj92RIgVN64qsHsEaSOfu3eB97s5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422434; c=relaxed/simple;
	bh=SApOOL/Qlklw1bTIz393xONrTqlOIWtFjDQ07dFPITU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naYnctaz3C0QqgnVhnj1ALFGWAFwUFrAXistJ3eSk5XhPiNvLVg/Y93x6QK1ln/Rr8b0vVg2NJVB3DwpPkbT8I/hIlLWPbTW2EcQEONkF9jwCTFBEEsQfylTGCHPM4o+WBcADlzR7uO5SlKlHPSBvaV9juRmZKvGdKhdMUWLFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnymkdvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C29FC4CEE3;
	Wed, 23 Apr 2025 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422434;
	bh=SApOOL/Qlklw1bTIz393xONrTqlOIWtFjDQ07dFPITU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnymkdvU/zMxxYr9oRd0A/MC6ffI8uWMVhtvWQjLNbNU6p2mWQWn+SQk25CGD7Cl1
	 9yZxOPVX6agY+IrIwl+L5ehk22YX9vM1dqUYuybPiG0e0bH7KGLvM1THS5JBbxYBXc
	 03MWYDc7gz5afe/hMXMe6lSLgxu9MEXF9T2CSfgA9RSXcIfxSL/XGAZr1gvrsvAvuh
	 RptZGXH1SIcVC+jL5xqxfjxdWBzJhag2FNY8ubIrKY8rPIKlagfW7WrioQVdlsM3Rc
	 RPoZPkA2+Vv5wdhlEFnTpzUDij8mVyZZs6EMJtN8u3gS+9Sin0CGHfhkhjFrAjcuh/
	 uH6pJuLWOoupg==
Date: Wed, 23 Apr 2025 16:33:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, rafal@milecki.pl,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 6/8] dt-bindings: net: brcm,unimac-mdio: Add
 asp-v3.0
Message-ID: <20250423-steadier-prayer-9b0a7ed87249@spud>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-7-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5PPP/BwB1PbFUvis"
Content-Disposition: inline
In-Reply-To: <20250422233645.1931036-7-justin.chen@broadcom.com>


--5PPP/BwB1PbFUvis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 04:36:43PM -0700, Justin Chen wrote:
> The asp-v3.0 Ethernet controller uses a brcm unimac like its
> predecessor.
>=20
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5PPP/BwB1PbFUvis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaAkIXAAKCRB4tDGHoIJi
0rpUAP9RKEHgRR9qtj0mJGDPB8wNXeqHfxy5Oa4EwiHsQxmbcgEAmvBjisfxQjZZ
aWDNjhTVlvw/OoFn4i9z+4rkCvhoUwY=
=uEnq
-----END PGP SIGNATURE-----

--5PPP/BwB1PbFUvis--

