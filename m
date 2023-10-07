Return-Path: <netdev+bounces-38830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330F7BC9B7
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19BA281D4A
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB6328DB;
	Sat,  7 Oct 2023 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Q3wsEt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BD1845
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 20:15:32 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B008BD
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 13:15:31 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57d086365f7so1862005eaf.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696709730; x=1697314530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+x6rfQhWXhTm1RSMqMW84m0RDGbyDjggmhf9IGytII=;
        b=F1Q3wsEttvRKAodb39OTfa7SPesuHbJKEYI0fVcca+4YAjD6lGQja7WzyoyzS0AeQ6
         WX/3XrgBwntA/LPFiGRLg1Pg/EC2Y1jR0rBA/GYTifrJ0yKf0HRMOSQ0FqT2GpQweQIC
         CVtMqam09zE3kxHRHFsVbXMCQ7Uuq8qg/p0IaCq8JqbjNfOusXizc+HnIJpG7K9hWpox
         iHay8W5t9TprlDmzSY5sRYb57DiAN7lFI1K+3lZi84q/XVVPa1SRMKmzyyA6Wv86dFrj
         Q9iLO4lENRDTrnark1/d0czDGgTq1X9iUQsjRZx7ve4LOzg8cRgj/wUfo6okxj6fWdpe
         tCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696709730; x=1697314530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+x6rfQhWXhTm1RSMqMW84m0RDGbyDjggmhf9IGytII=;
        b=JQInlPHmLQ8bImBs3w/9ENBQ0JkpAukccs+YF33CA555/mp0qKJW0lBDuG6r2xPBNp
         Q32QtfxWALJtvETyYoES1fcc+LMwVKZtqprKtgfWgHrEf99coZ11gkMRQ9dDwbdfFHBq
         U983EeqrwOE61t7oOHDwul8Kz+/+yst7DIi3fLVoCIlnfEeeIMGP2wIPXsLlxRUCZ46t
         BQRDVZMJCN2Ax3uVnA0YzD3zKefjIHghJfF5vl0WSIAV6/57OBroHwSZMZg42NfLAM+I
         g8xGQce/IwVqoFiyqdp7TElf9WaUJEYjpbhNKV4QwFrlpux3S7ne1BE30AY05buu1h1x
         GHyg==
X-Gm-Message-State: AOJu0YwIYfmOhFjyR5giYe5VtOh88wYE4C3gnOBufmQlVIETQ8B1B5Ld
	vWy6smpW/kBkowklEexdFTOaaQiGR0U=
X-Google-Smtp-Source: AGHT+IHIdPwllCeONLOkL+NJSpwdsIMpT8NzeRLVN2a8uxDnZE0AfXndAFhw2AEqXqp/DPwO2YFTzg==
X-Received: by 2002:a05:6358:9042:b0:143:788c:2560 with SMTP id f2-20020a056358904200b00143788c2560mr13252418rwf.15.1696709730170;
        Sat, 07 Oct 2023 13:15:30 -0700 (PDT)
Received: from takehaya-main.. ([2001:e42:407:1028::1000])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001b89a6164desm6321246plg.118.2023.10.07.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:15:29 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH ethtool-next] ethtool: add support for rx-flow-hash gtp
Date: Sun,  8 Oct 2023 05:15:16 +0900
Message-Id: <20231007201516.65612-1-hayatake396@gmail.com>
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
 ethtool.c            | 38 ++++++++++++++++++++++++++++++++++----
 test-cmdline.c       |  2 +-
 uapi/linux/ethtool.h |  6 ++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index af51220b63cc..8cb307596ad7 100644
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
@@ -1010,6 +1014,18 @@ static int parse_rxfhashopts(char *optstr, u32 *data)
 		case 'n':
 			*data |= RXH_L4_B_2_3;
 			break;
+		case 'c':
+			*data |= RXH_GTP_V2_C;
+			break;
+		case 'e':
+			*data |= RXH_GTP_EH;
+			break;
+		case 'u':
+			*data |= RXH_GTP_EH_UL;
+			break;
+		case 'w':
+			*data |= RXH_GTP_EH_DWL;
+			break;
 		case 'r':
 			*data |= RXH_DISCARD;
 			break;
@@ -1042,6 +1058,14 @@ static char *unparse_rxfhashopts(u64 opts)
 			strcat(buf, "L4 bytes 0 & 1 [TCP/UDP src port]\n");
 		if (opts & RXH_L4_B_2_3)
 			strcat(buf, "L4 bytes 2 & 3 [TCP/UDP dst port]\n");
+		if (opts & RXH_GTP_V2_C)
+			strcat(buf, "GTPv2-C Switching Flag [GTP]\n");
+		if (opts & RXH_GTP_EH)
+			strcat(buf, "GTP Extension Header [GTP]\n");
+		if (opts & RXH_GTP_EH_UL)
+			strcat(buf, "GTP Extension Header of Uplink [GTP]\n");
+		if (opts & RXH_GTP_EH_DWL)
+			strcat(buf, "GTP Extension Header of Downlink [GTP]\n");
 	} else {
 		sprintf(buf, "None");
 	}
@@ -1559,6 +1583,9 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V4_FLOW:
 		fprintf(stdout, "SCTP over IPV4 flows");
 		break;
+	case GTP_V4_FLOW:
+		fprintf(stdout, "GTP over IPV4 flows");
+		break;
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1573,6 +1600,9 @@ static int dump_rxfhash(int fhash, u64 val)
 	case SCTP_V6_FLOW:
 		fprintf(stdout, "SCTP over IPV6 flows");
 		break;
+	case GTP_V6_FLOW:
+		fprintf(stdout, "GTP over IPV6 flows");
+		break;
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -5832,16 +5862,16 @@ static const struct option args[] = {
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
diff --git a/test-cmdline.c b/test-cmdline.c
index cb803ed1a93d..c958ea9b159d 100644
--- a/test-cmdline.c
+++ b/test-cmdline.c
@@ -168,7 +168,7 @@ static struct test_case {
 	{ 1, "-f devname filename 1 foo" },
 	{ 1, "-f" },
 	/* Argument parsing for -N/-U is specialised */
-	{ 0, "-N devname rx-flow-hash tcp4 mvtsdfn" },
+	{ 0, "-N devname rx-flow-hash tcp4 mvtsdfnceuw" },
 	{ 0, "--config-ntuple devname rx-flow-hash tcp4 r" },
 	{ 1, "-U devname rx-flow-hash tcp4" },
 	{ 1, "--config-nfc devname rx-flow-hash foo" },
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 1d0731b3d289..e7c49336c77d 100644
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
@@ -2023,6 +2025,10 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_V2_C	(1 << 8) /* type gtpv2-c in case of gtp */
+#define	RXH_GTP_EH	(1 << 9) /* gtp extension header in case of gtp */
+#define	RXH_GTP_EH_UL (1 << 10) /* gtp extension header of uplink in case of gtp */
+#define	RXH_GTP_EH_DWL (1 << 11) /* gtp extension header of downlink in case of gtp */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


