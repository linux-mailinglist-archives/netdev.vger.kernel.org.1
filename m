Return-Path: <netdev+bounces-27544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F977C5D8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8A52812FB
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615117EF;
	Tue, 15 Aug 2023 02:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803E17C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:28:11 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94810C1;
	Mon, 14 Aug 2023 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1692066488;
	bh=yn404caKCvYzrFWgHbLiy3+pIAut/KwIxxQePdoi2Nw=;
	h=Date:From:To:Cc:Subject:From;
	b=rj9NU/KPfFwRk1RbnkAeRjSUfYDPMVCHjlZz+NI6rVBEl7il1mUNf9nRfvKXSe3D8
	 ynq5ODoCnL4v0ERdZz1vs7FZhxs7RhbeT5gr3iKAyz8r7bb5WGxe/NG0mKccwtWiRL
	 ABEgf4plKhrOiqN3kFIyuvpyb4jWr2HaGpUR9W5pMKhr82L/3Vj9XkIXKlgHKteQpG
	 eCeroH1XlBYbe/pugYBnNxRHQzUC7dggew74U9jimqBhKhKIFHYlT+FLm1SlfMgFzq
	 SJBxlNc1xyvDcUc0DCHGY6Z4zUbHoz+BSJV5mYhzd3t4p2jyFatJ14K1bybIZNNhuy
	 vSOsB8hqMe2qQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPwD802qxz4wZx;
	Tue, 15 Aug 2023 12:28:07 +1000 (AEST)
Date: Tue, 15 Aug 2023 12:28:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Adham Faris <afaris@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>
Subject: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20230815122807.7dddd4a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_+jTWPsYMUYkxIPJb6=edsH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/_+jTWPsYMUYkxIPJb6=edsH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  include/linux/mlx5/driver.h

between commits:

  c8e350e62fc5 ("net/mlx5e: Make TC and IPsec offloads mutually exclusive o=
n a netdev")
  1f507e80c700 ("net/mlx5: Expose NIC temperature via hardware monitoring k=
ernel API")

from the net-next tree and commits:

  e26051386a94 ("net/mlx5e: Move MACsec flow steering and statistics databa=
se from ethernet to core")
  17c5c415b9cb ("net/mlx5: Add RoCE MACsec steering infrastructure in core")

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

diff --cc include/linux/mlx5/driver.h
index e1c7e502a4fc,728bcd6d184c..000000000000
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@@ -806,9 -804,12 +806,14 @@@ struct mlx5_core_dev=20
  	struct mlx5_rsc_dump    *rsc_dump;
  	u32                      vsc_addr;
  	struct mlx5_hv_vhca	*hv_vhca;
 -	struct mlx5_thermal	*thermal;
 +	struct mlx5_hwmon	*hwmon;
 +	u64			num_block_tc;
 +	u64			num_block_ipsec;
+ #ifdef CONFIG_MLX5_MACSEC
+ 	struct mlx5_macsec_fs *macsec_fs;
+ 	/* MACsec notifier chain to sync MACsec core and IB database */
+ 	struct blocking_notifier_head macsec_nh;
+ #endif
  };
 =20
  struct mlx5_db {

--Sig_/_+jTWPsYMUYkxIPJb6=edsH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa4rcACgkQAVBC80lX
0GwJYAf9HMqfXCGysiiD9uPkWD3jZqMCASMxQDItmcjxYy0A4jCKDKzX8LQarfKT
7uuOZRmqAlB9MYo2QjZV1MNrxHRUT8Df/hf1tdd/RdSSWo0NWuQuw6i/DVZxdyM3
uViQFp9h/Eg4LCTkDhdlr+i9Tccdi52O6PhcRnA7F9YmKjqlBXGKJoCd5rPtKm3h
gJdef1Hp2m+efR+Kwu2Qj337HCY2nvEldD9FA9KB5SKcJ4TFo5HcttASU4FC4M8n
GLJn0xUiaxU6NIx7kQUvg3PTnJF/59VGGjQogE5Yfjh8xhqAqAAY/1msRAkV88Qs
q08Pv/Mw05PyWOwpRCp8DuqNRAJZVQ==
=eB3f
-----END PGP SIGNATURE-----

--Sig_/_+jTWPsYMUYkxIPJb6=edsH--

