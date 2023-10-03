Return-Path: <netdev+bounces-37540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E27B5DC2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 08F30281510
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FB208CD;
	Mon,  2 Oct 2023 23:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B41E521
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:37:18 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31038B4;
	Mon,  2 Oct 2023 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1696289835;
	bh=ZrA7I8jcs22PJNQSuzapXP+rXCoCoW1xUIsZd4l4XmI=;
	h=Date:From:To:Cc:Subject:From;
	b=k92f4Dqs4P6Fo0AbW2VHBQvxnhkpYXvz7zOAFtoODQCCTP6LUHnuazXhj8cnvPAsy
	 akvXM0B1kWYOgkWezC388pOEl8JpC+0OsIAvXOyTNDUBkQc2CJnEMOB+Wr7aLug6Sz
	 HptI2OTA8Z7XT8lfcDaPcVcJ8wxmFkHwdZ4ekVjhwZlc+rn2Eu/wtJ3qB0qw+Q34Tw
	 RzgxjoRWSpjarQf4B3Mbe5XVEbemrQaL7WVGsFVYVWTVOEGH1uVdISfm1+CbFjuyAK
	 oW8hPmssxpXbU1ijpk/JCiAoURdMiBy2tK/p0jPAtnKAmz7XxemgxB8FtAVZbE19kg
	 2f4cKzQGpjx6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rzy6L1G3Lz4xNg;
	Tue,  3 Oct 2023 10:37:14 +1100 (AEDT)
Date: Tue, 3 Oct 2023 10:37:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Jiri
 Pirko <jiri@resnulli.us>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20231003103712.5703b5e0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/audx8+6=rD2Db8A9QbMBV5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/audx8+6=rD2Db8A9QbMBV5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  include/linux/mlx5/device.h

between commit:

  ac5f395685bd ("net/mlx5: SF, Implement peer devlink set for SF represento=
r devlink port")

from the net-next tree and commit:

  0d293714ac32 ("RDMA/mlx5: Send events from IB driver about device affilia=
tion state")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/mlx5/device.h
index 8fbe22de16ef,26333d602a50..000000000000
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@@ -366,7 -366,8 +366,9 @@@ enum mlx5_driver_event=20
  	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
  	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
  	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
 +	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+ 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+ 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
  };
 =20
  enum {

--Sig_/audx8+6=rD2Db8A9QbMBV5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbVCgACgkQAVBC80lX
0GwXlQf/Ta0GYkWCHnuXhPZD4IN/SWBGyNK6uxsf9Pfsr0JfvwYZ0XvQ0nx5QD8g
w6h5inIBuLaEH8zSqJzXAxCPuBaN4JSorgRT4rZb7SHhn1J7PvHbEA8lqMyDOcit
0+G86x8rhz9E5hyUmq65x7UBr1/fIHOOks9D3G0wJ63DIoQqCbhRJBRxJuFnNrsf
DmdOEwxJetQF23cpt6Pgxq85+hgtb6itt9+l6NfM0tHMetlkKWe8FAOWRCv4utrq
eL20KbA73N+pNEm41XMIc6IzplkHuuZSxSLxzT7jBtwvoC8gWkE6Z5lgsgpQMFIs
qhKdk7V72zP/4vuo77OSDLowRMKMxQ==
=6jwz
-----END PGP SIGNATURE-----

--Sig_/audx8+6=rD2Db8A9QbMBV5E--

