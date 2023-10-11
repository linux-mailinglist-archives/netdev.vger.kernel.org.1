Return-Path: <netdev+bounces-40157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A37C6034
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03491C20CD5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2456249E1;
	Wed, 11 Oct 2023 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KcHd3z+6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB2249EA
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:13:18 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0510691
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:13:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7740cedd4baso20621785a.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697062396; x=1697667196; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMXs2ZjdP060taxzGMradMjobe3Z68DmqtrSkLKr6f8=;
        b=KcHd3z+6wK33Y+w9uHSpwOjleX8U7At4jCNqEpxwQTpJth/NJCEWEDxFrU286MSa26
         CtxHbTcbwbXpPRacx6ZxamIT7zWz1TB83vJcaAGDQyIXe19TPuImfiMzjvVrnXgP+hEk
         Dxx+arZslaFTbM74V6ndJ/3PVFugaHMpY6Buc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062396; x=1697667196;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMXs2ZjdP060taxzGMradMjobe3Z68DmqtrSkLKr6f8=;
        b=M7KIBLX7C/eelYTxGWyj/rCShSEuTu3+WRkGUya7BKuWoX+1yf1BZJCZUi0LNsWjLc
         Rc45U7LKfvGnIlSYnD1sSkDyVzpRfAMGbpKZJVg33QIB++DiHPzuGUWSmtf7RJU8Ux3g
         xJTOp0+rq16lat1dQLrddpsw3bzKI++ELTcHVLjArQF052A6vFxnWft7wmdmJxwE+nd3
         4WB/RjYXP8WZUeum7q4CCHwk8MgYIfwzGFZVFZiXya9RpVNoy8T5dJB+Vdl8RK63t7pc
         o07js+HBJiSqEKcy2d+DFI6XKGwfdKLPZ1NqLuFQqEe8itKVnI2nObrm4kER739ZEFtU
         E4hA==
X-Gm-Message-State: AOJu0YzwmqqNPP0dKIOwMFl18YPEfeGf9JX3PieSIIijuR+AM7Hi+Q0E
	VWa3aZt0e7DBokVuibCU+5MuOHjZJIAzgIh5Fxc3/wm5sCfXF50zQJNUs+zdi9SpGohdPsi/AOu
	UnSUHrm/EAmvNEVy2MvR2mccCWMB3Y6KSv1Sjig/kGUdO+LShF4Mhvv0uFfkBUHhoLkNiRDdMBu
	1hCsO2RSUQMg==
X-Google-Smtp-Source: AGHT+IFh6a4ASUnCVQKjMFdtZB9oDTb2zRgY09MeWCeKP04VRZH9EuZ5OzTOemMaqpPr+qdKRIYcDg==
X-Received: by 2002:a05:620a:47ae:b0:775:967e:3307 with SMTP id dt46-20020a05620a47ae00b00775967e3307mr22715640qkb.1.1697062395628;
        Wed, 11 Oct 2023 15:13:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a102c00b007759a81d88esm5505705qkk.50.2023.10.11.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:13:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	opendmb@gmail.com,
	justin.chen@broadcom.com,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 2/2] wol: Add support for WAKE_MDA
Date: Wed, 11 Oct 2023 15:12:42 -0700
Message-Id: <20231011221242.4180589-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004690270607782129"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	MIME_BOUND_DIGITS_15,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000004690270607782129
Content-Transfer-Encoding: 8bit

Allow waking-up from a specific MAC destination address, this is
particularly useful with a number of Ethernet PHYs that have limited
buffering and packet matching abilities.

Example:

ethtool -s eth0 wol e mac-da 01:00:5e:00:00:fb

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 common.c               | 16 ++++++++++++++--
 ethtool.8.in           | 15 +++++++++++----
 ethtool.c              | 26 +++++++++++++++++++++-----
 netlink/desc-ethtool.c |  1 +
 netlink/settings.c     | 25 ++++++++++++++++++++++---
 test-cmdline.c         |  4 ++++
 6 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/common.c b/common.c
index b8fd4d5bc0f4..a42d00fe3c0c 100644
--- a/common.c
+++ b/common.c
@@ -120,6 +120,8 @@ static char *unparse_wolopts(int wolopts)
 			*p++ = 's';
 		if (wolopts & WAKE_FILTER)
 			*p++ = 'f';
+		if (wolopts & WAKE_MDA)
+			*p++ = 'e';
 	} else {
 		*p = 'd';
 	}
@@ -129,13 +131,13 @@ static char *unparse_wolopts(int wolopts)
 
 int dump_wol(struct ethtool_wolinfo *wol)
 {
+	int i;
+	int delim = 0;
 	fprintf(stdout, "	Supports Wake-on: %s\n",
 		unparse_wolopts(wol->supported));
 	fprintf(stdout, "	Wake-on: %s\n",
 		unparse_wolopts(wol->wolopts));
 	if (wol->supported & WAKE_MAGICSECURE) {
-		int i;
-		int delim = 0;
 
 		fprintf(stdout, "        SecureOn password: ");
 		for (i = 0; i < SOPASS_MAX; i++) {
@@ -145,6 +147,16 @@ int dump_wol(struct ethtool_wolinfo *wol)
 		}
 		fprintf(stdout, "\n");
 	}
+	delim = 0;
+	if (wol->supported & WAKE_MDA) {
+		fprintf(stdout, "        Destination MAC: ");
+		for (i = 0; i < ETH_ALEN; i++) {
+			fprintf(stdout, "%s%02x", delim ? ":" : "",
+				wol->mac_da[i]);
+			delim = 1;
+		}
+		fprintf(stdout, "\n");
+	}
 
 	return 0;
 }
diff --git a/ethtool.8.in b/ethtool.8.in
index c0c37a427715..c7f457b9b739 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -62,7 +62,7 @@
 .\"
 .\"	\(*WO - wol flags
 .\"
-.ds WO \fBp\fP|\fBu\fP|\fBm\fP|\fBb\fP|\fBa\fP|\fBg\fP|\fBs\fP|\fBf|\fBd\fP...
+.ds WO \fBp\fP|\fBu\fP|\fBm\fP|\fBb\fP|\fBa\fP|\fBg\fP|\fBs\fP|\fBf|\fBe|\fBd\fP...
 .\"
 .\"	\(*FL - flow type values
 .\"
@@ -281,7 +281,7 @@ ethtool \- query or control network driver and hardware settings
 .B2 xcvr internal external
 .RB [ wol \ \fIN\fP[\fB/\fP\fIM\fP]
 .RB | \ wol \ \*(WO]
-.RB [ sopass \ \*(MA]
+.RB [ sopass \ \*(MA | mac-da \ \*(MA ]
 .RB [ master-slave \ \*(MS]
 .RB [ msglvl
 .IR N\fP[/\fIM\fP] \ |
@@ -949,14 +949,21 @@ a	Wake on ARP
 g	Wake on MagicPacket\[tm]
 s	Enable SecureOn\[tm] password for MagicPacket\[tm]
 f	Wake on filter(s)
+e	Wake on specific MAC destination address
 d	T{
 Disable (wake on nothing).  This option clears all previous options.
 T}
 .TE
 .TP
 .B sopass \*(MA
-Sets the SecureOn\[tm] password.  The argument to this option must be 6
-bytes in Ethernet MAC hex format (\*(MA).
+Sets the secureon\[tm] password.  The argument to this option must be 6
+bytes in ethernet mac hex format (\*(MA).
+.PP
+.TE
+.TP
+.B mac-da \*(MA
+Sets the destination MAC address to match against.  The argument to this option
+must be 6 bytes in ethernet mac hex format (\*(MA).
 .PP
 .BI msglvl \ N
 .br
diff --git a/ethtool.c b/ethtool.c
index af51220b63cc..513b4ed11623 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -973,6 +973,9 @@ static int parse_wolopts(char *optstr, u32 *data)
 		case 'f':
 			*data |= WAKE_FILTER;
 			break;
+		case 'e':
+			*data |= WAKE_MDA;
+			break;
 		case 'd':
 			*data = 0;
 			break;
@@ -2971,8 +2974,8 @@ static int do_sset(struct cmd_context *ctx)
 	int gset_changed = 0; /* did anything in GSET change? */
 	u32 wol_wanted = 0;
 	int wol_change = 0;
-	u8 sopass_wanted[SOPASS_MAX];
-	int sopass_change = 0;
+	u8 sopass_wanted[SOPASS_MAX], mda_wanted[ETH_ALEN];
+	int sopass_change = 0, mda_change = 0;
 	int gwol_changed = 0; /* did anything in GWOL change? */
 	int msglvl_changed = 0;
 	u32 msglvl_wanted = 0;
@@ -3093,6 +3096,13 @@ static int do_sset(struct cmd_context *ctx)
 				exit_bad_args();
 			get_mac_addr(argp[i], sopass_wanted);
 			sopass_change = 1;
+		} else if (!strcmp(argp[i], "mac-da")) {
+			gwol_changed = 1;
+			i++;
+			if (i >= argc)
+				exit_bad_args();
+			get_mac_addr(argp[i], mda_wanted);
+			mda_change = 1;
 		} else if (!strcmp(argp[i], "msglvl")) {
 			i++;
 			if (i >= argc)
@@ -3295,14 +3305,18 @@ static int do_sset(struct cmd_context *ctx)
 		if (err < 0) {
 			perror("Cannot get current wake-on-lan settings");
 		} else {
+			int i;
 			/* Change everything the user specified. */
 			if (wol_change)
 				wol.wolopts = wol_wanted;
 			if (sopass_change) {
-				int i;
 				for (i = 0; i < SOPASS_MAX; i++)
 					wol.sopass[i] = sopass_wanted[i];
 			}
+			if (mda_change) {
+				for (i = 0; i < ETH_ALEN; i++)
+					wol.mac_da[i] = mda_wanted[i];
+			}
 
 			/* Try to perform the update. */
 			wol.cmd = ETHTOOL_SWOL;
@@ -3315,6 +3329,8 @@ static int do_sset(struct cmd_context *ctx)
 				fprintf(stderr, "  not setting wol\n");
 			if (sopass_change)
 				fprintf(stderr, "  not setting sopass\n");
+			if (mda_change)
+				fprintf(stderr, "  not setting mac-da\n");
 		}
 	}
 
@@ -5669,8 +5685,8 @@ static const struct option args[] = {
 			  "		[ advertise %x[/%x] | mode on|off ... [--] ]\n"
 			  "		[ phyad %d ]\n"
 			  "		[ xcvr internal|external ]\n"
-			  "		[ wol %d[/%d] | p|u|m|b|a|g|s|f|d... ]\n"
-			  "		[ sopass %x:%x:%x:%x:%x:%x ]\n"
+			  "		[ wol %d[/%d] | p|u|m|b|a|g|s|f|e|d... ]\n"
+			  "		[ sopass %x:%x:%x:%x:%x:%x | mac-da %x:%x:%x:%x:%x:%x ]\n"
 			  "		[ msglvl %d[/%d] | type on|off ... [--] ]\n"
 			  "		[ master-slave preferred-master|preferred-slave|forced-master|forced-slave ]\n"
 	},
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index 661de267262f..78732bc2719c 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -120,6 +120,7 @@ static const struct pretty_nla_desc __wol_desc[] = {
 	NLATTR_DESC_NESTED(ETHTOOL_A_WOL_HEADER, header),
 	NLATTR_DESC_NESTED(ETHTOOL_A_WOL_MODES, bitset),
 	NLATTR_DESC_BINARY(ETHTOOL_A_WOL_SOPASS),
+	NLATTR_DESC_BINARY(ETHTOOL_A_WOL_MAC_DA),
 };
 
 static const struct pretty_nla_desc __features_desc[] = {
diff --git a/netlink/settings.c b/netlink/settings.c
index a506618ba0a4..a13251863af1 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -810,6 +810,7 @@ int wol_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	DECLARE_ATTR_TB_INFO(tb);
 	struct nl_context *nlctx = data;
 	struct ethtool_wolinfo wol = {};
+	unsigned int len;
 	int ret;
 
 	if (nlctx->is_dump || nlctx->is_monitor)
@@ -824,8 +825,6 @@ int wol_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (tb[ETHTOOL_A_WOL_MODES])
 		walk_bitset(tb[ETHTOOL_A_WOL_MODES], NULL, wol_modes_cb, &wol);
 	if (tb[ETHTOOL_A_WOL_SOPASS]) {
-		unsigned int len;
-
 		len = mnl_attr_get_payload_len(tb[ETHTOOL_A_WOL_SOPASS]);
 		if (len != SOPASS_MAX)
 			fprintf(stderr, "invalid SecureOn password length %u (should be %u)\n",
@@ -835,6 +834,16 @@ int wol_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			       mnl_attr_get_payload(tb[ETHTOOL_A_WOL_SOPASS]),
 			       SOPASS_MAX);
 	}
+	if (tb[ETHTOOL_A_WOL_MAC_DA]) {
+		len = mnl_attr_get_payload_len(tb[ETHTOOL_A_WOL_SOPASS]);
+		if (len != ETH_ALEN)
+			fprintf(stderr, "invalid destinatino MAC address length %u (should be %u)\n",
+				len, ETH_ALEN);
+		else
+			memcpy(wol.mac_da,
+			       mnl_attr_get_payload(tb[ETHTOOL_A_WOL_MAC_DA]),
+			       ETH_ALEN);
+	}
 	print_banner(nlctx);
 	dump_wol(&wol);
 
@@ -1050,10 +1059,11 @@ enum {
 	WAKE_MAGIC_BIT		= 5,
 	WAKE_MAGICSECURE_BIT	= 6,
 	WAKE_FILTER_BIT		= 7,
+	WAKE_MDA_BIT		= 8,
 };
 
 #define WAKE_ALL (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_ARP | \
-		  WAKE_MAGIC | WAKE_MAGICSECURE)
+		  WAKE_MAGIC | WAKE_MAGICSECURE | WAKE_MDA)
 
 static const struct lookup_entry_u8 port_values[] = {
 	{ .arg = "tp",		.val = PORT_TP },
@@ -1112,6 +1122,7 @@ char wol_bit_chars[WOL_MODE_COUNT] = {
 	[WAKE_MAGIC_BIT]	= 'g',
 	[WAKE_MAGICSECURE_BIT]	= 's',
 	[WAKE_FILTER_BIT]	= 'f',
+	[WAKE_MDA_BIT]		= 'e',
 };
 
 const struct char_bitset_parser_data wol_parser_data = {
@@ -1224,6 +1235,14 @@ static const struct param_parser sset_params[] = {
 		.handler_data	= &sopass_parser_data,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "mac-da",
+		.group		= ETHTOOL_MSG_WOL_SET,
+		.type		= ETHTOOL_A_WOL_MAC_DA,
+		.handler	= nl_parse_byte_str,
+		.handler_data	= &sopass_parser_data,
+		.min_argc	= 1,
+	},
 	{
 		.arg		= "msglvl",
 		.group		= ETHTOOL_MSG_DEBUG_SET,
diff --git a/test-cmdline.c b/test-cmdline.c
index cb803ed1a93d..cfe7d24c065f 100644
--- a/test-cmdline.c
+++ b/test-cmdline.c
@@ -74,6 +74,10 @@ static struct test_case {
 	{ 1, "--change devname sopass 01:23:45:67:89:" },
 	{ 1, "-s devname sopass 01:23:45:67:89" },
 	{ 1, "--change devname sopass" },
+	{ 0, "-s devname mac-da 01:23:45:67:89:ab" },
+	{ 1, "--change devname mac-da 01:23:45:67:89:" },
+	{ 1, "-s devname mac-da 01:23:45:67:89" },
+	{ 1, "--change devname mac-da" },
 	{ 0, "-s devname msglvl 1" },
 	{ 1, "--change devname msglvl" },
 	{ 0, "-s devname msglvl hw on rx_status off" },
-- 
2.34.1


--0000000000004690270607782129
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEejazUuG5wGXogh
+k6SggK4OJMYKve9ivrGU71QFS76MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxMTIyMTMxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCjqMfIp9yfrpDGIvAt0MAajGT2Ha8Jz/jn
d0PmDsUeftVq7Ib0vTVpwqqKG9btNa1dc1Je2ZkPDA5r/eT/AabiF4vsv9F/Teh0g0RXeLydfE2v
IZ5+plffcQMHQKahRaiNxr5w+9o02ZbOYVz118r4U3PGN/550dXUOVbqx25H8R3FJpnMMjNBpMMk
vMGm9pAzvkOhotZaPKyhGfSscRvHrfvlz3xw6/xYMhKISzjPlq6IrQt6o0n+ezqHuBYnt0v7OtmL
FuPQNV3Dx28WUz26dlKY1PKmvQUvlBPom0lg0i8CWTglHPpPBSedBpbT3EXXSDH/jdJx3HQtv27X
cj/u
--0000000000004690270607782129--

