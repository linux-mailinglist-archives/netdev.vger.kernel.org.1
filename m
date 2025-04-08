Return-Path: <netdev+bounces-180436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056ABA8151E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D6C189270D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFC24633C;
	Tue,  8 Apr 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOTOblY+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93849243958
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138353; cv=none; b=F9sOZ5CRQtPTjgCjp18DEr98PYkiGUXEMwet3QqDK6d7x27sDlf4Yu/NWBTLaIJw8E/4c1UcB25Pjda9CZL9RAjCYOB6bauSVtaqGYE/losUDaZIeDfPV8JLw/lcsmublFseQ+bvYYimpW0L1+QM2hZ+swzz9MvZLsbPBvEMQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138353; c=relaxed/simple;
	bh=mu+QLtbier6NMLYJyK3BwUVJp4CUvrmcEmRBDd0mqTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gis8XqlT1NI9x/zWqyLzaa6ZGr6UR15kXkFOal0rCx+fA6UpPA0ChwSLvRGIg0IwbgCyXLnPN4rizvVoxc+35ZCRSufmLrvXWPXrUUhM3rConQXUxf42v9eoZmXEzlnb8NTqnu7nduX+WTwgvqNoWQwW6MhYLS5D/v4OYi4qh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOTOblY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7D2C4CEE9;
	Tue,  8 Apr 2025 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138353;
	bh=mu+QLtbier6NMLYJyK3BwUVJp4CUvrmcEmRBDd0mqTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOTOblY+ZdTcyClr0tGlJuSZQqykvvZQyTFaVP4dUqCRDQa2OjnzVhZijrdnuw44l
	 YfCQ0/VyKQuwLF1JcWogJCgIVOwQDAwCjJmzFUdJZi7rF806Vy4piek8vrrelPeQJK
	 NjTFRujSZUbaue4RrOFUr5nynorD8crW+Jxntnnn+fqpiIZiAna9JhOrf/tSN6BtYv
	 DOh42UOUcGApDjtj1OkzAx0Jj9uoIrFohamjIAM5K8mEy8oWMXyJqNKvVz1HjJ6dcF
	 tVso4l2sRcrDSJhJ3cT1ZK6eT2nRREsRM8n/1tNy9mjyTUUsjCsN4w1fFzEOVX1HAN
	 DQ4uEHNLIXZuw==
Date: Tue, 8 Apr 2025 20:52:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Add L2 hw acceleration for airoha_eth driver
Message-ID: <Z_VwbsjFak7sREYN@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwckOtaj5kVyqye2"
Content-Disposition: inline
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>


--cwckOtaj5kVyqye2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce the capability to offload L2 traffic defining flower rules in
> the PSE/PPE engine available on EN7581 SoC.
> Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
> sharing the same L2 info (with different L3/L4 info) in the L2 subflows
> list of a given L2 PPE entry.
>=20
> ---
> Lorenzo Bianconi (3):
>       net: airoha: Add l2_flows rhashtable
>       net: airoha: Add airoha_ppe_foe_flow_remove_entry_locked()
>       net: airoha: Add L2 hw acceleration support
>=20
>  drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
>  drivers/net/ethernet/airoha/airoha_eth.h |  22 ++-
>  drivers/net/ethernet/airoha/airoha_ppe.c | 224 +++++++++++++++++++++++++=
+-----
>  3 files changed, 215 insertions(+), 33 deletions(-)
> ---
> base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
> change-id: 20250313-airoha-flowtable-l2b-e0b50d4a3215
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

Hi Andrew, David, Eric, Jakub and Paolo,

the series has been marked as 'changed requested' but Michal is fine with
current approach. Am I supposed to repost?

Regards,
Lorenzo

--cwckOtaj5kVyqye2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/VwbgAKCRA6cBh0uS2t
rMh2AP0RiMzPfMojS+LKe/VnGc+9kAPC0dZn8jlHkdT5JydKhQEA+jqP4K893c4F
fPL4pqO2PtARhomxzYl3AumfteZ96gI=
=nFvh
-----END PGP SIGNATURE-----

--cwckOtaj5kVyqye2--

