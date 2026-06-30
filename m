Return-Path: <netdev+bounces-302983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pl3hCNVgQ2qAXgoAu9opvQ
	(envelope-from <netdev+bounces-302983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171A6E0B72
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=bFxXJ1gm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302983-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2FDF30091F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478F3E7166;
	Tue, 30 Jun 2026 06:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201C3E6388;
	Tue, 30 Jun 2026 06:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800542; cv=none; b=Mdo78oa7Z7qXR9kC7NJqfL883Akuir3r7Rx3h/J9K8Cm+KV3lsaRjRvWLBJYT+euS8mTg/3xbGzoomcTAs6Nup4renWuFy92iozILsj9UonFtql/B5k5eNdl8XD5QId8G8VJHVwwBRYtMtM7pzvgwKgd5e8Z5YmcDfZS7GlzohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800542; c=relaxed/simple;
	bh=2qQkAGkJ8RG7Pv5RCEslgQMJGuw1MRty1nTa+PrIFOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcxyg8lKI4al5K/Gad+lsLDQ+It2WsZLuHai92RfVPHY4WteRU2jxdoplx+Z6cDKofBK9hETlvvyrw4FQT4xmE/jp6C1t3/rLBw0a33B8PcYEFz0xCuvaDrnWIKtNeLYinVIHmN1lT0RrY0B5h4OYGC/ULPhZgQ3Yab4vGUe9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bFxXJ1gm; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5dDo43731592;
	Mon, 29 Jun 2026 23:22:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	P3ivRcY35XQ4N63wYMYi7gFMNCJSojlecWoRN9pDhs=; b=bFxXJ1gm5F0E4NrrV
	5LIn60CtWV7otYY3LUJBmecdYw2jNI7TGKd77j334J+IbvqsTTJ3zWuHvwC86jvD
	/CRw5q64c9qVG8AoRXy+DWGldT1LnIcU5xwl4p3e+UPmRuWJCa6Si0Ma6X4fZKzI
	kBShbJ25SJFI/po51thvRRa7PLcaK+NfGPk0sDz3tm+elCHcMdqaAqExZtEvE8B6
	Y7MenfXoov2J3qOpFRSwa+YjU7YvjNTCkogBcsd1WVMVI2zzkww6LFsBmdifFy7j
	f+pxuOGODeuNIWsyJkoF4Va1aQRJ0x/WlsIAht1q9i2xK0vf+0Fk8zLQcq6wXZeR
	6ahvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f42dfh081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 23:22:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 23:22:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 23:22:09 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 0E3793F7068;
	Mon, 29 Jun 2026 23:22:04 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Kiran Kumar K <kirankumark@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>
Subject: [PATCH v2 1/2] octeontx2-af: reserve 4 PKINDs for skip-size custom use
Date: Tue, 30 Jun 2026 11:51:44 +0530
Message-ID: <20260630062145.2533816-2-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260630062145.2533816-1-nshettyj@marvell.com>
References: <20260630062145.2533816-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfXzdJDltZ76Isr
 kKI6OSyZL4tVYb0ZlHAB3FAkkzkyt+e5LZ919vtZxK/36KEFtMZ2//6e18ibtmb9hYuYFv6r1cq
 6Ft9eTu1OM2lpnx+lDBU4qGx5n1rJ4I=
X-Proofpoint-ORIG-GUID: FZv6LVrAkKqat1dl67kVKx_I_oIZ6Csf
X-Authority-Analysis: v=2.4 cv=Zrvd7d7G c=1 sm=1 tr=0 ts=6a436092 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=zuButbC3y48gSnXE8rEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: MekhZyiH_AzT830q6utkJ8OTisKeWaS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfX+IO0ADft0MlU
 Q082rCifxb2RUbcU8e3KilUogsUiaiveadS+AhqfhLDHRxF04jwgacelRWt5yH+zFGKa/DBitCW
 +AtsYtSpjkrizSFv3If5gDmJcp+wHEj5Mb2MNgiToamlWLmxAYf31bBpAd51qDJcqSDnH2Zkv7h
 C4WrLLs96NDXUc5UbZ3lrJfQhNFRGv2isc4t33rIS57USRw4XAEpMeovcAUCPsL0hlqe1VZleN8
 JZL4wyo9ZP2Sl4DEwDN/sIJ9MfXEAToKZ/n32MZNb1ywMLvlKVSrbJoF8hFMMNAuIZcOenRITj2
 632B8+TuHzEv5aXE7c7ypXr67uPkf/BxtE5B03sdgk2H2KfL08L6O5Yge/Codi1VfVTRChtLaJC
 Jp41yaDE4Ka+q/h9MqOcoeav96UpHAVMwFUjYAjSTv/3zfhpcwzkhAQIUWHGxZTHHXBWRqnG6E4
 d/lOwz+mOCNB/+IBxRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302983-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kirankumark@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2171A6E0B72

From: Kiran Kumar K <kirankumark@marvell.com>

The NPC block uses PKINDs to determine how incoming packets are
parsed. Reserve PKINDs 46-49 (NPC_RX_SKIP_SIZE_PKIND) for
configurable L2 skip-size use in the first pass, and PKINDs 50-53
(NPC_RX_CPT_SKIP_SIZE_PKIND) for the second pass where packets
carry a CPT (Cryptographic Accelerator Unit) header.

Add npc_set_skip_size_pkind() to program NPC_AF_PKINDX_ACTION0
for these reserved PKINDs with a user-supplied ptr_advance value
representing the L2 size to skip. For the corresponding CPT PKINDs
(pkind + 4), additionally configure the var_len_offset, var_len_mask,
var_len_shift, and var_len_right fields so the NPC can extract the
inner payload length from the CPT header.

Update rvu_npc_set_parse_mode() to accept a new skip_size argument
and dispatch to npc_set_skip_size_pkind() when the requested PKIND
falls in the newly reserved range. Extend the npc_set_pkind mbox
message struct with a skip_size field so PF/VF drivers can supply
this value at run time.

Advance NPC_UNRESERVED_PKIND_COUNT to NPC_RX_SKIP_SIZE_PKIND to
reflect the updated reservation boundary.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
v2:
- Fixed coding style.
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 43 +++++++++++++++++--
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 714e47f68d93..83f0da3a93fb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -803,6 +803,7 @@ struct npc_set_pkind {
 			 */
 	u8 var_len_off_mask; /* Mask for length with in offset */
 	u8 shift_dir; /* shift direction to get length of the header at var_len_off */
+	u8 skip_size; /* l2 size to skip */
 };
 
 /* NPA mbox message formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index eaed172f1606..719b3618eeb5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -161,10 +161,12 @@ enum npc_kpu_lh_ltype {
  * Software assigns pkind for each incoming port such as CGX
  * Ethernet interfaces, LBK interfaces, etc.
  */
-#define NPC_UNRESERVED_PKIND_COUNT NPC_RX_CPT_HDR_PTP_PKIND
+#define NPC_UNRESERVED_PKIND_COUNT NPC_RX_SKIP_SIZE_PKIND
 
 enum npc_pkind_type {
 	NPC_RX_LBK_PKIND = 0ULL,
+	NPC_RX_SKIP_SIZE_PKIND = 46ULL,
+	NPC_RX_CPT_SKIP_SIZE_PKIND = 50ULL,
 	NPC_RX_CPT_HDR_PTP_PKIND = 54ULL,
 	NPC_RX_CUSTOM_PRE_L2_PKIND = 55ULL,
 	NPC_RX_VLAN_EXDSA_PKIND = 56ULL,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7f3505ae6860..c5610f242687 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1181,7 +1181,7 @@ void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool ena);
 
 int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 			   u64 pkind, u8 var_len_off, u8 var_len_off_mask,
-			   u8 shift_dir);
+			   u8 shift_dir, u8 skip_size);
 int rvu_get_hwvf(struct rvu *rvu, int pcifunc);
 
 /* CN10K MCS */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 0297c7ab0614..144076e161c6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5392,7 +5392,7 @@ void rvu_nix_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int nixlf)
 
 	/* reset HW config done for Switch headers */
 	rvu_npc_set_parse_mode(rvu, pcifunc, OTX2_PRIV_FLAGS_DEFAULT,
-			       (PKIND_TX | PKIND_RX), 0, 0, 0, 0);
+			       (PKIND_TX | PKIND_RX), 0, 0, 0, 0, 0);
 
 	/* Disabling CGX and NPC config done for PTP */
 	if (pfvf->hw_rx_tstamp_en) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..08b83de9beb4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -4194,10 +4194,40 @@ npc_set_var_len_offset_pkind(struct rvu *rvu, u16 pcifunc, u64 pkind,
 	return 0;
 }
 
+static int npc_set_skip_size_pkind(struct rvu *rvu, u16 pcifunc, u64 pkind,
+				   u8 skip_size)
+{
+	struct npc_kpu_action0 *act0;
+	int blkaddr;
+	u64 val;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, pcifunc);
+	if (blkaddr < 0) {
+		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
+		return -EINVAL;
+	}
+
+	val = rvu_read64(rvu, blkaddr, NPC_AF_PKINDX_ACTION0(pkind));
+	act0 = (struct npc_kpu_action0 *)&val;
+	act0->ptr_advance = skip_size;
+	rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_ACTION0(pkind), val);
+
+	/* Update CPT_HR new PKIND */
+	val = rvu_read64(rvu, blkaddr, NPC_AF_PKINDX_ACTION0(pkind + 4));
+	act0 = (struct npc_kpu_action0 *)&val;
+	act0->ptr_advance = (skip_size + 40);
+	act0->next_state = NPC_S_KPU1_CPT_HDR;
+	act0->var_len_offset = (skip_size + 6);
+	act0->var_len_mask = 0xe0;
+	act0->var_len_shift = 0x5;
+	act0->var_len_right = 0x1;
+	rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_ACTION0(pkind + 4), val);
+	return 0;
+}
+
 int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 			   u64 pkind, u8 var_len_off, u8 var_len_off_mask,
-			   u8 shift_dir)
-
+			   u8 shift_dir, u8 skip_size)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	int blkaddr, nixlf, rc, intf_mode;
@@ -4218,6 +4248,12 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 							  shift_dir);
 			if (rc)
 				return rc;
+		} else if (pkind >= NPC_RX_SKIP_SIZE_PKIND &&
+			   pkind <= NPC_RX_SKIP_SIZE_PKIND + 3) {
+			rc = npc_set_skip_size_pkind(rvu, pcifunc, pkind,
+						     skip_size);
+			if (rc)
+				return rc;
 		}
 		rxpkind = pkind;
 		txpkind = pkind;
@@ -4254,7 +4290,8 @@ int rvu_mbox_handler_npc_set_pkind(struct rvu *rvu, struct npc_set_pkind *req,
 {
 	return rvu_npc_set_parse_mode(rvu, req->hdr.pcifunc, req->mode,
 				      req->dir, req->pkind, req->var_len_off,
-				      req->var_len_off_mask, req->shift_dir);
+				      req->var_len_off_mask, req->shift_dir,
+				      req->skip_size);
 }
 
 int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
-- 
2.48.1


