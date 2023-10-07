Return-Path: <netdev+bounces-38828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3B7BC999
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777871C208DC
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044D2E635;
	Sat,  7 Oct 2023 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Y+NSHO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6E1845
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 18:52:36 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003AC5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 11:52:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c5bf7871dcso25337595ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696704754; x=1697309554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsQgtmLR9HrRmMkx2uQGIl2upPEwi85+R9/11VAh48c=;
        b=B4Y+NSHOZRG4NmpGLC033AX3MfP/3mYkrQtDQHjwJbdeB++V2lMJZAA0/bIhtv5ijP
         my9Q4Z8c0TavlU8UqnRI5T3aQMLQaXIAyZIMb6V0R5mva0UlacmuBTELYHDRIDDWw7G+
         RQnHxb19bPn1iMLa3TbHJYMkO4zz/hMcUrRLVw7/EiZIM3rux/BLbgNeKo5BcRbDp96K
         ZC7p7LodJxJB7hgoQwn6tZJl3B5uOpMS7GWLmzOQnPXNVIcEpAoOn1CJWItSGGmtKZHs
         /VEty1Hd0dvhwjq4n9332whAl98LDYwxKu/F/LWoIz2wZ6C4TiwhuHiyYspGIdgEq+Wc
         wB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696704754; x=1697309554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsQgtmLR9HrRmMkx2uQGIl2upPEwi85+R9/11VAh48c=;
        b=PEwSwKTfFc9qZD5sJBMKD4a89RONZCWEb4a3KX0CsZSuvM+ivQmFtrZ9AUg/ySMCpl
         aEqy6PMjA/zHjuMmBqAB+uS9HnXYmmoCTcpg/uZ0cegpUrkYlJXhtfnwnUkFIT4f4rtB
         fsrDbkH0hfrEYx9WforunsphWtSEf9Y7QTvwCUfD2CIAuL0Eebth6n1CjRLAjI1U76Te
         j96otaCngVjlTvyhYd+B/XTh5kM/JvM1gQj6pUhu3I59aNK9LQgyCz2tYphARnscrIzx
         74/DqOcLRdaauqVMs76u/BPN2uMYnlmvMydOPX/zrJ72ba3sqTWWmrpUE++kCCYqcQL/
         zqTA==
X-Gm-Message-State: AOJu0YxTheCZdl3D2CEWIvQ/Zoybe0GtOpLFiDawK7xKeXwX2MPaGHld
	oSId4S5ovwHV8xwqYt6XAhZsRbUai+eJ7A==
X-Google-Smtp-Source: AGHT+IGVQp8vYkx9zeKfhr+pbrhNn4L/bkPtQT0j6pyDfMCpkLzQTXa59xuhmAQL76Trb4nx1V2IeA==
X-Received: by 2002:a17:903:22cd:b0:1bf:3c10:1d70 with SMTP id y13-20020a17090322cd00b001bf3c101d70mr12704025plg.6.1696704753846;
        Sat, 07 Oct 2023 11:52:33 -0700 (PDT)
Received: from takehaya-main.. ([2001:e42:407:1028::1000])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001c63429fa89sm6205011pli.247.2023.10.07.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 11:52:33 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH ethtool-next] ethtool: add support for rx-flow-hash gtp
Date: Sun,  8 Oct 2023 03:52:21 +0900
Message-Id: <20231007185221.38032-1-hayatake396@gmail.com>
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
By executing "ethtool -N <dev> rx-flow-hash gtp4 sd", RSS can include
not only the IP's src/dst but also the TEID of GTP packets.
Additionally, options [c|e] have been support.
These allow specification to include GTPv2-C cases as well as the
Extension Header's QFI in the hash computation.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
This patch is for using GTP flow hashes from ethtool. First, add the
parameter to enable RSS.
This patch helps bring optimizations to Linux servers connected to
mobile networks

 ethtool.c            | 28 ++++++++++++++++++++++++----
 test-cmdline.c       |  2 +-
 uapi/linux/ethtool.h |  4 ++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index af51220b63cc..5b3be32755e5 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -360,6 +360,8 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = AH_ESP_V4_FLOW;
 	else if (!strcmp(str, "sctp4"))
 		flow_type = SCTP_V4_FLOW;
+	else if (!strcmp(str, "gtp4"))
+		flow_type = GTP_V4_FLOW;
 	else if (!strcmp(str, "tcp6"))
 		flow_type = TCP_V6_FLOW;
 	else if (!strcmp(str, "udp6"))
@@ -370,6 +372,8 @@ static int rxflow_str_to_type(const char *str)
 		flow_type = SCTP_V6_FLOW;
 	else if (!strcmp(str, "ether"))
 		flow_type = ETHER_FLOW;
+	else if (!strcmp(str, "gtp6"))
+		flow_type = GTP_V6_FLOW;
 
 	return flow_type;
 }
@@ -1010,6 +1014,12 @@ static int parse_rxfhashopts(char *optstr, u32 *data)
 		case 'n':
 			*data |= RXH_L4_B_2_3;
 			break;
+		case 'c':
+			*data |= RXH_GTP_V2_C;
+			break;
+		case 'e':
+			*data |= RXH_GTP_EH;
+			break;
 		case 'r':
 			*data |= RXH_DISCARD;
 			break;
@@ -1042,6 +1052,10 @@ static char *unparse_rxfhashopts(u64 opts)
 			strcat(buf, "L4 bytes 0 & 1 [TCP/UDP src port]\n");
 		if (opts & RXH_L4_B_2_3)
 			strcat(buf, "L4 bytes 2 & 3 [TCP/UDP dst port]\n");
+		if (opts & RXH_GTP_V2_C)
+			strcat(buf, "GTPv2-C Switching Flag [GTP]\n");
+		if (opts & RXH_GTP_EH)
+			strcat(buf, "GTP Extension Header [GTP]\n");
 	} else {
 		sprintf(buf, "None");
 	}
@@ -1559,6 +1573,9 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V4_FLOW:
 		fprintf(stdout, "SCTP over IPV4 flows");
 		break;
+	case GTP_V4_FLOW:
+		fprintf(stdout, "GTP over IPV4 flows");
+		break;
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1573,6 +1590,9 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V6_FLOW:
 		fprintf(stdout, "SCTP over IPV6 flows");
 		break;
+	case GTP_V6_FLOW:
+		fprintf(stdout, "GTP over IPV6 flows");
+		break;
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -5832,16 +5852,16 @@ static const struct option args[] = {
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
+			  "tcp6|udp6|ah6|esp6|sctp6|gtp6 m|v|t|s|d|f|n|r|c|e... [context %d] |\n"
 			  "		flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4|"
 			  "ip6|tcp6|udp6|ah6|esp6|sctp6\n"
 			  "			[ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
diff --git a/test-cmdline.c b/test-cmdline.c
index cb803ed1a93d..99d7b40400be 100644
--- a/test-cmdline.c
+++ b/test-cmdline.c
@@ -168,7 +168,7 @@ static struct test_case {
 	{ 1, "-f devname filename 1 foo" },
 	{ 1, "-f" },
 	/* Argument parsing for -N/-U is specialised */
-	{ 0, "-N devname rx-flow-hash tcp4 mvtsdfn" },
+	{ 0, "-N devname rx-flow-hash tcp4 mvtsdfnce" },
 	{ 0, "--config-ntuple devname rx-flow-hash tcp4 r" },
 	{ 1, "-U devname rx-flow-hash tcp4" },
 	{ 1, "--config-nfc devname rx-flow-hash foo" },
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 1d0731b3d289..930e0cf4cdd9 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2009,6 +2009,8 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+#define GTP_V4_FLOW 0x13	/* hash only */
+#define GTP_V6_FLOW 0x14	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2023,6 +2025,8 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_V2_C	(1 << 8) /* type gtpv2-c in case of gtp */
+#define	RXH_GTP_EH	(1 << 9) /* gtp extension header in case of gtp */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


