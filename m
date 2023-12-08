Return-Path: <netdev+bounces-55433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE1380AD9C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7612815D0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBD5026C;
	Fri,  8 Dec 2023 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="W+X9ycCP"
X-Original-To: netdev@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A024123;
	Fri,  8 Dec 2023 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702066573;
	bh=7zDeKbPJAl8AvhFTIblAERkOHIfqFDPfl1Vqvi+CM28=;
	h=Date:From:Cc:Subject:From;
	b=W+X9ycCPgPivkQ0xTjz3ETf8qpk/Cxu4J6Vg2JQhBpjRmP1lNSkZf4BPBtvnQbwDY
	 Royly5AZaJXiyGhGbVwk3ETPaZrGvxf2j/Oo+qJ8G7fkNhnFATOatdA+lIlF4JN44H
	 1/j7sAR4xw2ltYDjdQ29EeF0Q2NCaMWqSoOBqB3o5L+1MQXYtzDmoDvjueczP4rZv9
	 0JSWbPGrGjvz5GY9/lkGLW/L/yMUjn1U6PxwPTToEFdroBY5RYp/rwnL8pnk4zDVGh
	 3lFVWURv+VeRo323GYjXILeFN8K5VjVsCbAnXD70Xu379ozRzmOxZ1L0+DHay4S1CG
	 u+SpOkmV10qQw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0971C12FD2;
	Fri,  8 Dec 2023 21:16:13 +0100 (CET)
Date: Fri, 8 Dec 2023 21:16:12 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: dns_resolver: the module is called dns_resolver, not
 dnsresolver
Message-ID: <gh4sxphjxbo56n2spgmc66vtazyxgiehpmv5f2gkvgicy6f4rs@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4764cojxptaryfum"
Content-Disposition: inline
User-Agent: NeoMutt/20231103


--4764cojxptaryfum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

$ modinfo dnsresolver dns_resolver | grep name
modinfo: ERROR: Module dnsresolver not found.
filename: /lib/modules/6.1.0-9-amd64/kernel/net/dns_resolver/dns_resolver.ko
name:     dns_resolver

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/dns_resolver/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/Kconfig b/net/dns_resolver/Kconfig
index 155b06163409..7c2dba273e35 100644
--- a/net/dns_resolver/Kconfig
+++ b/net/dns_resolver/Kconfig
@@ -23,6 +23,6 @@ config DNS_RESOLVER
 	  information.
=20
 	  To compile this as a module, choose M here: the module will be called
-	  dnsresolver.
+	  dns_resolver.
=20
 	  If unsure, say N.
--=20
2.39.2

--4764cojxptaryfum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVzeYwACgkQvP0LAY0m
WPGq3Q//Yj2fnDiiF2TEh3GLe/6/OTPVutSLxCXYS3p2Ii+rrwqnxji/CxWMYvTi
DqSlbAncQ1TAMuPfPSvUxf/e04vWHF8rcyPSck3ZKvlILLmai2O62iENbUx2Cchq
UkjZ2vjCmWQoI6B7L7tI9p6vwQaL+XzuHHIKR186ip+vAFak+bs26kZe4J39l7XH
AjXpbzpNXvNRqZXRxi8utCkpG2mBPejFq+I2YllXp3SHYZ07bipq49tOvKJBqlY3
yl0M2DrIgmPTHN+KNgTid35SJ0gfo1TMmwCy2JXSY1jDKBrTFpo1S3KDREcm04MY
B6Dipsz6x8OGvHiY1s0Iis/Wxm+gl203IaelAVBrpe2A/eepYyWIzI/tCth7RxgY
ZzVakkOnvhAu9PlUXJaHcMTrazBs86stc11zoOyo/TlHICBPMb1vT8P6IPncszRQ
HDpDep9uufgtjkmgbEwy5wGOeSGsEvBlXRc70aQ3KWuOeOt5Y8uoPTR5TP/hFjBe
OQ9bzg7a6nK9+VC/hTdiZeFa2dtvKnU6U4eONefHvoKtHwy6YEONZ+AXi76ReQ+j
T5OEBT8TPMMPEmVws3KJctF+d3okdPKOJ3HvL2wuuBTG+6QN/mzfuqDY8E/VNMRy
FHGxrbeLozJQbnZLhRD9mKMHF/9BZ9EHPj/ee3md0CPPOFfkTCQ=
=KQCC
-----END PGP SIGNATURE-----

--4764cojxptaryfum--

