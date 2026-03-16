Return-Path: <netdev+bounces-268183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAmSD8QbuGlYZAEAu9opvQ
	(envelope-from <netdev+bounces-268183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:03:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9A29BF07
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A06B3085310
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1AB306B3B;
	Mon, 16 Mar 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGe7C04r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C4306B1B;
	Mon, 16 Mar 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673028; cv=none; b=XipANJZ8dGdQxp9Px0NIALkbeNoCV3X3wMO3vZWJCMvewXYxL4NriY37X6PPQcmf2Is/wpxdkHdWrPMMX/Y9wLq1eZ48l2fXdyTPvSn11L64vDWzr5HnyDdqHUn9pfuRNMc21KePh42pOXjfjQVJ2+g+ZQnmA8CHGRAgYsAiPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673028; c=relaxed/simple;
	bh=wU2u/ScqWZ+YM3WroBO+6Ni7Gc4USP2uHkXeyYSxM4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YOxwzfp1cl//pOTqBV9MEt2kVqMOOwC1F1R5v6ehG7/4lmaUaFYhvKlS/br5Wxbmk5Hwhx/zTmFI5hYbV4IW20hO/puK3Cr9r/6+xqZS1AEJh+nHdg+BefUzMmv3+g6RlVsphROivKNxAB8xhUggSl9tLNT2Sz6MO/GfIVhQwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGe7C04r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D758DC2BC9E;
	Mon, 16 Mar 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773673028;
	bh=wU2u/ScqWZ+YM3WroBO+6Ni7Gc4USP2uHkXeyYSxM4U=;
	h=Date:From:To:Cc:Subject:From;
	b=CGe7C04rggSN/IMb9KpRUMnHS8Ia4V9wCObGk8do2Dp3vqNnWcAf7RmuaNCzorJAX
	 fYJzEWtxXNkX7V92xrV8mOTXEUReBJ9dwOz2rd7guIDQpfQAHSXWs2k/HqbsaiFMfj
	 HC/3Zbjzhy+rggDuIXniMDcvW+Atsn6JyIoS592ZyegB0shnV7cVkzO3eKu0ggbE19
	 vMpupOzlo+GDQci5U0/AykAS00UP4GOpiIM3PcD5oyOsC5XWG2IlR8I7PGo0Co3T5u
	 SVZT4diWUoxJsISfMONteLJaHfDtDpko/qqEM32UxnkUuziUO7ccNtFHoeGDcXs3IN
	 lLLJSxxGEfY2A==
Date: Mon, 16 Mar 2026 14:57:04 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Matthieu Baerts <matttbe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <abgaQBpeGstdN4oq@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y/aQFCUClaw1/FeL"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268183-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: A4F9A29BF07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Y/aQFCUClaw1/FeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/netfilter/nft_set_rbtree.c

between commit:

  598adea720b97 ("netfilter: revert nft_set_rbtree: validate open interval =
overlap")

=66rom the net tree and commit:

  3aea466a43998 ("netfilter: nft_set_rbtree: don't disable bh when acquirin=
g tree lock")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

(resolution should be the one supplied by Matthieu Baerts)

diff --cc net/netfilter/nft_set_rbtree.c
index fe8bd497d74a7,e429053766545..0000000000000
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@@ -639,9 -684,13 +639,9 @@@ static int nft_rbtree_insert(const stru
 =20
  		cond_resched();
 =20
- 		write_lock_bh(&priv->lock);
+ 		write_lock(&priv->lock);
 -		err =3D __nft_rbtree_insert(net, set, rbe, elem_priv, tstamp, last);
 +		err =3D __nft_rbtree_insert(net, set, rbe, elem_priv, tstamp);
- 		write_unlock_bh(&priv->lock);
+ 		write_unlock(&priv->lock);
 -
 -		if (nft_rbtree_interval_end(rbe))
 -			priv->start_rbe_cookie =3D 0;
 -
  	} while (err =3D=3D -EAGAIN);
 =20
  	return err;

--Y/aQFCUClaw1/FeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4Gj8ACgkQJNaLcl1U
h9BKnAf/e3+X+B/lsXD4bfaOMbScncAyKIXjLxw6yYkvrTDf+RE0MOtF/O96bq/f
j5Eqj2FjfTxCpRIY1FNS37BUj+2rH65n39GaX/K/5E++9RYAQJ6ImEihXpcbYJ/G
58GtKUNpQCYnl/tqEQje6h2UxINlH12Rq1daktZiPsK691VKa4DyUWRFP5jAYYRp
ukSL8SRgNtVzptp4KStc24VdM1xiEiCaSnSzQo1Afl7Pvrji57r/w8gyrNKLsajP
vhxQUHkFaUT6ULrQXbdNQw3JMsImeoaHeNAqnSmpRn+8mXCbmG5GfJ+EfjJl9sLl
chjUMF34xh3dm6CDMQt4P0U/0AcjWA==
=DF4n
-----END PGP SIGNATURE-----

--Y/aQFCUClaw1/FeL--

