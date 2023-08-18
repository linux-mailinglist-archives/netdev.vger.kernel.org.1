Return-Path: <netdev+bounces-28662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281D780310
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF1328228B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEB395;
	Fri, 18 Aug 2023 01:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEA375
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:22:54 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2124203;
	Thu, 17 Aug 2023 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1692321720;
	bh=J91y43CUV4wpm0FlW1qXk5Ftau/aRI4MIw2cmxJLr60=;
	h=Date:From:To:Cc:Subject:From;
	b=JzGGRFHpLI3bGcO8I+iEcT/l4ptJfOmsIjfRKzxc71gZuhyGApXRPBku/sJlhdxdP
	 fKlYMR9Wz7YYIunlLsZzpLgwYsVfxUBJvfDiF8eFpoCuvmw3aRwN4AzijAzCLzNN+/
	 tLPkjm/wBHbbzznjlQxEWMNNtaTlebBeXH0+jl7D1tHkq8eRH3dlDZjKNYDmNYcpmW
	 Y7mamIqVVqIRXx3HEg2JOWA3y0x97CQ4/DWyxi2QHAxbZx2knfmMWr3tQ7cr9Qv7MP
	 mC8k8xVrnY5RWS4a9/tqLSezLI9MPJtSC08D+L7gkg9LHjwOkfmjXDPlk/6JOR3KF/
	 4iFoD13x4/KHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRkcS3V3Lz4wZJ;
	Fri, 18 Aug 2023 11:22:00 +1000 (AEST)
Date: Fri, 18 Aug 2023 11:21:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Edward Cree
 <ecree.xilinx@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230818112159.7430e9b4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4x=_vmcY6dv.NiOPuZaOiYG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/sfc/tc.c

between commit:

  fa165e194997 ("sfc: don't unregister flow_indr if it was never registered=
")

from the net tree and commit:

  3bf969e88ada ("sfc: add MAE table machinery for conntrack table")

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

diff --cc drivers/net/ethernet/sfc/tc.c
index fe268b6c1cac,246657222958..000000000000
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@@ -1657,11 -2087,17 +2087,17 @@@ int efx_init_tc(struct efx_nic *efx
  	rc =3D efx_tc_configure_fallback_acts_reps(efx);
  	if (rc)
  		return rc;
- 	rc =3D flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	rc =3D efx_mae_get_tables(efx);
  	if (rc)
  		return rc;
 -	efx->tc->up =3D true;
+ 	rc =3D flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
+ 	if (rc)
+ 		goto out_free;
 +	efx->tc->up =3D true;
  	return 0;
+ out_free:
+ 	efx_mae_free_tables(efx);
+ 	return rc;
  }
 =20
  void efx_fini_tc(struct efx_nic *efx)

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTex7cACgkQAVBC80lX
0GyVTAgApL7cdEzEbkTkd3JPQ6bkSiv5gMEWKD6cg4ClpNAwVrbCNL0lSpHUamqD
ukvtZKetjrvGYSpAnnJuxP/9PlZEk3YVp6WwQSDa87MG8E1xndsCzFzzjb8iKgHE
DWLdjObxK+w2asWW0M/5WjiG/93FlfSQTllxaozMfWT/UAV71tmD01pmNRkV9Rix
gceupG81QEEqQEyoZq2cqGYU9VUJPrCFdoeBtQpoJaInNv8KeCnW6yBof9zdpx/c
ytm5bRIrbdNgEiZe9BRJXLkK5xyN0VbyhcyB5PQAmboBd5dYx5m9f5CstSNnMp2F
h1NXqadc5CqCg40WxRoCkT4hIXWXbQ==
=O70f
-----END PGP SIGNATURE-----

--Sig_/4x=_vmcY6dv.NiOPuZaOiYG--

