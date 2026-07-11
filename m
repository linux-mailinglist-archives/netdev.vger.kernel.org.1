Return-Path: <netdev+bounces-306799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nQeQI74TUmoYLwMAu9opvQ
	(envelope-from <netdev+bounces-306799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:58:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C57077411F7
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=KZJ8MgYz;
	dmarc=pass (policy=none) header.from=wp.pl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306799-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336FD3012264
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1C34AB03;
	Sat, 11 Jul 2026 09:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7B15687D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763899; cv=none; b=lMopeofTjw4BTZ6aehEnIhXREkaEwLIZ77JhvQzx9pOKNuQNjhXR4cfhDkUY8RkpdRzzHYBKgthhh9wSTerxH7OIDnh+Dr4VUuY79c+bAIcnmIVSxLJ5/4rFcwr5qQDnlyvU8RUPIpjzFCIZZr7cisbzVkMK14N4RwCBn9zCYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763899; c=relaxed/simple;
	bh=bmdc28A+pL+8OoTA1jVuf91WiD85kjg1Jqt9oBMs4+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFZjyt9ro4KnJSaNCtUAFTIcLy2QHbM6CJIl3OpCVnD1i0LOWZgPtCGE7xmiqXG9aqCFMa7+D9LDkfOSB1yIODMz2Tr+IuQfJiUxbtIMFcXzxiG6ew6f3x3hvgLxLKvRPtWWXe/6SfGdG5me6oU2KPBV6gYY3wpptyPF8gCwwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=KZJ8MgYz; arc=none smtp.client-ip=212.77.101.9
Received: (wp-smtpd smtp.wp.pl 20559 invoked from network); 11 Jul 2026 11:58:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1783763887; bh=/VkLV5SqF1W+5fMfTVjHiHWNpG5/USVlUpFXjZKHJQY=;
          h=From:To:Cc:Subject;
          b=KZJ8MgYz4EwChK7pGSNShi4Cxs+I6n1nen4/kvsT2oUeNgBY0FXYkl+a/AKY0vudJ
           ym+SXOD2FQviOS8/vs5+rhX/FxOYCZXwfkS9cmBINSRLEb9l+/3WGt1njy3re0cIdC
           HzGEV48D/W9gd06s2YH3H4zE5a/XKLRrTFzpKoZRlMH0uJkBzIYXIeU3gvOY4qGAAd
           NxIh0Z+EhwHR1oa5pULZOOgFPxPHjOllDycsQENtBOF5jb1nZpJf+TqIxnqh5amygt
           sQ07e6aYS0u4zYTqsl2oXdrnU4Kxr0GaB3v/QO5A2U7mjfOEA0WyW6Sm0n245voCxj
           AdCTo0W6MKPIw==
Received: from 83.24.36.106.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.36.106])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <danieller@nvidia.com>; 11 Jul 2026 11:58:07 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: danieller@nvidia.com,
	mkubecek@suse.cz,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jbe@pengutronix.de,
	netdev@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH ethtool-next v2 2/2] sfpid: print all compliance codes
Date: Sat, 11 Jul 2026 11:54:22 +0200
Message-ID: <20260711095803.257213-2-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711095803.257213-1-olek2@wp.pl>
References: <20260711095803.257213-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 0ed0ed1f8251b947245cc3e9f661b27b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QbPx]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306799-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:danieller@nvidia.com,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jbe@pengutronix.de,m:netdev@vger.kernel.org,m:olek2@wp.pl,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C57077411F7

SFP modules implement multiple compliance codes. This is common for
dual-rate modules. Before the `json` option was introduced, all
compliance codes were displayed. Currently, only the last code is
displayed. This commit fixes that bug. Compliance codes are
represented as array.

Before:
$ ethtool -m sfp-wan
...
	Transceiver codes                         : 0x00 0x00 0x00 0x01 0x20 0x40 0x0c 0x15 0x00
	Transceiver type                          : FC: 100 MBytes/sec
...
$ ethtool --json -m sfp-wan
[ {
...
        "transceiver_codes": [ 0,0,0,1,32,64,12,21,0 ],
        "transceiver_type": "FC: 100 MBytes/sec",
...
    } ]

After:
$ ethtool -m sfp-wan
...
	Transceiver codes                         : 0x00 0x00 0x00 0x01 0x20 0x40 0x0c 0x15 0x00
	Transceiver type                          : Ethernet: 1000BASE-SX
	Transceiver type                          : FC: intermediate distance (I)
	Transceiver type                          : FC: Shortwave laser w/o OFC (SN)
	Transceiver type                          : FC: Multimode, 62.5um (M6)
	Transceiver type                          : FC: Multimode, 50um (M5)
	Transceiver type                          : FC: 400 MBytes/sec
	Transceiver type                          : FC: 200 MBytes/sec
	Transceiver type                          : FC: 100 MBytes/sec
...
$ ethtool --json -m sfp-wan
[ {
...
        "transceiver_codes": [ 0,0,0,1,32,64,12,21,0 ],
        "transceiver_type": [ "Ethernet: 1000BASE-SX","FC: intermediate distance (I)","FC: Shortwave laser w/o OFC (SN)","FC: Multimode, 62.5um (M6)","FC: Multimode, 50um (M5)","FC: 400 MBytes/sec","FC: 200 MBytes/sec","FC: 100 MBytes/sec" ],
...
    } ]

Fixes: 4071862f58d8 ("sfpid: Add JSON output handling to --module-info in SFF8079 modules")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
Changes in v2:
 - drop </pre> leftover
 - use single sfp module in Before/After
 - rename module_print_array_string() -> module_print_any_array_string_entry()
---
 sfpid.c | 291 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 187 insertions(+), 104 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index ec5dd95..25ddd57 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -50,7 +50,6 @@ static void sff8079_show_connector(const __u8 *id)
 static void sff8079_show_transceiver(const __u8 *id)
 {
 	static const char *pfx = "Transceiver type";
-	char value[140] = "";
 
 	if (is_json_context()) {
 		open_json_array("transceiver_codes", "");
@@ -70,242 +69,326 @@ static void sff8079_show_transceiver(const __u8 *id)
 		       "Transceiver codes", id[3], id[4], id[5], id[6],
 		       id[7], id[8], id[9], id[10], id[36]);
 	}
+
+	if (is_json_context())
+		open_json_array("transceiver_type", "");
+
 	/* 10G Ethernet Compliance Codes */
 	if (id[3] & (1 << 7))
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"10G Ethernet: 10G Base-ER [SFF-8472 rev10.4 onwards]");
 	if (id[3] & (1 << 6))
-		sprintf(value, "%s", "10G Ethernet: 10G Base-LRM");
+		module_print_any_array_string_entry(pfx,
+			"10G Ethernet: 10G Base-LRM");
 	if (id[3] & (1 << 5))
-		sprintf(value, "%s", "10G Ethernet: 10G Base-LR");
+		module_print_any_array_string_entry(pfx,
+			"10G Ethernet: 10G Base-LR");
 	if (id[3] & (1 << 4))
-		sprintf(value, "%s", "10G Ethernet: 10G Base-SR");
+		module_print_any_array_string_entry(pfx,
+			"10G Ethernet: 10G Base-SR");
 	/* Infiniband Compliance Codes */
 	if (id[3] & (1 << 3))
-		sprintf(value, "%s", "Infiniband: 1X SX");
+		module_print_any_array_string_entry(pfx,
+			"Infiniband: 1X SX");
 	if (id[3] & (1 << 2))
-		sprintf(value, "%s", "Infiniband: 1X LX");
+		module_print_any_array_string_entry(pfx,
+			"Infiniband: 1X LX");
 	if (id[3] & (1 << 1))
-		sprintf(value, "%s", "Infiniband: 1X Copper Active");
+		module_print_any_array_string_entry(pfx,
+			"Infiniband: 1X Copper Active");
 	if (id[3] & (1 << 0))
-		sprintf(value, "%s", "Infiniband: 1X Copper Passive");
+		module_print_any_array_string_entry(pfx,
+			"Infiniband: 1X Copper Passive");
 	/* ESCON Compliance Codes */
 	if (id[4] & (1 << 7))
-		sprintf(value, "%s", "ESCON: ESCON MMF, 1310nm LED");
+		module_print_any_array_string_entry(pfx,
+			"ESCON: ESCON MMF, 1310nm LED");
 	if (id[4] & (1 << 6))
-		sprintf(value, "%s", "ESCON: ESCON SMF, 1310nm Laser");
+		module_print_any_array_string_entry(pfx,
+			"ESCON: ESCON SMF, 1310nm Laser");
 	/* SONET Compliance Codes */
 	if (id[4] & (1 << 5))
-		sprintf(value, "%s", "SONET: OC-192, short reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-192, short reach");
 	if (id[4] & (1 << 4))
-		sprintf(value, "%s", "SONET: SONET reach specifier bit 1");
+		module_print_any_array_string_entry(pfx,
+			"SONET: SONET reach specifier bit 1");
 	if (id[4] & (1 << 3))
-		sprintf(value, "%s", "SONET: SONET reach specifier bit 2");
+		module_print_any_array_string_entry(pfx,
+			"SONET: SONET reach specifier bit 2");
 	if (id[4] & (1 << 2))
-		sprintf(value, "%s", "SONET: OC-48, long reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-48, long reach");
 	if (id[4] & (1 << 1))
-		sprintf(value, "%s", "SONET: OC-48, intermediate reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-48, intermediate reach");
 	if (id[4] & (1 << 0))
-		sprintf(value, "%s", "SONET: OC-48, short reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-48, short reach");
 	if (id[5] & (1 << 6))
-		sprintf(value, "%s", "SONET: OC-12, single mode, long reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-12, single mode, long reach");
 	if (id[5] & (1 << 5))
-		sprintf(value, "%s", "SONET: OC-12, single mode, inter. reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-12, single mode, inter. reach");
 	if (id[5] & (1 << 4))
-		sprintf(value, "%s", "SONET: OC-12, short reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-12, short reach");
 	if (id[5] & (1 << 2))
-		sprintf(value, "%s", "SONET: OC-3, single mode, long reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-3, single mode, long reach");
 	if (id[5] & (1 << 1))
-		sprintf(value, "%s", "SONET: OC-3, single mode, inter. reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-3, single mode, inter. reach");
 	if (id[5] & (1 << 0))
-		sprintf(value, "%s", "SONET: OC-3, short reach");
+		module_print_any_array_string_entry(pfx,
+			"SONET: OC-3, short reach");
 	/* Ethernet Compliance Codes */
 	if (id[6] & (1 << 7))
-		sprintf(value, "%s", "Ethernet: BASE-PX");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: BASE-PX");
 	if (id[6] & (1 << 6))
-		sprintf(value, "%s", "Ethernet: BASE-BX10");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: BASE-BX10");
 	if (id[6] & (1 << 5))
-		sprintf(value, "%s", "Ethernet: 100BASE-FX");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 100BASE-FX");
 	if (id[6] & (1 << 4))
-		sprintf(value, "%s", "Ethernet: 100BASE-LX/LX10");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 100BASE-LX/LX10");
 	if (id[6] & (1 << 3))
-		sprintf(value, "%s", "Ethernet: 1000BASE-T");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 1000BASE-T");
 	if (id[6] & (1 << 2))
-		sprintf(value, "%s", "Ethernet: 1000BASE-CX");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 1000BASE-CX");
 	if (id[6] & (1 << 1))
-		sprintf(value, "%s", "Ethernet: 1000BASE-LX");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 1000BASE-LX");
 	if (id[6] & (1 << 0))
-		sprintf(value, "%s", "Ethernet: 1000BASE-SX");
+		module_print_any_array_string_entry(pfx,
+			"Ethernet: 1000BASE-SX");
 	/* Fibre Channel link length */
 	if (id[7] & (1 << 7))
-		sprintf(value, "%s", "FC: very long distance (V)");
+		module_print_any_array_string_entry(pfx,
+			"FC: very long distance (V)");
 	if (id[7] & (1 << 6))
-		sprintf(value, "%s", "FC: short distance (S)");
+		module_print_any_array_string_entry(pfx,
+			"FC: short distance (S)");
 	if (id[7] & (1 << 5))
-		sprintf(value, "%s", "FC: intermediate distance (I)");
+		module_print_any_array_string_entry(pfx,
+			"FC: intermediate distance (I)");
 	if (id[7] & (1 << 4))
-		sprintf(value, "%s", "FC: long distance (L)");
+		module_print_any_array_string_entry(pfx,
+			"FC: long distance (L)");
 	if (id[7] & (1 << 3))
-		sprintf(value, "%s", "FC: medium distance (M)");
+		module_print_any_array_string_entry(pfx,
+			"FC: medium distance (M)");
 	/* Fibre Channel transmitter technology */
 	if (id[7] & (1 << 2))
-		sprintf(value, "%s", "FC: Shortwave laser, linear Rx (SA)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Shortwave laser, linear Rx (SA)");
 	if (id[7] & (1 << 1))
-		sprintf(value, "%s", "FC: Longwave laser (LC)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Longwave laser (LC)");
 	if (id[7] & (1 << 0))
-		sprintf(value, "%s", "FC: Electrical inter-enclosure (EL)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Electrical inter-enclosure (EL)");
 	if (id[8] & (1 << 7))
-		sprintf(value, "%s", "FC: Electrical intra-enclosure (EL)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Electrical intra-enclosure (EL)");
 	if (id[8] & (1 << 6))
-		sprintf(value, "%s", "FC: Shortwave laser w/o OFC (SN)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Shortwave laser w/o OFC (SN)");
 	if (id[8] & (1 << 5))
-		sprintf(value, "%s", "FC: Shortwave laser with OFC (SL)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Shortwave laser with OFC (SL)");
 	if (id[8] & (1 << 4))
-		sprintf(value, "%s", "FC: Longwave laser (LL)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Longwave laser (LL)");
 	if (id[8] & (1 << 3))
-		sprintf(value, "%s", "Active Cable");
+		module_print_any_array_string_entry(pfx,
+			"Active Cable");
 	if (id[8] & (1 << 2))
-		sprintf(value, "%s", "Passive Cable");
+		module_print_any_array_string_entry(pfx,
+			"Passive Cable");
 	if (id[8] & (1 << 1))
-		sprintf(value, "%s", "FC: Copper FC-BaseT");
+		module_print_any_array_string_entry(pfx,
+			"FC: Copper FC-BaseT");
 	/* Fibre Channel transmission media */
 	if (id[9] & (1 << 7))
-		sprintf(value, "%s", "FC: Twin Axial Pair (TW)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Twin Axial Pair (TW)");
 	if (id[9] & (1 << 6))
-		sprintf(value, "%s", "FC: Twisted Pair (TP)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Twisted Pair (TP)");
 	if (id[9] & (1 << 5))
-		sprintf(value, "%s", "FC: Miniature Coax (MI)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Miniature Coax (MI)");
 	if (id[9] & (1 << 4))
-		sprintf(value, "%s", "FC: Video Coax (TV)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Video Coax (TV)");
 	if (id[9] & (1 << 3))
-		sprintf(value, "%s", "FC: Multimode, 62.5um (M6)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Multimode, 62.5um (M6)");
 	if (id[9] & (1 << 2))
-		sprintf(value, "%s", "FC: Multimode, 50um (M5)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Multimode, 50um (M5)");
 	if (id[9] & (1 << 0))
-		sprintf(value, "%s", "FC: Single Mode (SM)");
+		module_print_any_array_string_entry(pfx,
+			"FC: Single Mode (SM)");
 	/* Fibre Channel speed */
 	if (id[10] & (1 << 7))
-		sprintf(value, "%s", "FC: 1200 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 1200 MBytes/sec");
 	if (id[10] & (1 << 6))
-		sprintf(value, "%s", "FC: 800 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 800 MBytes/sec");
 	if (id[10] & (1 << 5))
-		sprintf(value, "%s", "FC: 1600 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 1600 MBytes/sec");
 	if (id[10] & (1 << 4))
-		sprintf(value, "%s", "FC: 400 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 400 MBytes/sec");
 	if (id[10] & (1 << 3))
-		sprintf(value, "%s", "FC: 3200 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 3200 MBytes/sec");
 	if (id[10] & (1 << 2))
-		sprintf(value, "%s", "FC: 200 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 200 MBytes/sec");
 	if (id[10] & (1 << 0))
-		sprintf(value, "%s", "FC: 100 MBytes/sec");
+		module_print_any_array_string_entry(pfx,
+			"FC: 100 MBytes/sec");
 	/* Extended Specification Compliance Codes from SFF-8024 */
 	if (id[36] == 0x1)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)");
 	if (id[36] == 0x2)
-		sprintf(value, "%s", "Extended: 100G Base-SR4 or 25GBase-SR");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 100G Base-SR4 or 25GBase-SR");
 	if (id[36] == 0x3)
-		sprintf(value, "%s", "Extended: 100G Base-LR4 or 25GBase-LR");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 100G Base-LR4 or 25GBase-LR");
 	if (id[36] == 0x4)
-		sprintf(value, "%s", "Extended: 100G Base-ER4 or 25GBase-ER");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 100G Base-ER4 or 25GBase-ER");
 	if (id[36] == 0x8)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)");
 	if (id[36] == 0xb)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G Base-CR4 or 25G Base-CR CA-L");
 	if (id[36] == 0xc)
-		sprintf(value, "%s", "Extended: 25G Base-CR CA-S");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 25G Base-CR CA-S");
 	if (id[36] == 0xd)
-		sprintf(value, "%s", "Extended: 25G Base-CR CA-N");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 25G Base-CR CA-N");
 	if (id[36] == 0x16)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 10Gbase-T with SFI electrical interface");
 	if (id[36] == 0x18)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)");
 	if (id[36] == 0x19)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)");
 	if (id[36] == 0x1a)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100GE-DWDM2 (DWDM transceiver using 2 wavelengths on a 1550 nm DWDM grid with a reach up to 80 km)");
 	if (id[36] == 0x1b)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G 1550nm WDM (4 wavelengths)");
 	if (id[36] == 0x1c)
-		sprintf(value, "%s", "Extended: 10Gbase-T Short Reach");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 10Gbase-T Short Reach");
 	if (id[36] == 0x1d)
-		sprintf(value, "%s", "Extended: 5GBASE-T");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 5GBASE-T");
 	if (id[36] == 0x1e)
-		sprintf(value, "%s", "Extended: 2.5GBASE-T");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 2.5GBASE-T");
 	if (id[36] == 0x1f)
-		sprintf(value, "%s", "Extended: 40G SWDM4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 40G SWDM4");
 	if (id[36] == 0x20)
-		sprintf(value, "%s", "Extended: 100G SWDM4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 100G SWDM4");
 	if (id[36] == 0x21)
-		sprintf(value, "%s", "Extended: 100G PAM4 BiDi");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 100G PAM4 BiDi");
 	if (id[36] == 0x22)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 4WDM-10 MSA (10km version of 100G CWDM4 with same RS(528,514) FEC in host system)");
 	if (id[36] == 0x23)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 4WDM-20 MSA (20km version of 100GBASE-LR4 with RS(528,514) FEC in host system)");
 	if (id[36] == 0x24)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 4WDM-40 MSA (40km reach with APD receiver and RS(528,514) FEC in host system)");
 	if (id[36] == 0x25)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100GBASE-DR (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x26)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G-FR or 100GBASE-FR1 (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x27)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 100G-LR or 100GBASE-LR1 (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x30)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 	if (id[36] == 0x31)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 	if (id[36] == 0x32)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 	if (id[36] == 0x33)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 	if (id[36] == 0x40)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 50GBASE-CR, 100GBASE-CR2, or 200GBASE-CR4");
 	if (id[36] == 0x41)
-		sprintf(value, "%s",
+		module_print_any_array_string_entry(pfx,
 			"Extended: 50GBASE-SR, 100GBASE-SR2, or 200GBASE-SR4");
 	if (id[36] == 0x42)
-		sprintf(value, "%s", "Extended: 50GBASE-FR or 200GBASE-DR4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 50GBASE-FR or 200GBASE-DR4");
 	if (id[36] == 0x43)
-		sprintf(value, "%s", "Extended: 200GBASE-FR4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 200GBASE-FR4");
 	if (id[36] == 0x44)
-		sprintf(value, "%s", "Extended: 200G 1550 nm PSM4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 200G 1550 nm PSM4");
 	if (id[36] == 0x45)
-		sprintf(value, "%s", "Extended: 50GBASE-LR");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 50GBASE-LR");
 	if (id[36] == 0x46)
-		sprintf(value, "%s", "Extended: 200GBASE-LR4");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 200GBASE-LR4");
 	if (id[36] == 0x50)
-		sprintf(value, "%s", "Extended: 64GFC EA");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 64GFC EA");
 	if (id[36] == 0x51)
-		sprintf(value, "%s", "Extended: 64GFC SW");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 64GFC SW");
 	if (id[36] == 0x52)
-		sprintf(value, "%s", "Extended: 64GFC LW");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 64GFC LW");
 	if (id[36] == 0x53)
-		sprintf(value, "%s", "Extended: 128GFC EA");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 128GFC EA");
 	if (id[36] == 0x54)
-		sprintf(value, "%s", "Extended: 128GFC SW");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 128GFC SW");
 	if (id[36] == 0x55)
-		sprintf(value, "%s", "Extended: 128GFC LW");
+		module_print_any_array_string_entry(pfx,
+			"Extended: 128GFC LW");
 
-	if (value[0] != '\0')
-		module_print_any_string(pfx, value);
+	if (is_json_context())
+		close_json_array("");
 }
 
 static void sff8079_show_encoding(const __u8 *id)
-- 
2.53.0


