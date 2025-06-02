Return-Path: <netdev+bounces-194633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3D3ACBA79
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2001C3A75A0
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D517B421;
	Mon,  2 Jun 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us3o10N3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D676523A
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886695; cv=none; b=hNvYQ9aTuDjIybAg0HXpdUbhQRi2VTItB5aXNho+9rS4cXgn1xw2FjtZmr4o7x4bKnzVSJtwPaMVEnwTSqa8fWT+7EYKsZoGynX5+eWfO8r1uG05q5vRKHzRKCxjm00pLx5nHEQeCiFmcVGgiHowRKYzyXOdnyRsKWw6rcIoRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886695; c=relaxed/simple;
	bh=cmYfIkVp2GhB7UtadlrV/W7IP6KSNE8PR/uzTHE33Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioyz8tQm4F4otbbgXixnBQe6JzrSRIyhc6WzvnYzdO7tOTTSZTQfqMQACWdh73nO2ixD7E0r6k0mvTU4QzPnQUltu8m5EGQK3eSzXx7fQTLlqVA7d+hPPpRI0287u3xt32gcYzvvDdCdnUATyJER44sjf8xZJjtCZVoLzhXsapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us3o10N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31608C4CEEB;
	Mon,  2 Jun 2025 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748886694;
	bh=cmYfIkVp2GhB7UtadlrV/W7IP6KSNE8PR/uzTHE33Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us3o10N3mDoMbCSp28Uu6+R2M+PcFrjvpFLmU4V48QpzqZuYYFbajcrfvegmAm/6l
	 wFcF9khuS5iPLPQr5JncapQyk1ckfiipwXgBdv4/X77HuXojKwNhmX3rlXRFzDA8SZ
	 hMIMnQd2Op3SqW7p891CXODxkSaQTbzvmOaWlnR+3FZ7qhvitOYYFc6OoBvt2D9THu
	 GrMkpSQw0lffYM7zOI8gzpPqoDQaRQ6E7iQQZx5N0DFIMXNBye7QhiqDuF7ts59Zu8
	 1WS81x8mfihD9QGIQbWgX707kQ0fMHX0OFh4+EWsczyqt29nHmdBq3bysJp5QiCjTt
	 14Ab+/JlhkLmQ==
Date: Mon, 2 Jun 2025 19:51:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: airoha: Initialize PPE UPDMEM source-mac
 table
Message-ID: <aD3kozxODijtDEZi@lore-desk>
References: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
 <20250529-airoha-flowtable-ipv6-fix-v1-1-7c7e53ae0854@kernel.org>
 <20250530180501.GQ1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DvCR9HLpxO5M9dR"
Content-Disposition: inline
In-Reply-To: <20250530180501.GQ1484967@horms.kernel.org>


--+DvCR9HLpxO5M9dR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, May 29, 2025 at 05:52:37PM +0200, Lorenzo Bianconi wrote:
> > UPDMEM source-mac table is a key-value map used to store devices mac
> > addresses according to the port identifier. UPDMEM source mac table is
> > used during IPv6 traffic hw acceleration since PPE entries, for space
> > constraints, do not contain the full source mac address but just the
> > identifier in the UPDMEM source-mac table.
>=20
> Hi Lorenzo,
>=20
> I think it would be nice to also mention a bit more clearly what (broken)
> behaviour this fixes. Likewise for patch 2/2.

Hi Simon,

sure, I will do it in v2.

Regards,
Lorenzo

>=20
> >=20
> > Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...

--+DvCR9HLpxO5M9dR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaD3kowAKCRA6cBh0uS2t
rFEgAQCvb6SYN8dv2ZvK999PTUzFx/PPLSgb3FFdFD8wcLjLDQD/YQkBTN9CF57q
h2ebypsgUx5rdgJ07u1RTYhudd96rAI=
=6fUW
-----END PGP SIGNATURE-----

--+DvCR9HLpxO5M9dR--

