Return-Path: <netdev+bounces-146021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD59D1B5B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66957281D9D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677A1E883E;
	Mon, 18 Nov 2024 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="mkDNjK+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24731E9060;
	Mon, 18 Nov 2024 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970773; cv=none; b=Ph1Cuq9SPNqn8KbGkb28JvUPqMysUCUSbRBsCz76Kwm22sgBA9CE3ZoHESXTyKLigdHRHCezW5EVbBRwAOlhgb0EvBRwNaL+VJCNZePxiUCT3QyT5imeD0aiGKjCu+xvoeqEKWCvHfNnGMEiZsPOZeCUDH25VBnGegYBWweDnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970773; c=relaxed/simple;
	bh=uOCkzoSHiJAiDYZFusLJ9OBEz5FlpCa8Y8HqQeFA+1E=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=OVITbaoftdxUt82XywAxYeLizq6miGyg0SJyHWJICMF/Pr2n8U26/wN+5PzbWZJ1a4tsPr4BHEoDZHB1BiAmEI68jWi1iUSHvyzmcZRe9Ew2V6ShGZPPej2ixj3q4ZBckv8eDUiabelmTwyRrFSRD3kCWHXZuj00qif7TNIRwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=mkDNjK+5; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1731970770; x=1763506770;
  h=from:date:cc:to:mime-version:message-id:subject:
   content-transfer-encoding;
  bh=uOCkzoSHiJAiDYZFusLJ9OBEz5FlpCa8Y8HqQeFA+1E=;
  b=mkDNjK+5oXGMcneWBxWlDF1RyrVVErgT9wLKAnXgL+nCS4bvldQeQPlS
   keDwWycSrJumxOhOJOaj5mbGs/xCqvffXpATG4C/PKBuJtxKJvTzoG/8c
   dWvmVkJKfWi/E0QrVrNLh/taPsv18i9hAuCVy2d0RsZeK1yfO6CfbJ31G
   U=;
X-CSE-ConnectionGUID: kke0BuBSRh+JtWNKrNCVXw==
X-CSE-MsgGUID: 74tnPZa7RO2m9bpH3+iY2Q==
X-IronPort-AV: E=Sophos;i="6.12,165,1728943200"; 
   d="scan'208";a="27706713"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 18 Nov 2024 23:58:18 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
Date: Mon, 18 Nov 2024 23:58:18 +0100
Cc: =?utf-8?q?Jason_A=2E_Donenfeld?= <Jason@zx2c4.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, =?utf-8?q?David_S=2E_Miller?= <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
To: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15e782-673bc680-4ed-422b5480@29006332>
Subject: [PATCH] =?utf-8?q?wireguard-tools=3A?= Extracted error message for the sake 
 of legibility
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hello,

This is a reminder about a patch sent to the WireGuard mailing list; CC=
ing the maintainers of drivers/net/wireguard/; below a verbatim of my c=
over letter.

Thank you,

**

I have been using WireGuard for some time; it does ease the configurati=
on of
VPNs. This is my first patch to the list, I asked to be subscribed; ple=
ase
confirm me it is the case.

I would like to improve my C programming skills; your feedback will be =
much
appreciated.

Ariel

-------- Original Message --------
Subject: [PATCH] wireguard-tools: Extracted error message for the sake =
of legibility
Date: Thursday, August 01, 2024 11:43 CEST
From: Ariel Otilibili <Ariel.Otilibili-Anieli@eurecom.fr>
Reply-To: Ariel Otilibili <Ariel.Otilibili-Anieli@eurecom.fr>

To: wireguard@lists.zx2c4.com
CC: "Jason A . Donenfeld" <Jason@zx2c4.com>,	Ariel Otilibili <Ariel.Oti=
libili-Anieli@eurecom.fr>

References: <20240725204917.192647-2-otilibil@eurecom.fr> <202408010949=
32.4502-1-otilibil@eurecom.fr>



Signed-off-by: Ariel Otilibili <otilibil@eurecom.fr>
---
 src/set.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/set.c b/src/set.c
index 75560fd..b2fbd54 100644
--- a/src/set.c
+++ b/src/set.c
@@ -16,9 +16,19 @@ int set=5Fmain(int argc, const char *argv[])
 {
 	struct wgdevice *device =3D NULL;
 	int ret =3D 1;
+	const char *error=5Fmessage =3D "Usage: %s %s <interface>"
+	  " [listen-port <port>]"
+	  " [fwmark <mark>]"
+	  " [private-key <file path>]"
+	  " [peer <base64 public key> [remove]"
+	  " [preshared-key <file path>]"
+	  " [endpoint <ip>:<port>]"
+	  " [persistent-keepalive <interval seconds>]"
+	  " [allowed-ips <ip1>/<cidr1>[,<ip2>/<cidr2>]...]"
+	  " ]...\n";
=20
 	if (argc < 3) {
-		fprintf(stderr, "Usage: %s %s <interface> [listen-port <port>] [fwma=
rk <mark>] [private-key <file path>] [peer <base64 public key> [remove]=
 [preshared-key <file path>] [endpoint <ip>:<port>] [persistent-keepali=
ve <interval seconds>] [allowed-ips <ip1>/<cidr1>[,<ip2>/<cidr2>]...] ]=
...\n", PROG=5FNAME, argv[0]);
+		fprintf(stderr, error=5Fmessage, PROG=5FNAME, argv[0]);
 		return 1;
 	}
=20
--=20
2.45.2


