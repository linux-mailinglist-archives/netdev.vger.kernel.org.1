Return-Path: <netdev+bounces-31318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A178D093
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 01:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6928281214
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF36FDC;
	Tue, 29 Aug 2023 23:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC896AAC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 23:28:32 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEEA11B;
	Tue, 29 Aug 2023 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1693351706;
	bh=MxfD5rB/5DGRsx1UFZiv+c2vCsiVC6XlMi4cYQc+DJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BaCv5kNx3dK43bYNeOzj6Uef42zVtb1lJodrEvVcs0sGdKSGUpXPrh+PLu94Mzea8
	 b1ak4Xru3g3jS2nCZm/lm3bCBj4KDwX8iiySRUVsnbULEtDuXtjqHumUiuF7X3j+tU
	 b39oAdffrJ9AlEA95TTw0C/Kt+6C9P246jdhqC5jPgwvZHNxfvTUnDUjrhfIUcfXkn
	 EitkyhpU3LkeMQOWrI7BfmpnEHxbWWrRSLXH9HlC8VIid0w2N8DjzX1I1p/lhTuUcq
	 IhKWsY/FIgLyt45/n5zyKn3fOd1GsEKQW94QR05zb6sHagxVKb8ratyQnCeYQvTR1f
	 7nbRrey4/yfDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rb3Ws3NT9z4wd0;
	Wed, 30 Aug 2023 09:28:25 +1000 (AEST)
Date: Wed, 30 Aug 2023 09:28:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the powerpc
 tree
Message-ID: <20230830092814.71cb6911@canb.auug.org.au>
In-Reply-To: <20230818111707.2714e8cb@canb.auug.org.au>
References: <20230818111707.2714e8cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kzYIKj8Isww0Z0lB3pjBXEU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/kzYIKj8Isww0Z0lB3pjBXEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 18 Aug 2023 11:17:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   drivers/net/ethernet/freescale/fs_enet/fs_enet.h
>=20
> between commit:
>=20
>   60bc069c433f ("powerpc/include: Remove unneeded #include <asm/fs_pd.h>")
>=20
> from the powerpc tree and commit:
>=20
>   7a76918371fe ("net: fs_enet: Move struct fs_platform_info into fs_enet.=
h")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> index aad96cb2ab4e,d371072fff60..000000000000
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> @@@ -9,8 -10,8 +10,6 @@@
>   #include <linux/phy.h>
>   #include <linux/dma-mapping.h>
>  =20
> - #include <linux/fs_enet_pd.h>
>  -#include <asm/fs_pd.h>
> --
>   #ifdef CONFIG_CPM1
>   #include <asm/cpm1.h>
>   #endif

This is now a conflict between the powerpc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kzYIKj8Isww0Z0lB3pjBXEU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTufw8ACgkQAVBC80lX
0GwGLgf/YrbEQb46AZGblOXOfqDRqvOClfY16YPJ421dwyYDswib581afeFKKuT4
vTnIg78VaetO8fLJXBP1E9mzu9LRPLmxMfYwDrlK5fk6IHP9X5euTN8VenbZsmYi
giGEaVKOd23q/CfZ0NRi+JhWRffPezZabAIYmo23UKw+QNaKMCsdziARRKmvT8DN
jkqfvR8GQz7nMJjzhMZj24xiTWs478zGRhOTXUXMWxDdcNKdbg4GzZlcD8ikV8az
GAU59J9HXcHeGPYpW4zLS2TWEFw1xF7xphIRlYJd63qRKQeiI4zyHQn+5V2wfgLm
OptDIA4IDHhVixYrjyCleSXLrlm8UQ==
=LI+k
-----END PGP SIGNATURE-----

--Sig_/kzYIKj8Isww0Z0lB3pjBXEU--

