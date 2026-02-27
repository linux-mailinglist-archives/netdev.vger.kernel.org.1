Return-Path: <netdev+bounces-261851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOhRLxWioWnEvAQAu9opvQ
	(envelope-from <netdev+bounces-261851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 654091B7F7B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C6ED3050CCB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B03F0754;
	Fri, 27 Feb 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0Wxb1rh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76A26B2D2;
	Fri, 27 Feb 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200465; cv=none; b=CX+pTI+d8Y4Xo/LpV0SFk84jaYWvJY4kF+o8C7G3ou5Iqq8ThdaSLNLGabm+Uszl2vopdbdpdYeXiYCaFsEMkBQJS9Sbp72p4G3+4p8J4RymTugSZVHpzPxjyDTQUoXUDd9EMdk5SbJkd6ZqPfoPYVVCH9Q0/40ACwDoXBYxTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200465; c=relaxed/simple;
	bh=AMjvPTzkrN1sRlxoYkeE7+Ga8oRyi6yLKgdP8QAuuwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RlYB0swgDb0Llssr19UrYDnZW9WFyE0O5gTRvIp8k1NOcZalZE8huZOtSSL0PWhtWX+Bo0A1s7vqfg9NEnwVa1G9ZXFxnDMZLW/971jDsa7smQpfJGaSveBLujepDx9o3HxUc8pI494fopnP60qswrBDZfP1OKbWM9M/3uKbhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0Wxb1rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E7C116C6;
	Fri, 27 Feb 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772200464;
	bh=AMjvPTzkrN1sRlxoYkeE7+Ga8oRyi6yLKgdP8QAuuwY=;
	h=Date:From:To:Cc:Subject:From;
	b=k0Wxb1rh5xllwE7Q0RchFMSdUwcZ3vGpQFK1A71xdK5k2jXuUesWT2ViE/Jt4tZkU
	 lPCS90TfPPYAhcFDYcaP8QakshdgsXw1LNiMii8fNEzB1dVrDpNq5pX6ddkOAzYZ3U
	 EMr5OT5gUPfMEtbhIWhP3P0DyPSTrIzsnBGDPMpjBAUtdnzY9UIsKeXFbsEXTC2ogq
	 z2bxx2jMYCsIBTtaDW5n2gg5tM2UL+uaEFt97/wQ2WsfFpXFrffoKkrDrfDaF8eNIY
	 0fyX++5ILpMRaWd1fzGW0vbiQwk4+dhvNYV5yScvJsC5GcEl/50FHbv00X+KRlkEks
	 pJZ07z1vtynfA==
Date: Fri, 27 Feb 2026 13:54:20 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Byungchul Park <byungchul@sk.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the mm-unstable
 tree
Message-ID: <aaGiDINfnUexT9Px@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B8qdWzXhJo42/F/5"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,sk.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 654091B7F7B
X-Rspamd-Action: no action


--B8qdWzXhJo42/F/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/netmem.h

between commit:

  0a8a9198a887f ("mm: introduce a new page type for page pool in page type")

=66rom the mm-unstable tree and commit:

  fd6dad4e1ae29 ("netmem: remove the pp fields from net_iov")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/net/netmem.h
index 85e3b26ec547f,a6d65ced52315..0000000000000
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@@ -93,38 -93,11 +93,21 @@@ enum net_iov_type=20
   *		supported.
   */
  struct net_iov {
- 	union {
- 		struct netmem_desc desc;
-=20
- 		/* XXX: The following part should be removed once all
- 		 * the references to them are converted so as to be
- 		 * accessed via netmem_desc e.g. niov->desc.pp instead
- 		 * of niov->pp.
- 		 */
- 		struct {
- 			unsigned long _flags;
- 			unsigned long pp_magic;
- 			struct page_pool *pp;
- 			unsigned long _pp_mapping_pad;
- 			unsigned long dma_addr;
- 			atomic_long_t pp_ref_count;
- 		};
- 	};
-=20
+ 	struct netmem_desc desc;
 -	struct net_iov_area *owner;
 +	unsigned int page_type;
  	enum net_iov_type type;
 +	struct net_iov_area *owner;
  };
 =20
 +/* Make sure 'the offset of page_type in struct page =3D=3D the offset of
 + * type in struct net_iov'.
 + */
 +#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
 +	static_assert(offsetof(struct page, pg) =3D=3D	\
 +		      offsetof(struct net_iov, iov))
 +NET_IOV_ASSERT_OFFSET(page_type, page_type);
 +#undef NET_IOV_ASSERT_OFFSET
 +
  struct net_iov_area {
  	/* Array of net_iovs for this area. */
  	struct net_iov *niovs;

--B8qdWzXhJo42/F/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmhogsACgkQJNaLcl1U
h9BB1Qf9HlbCj0VUO362KK37n6HFhXaEmxth6wOpaEIDm76hjBl494XxP48Rvbzr
pI269EOusl05dwESwsN6vA2ItoxMorQGSAR8+dZLjFDPriR7vqWCpYaixkMEwZ4o
KvbER5niIpv5QOCmz/427xr4vMvjsNcHJ9O+xMZidC9/C61EdfiTV4KUyUpU2l7l
vk7NOx8oClAdFdPXhQvI+7iMhNno15J9UPHsqLdBoTCoa1VkE+gq/yHt3uPYHdmX
SYTsC3OaPZ5eQQn3DtOGmDLLeWnEOhvOGHGRD0f+2FWDtqqY5axUibi+8uQDaMdy
AcBvWeyXHfbsNGR/drsXozD9/LmMhg==
=bZ9K
-----END PGP SIGNATURE-----

--B8qdWzXhJo42/F/5--

