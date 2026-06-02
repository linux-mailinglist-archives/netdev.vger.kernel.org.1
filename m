Return-Path: <netdev+bounces-294001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMX/BG9XHmrfigkAu9opvQ
	(envelope-from <netdev+bounces-294001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E8627FCA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B4853006F22
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9238D6B8;
	Tue,  2 Jun 2026 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eZ7h7uq3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD963559F2;
	Tue,  2 Jun 2026 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373177; cv=none; b=D9w9VIGAqFkj4JtE0QihOONxhhTNgAV5Wg+PSE1BEkFZNa4BmWba+O13B9IUbilq5gZrwDEAu/3HKc21Iwbr8LmPLMFubpl9u4JkUviwdUNsJs8RakFwq30L+pKbdIR1ngj+uLL443dvZhubpgbuQi0HRJ68fmIIae8Q6Whww4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373177; c=relaxed/simple;
	bh=odVbkLsYc9zXin6N4ErtJEXLgr26WWoRUV9OtU/6Lfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uttEfCe5TFMCLuayRfv55gPYbLg4uJB6XPlUo8sMuu26OwzzgSbvnp2YC5Vf+De1kQaOI1h02PP6Ws6CgfWqGmsEAbOR5IaXJfdJ7OhHxGNv8Zm+1mH7yfIMxPdO6v4QMGLBvaty0kH4M28I6N214Yx1mszrqK6hqMECi4RB6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eZ7h7uq3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520KUhd2859173;
	Mon, 1 Jun 2026 21:06:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=DL79iEY7HfT00ja8qClxL7B
	FCeWPH8BjqXAE1qQcsv8=; b=eZ7h7uq3DJrDbGshpjd71GvmsOPYFYcTZ+Vm8mb
	kUI98O0MEsSN/oBL4ygT0tNyGGgFl35KJAuY5BIyzySjfyU0NJhu0L+uOiy0sGFC
	jV8VLyXNuYibUnDMNum+Ax9AJblDjiLZi8fhbqt37hGLZJNx2soUecZaZmU7AVs8
	t+goWdBXPrMV17iZ4oq3e7nstTjsYChqOCaNPIlCI8fQonni6oMo/MnybR6AodFu
	/Wiv35+b6Wu3DoL6FyqfBkHQuDfCk8rHGPt8CkDsBzdh++p71C1/jwliiDq9OybC
	DY9LOpDdC9U3ayBqruv1npmLTQZMlnVA41zN4Iu43qJxp5w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxra6r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 21:06:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 21:06:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 21:06:02 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 121ED3F7062;
	Mon,  1 Jun 2026 21:05:55 -0700 (PDT)
From: Nitin Shetty J <nshettyj@marvell.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: <kirankumark@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>,
        "Andrew
 Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] octeontx2-af: kpu: Default profile updates
Date: Tue, 2 Jun 2026 09:35:25 +0530
Message-ID: <20260602040535.3975769-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1e56ab cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=_Xelv-kuwsPPiQfreVYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzNCBTYWx0ZWRfX+AdsVSk/Z4Ut
 O5yU3KR+JiGbrV7zA/WS1F2utMf7fbBnn5EpnfIiN8YL+GF4OBSsoETluuS5geT8382PeGzyaeW
 ucr9NkuNu+beDj7q/Z4/qctjyMmHeDZrMvp9i0nlvCLQscyb6aA8ZT/hyDIQzSKYUScrybm9x8z
 MpwhorTmWJwfUR943ugbZqo7JXzZxfuz7NeqNHRdPIQm9lNewiMKU4TjthNxeauAqZQGQgfXI5q
 jztSlBdL1pDzbk2At1HtMEtzcPYBLh3NIU3nlUdFzjKGxlhFDz+nUuCnWDr+h88n3mec4kfjCdF
 31Di5+5O1cXZbyiHYHoI+XTpuyTetTl+W/OuCTkX4afjzek0XUGaa8UCpwnbvppfm4zb6tMAbdk
 DPotVsO3DT4ImBSqto56v/ghJklUXWHz7w2X1284tV/FsUdYFPOvoeBzs8R/jFKtYFRAhscJrpX
 6BLqlxlpGFY6kCX552g==
X-Proofpoint-ORIG-GUID: 4qyIfcjg5dW39rJdG-Utcp1uWg4RjGBl
X-Proofpoint-GUID: tD1zZjaCvpw36jJ6Wx6Bg6cdnO60a0ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294001-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3D8E8627FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kiran Kumar K <kirankumark@marvell.com>

Add support for parsing the following:
1. fabric path header
2. tpids 0x88a8, 0x9100 and 0x9200 parsing for
   first pass and second pass packets
3. parse stacked VLANs
4. RoCEv2 header with UDP destination port 4791
5. single SBTAG parsing

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |    2 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |    2 +
 .../marvell/octeontx2/af/npc_profile.h        | 1260 +++++++++++++++--
 3 files changed, 1134 insertions(+), 130 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 6b3f453fd500..003487d7c3cf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -57,7 +57,7 @@ static struct npc_mcam_kex_extr npc_mkex_extr_default = {
 	.keyx_cfg = {
 		/* nibble: LA..LE (ltype only) + Error code + Channel */
 		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) |
-			NPC_PARSE_NIBBLE_INTF_RX |
+			NPC_CN20K_PARSE_NIBBLE_INTF_RX |
 				 NPC_CN20K_PARSE_NIBBLE_ERRCODE,
 
 		/* nibble: LA..LE (ltype only) */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index cefc5d70f3e4..2138c044fe41 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -41,6 +41,7 @@ enum npc_kpu_la_ltype {
 	NPC_LT_LA_CPT_HDR,
 	NPC_LT_LA_CUSTOM_L2_24B_ETHER,
 	NPC_LT_LA_CUSTOM_PRE_L2_ETHER,
+	NPC_LT_LA_FP_ETHER,
 	NPC_LT_LA_CUSTOM0 = 0xE,
 	NPC_LT_LA_CUSTOM1 = 0xF,
 };
@@ -114,6 +115,7 @@ enum npc_kpu_le_ltype {
 	NPC_LT_LE_TU_MPLS_IN_GRE,
 	NPC_LT_LE_TU_NSH_IN_GRE,
 	NPC_LT_LE_TU_MPLS_IN_UDP,
+	NPC_LT_LE_ROCEV2,
 	NPC_LT_LE_CUSTOM0 = 0xE,
 	NPC_LT_LE_CUSTOM1 = 0xF,
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index db74f7fdf028..62902f0ad686 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -30,12 +30,14 @@
 #define NPC_ETYPE_PTP		0x88f7
 #define NPC_ETYPE_FCOE		0x8906
 #define NPC_ETYPE_QINQ		0x9100
+#define NPC_ETYPE_QINQ2		0x9200
 #define NPC_ETYPE_TRANS_ETH_BR	0x6558
 #define NPC_ETYPE_PPP		0x880b
 #define NPC_ETYPE_NSH		0x894f
 #define NPC_ETYPE_DSA		0xdada
 #define NPC_ETYPE_PPPOE		0x8864
 #define NPC_ETYPE_ERSPA		0x88be
+#define NPC_ETYPE_FP		0x8903
 
 #define NPC_PPP_IP		0x0021
 #define NPC_PPP_IP6		0x0057
@@ -73,6 +75,7 @@
 #define NPC_UDP_PORT_GENEVE	6081
 #define NPC_UDP_PORT_MPLS	6635
 #define NPC_UDP_PORT_ESP	4500
+#define NPC_UDP_PORT_ROCEV2     4791
 
 #define NPC_VXLANGPE_NP_IP	0x1
 #define NPC_VXLANGPE_NP_IP6	0x2
@@ -191,6 +194,8 @@ enum npc_kpu_parser_state {
 	NPC_S_KPU2_EXDSA,
 	NPC_S_KPU2_CPT_CTAG,
 	NPC_S_KPU2_CPT_QINQ,
+	NPC_S_KPU2_CPT_CTAG2,
+	NPC_S_KPU2_CPT_SBTAG,
 	NPC_S_KPU2_MT,
 	NPC_S_KPU3_CTAG,
 	NPC_S_KPU3_STAG,
@@ -200,6 +205,9 @@ enum npc_kpu_parser_state {
 	NPC_S_KPU3_QINQ_C,
 	NPC_S_KPU3_DSA,
 	NPC_S_KPU3_VLAN_EXDSA,
+	NPC_S_KPU3_CPT_QINQ,
+	NPC_S_KPU3_CPT_CTAG,
+	NPC_S_KPU3_CPT_STAG,
 	NPC_S_KPU4_MPLS,
 	NPC_S_KPU4_NSH,
 	NPC_S_KPU4_FDSA,
@@ -281,6 +289,14 @@ enum npc_kpu_parser_state {
 	NPC_S_LAST /* has to be the last item */
 };
 
+enum npc_kpu9_extra_parser_state {
+	NPC_S_KPU9_ROCEV2 = NPC_S_LAST + 6,
+};
+
+enum npc_kpu4_extra_parser_state {
+	NPC_S_KPU4_SBTAG_PTP = NPC_S_LAST + 7,
+};
+
 enum npc_kpu_la_uflag {
 	NPC_F_LA_U_HAS_TAG = 0x10,
 	NPC_F_LA_U_HAS_IH_NIX = 0x20,
@@ -504,7 +520,7 @@ enum NPC_ERRLEV_E {
 static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -513,7 +529,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -522,7 +538,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -531,7 +547,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -540,7 +556,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -549,7 +565,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -558,7 +574,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -567,7 +583,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -576,7 +592,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -585,7 +601,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -594,7 +610,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -603,7 +619,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -612,7 +628,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -621,7 +637,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -630,7 +646,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -639,7 +655,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -648,7 +664,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -657,7 +673,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -666,7 +682,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -675,7 +691,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -684,7 +700,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -693,7 +709,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -702,7 +718,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -711,7 +727,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -720,7 +736,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -729,7 +745,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -738,7 +754,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -747,7 +763,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -756,7 +772,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -765,7 +781,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -774,7 +790,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -783,7 +799,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -792,7 +808,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -801,7 +817,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -810,7 +826,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -819,7 +835,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -828,7 +844,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -837,7 +853,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -846,7 +862,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -855,7 +871,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -864,7 +880,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -873,7 +889,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -882,7 +898,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -891,7 +907,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -900,7 +916,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -909,7 +925,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -918,7 +934,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -927,7 +943,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -936,7 +952,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -945,7 +961,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -954,7 +970,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -963,7 +979,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -972,7 +988,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -981,7 +997,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		12, 16, 20, 0, 0,
+		12, 16, 28, 0, 0,
 		NPC_S_KPU1_ETHER, 0, 0,
 		NPC_LID_LA, NPC_LT_NA,
 		0,
@@ -1087,6 +1103,141 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_IP,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_IP6,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_ARP,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_RARP,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_PTP,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_FCOE,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_CTAG,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_SBTAG,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_QINQ,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_ETAG,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_MPLSU,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_MPLSM,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_NSH,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_DSA,
+		0xffff,
+	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_FP,
+		0xffff,
+		0x0000,
+		0x0000,
+		NPC_ETYPE_PPPOE,
+		0xffff,
+	},
 	{
 		NPC_S_KPU1_ETHER, 0xff,
 		NPC_ETYPE_IP,
@@ -1159,6 +1310,15 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_SBTAG,
+		0xffff,
+		NPC_ETYPE_PTP,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU1_ETHER, 0xff,
 		NPC_ETYPE_SBTAG,
@@ -1177,6 +1337,15 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU1_ETHER, 0xff,
+		NPC_ETYPE_QINQ2,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU1_ETHER, 0xff,
 		NPC_ETYPE_ETAG,
@@ -1852,6 +2021,15 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU1_CPT_HDR, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU1_CPT_HDR, 0xff,
 		NPC_ETYPE_CTAG,
@@ -1870,6 +2048,24 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU1_CPT_HDR, 0xff,
+		NPC_ETYPE_QINQ2,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU1_CPT_HDR, 0xff,
+		NPC_ETYPE_SBTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU1_VLAN_EXDSA, 0xff,
 		NPC_ETYPE_CTAG,
@@ -2005,6 +2201,33 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		NPC_PPP_IP6,
 		0xffff,
 	},
+	{
+		NPC_S_KPU2_CTAG, 0xff,
+		NPC_ETYPE_SBTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CTAG, 0xff,
+		NPC_ETYPE_QINQ,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CTAG, 0xff,
+		NPC_ETYPE_QINQ2,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU2_CTAG, 0xff,
 		0x0000,
@@ -2230,6 +2453,24 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU2_SBTAG, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_SBTAG, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU2_SBTAG, 0xff,
 		0x0000,
@@ -2347,6 +2588,24 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU2_QINQ, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_QINQ, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU2_QINQ, 0xff,
 		0x0000,
@@ -2437,6 +2696,15 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU2_ETAG, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU2_ETAG, 0xff,
 		NPC_ETYPE_CTAG,
@@ -2807,7 +3075,43 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 	},
 	{
-		NPC_S_KPU2_MT, 0xff,
+		NPC_S_KPU2_CPT_QINQ, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_QINQ, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_CTAG2, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_CTAG2, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_CTAG2, 0xff,
 		NPC_ETYPE_CTAG,
 		0xffff,
 		0x0000,
@@ -2816,7 +3120,7 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 	},
 	{
-		NPC_S_KPU2_MT, 0xff,
+		NPC_S_KPU2_CPT_CTAG2, 0xff,
 		0x0000,
 		0x0000,
 		0x0000,
@@ -2825,7 +3129,61 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 		0x0000,
 	},
 	{
-		NPC_S_NA, 0X00,
+		NPC_S_KPU2_CPT_SBTAG, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_SBTAG, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_SBTAG, 0xff,
+		NPC_ETYPE_SBTAG,
+		0xffff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_SBTAG, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_CPT_SBTAG, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_MT, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU2_MT, 0xff,
 		0x0000,
 		0x0000,
 		0x0000,
@@ -3256,6 +3614,42 @@ static struct npc_kpu_profile_cam kpu3_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU3_CTAG_C, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CTAG_C, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CTAG_C, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_MPLSU,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CTAG_C, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_MPLSM,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU3_CTAG_C, 0xff,
 		NPC_ETYPE_IP,
@@ -3806,7 +4200,43 @@ static struct npc_kpu_profile_cam kpu3_cam_entries[] __maybe_unused = {
 		0x0000,
 	},
 	{
-		NPC_S_NA, 0X00,
+		NPC_S_KPU3_CPT_QINQ, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_QINQ, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_QINQ, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_QINQ, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_QINQ, 0xff,
 		0x0000,
 		0x0000,
 		0x0000,
@@ -3814,6 +4244,60 @@ static struct npc_kpu_profile_cam kpu3_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU3_CPT_CTAG, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_CTAG, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_STAG, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_STAG, 0xff,
+		NPC_ETYPE_CTAG,
+		0xffff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_STAG, 0xff,
+		NPC_ETYPE_IP,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU3_CPT_STAG, 0xff,
+		NPC_ETYPE_IP6,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 };
 
 static struct npc_kpu_profile_cam kpu4_cam_entries[] __maybe_unused = {
@@ -4120,6 +4604,15 @@ static struct npc_kpu_profile_cam kpu4_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU4_SBTAG_PTP, 0xff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_NA, 0X00,
 		0x0000,
@@ -6397,6 +6890,15 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU8_UDP, 0xff,
+		NPC_UDP_PORT_ROCEV2,
+		0xffff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU8_UDP, 0xff,
 		NPC_UDP_PORT_VXLAN,
@@ -7252,6 +7754,15 @@ static struct npc_kpu_profile_cam kpu9_cam_entries[] __maybe_unused = {
 		0x0000,
 		0x0000,
 	},
+	{
+		NPC_S_KPU9_ROCEV2, 0xff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
 	{
 		NPC_S_KPU9_VXLAN, 0xff,
 		0x0000,
@@ -8080,6 +8591,24 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
+	{
+		NPC_S_KPU12_TU_IP, 0xff,
+		0x0000,
+		NPC_IP_TTL_MASK,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+	},
+	{
+		NPC_S_KPU12_TU_IP, 0xff,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0000,
+		0x0001,
+		NPC_IP_HDR_FRAGOFF,
+	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
 		NPC_IPNH_TCP,
@@ -8087,7 +8616,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8096,7 +8625,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8105,7 +8634,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8114,7 +8643,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8123,7 +8652,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8132,7 +8661,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
-		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8141,7 +8670,16 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
 		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
+	},
+	{
+		NPC_S_KPU12_TU_IP, 0xff,
+		0x0000,
+		0x0000,
+		NPC_IP_VER_4 | NPC_IP_HDR_LEN_5,
+		NPC_IP_VER_MASK | NPC_IP_HDR_LEN_MASK,
 		0x0000,
+		NPC_IP_HDR_MF | NPC_IP_HDR_FRAGOFF,
 	},
 	{
 		NPC_S_KPU12_TU_IP, 0xff,
@@ -8647,6 +9185,126 @@ static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 3, 0,
+		NPC_S_KPU5_IP, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 3, 0,
+		NPC_S_KPU5_IP6, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 3, 0,
+		NPC_S_KPU5_ARP, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 3, 0,
+		NPC_S_KPU5_RARP, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 3, 0,
+		NPC_S_KPU5_PTP, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 3, 0,
+		NPC_S_KPU5_FCOE, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 12, 0, 0,
+		NPC_S_KPU2_CTAG, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 22, 0, 0,
+		NPC_S_KPU2_SBTAG, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 0, 0, 0,
+		NPC_S_KPU2_QINQ, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 12, 26, 0, 0,
+		NPC_S_KPU2_ETAG, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_ETAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 10, 2, 0,
+		NPC_S_KPU4_MPLS, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_L_WITH_MPLS,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 10, 2, 0,
+		NPC_S_KPU4_MPLS, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_L_WITH_MPLS,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 0, 0, 2, 0,
+		NPC_S_KPU4_NSH, 30, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		NPC_F_LA_L_WITH_NSH,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 12, 0, 1, 0,
+		NPC_S_KPU3_DSA, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 12, 0, 2, 0,
+		NPC_S_KPU4_PPPOE, 28, 1,
+		NPC_LID_LA, NPC_LT_LA_FP_ETHER,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 3, 0,
@@ -8711,6 +9369,14 @@ static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 22, 2, 0,
+		NPC_S_KPU4_SBTAG_PTP, 12, 1,
+		NPC_LID_LA, NPC_LT_LA_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		4, 8, 22, 0, 0,
@@ -8727,6 +9393,14 @@ static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 0, 0, 0,
+		NPC_S_KPU2_QINQ, 12, 1,
+		NPC_LID_LA, NPC_LT_LA_ETHER,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 12, 26, 0, 0,
@@ -9346,6 +10020,14 @@ static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 12, 0, 0, 0,
+		NPC_S_KPU2_CPT_CTAG2, 12, 1,
+		NPC_LID_LA, NPC_LT_LA_CPT_HDR,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		4, 8, 0, 0, 0,
@@ -9362,6 +10044,22 @@ static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 0, 0, 0,
+		NPC_S_KPU2_CPT_QINQ, 12, 1,
+		NPC_LID_LA, NPC_LT_LA_CPT_HDR,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 22, 0, 0,
+		NPC_S_KPU2_CPT_SBTAG, 12, 1,
+		NPC_LID_LA, NPC_LT_LA_CPT_HDR,
+		NPC_F_LA_U_HAS_TAG | NPC_F_LA_L_WITH_VLAN,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		12, 0, 0, 1, 0,
@@ -9483,6 +10181,30 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 0, 0, 0,
+		NPC_S_KPU3_STAG, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_STAG_STAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 0, 0, 0,
+		NPC_S_KPU3_STAG, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_STAG_STAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 0, 0, 0,
+		NPC_S_KPU3_STAG, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_STAG_STAG,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -9683,6 +10405,22 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_ITAG_UNK,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_IP, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_IP6, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -9787,6 +10525,22 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_QINQ_QINQ,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_IP, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_IP6, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
@@ -9869,8 +10623,16 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		2, 0, 0, 0, 0,
-		NPC_S_KPU3_CTAG, 10, 1,
+		0, 4, 8, 0, 0,
+		NPC_S_KPU3_CTAG_C, 16, 1,
+		NPC_LID_LB, NPC_LT_LB_ETAG,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 4, 8, 0, 0,
+		NPC_S_KPU3_CTAG_C, 12, 1,
 		NPC_LID_LB, NPC_LT_LB_ETAG,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
@@ -10109,88 +10871,176 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 42, 2, 0,
-		NPC_S_KPU5_IP6, 10, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_L_EXDSA,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_IP6, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 2, 0,
+		NPC_S_KPU5_ARP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_RARP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 0, 2, 0,
+		NPC_S_KPU5_PTP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 2, 0,
+		NPC_S_KPU5_FCOE, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		4, 8, 0, 0, 0,
+		NPC_S_KPU3_CTAG, 8, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA_VLAN,
+		NPC_F_LB_L_EXDSA_VLAN,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 0, 1,
+		NPC_LID_LB, NPC_LT_LB_EXDSA,
+		NPC_F_LB_U_UNK_ETYPE | NPC_F_LB_L_EXDSA,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_CPT_IP, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_CTAG,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 0, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_CTAG,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_CPT_IP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 0, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_CPT_IP, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 2, 0,
-		NPC_S_KPU5_ARP, 10, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_L_EXDSA,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 6, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 2, 0,
-		NPC_S_KPU5_RARP, 10, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_L_EXDSA,
+		NPC_S_KPU5_CPT_IP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
-		NPC_S_KPU5_PTP, 10, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_L_EXDSA,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		0,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 2, 0,
-		NPC_S_KPU5_FCOE, 10, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_L_EXDSA,
+		2, 6, 0, 0, 0,
+		NPC_S_KPU3_CPT_QINQ, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_QINQ_QINQ,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		4, 8, 0, 0, 0,
-		NPC_S_KPU3_CTAG, 8, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA_VLAN,
-		NPC_F_LB_L_EXDSA_VLAN,
+		2, 6, 0, 0, 1,
+		NPC_S_KPU3_CPT_QINQ, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_QINQ_QINQ,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 1,
-		NPC_LID_LB, NPC_LT_LB_EXDSA,
-		NPC_F_LB_U_UNK_ETYPE | NPC_F_LB_L_EXDSA,
+		8, 0, 6, 2, 0,
+		NPC_S_KPU5_CPT_IP, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		8, 0, 6, 2, 0,
-		NPC_S_KPU5_CPT_IP, 6, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
-		0,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
-		NPC_S_KPU5_CPT_IP6, 6, 1,
-		NPC_LID_LB, NPC_LT_LB_CTAG,
-		0,
+		2, 6, 0, 0, 0,
+		NPC_S_KPU3_CPT_CTAG, 10, 1,
+		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
+		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_STAG_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 2, 0,
-		NPC_S_KPU5_CPT_IP, 10, 1,
+		NPC_S_KPU5_CPT_IP, 6, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		6, 0, 0, 2, 0,
-		NPC_S_KPU5_CPT_IP6, 10, 1,
+		6, 0, 42, 2, 0,
+		NPC_S_KPU5_CPT_IP6, 6, 1,
 		NPC_LID_LB, NPC_LT_LB_STAG_QINQ,
 		NPC_F_LB_U_MORE_TAG | NPC_F_LB_L_WITH_CTAG,
 		0, 0, 0, 0,
@@ -10211,14 +11061,6 @@ static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 		0,
 		0, 0, 0, 0,
 	},
-	{
-		NPC_ERRLEV_LB, NPC_EC_L2_K3,
-		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 0,
-		NPC_LID_LB, NPC_LT_NA,
-		0,
-		0, 0, 0, 0,
-	},
 };
 
 static struct npc_kpu_profile_action kpu3_action_entries[] __maybe_unused = {
@@ -10589,13 +11431,45 @@ static struct npc_kpu_profile_action kpu3_action_entries[] __maybe_unused = {
 		0, 0, 0, 0,
 	},
 	{
-		NPC_ERRLEV_LB, NPC_EC_L2_K3_ETYPE_UNK,
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 0, 0, 1,
 		NPC_S_NA, 0, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_IP, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_IP6, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 10, 0, 0,
+		NPC_S_KPU4_MPLS, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		2, 6, 10, 0, 0,
+		NPC_S_KPU4_MPLS, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		8, 0, 6, 1, 0,
@@ -11085,9 +11959,89 @@ static struct npc_kpu_profile_action kpu3_action_entries[] __maybe_unused = {
 		0, 0, 0, 0,
 	},
 	{
-		NPC_ERRLEV_LB, NPC_EC_L2_K3,
-		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 0,
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_CPT_IP, 8, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_CPT_IP6, 8, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_CPT_IP, 4, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_CPT_IP6, 4, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 1,
+		NPC_S_KPU5_CPT_IP6, 4, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_CPT_IP, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_CPT_IP6, 6, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_CPT_IP, 8, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_CPT_IP6, 8, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 1, 0,
+		NPC_S_KPU5_CPT_IP, 4, 0,
+		NPC_LID_LB, NPC_LT_NA,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		6, 0, 42, 1, 0,
+		NPC_S_KPU5_CPT_IP6, 4, 0,
 		NPC_LID_LB, NPC_LT_NA,
 		0,
 		0, 0, 0, 0,
@@ -11365,6 +12319,14 @@ static struct npc_kpu_profile_action kpu4_action_entries[] __maybe_unused = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		8, 0, 6, 0, 0,
+		NPC_S_KPU5_PTP, 4, 1,
+		NPC_LID_LB, NPC_LT_LB_CTAG,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_LB, NPC_EC_L2_K4,
 		0, 0, 0, 0, 1,
@@ -11696,7 +12658,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 2, 0,
+		2, 0, 0, 2, 0,
 		NPC_S_KPU8_GRE, 40, 1,
 		NPC_LID_LC, NPC_LT_LC_IP6,
 		0,
@@ -12176,7 +13138,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 2, 0,
+		2, 0, 0, 2, 0,
 		NPC_S_KPU8_GRE, 40, 1,
 		NPC_LID_LC, NPC_LT_LC_IP6,
 		0,
@@ -12481,7 +13443,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 1, 0,
+		2, 0, 0, 1, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -12593,7 +13555,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 1, 0,
+		2, 0, 0, 1, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -12697,7 +13659,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 1, 0,
+		2, 0, 0, 1, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -12793,7 +13755,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 1, 0,
+		2, 0, 0, 1, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -12905,7 +13867,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 1, 0,
+		2, 0, 0, 1, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -13034,7 +13996,7 @@ static struct npc_kpu_profile_action kpu7_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 0, 0,
+		2, 0, 0, 0, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -13226,7 +14188,7 @@ static struct npc_kpu_profile_action kpu7_action_entries[] __maybe_unused = {
 	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
-		0, 0, 0, 0, 0,
+		2, 0, 0, 0, 0,
 		NPC_S_KPU8_GRE, 8, 0,
 		NPC_LID_LC, NPC_LT_NA,
 		0,
@@ -13393,6 +14355,14 @@ static struct npc_kpu_profile_action kpu8_action_entries[] __maybe_unused = {
 		NPC_F_LD_L_TCP_UNK_PORT_HAS_OPTIONS,
 		12, 0xf0, 1, 2,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 2, 0, 0,
+		NPC_S_KPU9_ROCEV2, 8, 1,
+		NPC_LID_LD, NPC_LT_LD_UDP,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		0, 0, 2, 0, 0,
@@ -13538,10 +14508,10 @@ static struct npc_kpu_profile_action kpu8_action_entries[] __maybe_unused = {
 		0, 0, 0, 0,
 	},
 	{
-		NPC_ERRLEV_LD, NPC_EC_NVGRE,
-		0, 0, 0, 0, 1,
-		NPC_S_NA, 0, 0,
-		NPC_LID_LD, NPC_LT_NA,
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		12, 16, 20, 2, 0,
+		NPC_S_KPU11_TU_ETHER, 4, 1,
+		NPC_LID_LD, NPC_LT_LD_GRE,
 		0,
 		0, 0, 0, 0,
 	},
@@ -14154,6 +15124,14 @@ static struct npc_kpu_profile_action kpu9_action_entries[] __maybe_unused = {
 		0,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 8, 1,
+		NPC_LID_LE, NPC_LT_LE_ROCEV2,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		12, 16, 20, 1, 0,
@@ -14893,6 +15871,22 @@ static struct npc_kpu_profile_action kpu12_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
+	{
+		NPC_ERRLEV_LC, NPC_EC_IP_TTL_0,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 0, 1,
+		NPC_LID_LG, NPC_LT_LG_TU_IP,
+		0,
+		0, 0, 0, 0,
+	},
+	{
+		NPC_ERRLEV_LC, NPC_EC_IP_FRAG_OFFSET_1,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 0, 1,
+		NPC_LID_LG, NPC_LT_LG_TU_IP,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		2, 12, 0, 2, 0,
@@ -14957,6 +15951,14 @@ static struct npc_kpu_profile_action kpu12_action_entries[] __maybe_unused = {
 		NPC_F_LG_U_UNK_IP_PROTO,
 		0, 0, 0, 0,
 	},
+	{
+		NPC_ERRLEV_RE, NPC_EC_NOERR,
+		0, 0, 0, 0, 1,
+		NPC_S_NA, 0, 1,
+		NPC_LID_LG, NPC_LT_LG_TU_IP,
+		0,
+		0, 0, 0, 0,
+	},
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		2, 12, 0, 2, 0,
-- 
2.48.1


