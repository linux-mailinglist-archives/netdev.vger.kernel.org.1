Return-Path: <netdev+bounces-260392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLUtC9ZcnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF4183704
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A12308AFD7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A53366814;
	Tue, 24 Feb 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xen0ESFl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3536656E;
	Tue, 24 Feb 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920112; cv=none; b=Z2WriUCLBfqw3BHqKaRshqsCERvsazwH7uuACJUisjlW88X4DG0djQRisjFzvfoj88pHTzsDjjUWo63ZoO5n2Xib/hNj/OYfYELvOtQ0kUpyaKIVovFZdUZDOflTIufH02/tQDpTOe8W90wC/FYYgOnHrKQ/Z0pDtLelPnwGqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920112; c=relaxed/simple;
	bh=H2t4dNUqFkQg4jWXQ0+JQdLkKsTN4x3SADKE7x2bj2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNBOL5QDerDBqYDG1fPgcMowVhS0WK7AMuNGxCiArTjDbeDlZaI29yZ5AZAyjyUSPOvWqYUtohJ0B6dO4yNUNnJDe+0CGzbD+8C//1RjANshA4gVEtVe1PQogq7LeqbZlstDe/F+5NgB0iAaI32wJiVAV30/538acYFd7c8ZeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Xen0ESFl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH2FnU4000896;
	Tue, 24 Feb 2026 00:01:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
	sFdzb4xZ3RkWS2AUpghp1Zp9yrWbTiGOhJAI1bd7Bg=; b=Xen0ESFluvu3ucOzh
	5T5lkkqFzLiMvKK6Kn5ISsPVH6eJUOsYYfKfk/M1rOp3GouJ0C9T2AWi8JZJprj3
	pb0GRRr6PGlUlwJwr+U0QtR1aD6ocXBr8EK8gN5U2S2pT5f5Zr9pOTxGUOW4Hrpn
	h06zfKK3bOMWLLgs6W9EpprXNRQsJNzLipbayJScb0EmhAI4lnlUE0J8MfOaT3ae
	dKJleQS4Cq1mhox3PP9kAf5Va3xfik0akmd+RRV3LfNSn/9rhlwOUTIj2ZIE7Xn3
	VX7YP8/uA9kX4ZK3bKULYrLwVJxIxviDOAGVYxYbJw7jcQZ1TMvrdb4kJ4y1HB9m
	mvixQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cg1ubc5s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:01:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:01:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:01:40 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2A46D3F7082;
	Tue, 24 Feb 2026 00:01:35 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v9 12/13] octeontx2-af: npc: cn20k: add debugfs support
Date: Tue, 24 Feb 2026 13:30:08 +0530
Message-ID: <20260224080009.4147301-13-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=P7Y3RyAu c=1 sm=1 tr=0 ts=699d5ae5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=VlSHqinqd2IHOLuXnyEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KqFunog52IDyJIRg_BKAw8cS6g8YiOL_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfX5QqjXdaouj43
 +1YzzaOo5tKE0xNjcdzpRFbPwMpV5VMuzbUc/COzDIu7CIZ/0/6rh9DFZfdtyxTO1Loa9VpF8pj
 +bto1jd//ztyTUCJzlTH8OcHEakOrF4nMFx/m4zDPpCEMr10+AhSNYHYrC5EX0mKHrhjPmjWKHA
 AijFGdr+PRwxuAyD4sUo0aCRiLy9gA9cmzJtOZSKPs2yjoEVAuAPTHt35cCgxx/n1zIKLAn0eSk
 0zDm1CEVihzBKMwFPL0290iTdtoSTp9mefrDPRG/hLkpBHVZ/YjsBuTSPm6cYXNXiTFvMiEGbaP
 Z1UcifABWKgNFJIyLiaSLAppfTgXacpi51dipnvr8lweWtBehxYqoRGErcQYSTJkFBv7q3qVN1Q
 2AWiDuIKY8TEuL7/c5LeNirLvw7KicH3GLauz3pXmeLQzlBiyJ98h4XOcmi1TWsfx7aUeE9yxNL
 ZurO4757DwjSe2odGXA==
X-Proofpoint-GUID: KqFunog52IDyJIRg_BKAw8cS6g8YiOL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260392-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 82FF4183704
X-Rspamd-Action: no action

CN20K silicon divides the NPC MCAM into banks and subbanks, with each
subbank configurable for x2 or x4 key widths. This patch adds debugfs
entries to expose subbank usage details and their configured key type.

A debugfs entry is also added to display the default MCAM indexes
allocated for each pcifunc.

Additionally, debugfs support is introduced to show the mapping between
virtual indexes and real MCAM indexes, and vice versa.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 261 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  41 ++-
 2 files changed, 292 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 0ba123be6643..3debf2fae1a4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -15,8 +15,269 @@
 #include "debugfs.h"
 #include "cn20k/npc.h"
 
+static int npc_mcam_layout_show(struct seq_file *s, void *unused)
+{
+	int i, j, sbd, idx0, idx1, vidx0, vidx1;
+	struct npc_priv_t *npc_priv;
+	char buf0[32], buf1[32];
+	struct npc_subbank *sb;
+	unsigned int bw0, bw1;
+	bool v0, v1;
+	int pf1, pf2;
+	bool e0, e1;
+	void *map;
+
+	npc_priv = s->private;
+
+	sbd = npc_priv->subbank_depth;
+
+	for (i = npc_priv->num_subbanks - 1; i >= 0; i--) {
+		sb = &npc_priv->sb[i];
+		mutex_lock(&sb->lock);
+
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE)
+			goto next;
+
+		bw0 = bitmap_weight(sb->b0map, npc_priv->subbank_depth);
+		if (sb->key_type == NPC_MCAM_KEY_X4) {
+			seq_printf(s, "\n\nsubbank:%u, x4, free=%u, used=%u\n",
+				   sb->idx, sb->free_cnt, bw0);
+
+			for (j = sbd - 1; j >= 0; j--) {
+				if (!test_bit(j, sb->b0map))
+					continue;
+
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				if (map) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0),
+						 "v:%u", vidx0);
+				}
+
+				seq_printf(s, "\t%u(%#x) %s\n", idx0, pf1,
+					   map ? buf0 : " ");
+			}
+			goto next;
+		}
+
+		bw1 = bitmap_weight(sb->b1map, npc_priv->subbank_depth);
+		seq_printf(s, "\n\nsubbank:%u, x2, free=%u, used=%u\n",
+			   sb->idx, sb->free_cnt, bw0 + bw1);
+		seq_printf(s, "bank1(%u)\t\tbank0(%u)\n", bw1, bw0);
+
+		for (j = sbd - 1; j >= 0; j--) {
+			e0 = test_bit(j, sb->b0map);
+			e1 = test_bit(j, sb->b1map);
+
+			if (!e1 && !e0)
+				continue;
+
+			if (e1 && e0) {
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				v0 = !!map;
+				if (v0) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0), "v:%05u",
+						 vidx0);
+				}
+
+				idx1 = sb->b1b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx1);
+				pf2 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx1);
+				v1 = !!map;
+				if (v1) {
+					vidx1 = xa_to_value(map);
+					snprintf(buf1, sizeof(buf1), "v:%05u",
+						 vidx1);
+				}
+
+				seq_printf(s, "%05u(%#x) %s\t\t%05u(%#x) %s\n",
+					   idx1, pf2, v1 ? buf1 : "       ",
+					   idx0, pf1, v0 ? buf0 : "       ");
+
+				continue;
+			}
+
+			if (e0) {
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				if (map) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0), "v:%05u",
+						 vidx0);
+				}
+
+				seq_printf(s, "\t\t   \t\t%05u(%#x) %s\n", idx0,
+					   pf1, map ? buf0 : " ");
+				continue;
+			}
+
+			idx1 = sb->b1b + j;
+			map = xa_load(&npc_priv->xa_idx2pf_map, idx1);
+			pf1 = xa_to_value(map);
+			map = xa_load(&npc_priv->xa_idx2vidx_map, idx1);
+			if (map) {
+				vidx1 = xa_to_value(map);
+				snprintf(buf1, sizeof(buf1), "v:%05u", vidx1);
+			}
+
+			seq_printf(s, "%05u(%#x) %s\n", idx1, pf1,
+				   map ? buf1 : " ");
+		}
+next:
+		mutex_unlock(&sb->lock);
+	}
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_layout);
+
+static int npc_mcam_default_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index;
+	u16 ptr[4], pcifunc;
+	struct rvu *rvu;
+	int rc, i;
+	void *map;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+
+	seq_puts(s, "\npcifunc\tBcast\tmcast\tpromisc\tucast\n");
+
+	xa_for_each(&npc_priv->xa_pf_map, index, map) {
+		pcifunc = index;
+
+		for (i = 0; i < ARRAY_SIZE(ptr); i++)
+			ptr[i] = USHRT_MAX;
+
+		rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0],
+						 &ptr[1], &ptr[2], &ptr[3]);
+		if (rc)
+			continue;
+
+		seq_printf(s, "%#x\t", pcifunc);
+		for (i = 0; i < ARRAY_SIZE(ptr); i++) {
+			if (ptr[i] != USHRT_MAX)
+				seq_printf(s, "%u\t", ptr[i]);
+			else
+				seq_puts(s, "\t");
+		}
+		seq_puts(s, "\n");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_default);
+
+static int npc_vidx2idx_map_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index, start;
+	struct xarray *xa;
+	void *map;
+
+	npc_priv = s->private;
+	start = npc_priv->bank_depth * 2;
+	xa = &npc_priv->xa_vidx2idx_map;
+
+	seq_puts(s, "\nvidx\tmcam_idx\n");
+
+	xa_for_each_start(xa, index, map, start)
+		seq_printf(s, "%lu\t%lu\n", index, xa_to_value(map));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_vidx2idx_map);
+
+static int npc_idx2vidx_map_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index;
+	struct xarray *xa;
+	void *map;
+
+	npc_priv = s->private;
+	xa = &npc_priv->xa_idx2vidx_map;
+
+	seq_puts(s, "\nmidx\tvidx\n");
+
+	xa_for_each(xa, index, map)
+		seq_printf(s, "%lu\t%lu\n", index, xa_to_value(map));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_idx2vidx_map);
+
+static int npc_defrag_show(struct seq_file *s, void *unused)
+{
+	struct npc_defrag_show_node *node;
+	struct npc_priv_t *npc_priv;
+	u16 sbd, bdm;
+
+	npc_priv = s->private;
+	bdm = npc_priv->bank_depth - 1;
+	sbd = npc_priv->subbank_depth;
+
+	seq_puts(s, "\nold(sb)   ->    new(sb)\t\tvidx\n");
+
+	mutex_lock(&npc_priv->lock);
+	list_for_each_entry(node, &npc_priv->defrag_lh, list)
+		seq_printf(s, "%u(%u)\t%u(%u)\t%u\n", node->old_midx,
+			   (node->old_midx & bdm) / sbd,
+			   node->new_midx,
+			   (node->new_midx & bdm) / sbd,
+			   node->vidx);
+	mutex_unlock(&npc_priv->lock);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(npc_defrag);
+
 int npc_cn20k_debugfs_init(struct rvu *rvu)
 {
+	struct npc_priv_t *npc_priv = npc_priv_get();
+	struct dentry *npc_dentry;
+
+	npc_dentry = debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
+					 npc_priv, &npc_mcam_layout_fops);
+
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
+					 rvu, &npc_mcam_default_fops);
+
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
+					 npc_priv, &npc_vidx2idx_map_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
+					 npc_priv, &npc_idx2vidx_map_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("defrag", 0444, rvu->rvu_dbg.npc,
+					 npc_priv, &npc_defrag_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 620724dad093..413f9fa40b33 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -23,6 +23,7 @@
 
 #include "cn20k/reg.h"
 #include "cn20k/debugfs.h"
+#include "cn20k/npc.h"
 
 #define DEBUGFS_DIR_NAME "octeontx2"
 
@@ -3197,7 +3198,9 @@ static void rvu_print_npc_mcam_info(struct seq_file *s,
 static int rvu_dbg_npc_mcam_info_display(struct seq_file *filp, void *unsued)
 {
 	struct rvu *rvu = filp->private;
+	int x4_free, x2_free, sb_free;
 	int pf, vf, numvfs, blkaddr;
+	struct npc_priv_t *npc_priv;
 	struct npc_mcam *mcam;
 	u16 pcifunc, counters;
 	u64 cfg;
@@ -3211,16 +3214,34 @@ static int rvu_dbg_npc_mcam_info_display(struct seq_file *filp, void *unsued)
 
 	seq_puts(filp, "\nNPC MCAM info:\n");
 	/* MCAM keywidth on receive and transmit sides */
-	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
-	cfg = (cfg >> 32) & 0x07;
-	seq_printf(filp, "\t\t RX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
-		   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
-		   "224bits" : "448bits"));
-	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_TX));
-	cfg = (cfg >> 32) & 0x07;
-	seq_printf(filp, "\t\t TX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
-		   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
-		   "224bits" : "448bits"));
+	if (is_cn20k(rvu->pdev)) {
+		npc_priv = npc_priv_get();
+		seq_printf(filp, "\t\t RX keywidth \t: %s\n",
+			   (npc_priv->kw == NPC_MCAM_KEY_X1) ?
+			   "256bits" : "512bits");
+
+		npc_cn20k_subbank_calc_free(rvu, &x2_free, &x4_free, &sb_free);
+		seq_printf(filp, "\t\t free x4 slots\t: %d\n", x4_free);
+
+		seq_printf(filp, "\t\t free x2 slots\t: %d\n", x2_free);
+
+		seq_printf(filp, "\t\t free subbanks\t: %d\n", sb_free);
+	} else {
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
+		cfg = (cfg >> 32) & 0x07;
+		seq_printf(filp, "\t\t RX keywidth \t: %s\n",
+			   (cfg == NPC_MCAM_KEY_X1) ?
+			   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
+					"224bits" : "448bits"));
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_INTFX_KEX_CFG(NIX_INTF_TX));
+		cfg = (cfg >> 32) & 0x07;
+		seq_printf(filp, "\t\t TX keywidth \t: %s\n",
+			   (cfg == NPC_MCAM_KEY_X1) ?
+			   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
+					"224bits" : "448bits"));
+	}
 
 	mutex_lock(&mcam->lock);
 	/* MCAM entries */
-- 
2.43.0


