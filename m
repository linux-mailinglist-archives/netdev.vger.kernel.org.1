Return-Path: <netdev+bounces-71815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3685530A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB151C21A9C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F813A86D;
	Wed, 14 Feb 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULDemqie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F912D768
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938085; cv=none; b=UrtAx27dVUzqTb8lBIZPZ/3dEvFGOLDQRIDCSrnEDlUTLGNM65eRWnixT7Nvi1oxmGYw1Jhye5kxcB6eL9fk7n2puW99QxtGR4RXk07xyDG6NQPBzyHaVrp7T199tWowphV+qd+QNdbEPYUnT8OK5axAMTOKmyCg4M393toKfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938085; c=relaxed/simple;
	bh=gj3Pm5aJ3SFI1wUg9LLe7kGqlr/JW2l2fYlObGxEYxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlpTz/98BAHsE91i0XNnY5Hj7FmNeDE+320T793tvWtPC+IINCqJzecJNHVf/q9L3tVHAfV3LJ1iHpeLnaM6H3iAOKPYbGPjkjrA9dicoqHcEP4xoBjWLJKBFVdz62G4+/vg6j/cnb+vq7QSj9MAwlaK/c+BGYqJN1Qu7SH2+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULDemqie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC738C433C7;
	Wed, 14 Feb 2024 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707938085;
	bh=gj3Pm5aJ3SFI1wUg9LLe7kGqlr/JW2l2fYlObGxEYxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULDemqie1jRNyCb1SwFsE1IyXKHUOD5/dFIGff1Socsza9l5ThImibvWkTYuXfEF8
	 yTPWIcX9zsEUHzl4g/dvWx514V+DSmXo+j36y72LcVLUDq3VskbWQQeae2fDQ+wy5v
	 eu3rp0R31KIY7RkbarGampyEFA9Shab3s0T/RKSQLqZxZ2rYvT7C4oiATHuXfRaWtU
	 lfG1kc3Yn6vdOGN5c7kvK/ws7XtBbMJ/QdjqHZjzwi9Ze7f3xYCSTl2k0yk0UK+7O8
	 5e2jQuceSMlRzz8Qgfac2VUospJMONMD+SYlNLI/hpTrMzztjcb62OGjtk/AS77kCP
	 UJWuYvJPIrwyw==
Date: Wed, 14 Feb 2024 20:14:41 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next] net: page_pool: make page_pool_create inline
Message-ID: <Zc0RIWXBnS1TXOnM@lore-desk>
References: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
 <20240214101450.25ee7e5d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yKxMMVgP6J95zPBA"
Content-Disposition: inline
In-Reply-To: <20240214101450.25ee7e5d@kernel.org>


--yKxMMVgP6J95zPBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 14 Feb 2024 19:01:28 +0100 Lorenzo Bianconi wrote:
> > Make page_pool_create utility routine inline a remove exported symbol.
>=20
> But why? If you add the kdoc back the LoC saved will be 1.

I would remove the symbol exported since it is just a wrapper for
page_pool_create_percpu()

>=20
> >  include/net/page_pool/types.h |  6 +++++-
> >  net/core/page_pool.c          | 10 ----------
> >  2 files changed, 5 insertions(+), 11 deletions(-)
>=20
> No strong opinion, but if you want to do it please put the helper=20
> in helpers.h  Let's keep the static inlines clearly separated.

ack, fine to me. I put it there since we already have some inlines in
page_pool/types.h.

Regards,
Lorenzo

--yKxMMVgP6J95zPBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc0RIQAKCRA6cBh0uS2t
rNfEAP4lFjpRuKfyJis8rw/oTjtQvfMZ7MWy9BMjmNocu1V9RgD7BFEgJdBEz9N4
KvdA4VVh0Ok6u9yv5cl+V+LNvz31lQ8=
=GGrI
-----END PGP SIGNATURE-----

--yKxMMVgP6J95zPBA--

