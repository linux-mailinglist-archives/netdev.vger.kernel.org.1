Return-Path: <netdev+bounces-185199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B01A99452
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6669A1CA0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33929A3C5;
	Wed, 23 Apr 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDBB8r5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB0298CCA;
	Wed, 23 Apr 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422451; cv=none; b=k/qFugSvpKX8TKA+/QuzSwqa12wsmC1+K09NVSgNk4BVx5TuEqGJfqaXIy9i1Q/jN7Z5riuWzENtplTwOj8L2DcZ0jAOg+Rc7XuFH085NGqmW8bbeMGvkQH6UKxovOz9RTgOVZhYo8A/fKrgP+vM3zuIqKHAU3y9W8NHoBfdvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422451; c=relaxed/simple;
	bh=4dZGTxOMlI6lJPyNCE7bp/S/ATLVwiABeAvtgl4Aa9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSS8wn2YB5WsZ7cInRG7FzfGUXJBEyz9gwGSVVdfhhgIumsy5U2XtZ5sqkQx1so5aFpEgqWKSm+La7N/AZ8j0ugE8COEW7lEJgF0HyUHSjA0Tg1Iw2vb7VO7bIpuVWqLXyvRhDExzhqH9XjGOfOgi2eohetiJ9roMDgMriYHBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDBB8r5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB4BC4CEE2;
	Wed, 23 Apr 2025 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422450;
	bh=4dZGTxOMlI6lJPyNCE7bp/S/ATLVwiABeAvtgl4Aa9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDBB8r5oF+sDb2+8MYCSJCnPScYtVX77O+SgNvUs2ZnDSlyBjCSuTzkukkrSkCuZi
	 r7NM0ChACP0fsel2Wb2Y1ouQlTxg1UZ8sKkp8zA8irROwWV1TTW4cOEo0Mdc/TxUfV
	 oC8l89DQGR1R5wJCqzYWjP/t2PGvgLu1b/1AaYgQvH5P7NY4/WhMMOJvjrELn4dw+f
	 f0KdxZk0olJeky8MlIeXEaESOPvRlRB32gM5dHQy7URo1Qbm7uOpok5dR+c70C+gzK
	 N84ZbUgLf5JW7uUfoDGqQgd/C/WlbXmdKdpHFlDk0orhqu4YZN5w8GToJXLRSeiMfT
	 EiFx6JmSeKGaw==
Date: Wed, 23 Apr 2025 16:34:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, rafal@milecki.pl,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 5/8] dt-bindings: net: brcm,asp-v2.0: Add
 asp-v3.0
Message-ID: <20250423-opt-entrust-8bee59fa7a1f@spud>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-6-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fU6Vs7wFRNSFVO99"
Content-Disposition: inline
In-Reply-To: <20250422233645.1931036-6-justin.chen@broadcom.com>


--fU6Vs7wFRNSFVO99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 04:36:42PM -0700, Justin Chen wrote:
> Add asp-v3.0 support. v3.0 is a major revision that reduces
> the feature set for cost savings. We have a reduced amount of
> channels and network filters.
>=20
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fU6Vs7wFRNSFVO99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaAkIbQAKCRB4tDGHoIJi
0n3DAQCsXV3h+OYNAdYj64Hv5z5YN9n3SvoK5dONNx863jk8JQD7Br0xBT9IUNfz
NNkAp9Wxz1W6EVCNUet7lhZToExeSQE=
=xNjz
-----END PGP SIGNATURE-----

--fU6Vs7wFRNSFVO99--

