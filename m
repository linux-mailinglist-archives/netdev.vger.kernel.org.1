Return-Path: <netdev+bounces-279634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPPiMfKQ5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:35:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BC426507
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 538E9300EF82
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AFB37756A;
	Mon, 20 Apr 2026 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VYz+iZFe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6D19F11B;
	Mon, 20 Apr 2026 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652527; cv=none; b=qGQEyMhgG8S+s9z2EZC3cQLR6GTby/YqpFL028laWs82s9XfL+17tGvx+f18QKLKEyjIKQvDS37Wk9C/npIHB2SOh51fBerV1hiY/sLy4lcMM7VezZgZARKbLpopCyHQmC2Xs8ix7h7husI3B2Uzh7AoeD1KHmgDBbzpdMv/DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652527; c=relaxed/simple;
	bh=6Hmx3MU1sTt0MgaFOeRwOaui78enaSk36Ls2KeY2i28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1XmTH7agJIlo4Y8yWjJi4MX3pCt50Vjcom/ZPam8l7UmykcC5N5Pq9/BAQGq/NPJrJTgk6Ko2oBxh7+KEsGl210t+PjMHpcclFtvIBZHXRZ+rcfKKQw9BEjU10Bq8mlIn7Edj4FJkfaDLLy2ZbdqOmP9B4xK72LgVaaESbtbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VYz+iZFe; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K2ITP32059117;
	Sun, 19 Apr 2026 19:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=d/1CGjzah25l6FONLZJEpN6
	3FyULMyldyju5FuTub40=; b=VYz+iZFedY5xTgm0Q7teCXm7IfSZJH6jC0+779n
	1JW8qS4jQzGA3ranaEtwEsxMfP3ZlTf/Wg9ElqgONMoaJvCEBZ7qS8Lu8bJGOB0N
	Mv+Bo4f2VdfgQoMVqJqgrnFI20FacJ7cDn8Sy+P1irpjidGlMM9NmqdEWpaNJAt/
	Wqa66QwU04J0rrTpRzFsAtnz9Ty5UYCzeoeXziZd+KhGEnO63iEIxvZk/QgNd4RM
	+RK1dHL1P4i5Hb8RtD0kewJYqCiLJybuBlLbZBGkXsCswLjhe5rcsvpOZpw5nwPD
	NDpCJzgcKR29fppeeBClVsIYiK/NfmN+X8jGx6ZFINkaYAQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dnb8180qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 4F0EE3F7041;
	Sun, 19 Apr 2026 19:34:58 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net 0/11] octeontx2-af: npc: cn20k: MCAM fixes
Date: Mon, 20 Apr 2026 08:04:31 +0530
Message-ID: <20260420023442.3295891-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfXz3zThfxeLvRR
 OCcbnw9Q3Tc2DuXk+C3RWiji9D6URgOb5MoDqZH8vzGZJvaxzWvI4wCb4w1U0e/cYpKBxSppSlQ
 n6J6JsW/R+7Ai/RpcvxYBF8HSIcKQXs91MbIRqGpKi2+VgOlaYCIKbiUg5LCmXPTt6AcgNOpuAX
 4AJwd1ew5wF1yBfngxBa4/bQ/jyrKo2GH5YLhBGZHDKd75r1C/9DYgXGb8lRly7cwhdUvIxkE/F
 DU92uWvEszSlk1Eqb/sRUmlW1o78rXKFYnFoQRhvEaWreGs68TNMO3b+OoBf10crVhK1TY94KaW
 TVD20y06SElrRmwDoEL6x/U8lsT+m2k4okATCubnfwIcTaVR/jQMlSPBkgTCopPJT30Fzu+kO6T
 uAaojtcY/3GXoSDZPmIGJbZuO9kodGTuxzKP7NoKH7MuXNkuBPnqMbQfnGcXpiWlh0z9VcVwmi5
 RcD4qEmVEAkbwyKldUg==
X-Proofpoint-GUID: Br1ogvDIhxpGPkBWqt6BMOjUjx3wWTI4
X-Authority-Analysis: v=2.4 cv=W6wIkxWk c=1 sm=1 tr=0 ts=69e590d6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=jJBzseYy13a1LWwCShkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Br1ogvDIhxpGPkBWqt6BMOjUjx3wWTI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279634-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 347BC426507
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
v1 -> v2: Addressed simon comments. Added more patch fixes to this series.
	https://lore.kernel.org/netdev/20260418162013.GG280379@horms.kernel.org/

2.43.0

