Return-Path: <netdev+bounces-38869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA17BCCBB
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CBC1C208CC
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19AD15D1;
	Sun,  8 Oct 2023 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he2iJUnZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09F881F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:30:50 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A6D6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:30:48 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a4e29928c3so42901307b3.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696746647; x=1697351447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DckoAtf8/2zr94zYIuCUUFNBHI0b/baWJy40NnU6w/8=;
        b=he2iJUnZuS+K85MgzcbgRazccybMWIj1Bv7MqZi407yksdl1XCvtOfj0qCtLgkqgDa
         e96w4idjc4c1z/qoAqXxn5TLKzIJXJosvbcO8qwFgmyqiIGe69pflj5oFwTgMZXyMSTx
         xTZkA9shsikjqxBRrjcv1JVFvI1W17fMt7PFQxj5bQ+2P1rR4ajbVzvEjzPq0xtMRqUu
         kl/UgTmK2KKYNUi5IBp2xzni/GtCtpw2gmC4oXXnKGc/fgfOti3VqqV6ZZrszOikPB6x
         AwVCGL9pQubZ+JnwE0zUH5E6uiRTr2W9NpYAMZ7QtUCAsz9X/GEpuGeGv0F0L1GZX4B+
         4/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746647; x=1697351447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DckoAtf8/2zr94zYIuCUUFNBHI0b/baWJy40NnU6w/8=;
        b=J0E+YqGHWUzEEb0tAjULETiizg2Pl30nQFYWcVbm2AdPtxGUtW2I3NkqcnmjhrwmPa
         F4cMGUX21Okdhq4B+BzJwHvzH70DitaFAansw2JSE227MBELcjOTmyA0zx5lBaS+c5yC
         BZLXlMFvU+N/07b/C/JGiblc0oHf97jKnvOf+4NjDKy36S5JZx83k3WrJnY+ql5NUsaD
         9hcTvN0fdgL0MxjxLTwGjv/jlH1trSnKfYI51tTnYBn2lEvBNFdN2XyAXZlDx3oqkyxo
         m70yLK86bxEsI0deasnWT7M6qekcGpJQC5QkX6fQBDAbgmhNyv8cRvREBNm0E3FKfVcC
         qhcQ==
X-Gm-Message-State: AOJu0YyXRvIn4mgFa7e1MXdFrcUhp5pi2XNW2C1s6DCqnhUD2DzjlDRw
	So1V5OxvVLPOY7t46XZ2yUlUIwUqKRNXuA==
X-Google-Smtp-Source: AGHT+IHKiymLFvecEP4SiEiD36rY4j2YZtXfpA8NRNLFD+kGAzpFBmWp+zI+I+bHEqwa+A3q+PlGRg==
X-Received: by 2002:a0d:cbc9:0:b0:59c:bab:eb4f with SMTP id n192-20020a0dcbc9000000b0059c0babeb4fmr11929432ywd.16.1696746647364;
        Sat, 07 Oct 2023 23:30:47 -0700 (PDT)
Received: from ocxma-dut.. ([153.126.233.61])
        by smtp.gmail.com with ESMTPSA id y134-20020a81a18c000000b0059f650f46b2sm2646691ywg.7.2023.10.07.23.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:30:47 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
X-Google-Original-From: Takeru Hayasaka <t-hayasaka@bbsakura.net>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH net-next v2] ethtool: add support for rx-flow-hash gtp
Date: Sun,  8 Oct 2023 06:30:41 +0000
Message-Id: <20231008063041.61709-1-t-hayasaka@bbsakura.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Takeru Hayasaka <hayatake396@gmail.com>

GTP Flow hash was added to the ice driver.
By executing "ethtool -N <dev> rx-flow-hash gtp4 sd", RSS can include
not only the IP's src/dst but also the TEID of GTP packets.
Additionally, options [c|e] have been support.
These allow specification to include GTPv2-C cases as well as the
Extension Header's QFI in the hash computation.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
While implementing it, I found that I was using the wrong parameters for
ethtool rx-hash-flow, so I fixed it.

 ethtool.c            | 58 +++++++++++++++++++++++++++++++++++++++++---
 uapi/linux/ethtool.h | 10 ++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index af51220..5325299 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -360,6 +360,16 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = AH_ESP_V4_FLOW;
 	else if (!strcmp(str, "sctp4"))
 		flow_type = SCTP_V4_FLOW;
+	else if (!strcmp(str, "gtpc4"))
+		flow_type = GTPC_V4_FLOW;
+	else if (!strcmp(str, "gtpu4"))
+		flow_type = GTPU_V4_FLOW;
+	else if (!strcmp(str, "gtpu4e"))
+		flow_type = GTPU_EH_V4_FLOW;
+	else if (!strcmp(str, "gtpu4u"))
+		flow_type = GTPU_UL_V4_FLOW;
+	else if (!strcmp(str, "gtpu4d"))
+		flow_type = GTPU_DL_V4_FLOW;
 	else if (!strcmp(str, "tcp6"))
 		flow_type = TCP_V6_FLOW;
 	else if (!strcmp(str, "udp6"))
@@ -370,6 +380,16 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = SCTP_V6_FLOW;
 	else if (!strcmp(str, "ether"))
 		flow_type = ETHER_FLOW;
+	else if (!strcmp(str, "gtpc6"))
+		flow_type = GTPC_V6_FLOW;
+	else if (!strcmp(str, "gtpu6"))
+		flow_type = GTPU_V6_FLOW;
+	else if (!strcmp(str, "gtpu6e"))
+		flow_type = GTPU_EH_V6_FLOW;
+	else if (!strcmp(str, "gtpu6u"))
+		flow_type = GTPU_UL_V6_FLOW;
+	else if (!strcmp(str, "gtpu6d"))
+		flow_type = GTPU_DL_V6_FLOW;
 
 	return flow_type;
 }
@@ -1559,6 +1579,21 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V4_FLOW:
 		fprintf(stdout, "SCTP over IPV4 flows");
 		break;
+	case GTPC_V4_FLOW:
+		fprintf(stdout, "GTP-C over IPV4 flows");
+		break;
+	case GTPU_V4_FLOW:
+		fprintf(stdout, "GTP-U over IPV4 flows");
+		break;
+	case GTPU_EH_V4_FLOW:
+		fprintf(stdout, "GTP-U and Extension Header over IPV4 flows");
+		break;
+	case GTPU_UL_V4_FLOW:
+		fprintf(stdout, "GTP-U over IPV4 Uplink flows");
+		break;
+	case GTPU_DL_V4_FLOW:
+		fprintf(stdout, "GTP-U over IPV4 Downlink flows");
+		break;
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1573,6 +1608,21 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V6_FLOW:
 		fprintf(stdout, "SCTP over IPV6 flows");
 		break;
+	case GTPC_V6_FLOW:
+		fprintf(stdout, "GTP-C over IPV6 flows");
+		break;
+	case GTPU_V6_FLOW:
+		fprintf(stdout, "GTP-U over IPV6 flows");
+		break;
+	case GTPU_EH_V6_FLOW:
+		fprintf(stdout, "GTP-U and Extension Header over IPV6 flows");
+		break;
+	case GTPU_UL_V6_FLOW:
+		fprintf(stdout, "GTP-U over IPV6 Uplink flows");
+		break;
+	case GTPU_DL_V6_FLOW:
+		fprintf(stdout, "GTP-U over IPV6 Downlink flows");
+		break;
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -5832,16 +5882,16 @@ static const struct option args[] = {
 		.opts	= "-n|-u|--show-nfc|--show-ntuple",
 		.func	= do_grxclass,
 		.help	= "Show Rx network flow classification options or rules",
-		.xhelp	= "		[ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 [context %d] |\n"
+		.xhelp	= "		[ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|gtp4|"
+			  "tcp6|udp6|ah6|esp6|sctp6|gtp6 [context %d] |\n"
 			  "		  rule %d ]\n"
 	},
 	{
 		.opts	= "-N|-U|--config-nfc|--config-ntuple",
 		.func	= do_srxclass,
 		.help	= "Configure Rx network flow classification options or rules",
-		.xhelp	= "		rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 m|v|t|s|d|f|n|r... [context %d] |\n"
+		.xhelp	= "		rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|gtp4|"
+			  "tcp6|udp6|ah6|esp6|sctp6|gtp6 m|v|t|s|d|f|n|r|c|e|u|w... [context %d] |\n"
 			  "		flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4|"
 			  "ip6|tcp6|udp6|ah6|esp6|sctp6\n"
 			  "			[ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 1d0731b..768fe8c 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2009,6 +2009,16 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+#define GTPU_EH_V4_FLOW 0x17	/* hash only */
+#define GTPU_EH_V6_FLOW 0x18	/* hash only */
+#define GTPU_UL_V4_FLOW 0x19	/* hash only */
+#define GTPU_UL_V6_FLOW 0x20	/* hash only */
+#define GTPU_DL_V4_FLOW 0x21	/* hash only */
+#define GTPU_DL_V6_FLOW 0x22	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
-- 
2.34.1


