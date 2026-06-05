Return-Path: <netdev+bounces-295638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 70MGCqRlImooWgEAu9opvQ
	(envelope-from <netdev+bounces-295638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E36455C4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=iYwSYiDQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295638-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C40F3011A48
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3F3793CA;
	Fri,  5 Jun 2026 05:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AB2BEC27;
	Fri,  5 Jun 2026 05:58:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639137; cv=none; b=iKBwy4rtvDdRjlvHbs++PjpY1IisaqOH3iFVYz9p7/QquO3JfoZwZmMvuER1NwEUyyg6f4F3NIV+dqHBskhRw5THrjj5KN/cfmTSEh8jX0wd/o/lY+0so8nvKYQ/WW/HhEH1OPYxvMYjy2SX41AgwOZeIvkdmklaca/aG2WSQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639137; c=relaxed/simple;
	bh=dwjBw0jzpS0xK6AEeDjnOofQsI3oKDhHAmvUmPpUPZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKXuDByCNzLIs/2rfLOChT+mQNQjqfTa6i0jMosYEvOP0L40J/RJ/fDg2L8MoqwL0GuPr4TAbBMxR9w8zXcFQHfKGmyb2AipFtaQ4zlTBfRpp/ByVGb7m6EJ/x1ZZopjYoD3EWufwMkG5XDzGFb7TVjSIibqNzZ91XXPQWTf9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iYwSYiDQ; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655373k0302220;
	Thu, 4 Jun 2026 22:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=r4P6iP5p8LVHPmacl0Uhl4o
	MCxOKHv47GwSkVL4uxeo=; b=iYwSYiDQOKNWmZhw1pUte+fC448YaHgQp7SyWZt
	JEHhFDFoBYSFAE4xluIgseBl0aaK3RXPXD25dV/YHiVf40N0RfVXDR+uwIhsRxpe
	xh7vCtkYiGRz7mn64FJvZ4Lpzp2q02HWtndlObFd0OYL3U392NNftUYb45tgpIV1
	MdsuAAMD0VQqCgr2pZTtQXMCe5RgqzXTwTDPEl0SBLQ+YEjba48SavEF6jOTsRoo
	IT2VPTR/wadVb7w/VtWACERKDCmbHj5iiEoRnPe80RbeqF6DjTu/bBOlg6xvG8pP
	UzS1P1dPzRYR3QcH+tMw9NUz8JiZFYyHSZ4Xvk2FTevvDvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekcj0adkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 22:58:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 22:58:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 22:58:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 44A233F707A;
	Thu,  4 Jun 2026 22:58:42 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sbhatta@marvell.com>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: Fix size of entry2cntr_map
Date: Fri, 5 Jun 2026 11:28:39 +0530
Message-ID: <20260605055839.3549559-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G78s1dk5 c=1 sm=1 tr=0 ts=6a226598 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=vxo8v1BruSKIEKsfoaQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NSBTYWx0ZWRfX/wXH111b1Aff
 8L1sLJ7ihDLKOwpgjXLx1Ma9jxHO/W6t/NNyxHbMZVVYE9yVCjlCnLaKcgXZDRnWDUyTAEX/7Ih
 XZtdiqrX8JeN44GkZeqcKukxo7r7HXNs8I8U7x5indbho63abSbcCuqxbtGriLvbkyKarX1aj68
 VwWMGvM6Ih1bC0FhQoFpvZpWcmcExyYvfvT28wV6AHRfDEW518oG0Q2kEny8d83E3BzFFn7i5Fd
 5olWinpqFMzyBAygPi8VEoTQiPsiky0FcsXlmZBikKtOfJ01BjmEUIoif0aZUvvHSxacngS/niP
 XSwOSlMLO0Em1TjUOA7sHVO/m0p+PSt/wJ4MrPy7mdyVdx8loT9JRZtXryXtKIHqmVxFbzdGAhA
 Z4euVGb96zapmOvpVZFN2kQMh6EWRQlQltphHuL/d3nbE/+YP8kCuUCN+1jCuSW71KgNiZudJoy
 5yakEny7IzoLpVbfGUg==
X-Proofpoint-GUID: zpZmO-VnCU-K4mqY427tbrrj5AUP2EI0
X-Proofpoint-ORIG-GUID: zpZmO-VnCU-K4mqY427tbrrj5AUP2EI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295638-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:sbhatta@marvell.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D24E36455C4

octeontx2-af: Fix out of bound access in entry2counter array.
KASAN prints below splat. This is caused by allocating counter for
reserved mcam entry for cpt 2nd pass entry. But mcam->entry2cntr_map
is not allocated for reserved entries.

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in npc_map_mcam_entry_and_cntr+0xb0/0x1a0
 Write of size 2 at addr ffff0001033e7ffe by task kworker/0:1/14

 CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 6.1.67 #1
 Hardware name: Marvell CN106XX board (DT)
 Workqueue: events work_for_cpu_fn
 Call trace:
  dump_backtrace.part.0+0xe4/0xf0
  show_stack+0x18/0x30
  dump_stack_lvl+0x88/0xb4
  print_report+0x154/0x458
  kasan_report+0xb8/0x194
  __asan_store2+0x7c/0xa0
  npc_map_mcam_entry_and_cntr+0xb0/0x1a0
  rvu_mbox_handler_npc_mcam_write_entry+0x268/0x280
  npc_install_flow+0x840/0xfe0
  rvu_npc_install_cpt_pass2_entry+0x138/0x190
  rvu_nix_init+0x148c/0x2880
  rvu_probe+0x1800/0x30b0
  local_pci_probe+0x78/0xe0
  work_for_cpu_fn+0x30/0x50
  process_one_work+0x4cc/0x97c
  worker_thread+0x360/0x630
  kthread+0x1a0/0x1b0
  ret_from_fork+0x10/0x20

Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index d301a3f0f87a..12f525b5df7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2181,7 +2181,7 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = kcalloc(mcam->bmap_entries, sizeof(u16),
+	mcam->entry2cntr_map = kcalloc(mcam->total_entries, sizeof(u16),
 				       GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;
@@ -2197,10 +2197,11 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
-	for (index = 0; index < mcam->bmap_entries; index++) {
+	for (index = 0; index < mcam->bmap_entries; index++)
 		mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
+
+	for (index = 0; index < mcam->total_entries; index++)
 		mcam->entry2cntr_map[index] = NPC_MCAM_INVALID_MAP;
-	}
 
 	for (cntr = 0; cntr < mcam->counters.max; cntr++)
 		mcam->cntr2pfvf_map[cntr] = NPC_MCAM_INVALID_MAP;
-- 
2.43.0


