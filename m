Return-Path: <netdev+bounces-78780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2438766DD
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA962B20EB6
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91F210D;
	Fri,  8 Mar 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eQgEmHwu"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39B4C65
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909885; cv=none; b=gFCGQstfj6tx7cwZOi8cghM6Vk9ia07ZnAfajHayN7QDE/payIawnFNOM/1pZRAkw25DwNYFMPExYDEZJbZ0Ml3Cw7YFLEQr4pe6fI777A23lRE5M6RXLV67kajGYFhU2NLu6PHVOge92kPMq0iqKkkgNAzIejphwrqbbNshbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909885; c=relaxed/simple;
	bh=PZ8/6eusF8uJV8HvA4Al6hFAOMy1hSTUnHoawNc+0rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIQn2n6MWcsDT2dZ8g8pI4GCAWCoZ7/vOhTGZQngmlULKFQnV3LZpPNFF7aqQPCZ7qKLVNFGLEdp91O2FprANkKmaQZhy9P0TFIzfs7+REwWVLcPI2gLv2bYVqluEodRB6AuYR+R7yEiz9YdcDqXCK5ot6v76iWLq/6E3c+RToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eQgEmHwu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B0C5187EEB;
	Fri,  8 Mar 2024 15:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709909876;
	bh=zOTtHZLaluwpGR8u0fZdBK1uOy/fTX/hHRdfA7HnP9s=;
	h=From:To:Cc:Subject:Date:From;
	b=eQgEmHwucBWZVPNIPZrmS8k5cEUx1F+nhJwjInOBcD+UvaPBWgrkhf12kPv/z8lxo
	 TLTph3ybsPBvRMHp+98EoIz64HIoP4r7x0TgLZd9qb2ElLZFLhVe3k4I+ViVzKyjeR
	 XOCTMFo/J13WfdTxoKJaeP4ULjZhfWmb99amiPGzb4+JlNSqjvNkKojP0vZ2MDmn2e
	 d7dAiaZ/s76h651Gc6GesEZciX0pUcs/YLpsQvya2v1hcOWFyZGZA8eAC5tikbxUoh
	 AhEBiqG1vE1SVBWINOnUm9E1e2TFI1CtdvzVgHBm/9z5IMzN5YyNuvFUeSU4oFSQ/i
	 iwck5v7CMPXQQ==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] ip link: hsr: Add support for passing information about INTERLINK device
Date: Fri,  8 Mar 2024 15:57:29 +0100
Message-Id: <20240308145729.490863-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The HSR capable device can operate in two modes of operations -
Doubly Attached Node for HSR (DANH) and RedBOX.

The latter one allows connection of non-HSR aware device to HSR network.
This node is called SAN (Singly Attached Network) and is connected via
INTERLINK network device.

This patch adds support for passing information about the INTERLINK device,
so the Linux driver can properly setup it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:

- Rebase the patch on top of iproute2-next/main repo
- Replace matches() with strcmp() when interlink
- Use print_color_string() instead of just print_string()
---
 ip/iplink_hsr.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index 76f24a6a..dc802ed9 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -21,12 +21,15 @@ static void print_usage(FILE *f)
 {
 	fprintf(f,
 		"Usage:\tip link add name NAME type hsr slave1 SLAVE1-IF slave2 SLAVE2-IF\n"
-		"\t[ supervision ADDR-BYTE ] [version VERSION] [proto PROTOCOL]\n"
+		"\t[ interlink INTERLINK-IF ] [ supervision ADDR-BYTE ] [ version VERSION ]\n"
+		"\t[ proto PROTOCOL ]\n"
 		"\n"
 		"NAME\n"
 		"	name of new hsr device (e.g. hsr0)\n"
 		"SLAVE1-IF, SLAVE2-IF\n"
 		"	the two slave devices bound to the HSR device\n"
+		"INTERLINK-IF\n"
+		"	the interlink device bound to the HSR network to connect SAN device\n"
 		"ADDR-BYTE\n"
 		"	0-255; the last byte of the multicast address used for HSR supervision\n"
 		"	frames (default = 0)\n"
@@ -82,6 +85,12 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (ifindex == 0)
 				invarg("No such interface", *argv);
 			addattr_l(n, 1024, IFLA_HSR_SLAVE2, &ifindex, 4);
+		} else if (strcmp(*argv, "interlink") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+			if (ifindex == 0)
+				invarg("No such interface", *argv);
+			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
 		} else if (matches(*argv, "help") == 0) {
 			usage();
 			return -1;
@@ -109,6 +118,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_HSR_SLAVE2] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
 		return;
+	if (tb[IFLA_HSR_INTERLINK] &&
+	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
+		return;
 	if (tb[IFLA_HSR_SEQ_NR] &&
 	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
 		return;
@@ -132,6 +144,10 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	else
 		print_null(PRINT_ANY, "slave2", "slave2 %s ", "<none>");
 
+	if (tb[IFLA_HSR_INTERLINK])
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "interlink", "interlink %s ",
+				   ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
+
 	if (tb[IFLA_HSR_SEQ_NR])
 		print_int(PRINT_ANY,
 			  "seq_nr",
-- 
2.20.1


