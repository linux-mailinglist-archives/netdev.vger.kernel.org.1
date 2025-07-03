Return-Path: <netdev+bounces-203908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B63AF7FE8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A849A4E7F60
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7082F6FA2;
	Thu,  3 Jul 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="CyhmBNlk"
X-Original-To: netdev@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4B2F5C38;
	Thu,  3 Jul 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566884; cv=none; b=U1xVoBJpUArW+5HWuyMxmwx9hKEO9nLuvN3DDOQEzyr+FgcmlX/HKk+AM9SE7PcrbyR4AiWhfDmIO+ktwIzDZORoFU4PklBxlUMuz0PjQhwh+I24l3bc0w0EMFjTcj0jsoM8D3e49CAh4d+3kYhEP06D6gQMWJCXuKwgS0t879E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566884; c=relaxed/simple;
	bh=3k4foJwiSwCxZ5Vjm6odRPJ35c0stk5RDqto91j+ZoA=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J1+sW6lXI3YHr3D4zZNIroqEHq1gDLwqm998FinpQpRoB4OJXYb5gG2BEsjDqJuwRIGd2UQpYo8wu0ElnUssKbNXbX6IiCbeXMbA2qbjcnxUSJQfaj59CYBgByuIBZ5rbQmJvfAMsvbeUVUWZz1BXr2P4r6Ch2nMnUTeLGAsloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=CyhmBNlk; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566880;
	bh=3k4foJwiSwCxZ5Vjm6odRPJ35c0stk5RDqto91j+ZoA=;
	h=Date:From:Cc:Subject:From;
	b=CyhmBNlk6BYwYmpW+amx/cud/qS87ltU4KWbQUomjWyLqkFv4gR7jEieOPV9eWagP
	 VTKP8aWF+ML8WLfxaLrrTBVd9f1gL/3HABIkzOqGQgNdAvojmhkdCF8FOhmlXclOHY
	 5nNbbzOPpb7EZYV2XOtvh3aFj0ECrWkiJjtFV9QeQPXTr9dJM2p0YGdgvcYgUHRqSw
	 N7+PaZBfzxgEYKHr86O/J66aJhgyEDH+/8hy89arLRIlXc6XPJuB9EnTSJIjDf1fba
	 vrM6AZ3aRYW/BGrWcNE0MC9rIYkBakZwFthyfHa2cCj102GjSNRnxPQtoWPNJDFv7V
	 5R6spGXoMeZUA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A58AF6B8;
	Thu,  3 Jul 2025 20:21:20 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:20 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] gve: global: fix "for a while" typo
Message-ID: <5zsbhtyox3cvbntuvhigsn42uooescbvdhrat6s3d6rczznzg5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brwvz2pc7ut54udy"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--brwvz2pc7ut54udy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_rx_dqo.c
index dcb0545baa50..6a0be54f1c81 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -608,7 +608,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct =
gve_rx_ring *rx,
 	buf_len =3D compl_desc->packet_len;
 	hdr_len =3D compl_desc->header_len;
=20
-	/* Page might have not been used for awhile and was likely last written
+	/* Page might have not been used for a while and was likely last written
 	 * by a different thread.
 	 */
 	if (rx->dqo.page_pool) {
--=20
2.39.5

--brwvz2pc7ut54udy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyiAACgkQvP0LAY0m
WPH6pQ//RLNMtsmQwFFeA/nb3vlKUFkUf+m8JHRjZwElO9B+Vzwn7yx4URWCTjME
wKnrnbZXNrNhqAPledUCvAXvyNKT6Q46YA5xcaLZEKBZbAv1jYYcQmfRMgpu5wj7
xncfvW5e/2Dq7ik4HQf1u3gXaMhfE4XspnViRyje+EAcR6XWpBUlaH7LytqE+OFG
kZDeRmTuhAx97J19P5bCDOeqKXrW7tejTO2Rz/PNDnT7ZQP0MrsD8zPKXuiIFGE8
sX3kVcri0jNw/wZ2EtLHMAXf3jK/YtXZ61leydBfec0mhKt5Qi5qDwrUMLsazRWX
+VnLdbQpbExAN3WCiBqYQ8lh/piJQfTF55bJCg/MyVEoAziCBjr/7Xvs1fENq3OZ
tH4vegKG+uxxGCknbKM+9IeUdVkGOhhB2nG5lBOKH+IPotuipM252l9ptJynvqK0
sDhbTNiT5FKKYqf/IuTQ7Gc+76myJ1IK67oo4m1qSFoEmmsvyFaqoFmujP1syegc
tA72TlmCUKWHFcvV8Vzqy3Cws2zXpLGH3eZ2aRKIGXMwFiDMY77ZIyks3+eh4YUX
E3LxsuxOku92a9BqG77FgUuO4VYSxKG7XLtNWa2Ws1HF78hXS7ITasLznb/gReLr
L33O8NQ3c2D1v20Oswjp/3hULrWiRGwHPl+0pcPROmmygHLblVo=
=+FX2
-----END PGP SIGNATURE-----

--brwvz2pc7ut54udy--

