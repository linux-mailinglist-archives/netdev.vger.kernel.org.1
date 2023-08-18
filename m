Return-Path: <netdev+bounces-28657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E707802F4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1DB28226D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4E395;
	Fri, 18 Aug 2023 01:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB1375
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:17:20 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACE3AA6;
	Thu, 17 Aug 2023 18:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1692321430;
	bh=Wj52K4lZS/g/aHhULzZG+L4pSUEP25cWrpsFG22rQf0=;
	h=Date:From:To:Cc:Subject:From;
	b=PK/TgGoIQym7SkBAW1O619pBDmh4ZWIrHy1ZL1APXY1N9PgjuOVNcTzqPtKff2vYi
	 Gm7bS7g0PJ4d2KglE8k0r5qvWWdA1vCq6ii1d3iT6cxXJPx45zzQF3Sk1k86qbD6el
	 RMmOEDIk41xRL/0VgCavqBSaiYodX63u27EIdo5P0YrBkKZRzNQ5nzAo+LdUalEKVC
	 8OJ2Yf6TWujxCDBc7WsSAS53/afWGZteBLytxD6NEWqyD+pBHhU0CmlG9Hc+KaEts+
	 k5QE0f5tVm234ehT17BNVL95wGY+QLKHhrZWi/a02fTqXZInuIqjfO+UzmDj+HdBod
	 G48goFp5a/woQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRkVs1gXZz4wy5;
	Fri, 18 Aug 2023 11:17:08 +1000 (AEST)
Date: Fri, 18 Aug 2023 11:17:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Networking <netdev@vger.kernel.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the powerpc tree
Message-ID: <20230818111707.2714e8cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kWOSr8h3qHdBONR47hMwJfY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/kWOSr8h3qHdBONR47hMwJfY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/freescale/fs_enet/fs_enet.h

between commit:

  60bc069c433f ("powerpc/include: Remove unneeded #include <asm/fs_pd.h>")

from the powerpc tree and commit:

  7a76918371fe ("net: fs_enet: Move struct fs_platform_info into fs_enet.h")

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

diff --cc drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index aad96cb2ab4e,d371072fff60..000000000000
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@@ -9,8 -10,8 +10,6 @@@
  #include <linux/phy.h>
  #include <linux/dma-mapping.h>
 =20
- #include <linux/fs_enet_pd.h>
 -#include <asm/fs_pd.h>
--
  #ifdef CONFIG_CPM1
  #include <asm/cpm1.h>
  #endif

--Sig_/kWOSr8h3qHdBONR47hMwJfY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTexpMACgkQAVBC80lX
0Gzrpgf/V3aE/K9DCrHYO5zLpcikiGZfJrSz5DX6IxzUB4v1iVCexGFyh8o1T6T9
IRYb4RRcbtOuxMl40T3yL4UJsjjVP2gTU/TRazpeoMcMvqFbLbv3+83f9TiP6jwF
dSv77sdA2jfN9UopC19hX9+aBDCKbit+HT1jJ75g4eAP8/vy/MJH2nWnFLRHwo9h
39cUiX0Rhi/1lXtmv2XbUHhMDegF/Zq2SECGGJ0Bf9XThjeeNiRDWAK/qfIjzZba
ZjK5HMPZakBGxHf38Ro/XG46AY374cNQ8ZWo6T6M4u813h3vV6zHRsQc05vPJBhJ
r8vckszA3e0kbWlsYd+/WYHo6jGAzQ==
=fzpM
-----END PGP SIGNATURE-----

--Sig_/kWOSr8h3qHdBONR47hMwJfY--

