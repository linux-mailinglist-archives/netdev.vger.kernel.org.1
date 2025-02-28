Return-Path: <netdev+bounces-170831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E268A4A25F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BED3A52B0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAB1C5D43;
	Fri, 28 Feb 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwbwhTjW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8281ADC8C;
	Fri, 28 Feb 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769482; cv=none; b=DWduKpwGSEeKwpB2jsW2FkG92Jk719pkvy5pkUNkigNMUtWqAF5aFrFQoz4UKAMXk+EEYQgLxCJaktTgO+9FRG2uR/3IKORsMlxN9ZOkc/vkt6RhI4mjEgGS93PuCB2JhRt7ABE3Er8c71pVA/s/rWTfMvW7LKsZ0+0DnSoExk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769482; c=relaxed/simple;
	bh=iFXFYJac1x/01yzYwzJ7fG3+azm9dT5eKRfdOp1DA6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqqStaevUXzsPH2E3fT6Bsw9cZMs4tGcaUH+IUbEHeomXPfgxOaDH4ewcgeEXr/YF8yMQFXvs8+JjsMHT6OKMa/lcTXsYH1EeBfcrsyCuscOCyz+BxSZcWVY84BA9fB1RN+IWnXKgspQuk9vVUgVGsA75j8IBP2VkOR78TBSHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwbwhTjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18765C4CED6;
	Fri, 28 Feb 2025 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769481;
	bh=iFXFYJac1x/01yzYwzJ7fG3+azm9dT5eKRfdOp1DA6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwbwhTjWsm/rEWnBTsCJipxxwmUD2J8KuLUOGYi+aUpraG2/peo7/zWSvm5cvML68
	 64lfs/0VLYwbXLLqym0E0nRDsrtuSW8UNewpyqQqE2FszcdwWxB4sgLqNfky9WGw29
	 RCBpk9vdQMnAlPYZrxjOLdbW/Ia3d+/dZFStcL2ClIqwaGPKwNibBu9bC4eCSfPBKU
	 7ahQ6elkUneoih0kqjfMqLoCU9n6jurYDR7VJUpOk1C9cYPPdTtrvk/sUprARGj2hx
	 UBTHctqjCg8baiXi68DWjerob+3LMTwlBVswGBjpbvsamKiH8qx5n9eptpaRobqUgX
	 1F8olGDoVjQ3A==
Date: Fri, 28 Feb 2025 19:04:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Wu <david.wu@rock-chips.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: Add support for rk3562 dwmac
Message-ID: <20250228-exciting-utility-29ca9428f121@spud>
References: <20250227110652.2342729-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s6OSw9lCrmZNjA6K"
Content-Disposition: inline
In-Reply-To: <20250227110652.2342729-1-kever.yang@rock-chips.com>


--s6OSw9lCrmZNjA6K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 07:06:50PM +0800, Kever Yang wrote:
> Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
> devices on the rk3562.
> rk3562 only has 4 clocks availabl for gmac module.
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--s6OSw9lCrmZNjA6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IIwwAKCRB4tDGHoIJi
0l7CAQDQfVhiOrJrK6vQiAo9PKlTv9kpqY0pN2q/by1QLSaqJAEAs+3bvp2mwkfQ
MJSUw0vuqY+xCcyhOApXc3xtB4aolgM=
=7KWW
-----END PGP SIGNATURE-----

--s6OSw9lCrmZNjA6K--

