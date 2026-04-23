Return-Path: <netdev+bounces-280706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAGBAqH46WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B414450DE6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD0D3007E0F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9DC39283C;
	Thu, 23 Apr 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J0ZarYvN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2B37EFF6;
	Thu, 23 Apr 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941016; cv=none; b=ncLIxLFSxyimva1pV/Kz0RqvpGf8cYKjzSHznba2U4aqfBUG6m7VNSiJ2PWv0kWXGEZxjJJblSwgKLOi5IZhEJSA+m319ggMsSyOx2epHhw4BJEYtKS+E7DYjws3FBy7Su08nSwdW13vj+N6DCTxH1IGiiW/jdA3yabg27uVRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941016; c=relaxed/simple;
	bh=c4P5ljwWIERDi8w/L+F+z1LqlOVP/I4zrJOCf38Absk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBzdjnj8x+mvhHbA3LvUwitAfOPDrpM2XqZ9urjAWrVI1S7suTyaBR6mqYjmB+sYeaIXMT+U2LjkuD+48VCQxwIxGo/SxVnWZziP/2+WAuRzerdMFPTP7WP6krrU+Hg8QdMxQftMTHRKWf97/IClatNJoSNdY69fyoEK/lt6rks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J0ZarYvN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6GQ7X693283;
	Thu, 23 Apr 2026 03:43:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JaCDIImaNeKAiU0re3vT+0q
	Vw8FZhnLXbuWH/63HtZc=; b=J0ZarYvNlSMWVFx0/l94ieZSGMHcspGT9f8Hp10
	yYZacPzZyvziezDHmKzfDiXEoEFLF8gURaaRox1Zu3kdcWEAfYmRI6H5DJB8TWV/
	KXqlOBrQqkL4Za9JPNV1XRE2VRsJ9F4bNoBgbUSKcq6gbPz/6d4ibsCEJZYTosxP
	P5wJtRzb3u0hudWYGuaj8DUCZauQH4Qw0GmNNEgFRjO1FnyZC7y7SS4kqnWogova
	6Nbh/reJIaJ0y8wfeIylJ4eWSDFPDT5u4KGXr4Q7rHps2Hdr5hLErBKD8qCWmdY1
	oeH2Y6ZXtIRWrYQbVHxjuPTH5BUlGlqFTJSrB+FKAFM1c/g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6jfgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:23 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5AB763F7058;
	Thu, 23 Apr 2026 03:43:20 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net 0/11] octeontx2-af: npc: cn20k: MCAM fixes
Date: Thu, 23 Apr 2026 16:13:06 +0530
Message-ID: <20260423104317.2707923-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _csxmAefIDXmG_hNw4dBAflexaacqg4a
X-Proofpoint-GUID: _csxmAefIDXmG_hNw4dBAflexaacqg4a
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f7cc cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=jJBzseYy13a1LWwCShkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX8SQxJcLf4ZSj
 OnbjeixVIWv8jKGx0d0V/txwYAsxfrDC6JEIbpma9m2runCsr6GmTHUbjA0gIzF/kJXV3Sb/gVe
 jdSzCZDaytDvuLFY28sLPwiq/hC1kOBV+68d0eG7MuF8fp62kYz8UErySFisxOsbzFPhhMeTukA
 PLkDdcu6eJ7Ize+bnUj1FkyEdV3jFeOrWKVgGa6shfK44csg0BRl4NKXWwekhu8c/aIuJZU3VI9
 FcSOFs+Bee3jl/7lQh7rL9iw7gjzV0TxH7cRcjmevwLBLe4Y1ewuk9SnBDAACnFwkHUzxM2Lpro
 2kodRs1AfqhN8oGR49sdbRXo5qstxr8pd1X5YSxN9lb2/9KCfj9KyrwwDBK8XtXTrbClocN/ezA
 1Y/0AkLmJPfMoatwfDjj3thTfRdCUXdGytxI3RT9up/EuojiBZvQzN2W0865kCCHq5+Svl8SwUZ
 rL/PQYjsYF/+bCO62QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-280706-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6B414450DE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series tightens Marvell OcteonTX2 AF NPC support for CN20K
silicon around MCAM key typing, optional debugfs setup, defrag
allocation rollback, x2 versus x4 KEX profiles and default-rule
allocation, logical MCAM clear and configuration, default-rule index
bookkeeping and explicit teardown, and NIXLF reserved-slot lookup when
default rules are missing.

Patches 1 through 3 focus on AF error handling: propagate
npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config,
copy, and read paths; treat cn20k NPC debugfs files as optional so
probe does not fail when debugfs is unavailable; and fix defrag MCAM
allocation rollback so allocation errno is not overwritten by subbank
index resolution.

Patches 4 and 5 align default-rule and flow-install behaviour with the
loaded mkex profile: prefer x4 default entries when the profile is x4,
and reject x4 flow keys when the profile is strictly x2.

Patches 6 through 8 refine cn20k MCAM programming: clear entries by
logical index and resolved key width, fix bank and CFG sequencing in
npc_cn20k_config_mcam_entry(), and read action metadata from the
correct bank in npc_cn20k_read_mcam_entry().

Patches 9 through 11 complete default-rule lifecycle handling:
initialize all default-rule index outputs up front, tear down default
MCAM rules explicitly (coordinated with npc_mcam_free_all_entries()),
and reject USHRT_MAX sentinel indices in npc_get_nixlf_mcam_index()
for cn20k.

Ratheesh Kannoth (11):
  octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
  octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in
  init
  octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc
  rollback
  octeontx2-af: npc: cn20k: Make default entries as x4.
  octeontx2-af: npc: cn20k: Reject request for x4 entries in x2
  profile.
  octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
  octeontx2-af: npc: cn20k: Fix bank value.
  octeontx2-af: npc: cn20k: Fix MCAM actions read
  octeontx2-af: npc: cn20k: Initialize default-rule index outputs up
  front
  octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on
  free
  octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

--

v2 -> v3:  Addresses simon, paolo comments.
	https://lore.kernel.org/netdev/20260420023442.3295891-1-rkannoth@marvell.com/

v1 -> v2: Addressed simon comments. Added more patch fixes to this series.
	https://lore.kernel.org/netdev/20260418162013.GG280379@horms.kernel.org/

2.43.0

