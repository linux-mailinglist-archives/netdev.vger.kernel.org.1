Return-Path: <netdev+bounces-31142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B497F78BD7F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 06:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC331C209C5
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 04:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D89ED1;
	Tue, 29 Aug 2023 04:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE5EC5
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:20:53 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65EC10E;
	Mon, 28 Aug 2023 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1693282845;
	bh=LCTwsLZO/y9qXqqJiawbsMLmw2FhrAQ1ReUUz+MpY78=;
	h=Date:From:To:Cc:Subject:From;
	b=GrZFCm9XjjKYh/fR3sKAQal7sQ/+NIpfE4QPChSvNaxQ73qZPS+btAR1TmItLxP5P
	 BYht1sSbLjjY+vBFF0Cr3RWF/puJx7GCNJtD83JINLHqmq8cvv/GlRSm6S90R7Zqez
	 yFeePIJvTdjpHZPyX/+QB3gCibYBOyQE0kX5p/GpLJt59IWv/vbP7Y+uDPIZkD0alV
	 XYaiXJu3Ug+l5PKRz28d1McV+BDIlNkKK1jcO77WAriEmf60jbMX3GtMHhq/uaoALt
	 8sHQBdgyXr3owyqfUxyhCNOY56v50vEwvLY/CIbSoqwz6FW0txiGrSbQIsoXQdW8iM
	 yRMJKplgSHbWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZZ3d3Gg4z4wy0;
	Tue, 29 Aug 2023 14:20:44 +1000 (AEST)
Date: Tue, 29 Aug 2023 14:20:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20230829142043.02a8416a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XAX+jcOo1g04j+hU4K6pv9E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/XAX+jcOo1g04j+hU4K6pv9E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/userspace-api/netlink/netlink-raw.rst:14: WARNING: undefined =
label: 'classic_netlink'

Introduced by commit

  2db8abf0b455 ("doc/netlink: Document the netlink-raw schema extensions")

--=20
Cheers,
Stephen Rothwell

--Sig_/XAX+jcOo1g04j+hU4K6pv9E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtchsACgkQAVBC80lX
0GzX5wf/ay9V4mN/wHWjhMnplOJf8UTF3CJ11glffrJuCeR0yEuRyxJkxV3S00AX
Rz1vuVUJPwecZICfyPGLQmOU3zgey2973j2FpK18qbWw1M6Zrxx6KKK1QFVVvphz
q7mH69JWWS2UKfJJVAbWpjeFB3qwbLN76p6H/8wTkHjBK1QXdO1SJ+ogPjZboO1L
TWcMYKMmSerjqU+8RJgoDbzVpFJdiDUM0/ixJ4RdHPtdzuR+yvPBT0UzFvYVOhKa
1omg1h3BVpPdaIKCk5ohBmgdX1m9dYmIL92xKw2SLI5tkODT52EfP8t7iZJ+v44H
7huSuUz4xw1g85YLYHOV5woR/aK6ig==
=0ITU
-----END PGP SIGNATURE-----

--Sig_/XAX+jcOo1g04j+hU4K6pv9E--

