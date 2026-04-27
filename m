Return-Path: <netdev+bounces-281222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNefH3ID72lz3QAAu9opvQ
	(envelope-from <netdev+bounces-281222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D294146D97A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2F63003315
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45851370D54;
	Mon, 27 Apr 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rq/Bv3CK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A942773E5;
	Mon, 27 Apr 2026 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271551; cv=none; b=FDfEQczPL+R9Am0AKZwj6z0OhYTYAes3Mig1JJMNBs6HV1+okIKVLAWZcKvhrrWpOoBPDdhGJ6yKoa7jFFjM1Cgr5qo5oZbq86KjbyhXC2uxTbQtyS57A1iOJdYBeWQdKsyELX3j1MKpFGphK5upYhUVbz9Tgfn40bIUMlZqBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271551; c=relaxed/simple;
	bh=5iBjgdxjnUlfE5L0DaXADH3mrUlDHcgrZ17MszzoYgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQ/IcM2op2uJiumwReUNmwilrE+eu0wmqd9cS/xZVt8HwzGYMs0C2jmNSZOb4BmQL70xh/esAufE+QKnhsmHt58qy+ZJFBCsIqT7AAQoPMh2njw1a2S/AX2AyKY3kvwy0Ys3rd4dLbtJNqW9FlfO8w3Ss21lvqqLtSAplVsIojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rq/Bv3CK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLsQmA2513409;
	Sun, 26 Apr 2026 23:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LZ5Rp3Sc6LzkN60F7zOZuOk
	E8d+vMwx6dQZY70et7lw=; b=Rq/Bv3CKjb4WESs4jHEWEJ/3OXzjgy1BtPsJ+aJ
	5ySylG84HpHxOSFiF4llI9k/DbyNdEv4FlBgKptae5bFCgwSblFBxVJbZB5eg3SR
	4GsJyS3LkEtZUZs9aP9oGz+Sd0AuU4AcWNDwCyFr3F4dWE6N8I1xfadJorXhMgpm
	2XYfHj4uVTAsxHmYJRqpSX7v/i9s4N1wKhsRkhrqvrq/X2D62/L3XfdLVlB1iqsa
	iCrSLUDt0w279PJnqED9Fti1mF9NMVxW4EqiuCQPNvLAGFtc4wrgX+FmH05y53vs
	uEWjDLojiGK11GQH79H0RaaaAOaXMbk1HeZ4Q8v1b1YzQAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fjxqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:19 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id F1FC13F70C6;
	Sun, 26 Apr 2026 23:32:15 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net 0/10] octeontx2-af: npc: cn20k: MCAM fixes
Date: Mon, 27 Apr 2026 12:02:03 +0530
Message-ID: <20260427063213.3937451-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4CrfeMwAGpt9Ec9Ra_OKpePcV8gzoSF6
X-Proofpoint-GUID: 4CrfeMwAGpt9Ec9Ra_OKpePcV8gzoSF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfXyHBkj2fyaUQ6
 94Pe2uBtVm84pkiF2Tiaz6QETTTYay48nPxvo7RXeekPAOJKCTrOh6CYSVVmhJM8DVmfiBJPvf0
 VIRIi1eevsTiOrkFtX6NG7vfW3RVgMpdpzyFV5y/b+ohUWszo5P5yBO68iY7SGU3y+BpbHc99Ov
 /15n4wFfguwNek6gQS+l5alfLoTOtfMb1iK9Asc0YawnR8e2mmdhCsd/Uim5z20zPjE7LIohTjp
 6oJzBVzTG1pBXMqFs6vUOSYHgWelzB9yXwio/xHWEuW319iVvyTxNzzUZvHHF5Bkjkf9nn5kv/2
 x7fVIwAHL7reWBmvwZApokm8pxwuTi4erUQIu+WwmspiSUdQZz6xdq8sEQC1SDHyUbfGmHgvJJv
 fMkoUFGcO4flqlTwXbuT0eOmE7RTAO4RLxBQH2EvwC9BylvyM4//oUwI/1U2adb/30Z494usdRb
 LHFXLzB4XZt8LsgxduQ==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef02f4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=Xbr5Wl5ec5yMYdqX9r8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: D294146D97A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281222-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

This series tightens Marvell OcteonTX2 AF NPC support for CN20K silicon
around MCAM key typing, optional debugfs setup, defrag allocation
rollback, defrag entry relocation bookkeeping, logical MCAM clear and
configuration, default-rule index handling and explicit teardown, and
NIXLF reserved-slot lookup when default rules are missing.

Patches 1 through 3 focus on AF error handling: propagate
npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config,
copy, and read paths; treat cn20k NPC debugfs files as optional so probe
does not fail when debugfs is unavailable; and fix defrag MCAM
allocation rollback so allocation errno is not overwritten by subbank
index resolution.

Patch 4 fixes npc_defrag_move_vdx_to_free(): when an MCAM line is moved
to a new physical index, copy entry2target_pffunc[] to the new slot,
clear the old slot, and update the matching mcam_rules entry so
software state matches hardware after defrag.

Patches 5 through 7 refine cn20k MCAM programming: clear entries by
logical index and resolved key width, fix bank and CFG sequencing in
npc_cn20k_config_mcam_entry(), and read action metadata from the correct
bank in npc_cn20k_read_mcam_entry().

Patches 8 through 10 complete default-rule lifecycle handling:
initialize all default-rule index outputs up front, tear down default
MCAM rules explicitly (coordinated with npc_mcam_free_all_entries()),
and reject USHRT_MAX sentinel indices in npc_get_nixlf_mcam_index() for
cn20k.

Ratheesh Kannoth (10):
  octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
  octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
  octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
  octeontx2-af: npc: cn20k: Fix target map and rule index while defrag
  octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
  octeontx2-af: npc: cn20k: Fix bank value.
  octeontx2-af: npc: cn20k: Fix MCAM actions read
  octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
  octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
  octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

--
v3 -> v4:
  - Add patch fixing entry2target_pffunc[] and mcam_rules when defrag
    relocates an MCAM entry (npc_defrag_move_vdx_to_free()).
  - Drop the standalone default-entry x4 preference and x2-profile
    flow-install rejection patches from this series (10 patches total).
  https://lore.kernel.org/netdev/20260420023442.3295891-1-rkannoth@marvell.com/

v2 -> v3: Addresses simon, paolo comments.
	https://lore.kernel.org/netdev/20260420023442.3295891-1-rkannoth@marvell.com/

v1 -> v2: Addressed simon comments. Added more patch fixes to this series.
  Link: https://lore.kernel.org/netdev/20260418162013.GG280379@horms.kernel.org/

2.43.0

