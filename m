Return-Path: <netdev+bounces-265554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHcdMhHPrmnEIwIAu9opvQ
	(envelope-from <netdev+bounces-265554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:45:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B036239F20
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 062F4310BD5D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F793C1977;
	Mon,  9 Mar 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjrmkW3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909413BD623;
	Mon,  9 Mar 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063755; cv=none; b=dfSG6mhMSyX6VWnnfPsmxl4J+e+vzU4LPYP33uddc1CoGSRdvHSIunK9QfAfB2moo9KwNj9Hj5x85YSC+7c2EGIlPQtdxa2mTgM6qYKtU4cl61LFWZlo/FkZ9uMBBmuWAaynytE26UjO7QvAkiTQPsZjA7n8e/m0aXNc2x1gF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063755; c=relaxed/simple;
	bh=Fdl8FJojdFPF1FUx1e+Rv2JUkktdlZW2eiayHkO7iv4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UasuXBd//dyIvDJfsbWupVfNwtnFxFXzszV9vdjVs+wCOdEyKx+Jqqz3Uzi5ELrOOMGol8vWsrDJwahnDNn62TDDwjVvTG7YbUEmnlBEmQGofIDZ1wq5xmGjn6I3M7sNtQv4w5pb9rRFfAJCayj7U7PDLdgcsGMMb+B1927+l6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjrmkW3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C506C4CEF7;
	Mon,  9 Mar 2026 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773063755;
	bh=Fdl8FJojdFPF1FUx1e+Rv2JUkktdlZW2eiayHkO7iv4=;
	h=Date:From:To:Cc:Subject:From;
	b=BjrmkW3Zr2SH+Wm7b+tx8B/mPCsCp2tpivIfWmZAE33S/KEoG2bNi9NmR4sXz4OBO
	 cWIR6eSbASwSZFExdk+TNwIbuh0QN7O+nodVGuJnsRbsrENjFMKPtuvV751oGjgKOb
	 1aogQzKswagsChUTcC4HFFGE+bHYYNoB+GaSIfW3feqzuV01nc3u/6eTVUDNIYo4if
	 GcBDy/R5GSchddRNd7bQ5LEtVO73dbUkOgIoCMPl3oGdUUBYl9HGJD0tKJYAnvhqbl
	 35LEjNRiT5N+NX7WX9zhU2DYOKxb03tARqg0GquVsLYowT/jhC3mIUaS8ab/8jlqH6
	 QDGhBGhtYbzew==
Date: Mon, 9 Mar 2026 13:42:30 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aa7ORohmf67EKihj@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ySJF7kGR7n2ojKAD"
Content-Disposition: inline
X-Rspamd-Queue-Id: 2B036239F20
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
	TAGGED_FROM(0.00)[bounces-265554-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--ySJF7kGR7n2ojKAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c

between commit:

  db25c42c2e1f9 ("net/mlx5e: RX, Fix XDP multi-buf frag counting for stridi=
ng RQ")

=66rom the net tree and commit:

  dff1c3164a692 ("net/mlx5e: SHAMPO, Always calculate page size")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 268e208847577,8fb57a4f36dd8..0000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@@ -1971,12 -1977,13 +1973,12 @@@ mlx5e_skb_from_cqe_mpwrq_nonlinear(stru
  			return NULL; /* page/packet was consumed by XDP */
  		}
 =20
 -		nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
 -		if (unlikely(nr_frags_free)) {
 -			frag_page -=3D nr_frags_free;
 +		new_nr_frags =3D sinfo->nr_frags;
 +		nr_frags_free =3D old_nr_frags - new_nr_frags;
 +		if (unlikely(nr_frags_free))
- 			truesize -=3D (nr_frags_free - 1) * PAGE_SIZE +
+ 			truesize -=3D (nr_frags_free - 1) * page_size +
  				ALIGN(pg_consumed_bytes,
  				      BIT(rq->mpwqe.log_stride_sz));
 -		}
 =20
  		len =3D mxbuf->xdp.data_end - mxbuf->xdp.data;
 =20

--ySJF7kGR7n2ojKAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmuzkUACgkQJNaLcl1U
h9CF4AgAgEzpN8P7HDKLKz3jWKWCIkbEixssWOKt0d5kjiF1/hLAo5wUeoLaovSp
yDv3ZP1DthcYDy2Dcmkq2cW5Bud9G1HFwlc84zO627R8/XI1CFA/zuJrNRAAqMYM
xvn2Am3rreMTGZvDKbvNT+d6/Cplklr0TjUTYg4w42WoI5y6Z0Y3LjvYNUGLWlXF
tSzD4GK2a7/tAEAwSBKd1RuUz5igvW4ye9enHf6Yvml8RzbwBr0bhBcLxqCw5rDF
q0qyuHh2nBJE6qXGDv9GVvWObbFeeW/k+4B7N3AtOGPYnUUh0tA4Hwex9E399tQf
QuGNsekrPuUYPfMZ2jR9Kv8zVcaNWA==
=KVdP
-----END PGP SIGNATURE-----

--ySJF7kGR7n2ojKAD--

