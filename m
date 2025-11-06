Return-Path: <netdev+bounces-236185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F5C39954
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00833BC512
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B873019D3;
	Thu,  6 Nov 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLSPPLdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50617301709
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417678; cv=none; b=lHaPWn/2p7uE0kv/zxryKl8c8L5qQqa5PV8ZBNz6g7v4lz9RagSo7N/PeGTWEsbRWGlV5/WxwmfB6PJhZ3C4GjXaNzry6nsQkcYyvkdeeagtDQCs0ZrYOzaIlFxDO+pNI8hO0sB7ZjZCYpKiC8UlQRQ81FKfcJZ4R8eBmm5gcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417678; c=relaxed/simple;
	bh=YiVe8+DZyNnQGIgd/hOnfeLOTbD3P2I+OquzuRl7QwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plaFYWZe9sDkcxIBh8roslg4jzCdoK+rdfLakohB8CvhTMvGijffNQ+4csrKj3F6bu0jhZ/KEZ3ERbxW0RjibT/oUEvrn0ufFJDgSFnGKn14qelDqORlKflxOvE23GvkBv3n0G4By4sHsRkO9OubI54KP2LVLZNkr3ufHVwNyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLSPPLdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96500C4CEF7;
	Thu,  6 Nov 2025 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762417677;
	bh=YiVe8+DZyNnQGIgd/hOnfeLOTbD3P2I+OquzuRl7QwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLSPPLdA9asjEPTe1fwBXXZGKkox3d84kem5UMcG234XR8UI4bVi108mUOHkZL4aS
	 41VIDDUiQtfg4HnCJig3ZTWg/VbJeuXc1qFBaqY/Vavti9xqWQC6k4/VdSm31TRRC4
	 pCl2S0+3G0Ol/Ig1Gt+YiHJcN68m6YPnarXA8m5KI2o6oMhmN6ukBSja8mY9dOXAbH
	 9dSlYmF1irKNyRbDUECnTydeTlPcv45zA4HMjpDxyNTZOicglS4joC0alP2J0MJZB2
	 Bt5EXMvFALKkOC7IA39mT2zrQiG7EbG3SP+zxxqdj+JyEyzJTbsyMBoBDzSgS4CM9J
	 PYigpjEx5B6mA==
Date: Thu, 6 Nov 2025 09:27:55 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue struct
Message-ID: <aQxcC7-F6aaFgkxS@lore-desk>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
 <20251104183200.41b4b853@kernel.org>
 <aQsCYoS-cvkUjrMv@lore-desk>
 <20251105162846.53acd791@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1BeUY8BOGFuhrgeF"
Content-Disposition: inline
In-Reply-To: <20251105162846.53acd791@kernel.org>


--1BeUY8BOGFuhrgeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 5 Nov 2025 08:53:06 +0100 Lorenzo Bianconi wrote:
> > > On Mon, 03 Nov 2025 11:27:56 +0100 Lorenzo Bianconi wrote: =20
> > > > Do not allocate memory for rx-only fields for hw tx queues and for =
tx-only
> > > > fields for hw rx queues. =20
> > >=20
> > > Could you share more details (pahole)
> > > Given that napi_struct is in the same struct, 20B is probably not goi=
ng
> > > to make much difference? =20
> >=20
> > I agree the difference is not huge, I added this patch mainly for code
> > readability. If you prefer I can drop the patch, I do not have a strong
> > opinion about it. What do you think?
>=20
> I would not do it but your call.. Perhaps staring at data structures
> in crash dumps w/ drgn made me overly cautions of unnecessary overlap.

ack, fine. I will drop the patch in the next revision.

Regards,
Lorenzo

--1BeUY8BOGFuhrgeF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQxcCwAKCRA6cBh0uS2t
rGr3AQCAdQ7oErdqyjTiSzfI46laBhyyW1FvstOzD4ZU6iWQUQD+ICRVZnM+6FsC
H3cVqWZOZ9iiLGrnByrS9ye/RUcqUgw=
=5zhL
-----END PGP SIGNATURE-----

--1BeUY8BOGFuhrgeF--

