Return-Path: <netdev+bounces-22991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7D76A563
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F82816DE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2A371;
	Tue,  1 Aug 2023 00:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440C36C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:17:14 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7087173D;
	Mon, 31 Jul 2023 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1690849030;
	bh=oMvFNBSH98YR96Y1UgC3tI4QIdqPVGbnRBQS4lVnmK8=;
	h=Date:From:To:Cc:Subject:From;
	b=gooAluXNE0NE4d1IrtCFx4onVZdMVkan3zpCN8kPtCq1etsbOUKYAVWlWKVzgaSlS
	 fHbit6ZBAVIgloW/9N5P/CqAeoEbWt5fHe5OddJ0q9/a+6VH8CJgQKq/g8u/Pe/PFy
	 iAEweQRYTpXm9avv5jC6WAC1aVTo6MszsOEkkQqT2qI6npP5qZSZ+ED2Mr9jmtbPrz
	 DXv4kj/NV/ID5EVEjvybVliSjJjrOpy1GxecNiza3IPpN82Z87/Kt2Xa5uqW3VPhP8
	 g5NqK+9igU6Mkimv6asMqVjrXB9Vp0hojboqx8F7vB/PzKJyvlmkLZHi5seBjY+e8c
	 w2XstjARXNI5A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFFzT6nYXz4wy5;
	Tue,  1 Aug 2023 10:17:09 +1000 (AEST)
Date: Tue, 1 Aug 2023 10:17:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230801101708.1dc7faac@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+G_pMPqYCr2nKoaTLK9Q1F7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/+G_pMPqYCr2nKoaTLK9Q1F7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/broadcom/bnxt/bnxt.c

between commit:

  37b61cda9c16 ("bnxt: don't handle XDP in netpoll")

from the net tree and commit:

  2b56b3d99241 ("eth: bnxt: handle invalid Tx completions more gracefully")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

idiff --cc drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 06b238bef9dd,a3bbd13c070f..000000000000
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@@ -686,10 -744,9 +745,10 @@@ static void bnxt_tx_int(struct bnxt *bp
  next_tx_int:
  		cons =3D NEXT_TX(cons);
 =20
- 		dev_kfree_skb_any(skb);
+ 		dev_consume_skb_any(skb);
  	}
 =20
 +	bnapi->tx_pkts =3D 0;
  	WRITE_ONCE(txr->tx_cons, cons);
 =20
  	__netif_txq_completed_wake(txq, nr_pkts, tx_bytes,
@@@ -2571,11 -2595,12 +2597,11 @@@ static int __bnxt_poll_work(struct bnx
  	return rx_pkts;
  }
 =20
 -static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnap=
i)
 +static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnap=
i,
 +				  int budget)
  {
- 	if (bnapi->tx_pkts)
 -	if (bnapi->tx_pkts && !bnapi->tx_fault) {
 -		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
 -		bnapi->tx_pkts =3D 0;
 -	}
++	if (bnapi->tx_pkts && !bnapi->tx_fault)
 +		bnapi->tx_int(bp, bnapi, budget);
 =20
  	if ((bnapi->events & BNXT_RX_EVENT) && !(bnapi->in_reset)) {
  		struct bnxt_rx_ring_info *rxr =3D bnapi->rx_ring;

--Sig_/+G_pMPqYCr2nKoaTLK9Q1F7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTITwQACgkQAVBC80lX
0GwP/wgAhR+JXLjo1+DQCJkzFHBJVeJtPEQiJ94Kn92FzNJ9wwPNhNTsySwaKcZp
SjcSq6q+MHyv4f2dZ6vLXKw1PByLC1+Qmv3veJ+wPiHXvOQQEWNdtSUOaPslxGpK
FcdmWSm+SmH55BbdNzrHb4bobfkU5HHTceJcgokYj7Zwb+R1mKUqBMyJSPU8KlB5
1BMSU5n2hvLiyCJ0w3xnx/V7mREnqxtG/QgBbqH6Av6vO8aj9Dzuk+cdIp3fAiTk
xinou48ZkPiZmIHTcdb6/tlQCpjzwqtK4UIqhTGV0w5conBHuTNH+cmN3JS91jw8
GHGzV9vMC8DceBVyMFyoxJtbGj0+mA==
=2RXl
-----END PGP SIGNATURE-----

--Sig_/+G_pMPqYCr2nKoaTLK9Q1F7--

