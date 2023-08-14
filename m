Return-Path: <netdev+bounces-27526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820E77C3CF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B86A2812B1
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7EA938;
	Mon, 14 Aug 2023 23:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DA8BEB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:16:05 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B3172B;
	Mon, 14 Aug 2023 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1692054959;
	bh=Rqwi+zhP25P2IBqIce94uQvoB6n5hoS4LMZG7sj7Ap4=;
	h=Date:From:To:Cc:Subject:From;
	b=ffV0ykxLqGNPH4dh+84NiGngqCTMbo+2tNbfhqwMtSbPABllKPuu5Lq7iumV4j3Ab
	 0HNbJfm5j/SgF3V5QV9gF6AFrwhXfri25TwUJ5EGgzt+iMnPW46tSppoynynPUTK4D
	 61c3mbOq604iagggpEiQDtZQ5w24jOzuPSjiEidm97Nyj7f0W3s/Qeehe9XwC0HWmj
	 r5HkUK51gpCB20c9b/o0XChTH1pZCuEtzzE+TSoZWI0uOkHFXJQeVWQYbzDjiql58a
	 RIbcjyFIHLJhklX2SZhyqmfZFeh/rEKOZi176/lRTVBDZ79mmEP8w8uy6wgQ8qqSqK
	 AGVErQlrsQjSg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqyR2kH9z4wZt;
	Tue, 15 Aug 2023 09:15:58 +1000 (AEST)
Date: Tue, 15 Aug 2023 09:15:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, "Lee, Chun-Yi"
 <joeyli.kernel@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20230815091558.1fd17d91@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1ybRByEC+YDFe5DIDgspPge";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/1ybRByEC+YDFe5DIDgspPge
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9c33663af9ad ("Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in H=
CIUARTGETPROTO")

is missing a Signed-off-by from its author.

Actually I assume that the SOB and the Author Email metadata are just
using two different email addresses.

--=20
Cheers,
Stephen Rothwell

--Sig_/1ybRByEC+YDFe5DIDgspPge
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTata4ACgkQAVBC80lX
0GxD3gf+NWSARlPf9sBg/5ITGVkyMLPUioqAUn1A9tVNXLJ74X/kEsJ98IFKctjE
HYgA+UohqbeZO9iza5VKgJ6DmbA8DOQ1sWnypFOCVq7VQOKzy7252QyPSywl/OjD
jOrjSRcuGL6LJY9DMsBPTk3piQN2k2ZCkNrTFMdA7B0DzloMKEP9OHPMz+STP6Pr
1rdZcZ5MDihsYSmZnTL+ZNtoF8uTKgShT75yrAs9Nx6b4OWBFGwG+ZY34NkJxSTX
Gl16mBpPjgV5LI+AdCVzlAQAX7WAnnwN9C+AbN5FMifIAANWLslT8cyQZHCPaS67
VL7nGtMxjdMKsMBOR5q8pOtk8z66MA==
=uRnT
-----END PGP SIGNATURE-----

--Sig_/1ybRByEC+YDFe5DIDgspPge--

