Return-Path: <netdev+bounces-261345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IE0BBpHoGkuhwQAu9opvQ
	(envelope-from <netdev+bounces-261345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:14:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F781A630E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED6330A7558
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22B311963;
	Thu, 26 Feb 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFE78K9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA32DECBF;
	Thu, 26 Feb 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111450; cv=none; b=FvnGwj0S8Pbi+SbGQQq5PgI/762M2TJoXzh19M7T/pGo/lhL/jrrGugvTRHMlSuUuX1uZljQenriwueAtGABxZ9uBlIk4HVYiUsKKZ6C+fMhbxHujk1WiSPRtOV1z2ToXYjYJMO0Q9Z/2sfI8lEFdtEalkLuYlfURTdJIkl//VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111450; c=relaxed/simple;
	bh=C4eMAFRdacQNFuE024DtfsctH+er00ixJMhwD+JseHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uQsP7btT4UKp9u6E6maAhJrxxzDLi9Myz/SqwQ8lQIKz5HlyDvyXjygNw4AuaWtpl88kGFJiQChb0D52a8lPL4O7YpP7Udn7kv+4XGGITQuXjeq/t6EzoN6w8RFEIIqs2X5CneQtiP4gMpwZUmx1qHoVMyf1uAjimJPTOz+rwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFE78K9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D11C116C6;
	Thu, 26 Feb 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772111450;
	bh=C4eMAFRdacQNFuE024DtfsctH+er00ixJMhwD+JseHE=;
	h=Date:From:To:Cc:Subject:From;
	b=WFE78K9xm9eujsTLCvowp6+vqtegWFnuc26lR3QWfYMm1Dqw5F560bczzmq7fWdrR
	 8c/r0WTEjwKqoFi7CT4S8GQ9gwRmCi9ll+SllwqrGBidWTSA/yQMlrDJ/wluax8BsN
	 sPg6eY7BvpkXStl2jScsZVJramcZC7WtaWn7Fh35mkojVbiKhGkYkdqgrfpdz+a17T
	 rV+Jr2qWvdX0fWTQN8z5/5Nx56uWLs8cNEOIyxC6e5CM4dlqQXP3YKT7uTkjsiKVg6
	 SVJBttuP4sB9njz+pf6dwkaViZIrfIiYpUQ0ooB6DEr2lUXFhf9M5ADA9sjBQ5J6KF
	 f8D1S9kDDyhgw==
Date: Thu, 26 Feb 2026 13:10:45 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: linux-next: manual merge of the net-next tree with the origin tree
Message-ID: <aaBGVUWIb1a5srxr@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+dCWai39WQ5lHEl"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261345-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 73F781A630E
X-Rspamd-Action: no action


--U+dCWai39WQ5lHEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c

between commits:

  69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar=
 types")
  bf4afc53b77ae ("Convert 'alloc_obj' family to use the new default GFP_KER=
NEL argument")

=66rom the origin tree and commit:

  8a96b9144f18a ("net/mlx5e: Alloc xsk channel param out of mlx5e_open_xsk(=
)")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff -cc drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index ac6f0581aa09a,d39f778ecd85b..0000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c

--U+dCWai39WQ5lHEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmgRlQACgkQJNaLcl1U
h9BZEQf+LBneEKglD0/YYqsmeSDobLWl00I5wVUA0JmukMcuIFkAYFA6PLpYzaad
0xWSRTqAcTMUPY7hRbPQ/tnvFKVSBl9Xy43fZPMMqpxRBIn27vIBre7fq4y1qWkk
iYGE5T2ewqU5DaoUpd+nE4FJqvThQIHOCUdSoF7bnJ7CLRMW1tk8XBHn65t3jhpa
toYw+qHxARbzr2MpU5aMFjAkW1HWcoqvhGg/oHPKDpd0fLukWQo+7sdM4F3UbAy1
IEEpka6mbzKkyLQ5wVYgAhKCfmq3GeIpyARGdBw+0ZqIuHQfdMpfesMWsO0+SNJV
kw4LsIhgTRN48kfOK14s8lEpVGgX3Q==
=rsBm
-----END PGP SIGNATURE-----

--U+dCWai39WQ5lHEl--

