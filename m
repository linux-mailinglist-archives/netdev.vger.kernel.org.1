Return-Path: <netdev+bounces-248481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFF5D09726
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E2683034F3A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929A35A952;
	Fri,  9 Jan 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gIHmK+AR"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55032F748
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960800; cv=none; b=LQDcU4/2aYSZHFvzpMJheO8pqTzB1EkNODNgGVSnHPXRh48MC4r/GyfOqSuq+ZVAPxzUT4FIkz3yvmhavdvryD+hjidDskpwkjiteHj+HzGt0m9QXb9Hy9/+hVcxNV8A2HEij43RXq9vdiU/YkvHRcPPK1Z3TrB0DLhP4Ju2vHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960800; c=relaxed/simple;
	bh=0yIboiZ8laNJ/CNq79lvdYNX16Y4FwxBgDWahMAFWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvRzMDoZOopTCkTBSoBZuj8z2q6Qm6bBsb9eADIAtoM9jLbJ91pUR3NnsuZQPx1mmgzCJnykvs6rHqiVWZ/RxweB0QrK1aC9MLdzqq2KHZakXkKrRw3ueBtxnOrCcp/jknPW+zArfgX+Gu1lni/jnlIae7BY5GPhHO5nf4TqTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gIHmK+AR; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767960787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EETQ3C2Ap/oA0jEy2/KTMPkQ1GCOoyHzuFkFxZNtMb8=;
	b=gIHmK+AR693tXzNTKjXokpseT5ImWVGflJPzyf7iM6EvDZ0XU4K6aItdnleZuNziD3t5HK
	hptCgc1ZaE9xz6vyuiqerswDansfn3niL4ajhMmpyBg6rKGBpwwMF3rSavh3mWcZWki6Yl
	R6d6b1JsaaqVwMfczgZNExdV7WIzmg4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: ipconfig: Remove outdated comment and indent code block
Date: Fri,  9 Jan 2026 13:11:29 +0100
Message-ID: <20260109121128.170020-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The comment has been around ever since commit 1da177e4c3f4
("Linux-2.6.12-rc2") and can be removed. Remove it and indent the code
block accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Move const definition to the top (Paolo)
- Format ternary expression
- Link to v1: https://lore.kernel.org/lkml/20251220130335.77220-1-thorsten.blum@linux.dev/
---
 net/ipv4/ipconfig.c | 89 +++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 019408d3ca2c..b1e1be00ff8b 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -679,8 +679,18 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 static void __init
 ic_dhcp_init_options(u8 *options, struct ic_device *d)
 {
-	u8 mt = ((ic_servaddr == NONE)
-		 ? DHCPDISCOVER : DHCPREQUEST);
+	static const u8 ic_req_params[] = {
+		1,	/* Subnet mask */
+		3,	/* Default gateway */
+		6,	/* DNS server */
+		12,	/* Host name */
+		15,	/* Domain name */
+		17,	/* Boot path */
+		26,	/* MTU */
+		40,	/* NIS domain name */
+		42,	/* NTP servers */
+	};
+	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
 	u8 *e = options;
 	int len;
 
@@ -705,51 +715,36 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		e += 4;
 	}
 
-	/* always? */
-	{
-		static const u8 ic_req_params[] = {
-			1,	/* Subnet mask */
-			3,	/* Default gateway */
-			6,	/* DNS server */
-			12,	/* Host name */
-			15,	/* Domain name */
-			17,	/* Boot path */
-			26,	/* MTU */
-			40,	/* NIS domain name */
-			42,	/* NTP servers */
-		};
-
-		*e++ = 55;	/* Parameter request list */
-		*e++ = sizeof(ic_req_params);
-		memcpy(e, ic_req_params, sizeof(ic_req_params));
-		e += sizeof(ic_req_params);
-
-		if (ic_host_name_set) {
-			*e++ = 12;	/* host-name */
-			len = strlen(utsname()->nodename);
-			*e++ = len;
-			memcpy(e, utsname()->nodename, len);
-			e += len;
-		}
-		if (*vendor_class_identifier) {
-			pr_info("DHCP: sending class identifier \"%s\"\n",
-				vendor_class_identifier);
-			*e++ = 60;	/* Class-identifier */
-			len = strlen(vendor_class_identifier);
-			*e++ = len;
-			memcpy(e, vendor_class_identifier, len);
-			e += len;
-		}
-		len = strlen(dhcp_client_identifier + 1);
-		/* the minimum length of identifier is 2, include 1 byte type,
-		 * and can not be larger than the length of options
-		 */
-		if (len >= 1 && len < 312 - (e - options) - 1) {
-			*e++ = 61;
-			*e++ = len + 1;
-			memcpy(e, dhcp_client_identifier, len + 1);
-			e += len + 1;
-		}
+	*e++ = 55;	/* Parameter request list */
+	*e++ = sizeof(ic_req_params);
+	memcpy(e, ic_req_params, sizeof(ic_req_params));
+	e += sizeof(ic_req_params);
+
+	if (ic_host_name_set) {
+		*e++ = 12;	/* host-name */
+		len = strlen(utsname()->nodename);
+		*e++ = len;
+		memcpy(e, utsname()->nodename, len);
+		e += len;
+	}
+	if (*vendor_class_identifier) {
+		pr_info("DHCP: sending class identifier \"%s\"\n",
+			vendor_class_identifier);
+		*e++ = 60;	/* Class-identifier */
+		len = strlen(vendor_class_identifier);
+		*e++ = len;
+		memcpy(e, vendor_class_identifier, len);
+		e += len;
+	}
+	len = strlen(dhcp_client_identifier + 1);
+	/* the minimum length of identifier is 2, include 1 byte type,
+	 * and can not be larger than the length of options
+	 */
+	if (len >= 1 && len < 312 - (e - options) - 1) {
+		*e++ = 61;
+		*e++ = len + 1;
+		memcpy(e, dhcp_client_identifier, len + 1);
+		e += len + 1;
 	}
 
 	*e++ = 255;	/* End of the list */
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


