Return-Path: <netdev+bounces-104632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794890DAA4
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24581F2314F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274F50246;
	Tue, 18 Jun 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dme/cf6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF779FD;
	Tue, 18 Jun 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731857; cv=none; b=OV5z1WvM4vlN7opYZBBT98r/brSiUnnPLmYQ0De4fWJGDpc9U5F54T3j0WkAcmthzrxYlH9zNr/yXJPJ2os098C7h7JgjUviMK1+JlBNgZj+r4ppDd6PKOJSZKiUq77wNYHx2taDPRAS/iacS9zXC/7hk7jqLKiEM4Q89KFss+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731857; c=relaxed/simple;
	bh=+AIDgnkglNABOkM07rYQEuwdoQhiijYiDXrSPBEmNso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxNEyJWRJOuamvQ+eMGrLxHj4v2ETYPFs4AROa0R+vtZlJz0fjDSc4JG9NCeAXennF9egkXdk7iuMBlxRjoHEhD3JycFTDpVup9L2ib/OKx2PZV8CMIXR+Y5ZMaWF9TKdT3TMpQbspf567Vl6FcRgICW2hsw5NT/eeq4bo8VgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dme/cf6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E1C3277B;
	Tue, 18 Jun 2024 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718731856;
	bh=+AIDgnkglNABOkM07rYQEuwdoQhiijYiDXrSPBEmNso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dme/cf6uW4hfXjEHMMUZ5cmBMGTqn+Z29mSxUCF8xexGDNK8ynkK4zxJ07QC4j0GR
	 ApXNUkaUb2ze7qHAEtzXroLEktMM+7yGvn9bLW+uQwGMMyrNjNr5V2vqYDSBzGUqM0
	 cIZUfBiLVDJfwRE+fWOEriXccv3puvg2pWnEbx/Aywgqi46KPlkTLBhojivLV+oe3a
	 GgYCUHMBfEaB72IuIsHHGF/+j+cJ8zoFWcwP0raDSfhfl7uiacMye8OI+7XcDvPx4W
	 PqfqMv0qej6Cq1o2pQ4cI01Foz6h7G6nO5ksKWtMANOEg5plcxbHTo5diFDNPhbefj
	 lcewYiGpvxEhA==
Date: Tue, 18 Jun 2024 18:30:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: net: remove arc_emac.txt
Message-ID: <20240618-speculate-sampling-d7933a1dc858@spud>
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
 <1a45f178-3ed4-49cc-9bb9-c1f9978356bb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QYbO1KTJM7QqsiWe"
Content-Disposition: inline
In-Reply-To: <1a45f178-3ed4-49cc-9bb9-c1f9978356bb@gmail.com>


--QYbO1KTJM7QqsiWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2024 at 06:14:32PM +0200, Johan Jonker wrote:
> The last real user nSIM_700 of the "snps,arc-emac" compatible string in
> a driver was removed in 2019. The use of this string in the combined DT of
> rk3066a/rk3188 as place holder has also been replaced, so
> remove arc_emac.txt

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QYbO1KTJM7QqsiWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHESgAKCRB4tDGHoIJi
0n2FAP0bZj3ydwoGLXHSklzjFjA0G1JZuS2f9Mq5LO+o++9dDwD/Zv8VPx8TNMgY
rQ3xZj/iKj+ScXOPgIQ4AiexcWy9Wws=
=YHdX
-----END PGP SIGNATURE-----

--QYbO1KTJM7QqsiWe--

