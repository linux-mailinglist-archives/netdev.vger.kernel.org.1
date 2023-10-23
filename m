Return-Path: <netdev+bounces-43339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CD7D292B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 05:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887D728130C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48E1841;
	Mon, 23 Oct 2023 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oetn57SU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55DED1
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 03:47:26 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0CE9;
	Sun, 22 Oct 2023 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1698032843;
	bh=SziYY1ABMf8DuL5z0is9ByCbU2OtLabxluT0AfjFci8=;
	h=Date:From:To:Cc:Subject:From;
	b=Oetn57SUZrJ2AW4oMKUMSKY15V6Sl8gxYfS8PDjS2T1l7+4SzuBtt+LUZHiOBlyN3
	 n2dOU5oW8Blse0X+2xT9bJrFFmjhQS6DBsIAXOXqM+0U0BjtRPsVwnaJF6YGwaIXJI
	 ppmyctlqDICZkwVGHQHs+ZNHtwKtTv/8Fo8m2YPCwG6Vu3ks8Jt+G77yvcd+mtPf0S
	 wzA/2TnB/A5U9/5MxfTtmhMApbvgt2jsTLLODcRI5Y7cpiwAKzDKu3FZy5VLnVkf3A
	 F4b27HmlpSOSKe3Ku3S41CufgluvSLQOARp/bOM17A3J1Dylcpx5CxecOvWIPGJMUc
	 dVZjt/YTHWLag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDLjk2ZTFz4x23;
	Mon, 23 Oct 2023 14:47:22 +1100 (AEDT)
Date: Mon, 23 Oct 2023 14:47:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Benjamin Poirier
 <benjamin.poirier@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: linux-next: manual merge of the staging tree with the net-next tree
Message-ID: <20231023144720.231873f1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1k0w+OwPEDYvUpmeB8AIS_y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/qlge/qlge_devlink.c

between commit:

  3465915e9985 ("staging: qlge: devlink health: use retained error fmsg API=
")

from the net-next tree and commit:

  875be090928d ("staging: qlge: Retire the driver")

from the staging tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU17MgACgkQAVBC80lX
0GxEkggAke6CgrGBCpIMbig3gO6i+5vRazhxfigGMdsUJIaAgTtTkmgZy3ziEUO8
zqA/zfUhemkK4MfxzCDnJlSiCB8fM7qkuTf9u8lN3l/Bv+jqIOPySsNFyw+6z01h
PE5ngUL9y1wLl0r2ShhJn9VH6VYeTGcgCMz0g9GlyPvjTDJ5rJkXreS34MF7FbIK
hlPy1KFVwqok/Z1KTFDyuiaJSRTXEtTECsoz4tHOKksRDE5jB0KV1gTl4wB9uFpQ
tbkRYzzXlYuxUSDKhENFsJ1wDky2wRZsJlFQbRjDIoimtwn4xwI3z0SNujpRACI4
n2Qmw+PDVT65lvukobXDl50hX5WGjQ==
=dcuf
-----END PGP SIGNATURE-----

--Sig_/1k0w+OwPEDYvUpmeB8AIS_y--

