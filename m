Return-Path: <netdev+bounces-13859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3573D7C0
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1181C2081C
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398CED6;
	Mon, 26 Jun 2023 06:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB0EC5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:29:20 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3AA8;
	Sun, 25 Jun 2023 23:29:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHxL0xBtz4wZy;
	Mon, 26 Jun 2023 16:29:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1687760952;
	bh=hZj5SpgUl5Mk5j8hYoLE+L8btm7Rk7BQ0o68g324GBk=;
	h=Date:From:To:Cc:Subject:From;
	b=BOBahx3pY3L3eGOJ8WOb7h7BlMyKQKC0OUJrcUvALWJij63+SHs07oFAJI1G5k7dj
	 O4LZL6hHwIKAAQyurZI3+yV+SWVHu+vT1SxZprldGd2gBLLTr8UpsMgxn2vcC63DiI
	 V0ndnuCzyQJsnsS/LB5bdPbPttb1wb0Wi1kbdLw9w5spaHNhiFmIVzAzuNuRBpO6Gx
	 LzfOjyCpUqRQtYFBrntu93BXXmDJBbEj4GdiTHjaBmco8utTtdwIZh0XzAqbqWWgJ9
	 G0PcEoSEtg8PF0Yzv+p3yvNU0f7a2Atft+j7Bj/Ewsz/a1hyI118mYJ7M0HZlRYTIg
	 4ELutZF2rkxLw==
Date: Mon, 26 Jun 2023 16:29:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230626162908.2f149f98@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pgqS=2ogaJDS6o=laFxWZbx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/pgqS=2ogaJDS6o=laFxWZbx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/networking/kapi:144: include/linux/phylink.h:110: ERROR: Unex=
pected indentation.
Documentation/networking/kapi:144: include/linux/phylink.h:111: WARNING: Bl=
ock quote ends without a blank line; unexpected unindent.
Documentation/networking/kapi:144: include/linux/phylink.h:614: WARNING: In=
line literal start-string without end-string.
Documentation/networking/kapi:144: include/linux/phylink.h:644: WARNING: In=
line literal start-string without end-string.

Introduced by commit

  f99d471afa03 ("net: phylink: add PCS negotiation mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/pgqS=2ogaJDS6o=laFxWZbx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZMDQACgkQAVBC80lX
0GwdiAf/Wa4isrd91W2nI9RQUXaMPonnmNvOJ/IRshOLqgqhQyw2d+bbdycqfHX6
rasmuBo0MW1z9ct1ci5sR3YTVH2WooA1Td3hNrbyNceOih4xkDPmvx+tHHRc/M6Z
qqrlR64SmVF0uMPIKn47Karf5UmtHSbCFvQ7IgAPFfuTIQxRa2N0iVJU584K3rdW
Ci8F3/ufVDbHQoiq8U5zxOdsouqXhSfkN0eiwmuU0A6GVgWz6jn208LKUyY0zzfa
mhCKamg8lwgUG9LWkWubGNZtJb9qvSR+NuYCnc371b2+Fq+7pT8hJN4WC27CmrUa
EYaSZqzlANa7EAThC6SuMD8W193DGA==
=b9NL
-----END PGP SIGNATURE-----

--Sig_/pgqS=2ogaJDS6o=laFxWZbx--

