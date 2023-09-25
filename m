Return-Path: <netdev+bounces-36065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446A7ACDFE
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D9E4B1F241D5
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25C110C;
	Mon, 25 Sep 2023 02:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EF10E2
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:14:24 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2BC6;
	Sun, 24 Sep 2023 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1695608062;
	bh=EkhDackxSfFieoGUWeVtOtGWn3+W1tDL1N3rERMkARA=;
	h=Date:From:To:Cc:Subject:From;
	b=mMHLk4kVK953Ezes7KGMVBGp451KsgVM3IQb6wnSU+W/2kG1Suop3nSy6ueABtlwM
	 TnpFH4kadya4Fyyl9uXhfIIzGfxefxOFRMMs+V3v3FuvMe/O4EkQt1MgHUOy3/JxJB
	 W79zIQJkmAph4rJ+GUjh6EfqiMo1LuDpCxoqkszcluT+JM4+lojR5IwjG5/UP08t8D
	 3kkH0/IGWsskVHAGwrwsnb4bucB2ag8HIF21e04r0e6pfYGar+Yo7jK1ypiKS3pcc5
	 /V/P/5NrYbjBuVUgje6HwkfLQJBkkUML5m6HrZyQqUPkFXbiU4lv71PpJKnoKtce4O
	 +1Uq5g1WmndGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv5zK3Zqsz4xGC;
	Mon, 25 Sep 2023 12:14:21 +1000 (AEST)
Date: Mon, 25 Sep 2023 12:14:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mfd tree
Message-ID: <20230925121420.520e91fa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u7varwAHQlwd/t1W6/03L.E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/u7varwAHQlwd/t1W6/03L.E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the net-next tree as different commit
(but the same patch):

  d6e3854f720f ("dt-bindings: mfd: syscon: Add compatibles for Loongson-1 s=
yscon")

This is commit

  7e10088bc4e4 ("dt-bindings: mfd: syscon: Add compatibles for Loongson-1 s=
yscon")

in the net-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/u7varwAHQlwd/t1W6/03L.E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ7PwACgkQAVBC80lX
0GwU8gf+KxcF954ii0iKnlLfcX6hdg017KWY4btd4V1FtYfpQLpbIbMhkhPWVXEw
juT7N9fhLVk/mbZPN+4pO10TM+9PdmX6mi1vxB77JEV4pENsMVDHLcMNyD42adXr
Tlr+87DdlnYkXUbeIEfrs1fR2oLbnZSmsBJZY5SsPjfx9+DgUk9bzv7S/m4G08p+
bKYCabUgVMYXu07UE+TPMczH2kpUldpA/m1epJblv4FZKLcZSeCCgVeCUsqkb/LR
nwTfG68vHdoPgQ7Dg2/EPCMBFNSCCYxIKWs5NW57EZ78U+9at1fs5zuFzVOqv/6U
G7FXiRDN7RxuKzCUzLScL5cf7WTyiA==
=CuD1
-----END PGP SIGNATURE-----

--Sig_/u7varwAHQlwd/t1W6/03L.E--

