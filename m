Return-Path: <netdev+bounces-192386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45005ABFAB2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2F188FD71
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6031DF75C;
	Wed, 21 May 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwFl0xCR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6791A257D;
	Wed, 21 May 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842676; cv=none; b=dfsguclUaxJHsGZoAoVXP42vOztgdpS1BE7pkg7ao/EvrwdQWT9Wkj64nyJ4rojen27yRIgKLOglADiBY88tTdPKT1d02Lx+YMxKvO518di2/Mw5M5Ahsr3IS9Oark6urmPidQxnlPSmLR+u0VXE3hHUP5Q0QCMYWgjA1gUKiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842676; c=relaxed/simple;
	bh=CRXCr3Uh0WGqe0ESiF0panNk2y+kY7VENjp5cg4gP4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSMmA02EU9hQcdX/0O2OHqvFoCHl7OOkzmoZDlclOzLD/zbAig4fsCWv4EIARlSgHS+ejeyvaeMOL48vA5SLLbKWGKeMkp54XBxQSRaFHPMlOVkVNuTdZYW8VTlAeLMwdmDJCJPVAiVTrpgaXBi8esQxSWIXx2nUY+WVDP39bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwFl0xCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA8C4CEE4;
	Wed, 21 May 2025 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747842674;
	bh=CRXCr3Uh0WGqe0ESiF0panNk2y+kY7VENjp5cg4gP4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwFl0xCRRLwp400F5dLYDjwJ+pqmtK7xX0OYpjGEmOGfMFjQpssfmAD1ZqG5KAnHk
	 x7M7uJxvrojw8em6NUUynuEM7zvFHbWDBqbhPEKG3B9SW4D5KlQuBxOzGvVQ+3ggpn
	 Fvq+44Jct/cBYWcGV9VogKMCVXvoClVDGK5rzZUY19zvuxPFoVgsZwVZBkODYoC8mp
	 K7AnU/6aYPxCHs5RsRogeDO2x/T7+aB2GYu1aAHm46Iv7zAZc634fwtAVaay+c5boN
	 IEudIM0MuEi/lZ/JXXxH8I6qHwJjs4eSxUA7sAqI1+rK8Xf81BS+LcCTOeTbCWRQpM
	 Ec/wr7XC8BBqg==
Date: Wed, 21 May 2025 16:51:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: airoha: Add EN7581
 memory-region property
Message-ID: <20250521-tinwork-numeric-35f98627d3d2@spud>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
 <20250521-airopha-desc-sram-v3-1-a6e9b085b4f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wjvgKzIIZLrkHJfJ"
Content-Disposition: inline
In-Reply-To: <20250521-airopha-desc-sram-v3-1-a6e9b085b4f0@kernel.org>


--wjvgKzIIZLrkHJfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 09:16:36AM +0200, Lorenzo Bianconi wrote:
> Introduce memory-region and memory-region-names properties for the
> ethernet node available on EN7581 SoC in order to reserve system memory
> for hw forwarding buffers queue used by the QDMA modules.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--wjvgKzIIZLrkHJfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaC32bQAKCRB4tDGHoIJi
0jfDAQDU0/mGf2mXREMZJiO9Z2iGK1V1+C+Zk9qaLvyd/7jKJAD/bl9C4D9zQtX4
K3gqNtnGI+N3oAYNQE/13WP9DV/89gM=
=3S3F
-----END PGP SIGNATURE-----

--wjvgKzIIZLrkHJfJ--

