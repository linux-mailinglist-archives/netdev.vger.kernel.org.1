Return-Path: <netdev+bounces-278917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAMoGr9d4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B102E40A1A4
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D169301664F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92B30AD1C;
	Thu, 16 Apr 2026 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MQnfb9Zn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9288275848;
	Thu, 16 Apr 2026 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311735; cv=none; b=o4TfL77KAtPKoyWl0sdcCYwYIctzYlqoplJODLvtw9MZHpoQ3oViEqSBQMy40WmSf+54rPDWrN4vDO/ZTNmxxUK8cNFgzNzlPVGq1omjQiJBmLODLypCtF9pZJBt0jQ6N1oldH8VZOBXszZRl26WwXHFbtja8R3x3/5GOctnwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311735; c=relaxed/simple;
	bh=NJ3PuwMcYAd2XPc1D5PhmImA3OZFHxhBOO3OlQcdN+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEBHbiLFhErP7sOsHXMdyr8FBvZWTaHhTPrtKIWdJZL9U8rDWhFXwtskalFPyPNCkUHJ5lxHgwRXdVfmkteiPbLiSev38aShJ4HCz/2TOzYGFx9l6RrXk3YVId76UezgrCE4MIFpxbk3eE7NdAaJ6JGP6jLtL8EJJalhKWlxOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MQnfb9Zn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FIXpEK1586716;
	Wed, 15 Apr 2026 20:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/oMnbSfR/Ocx04SV5qBfeNF
	39R0O6Dbrg1icXhyuXeQ=; b=MQnfb9ZnymjOxYvRWvCEZqi1ktNToSkuXtXBsbP
	ZHX8W8MtXkvkn4tqbLPvbdG43yP4ynl6LDn5nICRrobne4GANcbDsrX8TvYLwu9i
	n2yXAG5aBL2ly4f0Ig4vvJQZ8FFrL8azVuHCNBBbxWToDgZRB2OiYnnS5k8rHqIW
	noubzREOFh7cBFOQ4icZj5qgYXASZLM0Jtck1NZudaXS/hdvn9diQiT0vUrhHo4D
	tV/EO3M7mL6Gq3zgxrN54i2DnXrtO7lNn2sNSg7Av2HrUv+gSvt2vYKFXKMr1LU5
	l9GuJL08/GLxCFIGcaHZniaE0xYyS9JWVuD+ZMEcaYvVMzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dh84n6vug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:55:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Apr 2026 20:55:07 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Apr 2026 20:55:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Apr 2026 20:55:06 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C0A7B3F7079;
	Wed, 15 Apr 2026 20:55:02 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net 0/3] octeontx2-af: Fix smatch reported errors
Date: Thu, 16 Apr 2026 09:23:49 +0530
Message-ID: <20260416035352.333808-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=B7OJFutM c=1 sm=1 tr=0 ts=69e05d9c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=sqD7-xo7ai8gySfZiBQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: JBt1h_lrd_we9DW16bddzDRe1F-Xnb2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzMyBTYWx0ZWRfXwNUjwBYuS/uA
 XL6vfewpmUGEAkYEDPpoJ5/+S9k/RGVLVywc8w1AgddnFCZ1tGQG3zKzQKAJjZk15WCnMLLshx+
 Rz9EbMDL5Ak7pNEupiTOSCJgcjbMSYB/hdmEVV6jHWihncqvSRcDDBlJtJxsyluRQERdmeQzCH6
 tM3NvoKKDrKMIaFQsRPZ0Dl5ZXrNFhqeFwlwfxfAom3sHfQHAFXnx8IW15BvFPlqlsKY1ZDspn6
 EaxiO/cYUf8G4ovNw8DZPZNt0P0SjCNSW8Cqe/PiPS597kPwy3IKTf3jQ0u5BUE25xWxUcUNTRs
 UlmSQLbMqCQFoTZ1wgjKMb/5kaLw0OZxQzK9k6mMSommVBpSHU4PUWg44emrc13O6dMl6KIZRIl
 hO4abCc11zq1anHltpz+vHP/ZUlZY9QiIN4Sqc3TDs9K7QpkF423k/F6z2TrQSIJNqx/HND1Wl9
 jYqEtZwmPLDfzkGkSAw==
X-Proofpoint-ORIG-GUID: JBt1h_lrd_we9DW16bddzDRe1F-Xnb2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278917-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B102E40A1A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series tightens error handling in the Marvell OcteonTX2 AF CN20K NPC
layer: MCAM paths now respect npc_mcam_idx_2_key_type() failures, debugfs
setup follows the usual "optional, do not fail init" convention, and
defrag rollback reports failure when freeing slots after a partial
allocation does not complete cleanly.

Patch 1 returns early when resolving an MCAM index to a key type fails,
so enable, configure, copy, and read paths do not program or interpret
hardware with a stale or undefined key type.

Patch 2 removes dentry and allocation-failure checks around
debugfs_create_file() in npc_cn20k_debugfs_init().  Debugfs entries are
diagnostic; callers should not abort probe or subsystem init when they
cannot be created (including when debugfs is disabled).

Patch 3 sets the error code when __npc_subbank_free() fails inside the
rollback loop in npc_defrag_alloc_free_slots(), so the function does not
return success after a failed cleanup.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Ratheesh Kannoth (3):
  octeontx2-af: npc: cn20k: Handle npc_mcam_idx_2_key_type() failures
  octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in
    init
  octeontx2-af: npc: cn20k: Return error when defrag rollback free fails

---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 33 ++++++-------------
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 21 +++++++++---
 2 files changed, 26 insertions(+), 28 deletions(-)

--
2.43.0

