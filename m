Return-Path: <netdev+bounces-282202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABDMI71s8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B148E4D7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6364F30197C7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F143815F7;
	Wed, 29 Apr 2026 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iIj0NxBI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0137FF62;
	Wed, 29 Apr 2026 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429678; cv=none; b=Y1giu2CssorqNWtIensrfFPN3wXjx0Pib+qWOViJJPdGK/lP21JDVelVofFEE9L6UUsAc7SuU14Ky7DOMll5dQl8Z52yhh9IcW0L1a743S7ActoiJrvKKXv7SRulVXN56olISZS99xhJevYTz6fXQ7L9XIPsbMg5FUuMxI7i6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429678; c=relaxed/simple;
	bh=AkPFceWU+ZYyM8uHmBYL7YveuTRchdbB0aJkUSwH6Zs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPfElmBPY6RlZ27vrOb2+ePbV+0FSUE34T9OQxASTl4zoR7m4g1XFjCZEeM79EdIxQxVdBDiEwOU/Q3mBQ5nA0Fa/TiozjHVcjsJ/L9+Zd5jJttkC4d/9pwtwm2PegaigtzIVBIoHNxz3XCbotorYU0O6JC+2CVEGM4BYLusb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iIj0NxBI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SNc0hB4076530;
	Tue, 28 Apr 2026 19:27:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JwkDD1pRTTj21vRR/bYOG9G
	WVcIr8sIGS5W8I7hiDCY=; b=iIj0NxBItn5J6J/77kGyq0wKni1lGKbvJrq5KoZ
	QDPpUff6ALHewfGRO8+yD+L3J3MwGTkXXZvEIARRVf5Io6qZBZfjWdY3TbKp7dny
	vANPZj+WxQUoM9FBMPtPsEhuepHJtMzOTIz+j3Mcl5FuP9yoG0+H0Ylk3zb4c7it
	AsvZ4MN3pXkeqLycrD5rOiyRrEiWtWwFGtUXDDEZtIlM0rvWpO1Mc6ELzqdQXuGc
	E4VnoeXkjqsvgSECAae2i8Dn2IiILReXXeQn3yJx7frXkKY0RqP1Z6qXvkCPe2mh
	C1a//F5m3dS962I5IMRyraLmiuHVm1TqDQIGaAB29FVim0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4du6r38c08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 19:27:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Apr 2026 19:27:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Apr 2026 19:27:33 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E14E83F70E6;
	Tue, 28 Apr 2026 19:27:30 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net 00/10] octeontx2-af: npc: cn20k: MCAM fixes
Date: Wed, 29 Apr 2026 07:57:12 +0530
Message-ID: <20260429022722.1110289-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CtfD-D1zh_1vY-WPDVwTxCCQ8XL8_RyY
X-Proofpoint-ORIG-GUID: CtfD-D1zh_1vY-WPDVwTxCCQ8XL8_RyY
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=69f16c96 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=ALkQAJV8toBbO7D8Nj8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyMSBTYWx0ZWRfX3nrvN/inMSYy
 GX9lATlv63RC7+512qDbvIshhCTxs0HIK/RLlwRddR5Vrf6VBCD9gRFm55Wts4bWaFOKozH9eBQ
 pI4PJiQHJIRpV6UYWNvZjz95RGoccHueYARrxS9yOH4iqfD8FrEgklL+Zqo2TbPTi4xnzB0Yzht
 gaV13GYBvTKA5I6JQCONjeeE6rtikOBmfVB9jVNn0vZSRc3a20mT2WOmZd70tf8danhoAj/Gy4h
 q9Qz0u5MAAVzp9cakBhGg9MJojq7/hQGKl6mqktswrPJzjInK6nMJU0q07XZ3+T+rKgYvQJtjIA
 09r/ER+OidQ/h8HnAYPKHHNnCoCfTDjdiLry7t0sADqrxgzIRgZf1eboCHEmec4cEXPo70X6ZI/
 dT9Hmo4xNsvzA70/kG9XKVPTGSsoTm2F+nt9DhkHzpa7X7TdLb2oGTML22g93NEJhFwyLGjxXA3
 +W+ol+0fg/GRzMYFPMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 4B2B148E4D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282202-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

This series tightens Marvell OcteonTX2 AF NPC support for CN20K silicon
around MCAM key typing, optional debugfs setup, defrag allocation rollback,
defrag entry relocation bookkeeping, logical MCAM clear and programming,
default-rule index handling with explicit teardown, and NIXLF reserved-slot
lookup when default rules are missing.

Patches 1 through 3 focus on AF error handling: propagate
npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config, copy,
and read paths; treat cn20k NPC debugfs nodes as optional so probe does not
fail when debugfs is unavailable; and fix defrag MCAM allocation rollback
so allocation errno is not overwritten during subbank index resolution.

Patch 4 fixes npc_defrag_move_vdx_to_free(): when an MCAM line is moved to
a new physical index, move entry2target_pffunc[] association to the new
slot, clear the old slot, and retarget the matching mcam_rules entry so
software state matches hardware after defrag.

Patches 5 through 7 refine cn20k MCAM programming: clear entries using the
logical MCAM index and resolved key width, fix bank/CFG sequencing in
npc_cn20k_config_mcam_entry(), and read action metadata from the correct
bank in npc_cn20k_read_mcam_entry().

Patches 8 through 10 complete default-rule lifecycle handling: initialize
default-rule index outputs eagerly, tear down reserved default MCAM rules
explicitly (coordinated with npc_mcam_free_all_entries()), and reject
USHRT_MAX sentinel indices from npc_get_nixlf_mcam_index() on cn20k.

Ratheesh Kannoth (10):
  octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
  octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
  octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
  octeontx2-af: npc: cn20k: Fix target map and rule
  octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
  octeontx2-af: npc: cn20k: Fix bank value
  octeontx2-af: npc: cn20k: Fix MCAM actions read
  octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
  octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
  octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v4 -> v5:
	https://lore.kernel.org/all/20260427063213.3937451-11-rkannoth@marvell.com/

v3 -> v4:
  - Add patch fixing entry2target_pffunc[] and mcam_rules when defrag
    relocates an MCAM entry (npc_defrag_move_vdx_to_free()).
  - Drop the standalone default-entry x4 preference and x2-profile flow-
    install rejection patches from this series (10 patches total).
  Link:
  https://lore.kernel.org/netdev/
  20260420023442.3295891-1-rkannoth@marvell.com/

v2 -> v3:
  Addresses Simon and Paolo comments.
  Link:
  https://lore.kernel.org/netdev/
  20260420023442.3295891-1-rkannoth@marvell.com/

v1 -> v2:
  Address Simon comments and add further cn20k NPC correctness fixes.
  Link:
  https://lore.kernel.org/netdev/
  20260418162013.GG280379@horms.kernel.org/

2.43.0

