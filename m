Return-Path: <netdev+bounces-182596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B069A8945A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC55C188912E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141B274FEF;
	Tue, 15 Apr 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujKc618B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A032383A5
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700411; cv=none; b=gtbP45FLQj3jwxsRBrbs/eUOHN5tc7IXGnvzHEekx1hOzBe265uEcpvnUzwq7IUIt3K5VsPRcp9mQWbk0NjQpDriufDdEta4L0Ucrdxva5XEHW5wCQnQJ2WojgwK4kgD1fTQJgv/GsgP0FF8Yo/Rt6OW2r+isORxyrfw5k4Sd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700411; c=relaxed/simple;
	bh=1PC46Vdcr0OAu09saI7OHeFXNfj9AflC88OcdjsUm3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJnxRuI30Q38zkV43j5XzctKVV5FTiZQ3dKJ7Lod5XGmD58HHIm5gkdY/9tNNftq1T+1UBZJQ6pYvcTgZMnzGX8ASNp25eqLOlYvF/D+wDqyyw+dzmI2/F9vtDDv2o9ZIhipHxsgJVRICSbcmP3BSk3aWrSUoGSxD6HKE2EQlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujKc618B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BDBC4CEEB;
	Tue, 15 Apr 2025 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744700410;
	bh=1PC46Vdcr0OAu09saI7OHeFXNfj9AflC88OcdjsUm3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujKc618B/ou2TpHkW7e+oQiY27wxFzaiQjx+lwRDensTqOTfq4N7VDbmIMEqKiejR
	 769+lRehSFbFy0y0M9kldrsy4Dg/QTA+9QLxd2x9JHQu/wr5K+I3MfjW2ezrQWkwG3
	 Qm2mMIU7gPKiPo135WIWgKbuBiMg7Z7n3/ZbyXQVXd3qE2akxRtY0Qt37o9TUMoSZk
	 9N61Vl8amMwp/9q+dYB3lddXUmt0vzo97QlraaSQUTTUEA82Qnq5Qk/qX46DKAuY4V
	 Ktw7Q7vDtm6Zc3gw8oBaZBQ9paqos1H9kHOXp0kaQyQZnc1WOavMdxHtsWTyfKaj0n
	 cQBlh2nKmUvBQ==
Date: Tue, 15 Apr 2025 09:00:07 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v3] net: airoha: Add matchall filter offload
 support
Message-ID: <Z_4D9_MHlMvJWAsh@lore-desk>
References: <20250410-airoha-hw-rx-ratelimit-v3-1-5ec2a244925e@kernel.org>
 <20250414172825.028f019f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IzGoBAwR0rgqHKm6"
Content-Disposition: inline
In-Reply-To: <20250414172825.028f019f@kernel.org>


--IzGoBAwR0rgqHKm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 10 Apr 2025 17:25:37 +0200 Lorenzo Bianconi wrote:
> > Introduce tc matchall filter offload support in airoha_eth driver.
> > Matchall hw filter is used to implement hw rate policing via tc action
> > police:
>=20
> Does not apply, probably due to net merge..

ack, I will rebase and repost.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--IzGoBAwR0rgqHKm6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/4D9wAKCRA6cBh0uS2t
rI+VAP0XQCJqirBFPpwt+Ssdi8rQU29HxigMxhCSrFTXOtOFvAEA2EOI0nZRSEtW
an8ErWCayNqv+ZD3UEhdJG1bOhugoQ4=
=6SM4
-----END PGP SIGNATURE-----

--IzGoBAwR0rgqHKm6--

