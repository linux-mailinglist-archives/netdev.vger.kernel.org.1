Return-Path: <netdev+bounces-198911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F721ADE4A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8867177E9B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424527E07D;
	Wed, 18 Jun 2025 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmGbiLy3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC972F533D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232352; cv=none; b=fV2oc8eIMTCUR2+krs8Ljn8EPTN7CaIKdtPq2RDmuIjqmFp2wEDGrrboL7FNISLgtgw1jins9oy/7c+JY9WlDs4JjhxI8TiF9PZoMSXnEcTV5N20XAi92YE4a9mVFvymNtZJwABfD21z+yhtH/RJjQstZiyrwJen/k1pvsH4D90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232352; c=relaxed/simple;
	bh=BXfpVsjWF0Y78+XsAp5AT1RaqbCb/hX1z9JCJ/YUswA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaUgZT0wsQMGbMKfMjcfYUwxDJp2H7/1x99lZJ6Pp6yIqqRTNsp2BQwJ2hoVbj9ug4z/wNe6toSGk8A5NxdJutmJJAepyuzFRvaLC8LVGl9q1zcWQ8ZbrTGJR919sEozMj7TknGl5ocvPe2YbO33WnY1FpbQKj0zVryESBL/P6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmGbiLy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C502C4CEE7;
	Wed, 18 Jun 2025 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232351;
	bh=BXfpVsjWF0Y78+XsAp5AT1RaqbCb/hX1z9JCJ/YUswA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmGbiLy3WreaKTciX0axCUsGg49kV6/sc/gGCErHdNBCr99cH1GrPnVnlkJOm3+9q
	 BundZ2J83ddUDvMbMMGvzpQNdCmzuFG+XHKPDvjdS6t3KKfkA70OxFqhYgjxdZG+bu
	 fu6yO9HZFnBHZEoi4R813zfAebXLbBe47i/az/jhEOp4BB6kFk6y+NL+i8TFRqvMJa
	 I4TpX416cZrCLTYFJhY4jIU69QiI74Cejg3LIujQV8p1xJooyiQvw6hM30KbuWen2D
	 7uvL2iXHoW0ux/Q/kauhuhxLIG85Fgi2/zjsrpubX3GwrP5a0S6jz8ueLfMsmYWVJL
	 /uySsCko3bqgw==
Date: Wed, 18 Jun 2025 09:39:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
Message-ID: <aFJtHUmhoqjJUN9T@lore-desk>
References: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>
 <20250617153131.56a783c4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uo43+w1z7RWJd+56"
Content-Disposition: inline
In-Reply-To: <20250617153131.56a783c4@kernel.org>


--uo43+w1z7RWJd+56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 16 Jun 2025 12:27:06 +0200 Lorenzo Bianconi wrote:
> > Subject: [PATCH net-next] net: airoha: Always check return value from a=
iroha_ppe_foe_get_entry()
> >=20
> > airoha_ppe_foe_get_entry routine can return NULL, so check the returned
> > pointer is not NULL in airoha_ppe_foe_flow_l2_entry_update()
> >=20
> > Fixes: b81e0f2b58be3 ("net: airoha: Add FLOW_CLS_STATS callback support=
")
>=20
> Looks like the commit under fixes is in net, is the tree in the subject
> wrong?

ack, fine. I will post v2 targeting net tree.

Regards,
Lorenzo

--uo43+w1z7RWJd+56
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFJtHQAKCRA6cBh0uS2t
rCKsAQCEFmeCcYEX24UTb6vH2FZr1eqY6402wluHC5kMW0VdqQD+OI0UDARUoXKC
xgnAAwGTKjYg1NfFKAcFPp9nkKkWYAA=
=Awjz
-----END PGP SIGNATURE-----

--uo43+w1z7RWJd+56--

