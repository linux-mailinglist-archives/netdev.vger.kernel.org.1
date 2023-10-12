Return-Path: <netdev+bounces-40229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EB47C649A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF42282587
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 05:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294DECA6F;
	Thu, 12 Oct 2023 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9bQpCQb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6DD263
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:24:11 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198D90
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:24:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso53600276.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697088248; x=1697693048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1cP6tomGjAXDkWGX7Lga93uumHzInEBBrDc/NcXHLc=;
        b=P9bQpCQb0CWDpg7UOx32mftpDlHe7OKhXd9/8uBGxDz2E1BXCsa8flBSgJYOs8LUfa
         TghvA1r+lj+0JfworovLKMyprQKbH51zmDK1X4VeZBR+esfVT9GZVQeCMmEM4zM+UXU8
         XXnV74hTuPQ6UWVoCdM5FiTije9UXS8XeooaQv4NLpsJsCPsQJiIJOAeTn9OezUj5OGs
         jWGBR1xRuSZwIuY+KktyvGbxi2b9KJPiKT0gMLKAfbHoz3T7t8PacQex98tb9vliSqqN
         /oVoA0nsZTbOkq7oD8hED7vAm933DAtuoc4kZO4dok1W0ZdzbsKSvjkweGjbWan+eyK3
         5qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697088248; x=1697693048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1cP6tomGjAXDkWGX7Lga93uumHzInEBBrDc/NcXHLc=;
        b=oCLfA7Nqq+oufdLvSnZQn7YzH+dH3PYtoOpUL7JBj4tMJk33D69MlttVZWULX5s9T3
         FKSf9r7yeQFms9PlceqrX2Rz3Qea2RCAZVNU7sLLDsOFeOrWW2ABHqkyKunzvjs7hFM9
         jE1uZCABHa8tXCcWA7DlODyPbsuW622GO5X9dxCz1TOGo1jKK/QUJ+6FCa93Cg/tZ35N
         UwT7AUtrF/NDXhgajcxhmFpzEZV8lZ2dHTLlFc1orArl5GTX5KYsMmnJBdhGx7fWri6K
         /YuYwwxx7vj9WAQM1sLyWaao8QOwurciiBShIHnlMujKz8LIVRbkUqRWZz5uxNyU0W60
         mUAg==
X-Gm-Message-State: AOJu0YwppwouYddcVRQ+sQ7lX3K1tJwI5vUksZ/bdEVI61OywHq4y8wA
	xDWD4tZ5IJukpQariOhVSUci1zCOXQg=
X-Google-Smtp-Source: AGHT+IFt5y4/JkabSdkoGSoH1TMRDXnFm/XMYmukTjbN8assy4K510AEuOoVXRtFtggwiI1CizMEIA==
X-Received: by 2002:a25:1941:0:b0:d85:4c83:5d81 with SMTP id 62-20020a251941000000b00d854c835d81mr22267137ybz.48.1697088248561;
        Wed, 11 Oct 2023 22:24:08 -0700 (PDT)
Received: from ocxma-dut.. ([153.126.233.61])
        by smtp.gmail.com with ESMTPSA id w78-20020a25c751000000b00d9ac87e0b17sm172129ybe.30.2023.10.11.22.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:24:08 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH net-next v3] ethtool: add support for rx-flow-hash gtp
Date: Thu, 12 Oct 2023 05:24:02 +0000
Message-Id: <20231012052402.105909-1-hayatake396@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GTP Flow hash was added to the ice driver.
By executing "ethtool -N <dev> rx-flow-hash gtpu4 sde", RSS can include
not only the IP's src/dst but also the TEID of GTP packets.
Additionally, options <e> have been support.
These allow specification to include TEID in the hash computation.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
Added GTPC flow type
Changed so that TEID can be selected as a key

 ethtool.c            | 71 ++++++++++++++++++++++++++++++++++++++++++--
 uapi/linux/ethtool.h | 13 ++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index af51220..714e226 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -360,6 +360,18 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = AH_ESP_V4_FLOW;
 	else if (!strcmp(str, "sctp4"))
 		flow_type = SCTP_V4_FLOW;
+	else if (!strcmp(str, "gtpc4"))
+		flow_type = GTPC_V4_FLOW;
+	else if (!strcmp(str, "gtpc4t"))
+		flow_type = GTPC_TEID_V4_FLOW;
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
@@ -370,6 +382,18 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = SCTP_V6_FLOW;
 	else if (!strcmp(str, "ether"))
 		flow_type = ETHER_FLOW;
+	else if (!strcmp(str, "gtpc6"))
+		flow_type = GTPC_V6_FLOW;
+	else if (!strcmp(str, "gtpc6t"))
+		flow_type = GTPC_TEID_V6_FLOW;
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
@@ -1010,6 +1034,9 @@ static int parse_rxfhashopts(char *optstr, u32 *data)
 		case 'n':
 			*data |= RXH_L4_B_2_3;
 			break;
+		case 'e':
+			*data |= RXH_GTP_TEID;
+			break;
 		case 'r':
 			*data |= RXH_DISCARD;
 			break;
@@ -1042,6 +1069,8 @@ static char *unparse_rxfhashopts(u64 opts)
 			strcat(buf, "L4 bytes 0 & 1 [TCP/UDP src port]\n");
 		if (opts & RXH_L4_B_2_3)
 			strcat(buf, "L4 bytes 2 & 3 [TCP/UDP dst port]\n");
+		if (opts & RXH_GTP_TEID)
+			strcat(buf, "GTP TEID\n");
 	} else {
 		sprintf(buf, "None");
 	}
@@ -1559,6 +1588,24 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V4_FLOW:
 		fprintf(stdout, "SCTP over IPV4 flows");
 		break;
+	case GTPC_V4_FLOW:
+		fprintf(stdout, "GTP-C over IPV4 flows");
+		break;
+	case GTPC_TEID_V4_FLOW:
+		fprintf(stdout, "GTP-C (include TEID) over IPV4 flows");
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
@@ -1573,6 +1620,24 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V6_FLOW:
 		fprintf(stdout, "SCTP over IPV6 flows");
 		break;
+	case GTPC_V6_FLOW:
+		fprintf(stdout, "GTP-C over IPV6 flows");
+		break;
+	case GTPC_TEID_V6_FLOW:
+		fprintf(stdout, "GTP-C (include TEID) over IPV6 flows");
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
@@ -5833,7 +5898,8 @@ static const struct option args[] = {
 		.func	= do_grxclass,
 		.help	= "Show Rx network flow classification options or rules",
 		.xhelp	= "		[ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 [context %d] |\n"
+			  "gtpc4|gtpc4t|gtpu4|gtpu4e|gtpu4u|gtpu4d|tcp6|udp6|ah6|esp6|sctp6|"
+			  "gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d [context %d] |\n"
 			  "		  rule %d ]\n"
 	},
 	{
@@ -5841,7 +5907,8 @@ static const struct option args[] = {
 		.func	= do_srxclass,
 		.help	= "Configure Rx network flow classification options or rules",
 		.xhelp	= "		rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
-			  "tcp6|udp6|ah6|esp6|sctp6 m|v|t|s|d|f|n|r... [context %d] |\n"
+			 "gtpc4|gtpc4t|gtpu4|gtpu4e|gtpu4u|gtpu4d|tcp6|udp6|ah6|esp6|sctp6"
+			  "|gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d m|v|t|s|d|f|n|r|e... [context %d] |\n"
 			  "		flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4|"
 			  "ip6|tcp6|udp6|ah6|esp6|sctp6\n"
 			  "			[ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 1d0731b..6fb6a07 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2009,6 +2009,18 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x20	/* hash only */
+#define GTPU_UL_V4_FLOW 0x21	/* hash only */
+#define GTPU_UL_V6_FLOW 0x22	/* hash only */
+#define GTPU_DL_V4_FLOW 0x23	/* hash only */
+#define GTPU_DL_V6_FLOW 0x24	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2023,6 +2035,7 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


