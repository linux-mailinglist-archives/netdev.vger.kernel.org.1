Return-Path: <netdev+bounces-145036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649B9C92BF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8056AB2850B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C21AB52F;
	Thu, 14 Nov 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfWrtwKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FA1A76B7;
	Thu, 14 Nov 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614311; cv=none; b=dXP28w+YbUB+vdV+TVukDhhLA/C1y6JUPJmPyE/3CdZDj3eNBQ2EbobFMn+VMJpB5pJDFhtWcQ9ZdxYZcrdL4VYGucjN8Nu5RmLcAr/DMkmr/olNoFs/p6Wk0ZrndtMXMdfDQDfGebjmBDY77f907wPejttIx1A6D2HJHUvID/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614311; c=relaxed/simple;
	bh=UzbM5KLQvcqoKIF3HGt17WHqeyA6Dsuz8nVCqb6Xmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNHO7RVMi8quSbkB7w2N/RNIu4TfhbQ7kRFAbJReBiLDV6itigDm/TEz4Tj3uMVoDcGa24cvg+BfaaKGp+GDM1od486Gge4NJHlO7oK9xri7keusAS067jwK5T2qg7SPCA2nVJhCxfQvyanlu47Ug0cQ7FfOkyzGHfl1GfaHgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfWrtwKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00ECC4CECD;
	Thu, 14 Nov 2024 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614310;
	bh=UzbM5KLQvcqoKIF3HGt17WHqeyA6Dsuz8nVCqb6Xmxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfWrtwKhqNeoWPpeHsPXl9N3n/9k8ev61vZUE7M53EjM4bNqM3sqTwFHnNPD82TIh
	 zbjN0h32hV2DOL1/aqaUJmnexZn+b5nOZpyMG7dOJasdDoI2ya9xp1eK0kMgxqGoAR
	 MX0QZmSyrB+fJ/3qPY+hN4Aul/xUwlOAmYeKdZLQvN0hwDIasxTnJvQOZ9YqaOecNQ
	 CH55NLtsUHJKP1/hxNQxNWiTAaYiExiUCNGvcfbyMsNWJBz6QQPmC/MjUS+f7D2HpO
	 j+k2gHm5GZW+zwvTfCpD87peqVfkl3s5o9IV1aVdngD4AjBrwz+dHMLRrPG416Xspf
	 ukD2KaJSGpf1g==
Date: Thu, 14 Nov 2024 19:58:25 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Drop
 undocumented "id"
Message-ID: <20241114-closable-send-e436703b84f1@spud>
References: <20241113225642.1783485-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VelJ3la0mL5zv151"
Content-Disposition: inline
In-Reply-To: <20241113225642.1783485-2-robh@kernel.org>


--VelJ3la0mL5zv151
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:56:43PM -0600, Rob Herring (Arm) wrote:
> "id" is not a documented property, so drop it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--VelJ3la0mL5zv151
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZWYQAKCRB4tDGHoIJi
0kDJAP9No95gjNAUzywaEK2oNa/U9zzCbWF5QBPhe4p4MtLlEgEA5oZ/gnHZk6bE
QKHnwp+J4Ym7vrGXZTVP0OEORfnRTAo=
=JFEJ
-----END PGP SIGNATURE-----

--VelJ3la0mL5zv151--

