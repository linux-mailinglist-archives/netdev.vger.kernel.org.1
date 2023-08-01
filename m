Return-Path: <netdev+bounces-23019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB776A683
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38B1281781
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36FEBD;
	Tue,  1 Aug 2023 01:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D27E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:42:47 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DF1BF1;
	Mon, 31 Jul 2023 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1690854137;
	bh=R0PEe73zlfYAKebLRzhdfAzKrKATJClV0PH4WjYF9+Y=;
	h=Date:From:To:Cc:Subject:From;
	b=JoH0sr+YSK8u4uQc94xxJYtL0S7C1R0vkckil6rOa2KHb7cYTnbAFpzwKU5spHrER
	 kaqMVgKdhEzIySPt9FF7MnspVVSf/hCU342ZLO8t1oX0Wj/sf/t59WcNULrkv9h7Yi
	 ETuvuOOsmSOcYCfqrMUZG2jbGogMwOuBvozjZ5+bja1QE72zYeJy1GTC1dN3acqBGR
	 s1EM4fPyMtiA2JgPAkQQzcuMVGwMveU0/lK2DKCLux/GVnfKTs3LdawYtW/HtP21Kf
	 Rrlcv853z3Szq0Cr/Ratnhxr4UaLJRw5/7AWBv2J4uvvx0neH2q9njEiBsr4Y4rRQA
	 E9sXHH38Rs8mw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFHsg6VQwz4wZw;
	Tue,  1 Aug 2023 11:42:15 +1000 (AEST)
Date: Tue, 1 Aug 2023 11:42:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Guillaume Nault
 <gnault@redhat.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with the net-next
 tree
Message-ID: <20230801114214.2e169762@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SlBZ/wYr8B1uaHmZK/xISTS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  security/security.c

between commit:

  5b52ad34f948 ("security: Constify sk in the sk_getsecid hook.")

from the net-next tree and commit:

  bd1f5934e460 ("lsm: add comment block for security_sk_classify_flow LSM h=
ook")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/security.c
index 2dfc7b9f6ed9,9177fd0968bd..000000000000
--- a/security/security.c
+++ b/security/security.c
@@@ -4396,7 -4421,14 +4421,14 @@@ void security_sk_clone(const struct soc
  }
  EXPORT_SYMBOL(security_sk_clone);
 =20
+ /**
+  * security_sk_classify_flow() - Set a flow's secid based on socket
+  * @sk: original socket
+  * @flic: target flow
+  *
+  * Set the target flow's secid to socket's secid.
+  */
 -void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
 +void security_sk_classify_flow(const struct sock *sk, struct flowi_common=
 *flic)
  {
  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
  }

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTIYvYACgkQAVBC80lX
0GxibAf/V0a39pcCXf9IcteRyqNunHpmz4gxlVi7pAUrGkNWZ5HSGOZqW6YzjcUG
021K7vdkI907fOtYQ78FpckhEykLY2Ibi0iwUezNmd39ycPniL3QTxWzOk6p4N/I
S5CaQfh9Xib03TWFhoNcMOvHY37RpLMXKbii8Njv8M4DwlwVVtrR1fxmFFoezYlO
ehGSZRjaEPLDDLze+hxAZi5XRvwdWYW77GuRwSbqw/letpC3r+0jbe6lP0jVGB3F
BS39zrSDb50l4nN8W6KkIhVSBUckBqgbJlx16VY67aJwov+yTjGqQJCAmgC/Yh7u
RG0MlqdcCrw+aMtIGZi9Sx6XFmzXeg==
=LR5K
-----END PGP SIGNATURE-----

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS--

