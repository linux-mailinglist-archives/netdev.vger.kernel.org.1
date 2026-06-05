Return-Path: <netdev+bounces-295650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFdDBqZvImriXAEAu9opvQ
	(envelope-from <netdev+bounces-295650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A919164598F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=DZeBgqYz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295650-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295650-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6668830BE475
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4D3406281;
	Fri,  5 Jun 2026 06:33:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8C3168EF;
	Fri,  5 Jun 2026 06:33:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641199; cv=none; b=qjbrCQZZ9PNAbw5Asx2iffwZ1avRLS6L+fM3CHgDhUSKYyHpF15yG678cpZZda89psFoT8PqTzQJaVj8cmJMzpz58yx9RVzzerGGLUMR0DIh9x50mZAcAvYXdDaghnRzYE5dxeqJaz3Kbq4nOUzafqdszXaJYrA+v9+8AlnEGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641199; c=relaxed/simple;
	bh=YMQeg9bxijFxYVfxp+GeLcy2jlLWYni9+FiXud56gvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeGEwza8mNGrjLDAbFvL3lGgq9nzkjt3F5xxek+4c9N6625A6lR+UCY4LwVPotABlOPBVS0Lryd1sC3EMWNcDEXJQDar+fRcIRksTY8Rg9zsMS0AdGSpyZQdGAKffeZz7Ggz/hrElHZ8ycu+/PxplBunYTb0i5FJIacQjpvLM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DZeBgqYz; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LPkn03891278;
	Thu, 4 Jun 2026 23:33:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	rrRfGbygOBWqRZOZWDrHOfN7QhBRcp/izssYbLkZpQ=; b=DZeBgqYzGJ/WhMM6/
	1wtRZJnBADcH1Eq1+z4PlIlDf/mtoEZ+UGPAWQ2Uqj1w5hdIRZrjMnP2KFkdFY63
	47cihJg7ksCr2e7ZUGwkQGMsKXQ/xhVdW6tHRX5n1fpcLXvMEE5dqOfxTFmwR8HV
	dQ56avsBQvoDkQOkk6lAs20dJjOgPKd5Xt9CQRyq02Jh+AH5VCIYlz4U0QPyDmQ2
	EbgBitOQLL597zcC3aDzGWdi8tw8iepMkOdBQhpl7vqi3ao1m8/lU0oFtsdmHiB8
	P5cXhoagBjNMcsQEUjlygyoPyXf8ipPlL6c6BcftmowY3PscOU1EH1bOjtnfJZj+
	a5lsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekh8x9b52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 23:33:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:33:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 23:33:06 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 594743F707A;
	Thu,  4 Jun 2026 23:33:02 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 2/9] octeontx2-af: npc: cn20k: debugfs enhancements
Date: Fri, 5 Jun 2026 12:02:38 +0530
Message-ID: <20260605063245.3553861-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605063245.3553861-1-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TCs1mYdx-PKEgxiyJn9uFdj67kaJ3VrK
X-Authority-Analysis: v=2.4 cv=DqNmPm/+ c=1 sm=1 tr=0 ts=6a226da3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=MGki9FtnWEUF7_4ZUUMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2MSBTYWx0ZWRfX0HvX87YYz0Zg
 7ph7V0cf57oxO3a8X0SvcYoiZ1/0h5VzlJ5J7EGWqtjBHXlSZMjHG7S581XCh51tHVm+4ulBCNi
 qWlkwakQ8FJS2gFCFUhHEYWEo6tMttpo/j1U2280yD/S93Yac/4qV7nxt3owG220k+hZUBgctSp
 sxzNAiXyJej5X/VNOnCatvIY7Vsro4INozsBb+h98wtu5ERbN7SGQEb9if/Y3j9xomS0N++gzEY
 L0V2y7ovtgcfQZyO767C8zfGT7XNUnBw8y1BFbI4ivoG8dSgrxgfN13kEw062sZffr2Hb7czWXv
 P4cv94bxvQ8AjC/fUs98ja7KtZPvU2vE0Jgbb43/5rAAYrjAt39IoZ2d4Sa4Ks150h1W59IbcwV
 O+cgmFuwQUfCNGIJvfesdJjbT/dN8YznrUA1RP+LYGAg4yAXIpeJ0Ybf4rYxoi7YruiJdZon0uW
 DZuOGzeoHFdw586Zd2w==
X-Proofpoint-GUID: TCs1mYdx-PKEgxiyJn9uFdj67kaJ3VrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295650-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,npc_priv.sb:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A919164598F

Improve MCAM visibility and field debugging for CN20K NPC.

- Extend "mcam_layout" to show enabled (+) or disabled state per entry
  so status can be verified without parsing the full "mcam_entry" dump.
- Add "dstats" debugfs entry: for enabled MCAM indices, print hit deltas
  since the prior read by comparing hardware counters to a per-entry
  software baseline and advancing that baseline after each read (hardware
  counters are not cleared).
- Add "mismatch" debugfs entry: lists MCAM entries that are enabled
  but not explicitly allocated, helping diagnose allocation/field issues.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 158 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  37 +++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  11 ++
 3 files changed, 191 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 6f13296303cb..730ef97a57e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -13,6 +13,7 @@
 #include "struct.h"
 #include "rvu.h"
 #include "debugfs.h"
+#include "cn20k/reg.h"
 #include "cn20k/npc.h"
 
 static int npc_mcam_layout_show(struct seq_file *s, void *unused)
@@ -58,7 +59,8 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 "v:%u", vidx0);
 				}
 
-				seq_printf(s, "\t%u(%#x) %s\n", idx0, pf1,
+				seq_printf(s, "\t%u(%#x)%c %s\n", idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
 					   map ? buf0 : " ");
 			}
 			goto next;
@@ -101,9 +103,13 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 vidx1);
 				}
 
-				seq_printf(s, "%05u(%#x) %s\t\t%05u(%#x) %s\n",
-					   idx1, pf2, v1 ? buf1 : "       ",
-					   idx0, pf1, v0 ? buf0 : "       ");
+				seq_printf(s, "%05u(%#x)%c %s\t\t%05u(%#x)%c %s\n",
+					   idx1, pf2,
+					   test_bit(idx1, npc_priv->en_map) ? '+' : ' ',
+					   v1 ? buf1 : "       ",
+					   idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
+					   v0 ? buf0 : "       ");
 
 				continue;
 			}
@@ -120,8 +126,9 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 vidx0);
 				}
 
-				seq_printf(s, "\t\t   \t\t%05u(%#x) %s\n", idx0,
-					   pf1, map ? buf0 : " ");
+				seq_printf(s, "\t\t   \t\t%05u(%#x)%c %s\n", idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
+					   map ? buf0 : " ");
 				continue;
 			}
 
@@ -134,7 +141,8 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 				snprintf(buf1, sizeof(buf1), "v:%05u", vidx1);
 			}
 
-			seq_printf(s, "%05u(%#x) %s\n", idx1, pf1,
+			seq_printf(s, "%05u(%#x)%c %s\n", idx1, pf1,
+				   test_bit(idx1, npc_priv->en_map) ? '+' : ' ',
 				   map ? buf1 : " ");
 		}
 next:
@@ -145,6 +153,136 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(npc_mcam_layout);
 
+#define __OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)			\
+static const struct file_operations __name ## _fops = {			\
+	.owner = THIS_MODULE,						\
+	.open = __name ## _open,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(__name, __size)		\
+static int __name ## _open(struct inode *inode, struct file *file)		\
+{										\
+	return single_open_size(file, __name ## _show, inode->i_private,	\
+				__size);					\
+}										\
+__OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)
+
+static DEFINE_MUTEX(stats_lock);
+
+/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
+ * hard limit on all silicon variants, preventing any possibility of
+ * out-of-bounds access.
+ */
+static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
+static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	int blkaddr, pf, mcam_idx;
+	u64 stats, delta;
+	struct rvu *rvu;
+	char buff[64];
+	u8 key_type;
+	void *map;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return 0;
+
+	mutex_lock(&stats_lock);
+	seq_puts(s, "idx\tpfunc\tstats\n");
+	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
+		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
+			mcam_idx = bank * npc_priv->bank_depth + idx;
+
+			if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &key_type))
+				continue;
+
+			if (key_type == NPC_MCAM_KEY_X4 && bank != 0)
+				continue;
+
+			if (!test_bit(mcam_idx, npc_priv->en_map))
+				continue;
+
+			stats = rvu_read64(rvu, blkaddr,
+					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
+			if (!stats)
+				continue;
+			if (stats == dstats[bank][idx])
+				continue;
+
+			if (stats < dstats[bank][idx])
+				dstats[bank][idx] = 0;
+
+			pf = 0xFFFF;
+			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
+			if (map)
+				pf = xa_to_value(map);
+
+			delta = stats - dstats[bank][idx];
+
+			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
+				 mcam_idx, pf, delta);
+			seq_puts(s, buff);
+
+			dstats[bank][idx] = stats;
+		}
+	}
+
+	mutex_unlock(&stats_lock);
+	return 0;
+}
+
+/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
+#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH * 64)
+DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);
+
+static int npc_mcam_mismatch_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	struct npc_subbank *sb;
+	int mcam_idx, sb_off;
+	struct rvu *rvu;
+	char buff[64];
+	void *map;
+	int rc;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+
+	seq_puts(s, "index\tsb idx\tkw type\n");
+	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
+		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
+			mcam_idx = bank * npc_priv->bank_depth + idx;
+
+			if (!test_bit(mcam_idx, npc_priv->en_map))
+				continue;
+
+			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
+			if (map)
+				continue;
+
+			rc = npc_mcam_idx_2_subbank_idx(rvu, mcam_idx,
+							&sb, &sb_off);
+			if (rc)
+				continue;
+
+			snprintf(buff, sizeof(buff), "%u\t%d\t%u\n",
+				 mcam_idx, sb->idx, sb->key_type);
+
+			seq_puts(s, buff);
+		}
+	}
+	return 0;
+}
+
+/* "%u\t%d\t%u\n" needs less than 64 characters to print. */
+DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_mismatch, TOTAL_SZ);
+
 static int npc_mcam_default_show(struct seq_file *s, void *unused)
 {
 	struct npc_priv_t *npc_priv;
@@ -259,6 +397,12 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
 	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
 			    npc_priv, &npc_vidx2idx_map_fops);
 
+	debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
+			    &npc_mcam_dstats_fops);
+
+	debugfs_create_file("mismatch", 0444, rvu->rvu_dbg.npc, rvu,
+			    &npc_mcam_mismatch_fops);
+
 	debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
 			    npc_priv, &npc_idx2vidx_map_fops);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 003487d7c3cf..31eaaceb8766 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -824,7 +824,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
 			    cfg);
-		return 0;
+		goto update_en_map;
 	}
 
 	/* For NPC_CN20K_MCAM_KEY_X4 keys, both the banks
@@ -842,6 +842,12 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 			    cfg);
 	}
 
+update_en_map:
+	if (enable)
+		set_bit(index, npc_priv.en_map);
+	else
+		clear_bit(index, npc_priv.en_map);
+
 	return 0;
 }
 
@@ -1789,9 +1795,9 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 	return 0;
 }
 
-static int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
-				      struct npc_subbank **sb,
-				      int *sb_off)
+int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+			       struct npc_subbank **sb,
+			       int *sb_off)
 {
 	int bank_off, sb_id;
 
@@ -4498,11 +4504,19 @@ static int npc_priv_init(struct rvu *rvu)
 		npc_const2 = rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
 
 	num_banks = mcam->banks;
+	if (num_banks > MAX_NUM_BANKS) {
+		dev_err(rvu->dev,
+			"Number of banks(%u) is invalid\n", num_banks);
+		return -EINVAL;
+	}
+
 	bank_depth = mcam->banksize;
 
 	num_subbanks = FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
-	if (!num_subbanks) {
-		dev_err(rvu->dev, "Number of subbanks is zero\n");
+	if (!num_subbanks || num_subbanks > MAX_NUM_SUB_BANKS) {
+		dev_err(rvu->dev,
+			"Number of subbanks is invalid %u\n",
+			num_subbanks);
 		return -EFAULT;
 	}
 
@@ -4513,10 +4527,15 @@ static int npc_priv_init(struct rvu *rvu)
 		return -EINVAL;
 	}
 
-	npc_priv.num_subbanks = num_subbanks;
-
 	subbank_depth =	bank_depth / num_subbanks;
+	if (subbank_depth > MAX_SUBBANK_DEPTH) {
+		dev_err(rvu->dev,
+			"Invalid subbank depth %u\n",
+			subbank_depth);
+		return -EINVAL;
+	}
 
+	npc_priv.num_subbanks = num_subbanks;
 	npc_priv.bank_depth = bank_depth;
 	npc_priv.subbank_depth = subbank_depth;
 
@@ -4605,6 +4624,8 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	 */
 	kfree(npc_priv.sb);
 	kfree(subbank_srch_order);
+	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
+		     MAX_SUBBANK_DEPTH);
 }
 
 static int npc_setup_mcam_section(struct rvu *rvu, int key_type)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 3d5eb952cc07..3e851950be64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -10,6 +10,10 @@
 
 #define MKEX_CN20K_SIGN	0x19bbfdbd160
 
+/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
+ * hard limit on all silicon variants, preventing any possibility of
+ * out-of-bounds access on matrix defined using these values.
+ */
 #define MAX_NUM_BANKS 2
 #define MAX_NUM_SUB_BANKS 32
 #define MAX_SUBBANK_DEPTH 256
@@ -170,6 +174,7 @@ struct npc_defrag_show_node {
  * @num_banks:		Number of banks.
  * @num_subbanks:	Number of subbanks.
  * @subbank_depth:	Depth of subbank.
+ * @en_map:		Enable/disable status.
  * @kw:			Kex configured key type.
  * @sb:			Subbank array.
  * @xa_sb_used:		Array of used subbanks.
@@ -193,6 +198,9 @@ struct npc_priv_t {
 	const int num_banks;
 	int num_subbanks;
 	int subbank_depth;
+	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
+		       MAX_NUM_SUB_BANKS *
+		       MAX_SUBBANK_DEPTH);
 	u8 kw;
 	struct npc_subbank *sb;
 	struct xarray xa_sb_used;
@@ -336,5 +344,8 @@ u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
 int npc_cn20k_defrag(struct rvu *rvu);
 bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
+int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+			       struct npc_subbank **sb,
+			       int *sb_off);
 
 #endif /* NPC_CN20K_H */
-- 
2.43.0


