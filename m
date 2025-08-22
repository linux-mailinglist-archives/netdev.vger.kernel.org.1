Return-Path: <netdev+bounces-215934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A6B30FC7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E814B5C6852
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447A2E7166;
	Fri, 22 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOFIAolK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054C2E54AA
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846032; cv=none; b=umaCqm1MVVNDsSzWEpUZ3Z1PbPSx50cdkI2bEpO4ogWQX2XeHJLPf6nb0jwlS9R0p8WqxHhUowua7hFSiUJr0+Kz9ypTqvVjE/vnOPIwaPEU7JBXA5RjuWFa1CLw+b/8XFMg73Yf00WnYXhRSqZvknvpkcZeYa5uiiuab+vSSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846032; c=relaxed/simple;
	bh=QI4S+Cfn/P10Eg8qjEHO9hXbG9rIH/PlkrXcpQyh7Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCLQm/6VuKTianjY2IhtLJ9Tqv4pAc9eCtjAM+UTi0uig+EjfVx27XIfQlbNS5mS+Z41Yo6acLw83nKjM8zcmNQnSb+lZMM3WCbgqQNvkTYabbyEXhdKouqCKPnV6sEcXNpYqlU2WYImkynAOzNg8/CUYLMgDbMLERBx2RoSElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOFIAolK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC610C4CEF4;
	Fri, 22 Aug 2025 07:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755846032;
	bh=QI4S+Cfn/P10Eg8qjEHO9hXbG9rIH/PlkrXcpQyh7Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOFIAolKI2qMkjFwPhLSWCq221EIYCu/mID8GiikO/HQtWo0w4r+24RBu5CBpL0YO
	 X9ept7kI7u4AK2afWQIrHJOI3NUc3mlGfKiO2N1IuJp2zH+1Qp13caqO7qkbjKuOB7
	 86Fkfv1ClEbT0OM+XEUg/Q1mdYApYzcqY5uAfqIcYMBSy6ujasYV1ZoIdoMPok/8pm
	 qUZqwsKzGl8F3mA71LrLwg6T4Tuiu1FUEV+OL9nQkVFReqyyZ/i4HaAecovTors+LI
	 J+ZkT+ZIYz/AHYGsTb71UyFSt5jm8j8hGxKmeEjlkTcDsfo2dbJ7Nz+D9WLMunvNo/
	 1onFQnaa97Iwg==
Date: Fri, 22 Aug 2025 09:00:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: airoha: Add PPE support for RX wlan
 offload
Message-ID: <aKgViYI74bN1y--U@lore-rh-laptop>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
 <20250821183420.45af8077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="onp8zdhmBvKzfJxz"
Content-Disposition: inline
In-Reply-To: <20250821183420.45af8077@kernel.org>


--onp8zdhmBvKzfJxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 19 Aug 2025 14:21:05 +0200 Lorenzo Bianconi wrote:
> > Introduce the missing bits to airoha ppe driver to offload traffic rece=
ived
> > by the MT76 driver (wireless NIC) and forwarded by the Packet Processor
> > Engine (PPE) to the ethernet interface.
>=20
> Doesn't apply :( please rebase

Uhm weird, it applies cleanly on top of net-next to me
(git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git). I will
repost.

Regards,
Lorenzo

--onp8zdhmBvKzfJxz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKgVhgAKCRA6cBh0uS2t
rLaTAP0TqBnNLsXSZso8mTSrP9MFqN8++YyOP4qmvMkUNeHOwgD/eCGuV3E9W5fP
vj5pEBPHqb7A4FhFLjoa2Tl2fauFlgY=
=ig+N
-----END PGP SIGNATURE-----

--onp8zdhmBvKzfJxz--

