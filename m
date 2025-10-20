Return-Path: <netdev+bounces-230979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E8DBF2B99
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E10F18A6487
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F62BF01D;
	Mon, 20 Oct 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxNlxydD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186B2561AE;
	Mon, 20 Oct 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981553; cv=none; b=BdyFxYIgRzUNSBNeM6+w59buBMmO5ShUSKIrsnewjQcLhR2ADNHeW3W8/Nb4rYgnzGwhoGMaYcIdoOlx14IvRQYOKPzf//UXZy0bqOSL6NHRI8A/giP5FSItnFUiwff/WdTLnZ8f43I5Azq70tlI5HFOzF/lHtjt5J4HGF7Qzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981553; c=relaxed/simple;
	bh=cKso7ybb9iJDanB4qNQL4k5Ww5/ll0Fs6J9dM79RXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdczWlW70drAvm28HLAJV0Dm7PzD9VuFqq9Lc7zVc/lsjzsKLj6ksxjVmiZnfJhE7fkT/tN5ONBN5ipJspYzbti2NAf7TjSgUGs5/PABVEyjwFeg+inaeeRLhDwI+qOvqON0uJnjHUeJVLddnUDqwzWxuDGfUhlpn6QSQxII7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxNlxydD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAD4C4CEF9;
	Mon, 20 Oct 2025 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981550;
	bh=cKso7ybb9iJDanB4qNQL4k5Ww5/ll0Fs6J9dM79RXaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxNlxydD+pAipulVtdKT1k0HzWG2vQdHfDvfTnx0eEVuwCe9TM3CQtoWtN1QqOc0l
	 RI7NLPfQxkgkKfh9EPWTrBq+oWWzFXZzakp2ThpB5MlPb/zorCXg1zKTcGSKhk5cmI
	 a8jlbqQC5rgQmOQ3WyvMW+mElJHzqMEyWP7gZat8dP5U3nc73OBhtBlQ3mCAKLFd70
	 o010CW37VeeUXx5YIT+56I40L4dq+r9LqEGhBjpE2o/+/QO4FVc9cFB0mD4+hzWVRt
	 vO8TTHzf0JMdYIDxejH3QPDCVaYZTm+J0f6+x9lajVz9uGkuiHOuCcVyqiaL5jgRDm
	 s39Aswgovvb6A==
Date: Mon, 20 Oct 2025 18:32:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/13] dt-bindings: net: airoha: Add AN7583
 support
Message-ID: <20251020-vision-outspoken-7083858d278c@spud>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
 <20251017-an7583-eth-support-v3-1-f28319666667@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikE/IhHK61RqCyon"
Content-Disposition: inline
In-Reply-To: <20251017-an7583-eth-support-v3-1-f28319666667@kernel.org>


--ikE/IhHK61RqCyon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:06:10AM +0200, Lorenzo Bianconi wrote:
> Introduce AN7583 ethernet controller support to Airoha EN7581
> device-tree bindings. The main difference between EN7581 and AN7583 is
> the number of reset lines required by the controller (AN7583 does not
> require hsi-mac).
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ikE/IhHK61RqCyon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZyKQAKCRB4tDGHoIJi
0tFvAP9DJl24eno8NxIX9XQVm4OUQPtBYct3ESOFm89Kv/5TiwEAm7Cnd2e3nASD
TVa9KnbLfOIk4PROrVEsjg2j99tMHw0=
=RGLT
-----END PGP SIGNATURE-----

--ikE/IhHK61RqCyon--

