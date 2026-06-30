Return-Path: <netdev+bounces-302981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id thjlJ5ZgQ2pyXgoAu9opvQ
	(envelope-from <netdev+bounces-302981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 107116E0B44
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="NU/5nzWc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302981-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D6993016002
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B73E44E0;
	Tue, 30 Jun 2026 06:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47393336EE9;
	Tue, 30 Jun 2026 06:22:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800531; cv=none; b=KLsFY5d1atwR8hINvwUv1Ss6Mcs39mIkI34j57f7TBcePkaK9BIhJmQ4S4s5knN/FeaUH/UzIEasjg52O/QR4uNr8E12syifvtp9m/lrRK3J8nv0hm4LXCil1aZSpjt547YPVKzN7D9q8RDZyU2ddhvKok6VLpRrsB4FB6uo8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800531; c=relaxed/simple;
	bh=m2O89VPI6JEXJFqa/aL9ZWvlMZJ7oWrYznfu5QiSfNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qga2Qm2b41KGfokweWfzucJ6GrRWjHWDIp944gh+Ru8R75v2+zta1UddLdg4wFWBI3FZ5rjcizPjex28Yf4UGIICG4W8ArKYZVIo8G6Z7GSISjlpG6La11ROMJ52XHRH5ZlhikUMRvreW/RwSTPMvsWRA78TB092WbWDr2dlTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NU/5nzWc; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5d8Kx3954375;
	Mon, 29 Jun 2026 23:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=0Ci3YaisIhEr4wgLMHcO67X
	tvB074lKFvewkGmLcHB4=; b=NU/5nzWczIMMQJETmsJJFKLqYfb3Bsij2pyXeCR
	sM4ZFCpzaYPF0pbwnEMIc9v0u/I/M9KtzkBk5Y9proIL8goys08jvjLktKY+CdwJ
	HbE2HWgRm1VBJ3Qb1olKiCcbRLjQox9JevbGdO2qYf/ZZQhUG/7mfb1Clyj12Z+M
	568Qt8zw1eOobcUmS7LfA8orSL2Zf6ZYQ/qTl4ghZRlRiw92/1J60BMnyI6v1Vjx
	MeoHqxw62RDqA3fe74bRri1a6lO/V7KB9x9y3wYFJNDNzfALlFVgP7/tGpTNuM+G
	KFpXsXdNuDqNrQhYnNkajTWLOn4RZlLB2IMm5eGkdBDrOow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f3uwfajkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 23:21:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 23:21:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 23:21:58 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 289BA3F7080;
	Mon, 29 Jun 2026 23:21:53 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH net-next 0/2] octeontx2-af: NPC parser and RSS improvements
Date: Tue, 30 Jun 2026 11:51:43 +0530
Message-ID: <20260630062145.2533816-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PFwlYgTSE9VEA1V3mbrElzDCWuD0Lsxz
X-Authority-Analysis: v=2.4 cv=WNJPmHsR c=1 sm=1 tr=0 ts=6a436087 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=mlPuASG-G_L-QCVXceYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PFwlYgTSE9VEA1V3mbrElzDCWuD0Lsxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfX7ZKi5eVmWJJN
 Ps4N6q9Mvx9HL3U5qwWs0bgHHR+bM7Df/q2LssEMXe95E/EGD7jzepb6YGX2gwKVa7iBCQg7nSi
 eP2JWkMaUknNcWManizYoE4+WK6IDSLMbYC3nOQwpCvOVtwC3G+kM6yEv5W6t1Rlum9Y1Q0fdeh
 vWfsrDoFk/xPXAhGx105ODD4oTAi8OuerJcfI059+bBi7SV+q73isOZRGHvHoY8m9wNgi2drCe4
 5jc9zh2E+k4TC7iV86v2UOfySDLF0Q3lSZPzXWK0RU5zz/kl7GjJqQoh3+ZQA7Mk2ZObah2GhLe
 9IR3ynEBQJkgHe6eZHE++jXcayIGItsczdwcXO2Ie30XoXRmRCbpFIAA0Z36U5rxEtNnrEL/Vr3
 jpX5jC2Q41TmgckKMjOsBXUrdUPrGhUQStbUAlBiEo1S+towp27nYvs/3yVs90MB4vpjAZLw9yA
 D3muv4N2dR+uvggOtOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MiBTYWx0ZWRfX+I0a69X7XFNU
 g/6sEk7Ueg/U0TiD6M/eXDwxoxj5680U0bftdzKTjJ0a43cAKJUhqsPz29t1NgNX1yVaPY6Nvro
 aYWv7GCEuzfRs28H1m3RyNakjTpljdQ=
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302981-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107116E0B44

From: Kiran Kumar K <kirankumark@marvell.com>

This series extends the Marvell OcteonTX2 admin-function driver with two
improvements to the NPC (Network Parser CAM) block. The NPC parses packets
received by or transmitted from the NIX, and its matching CAM (MCAM)
selects which VFs, queues, or output ports handle each packet.

Patch 1 reserves a new range of PKINDs (46-53) to support configurable
L2 skip-size parsing. Packets arriving with variable length L2 headers
or a CPT (Cryptographic Accelerator Unit) pre-header can be steered
to one of four skip-size PKINDs so the NPC advances past the right number
of bytes before starting protocol classification. The mbox interface is
extended with a skip_size field so PF/VF drivers can program the desired
L2 offset at run time without rebuilding firmware.

Patch 2 adds a NIX_FLOW_KEY_TYPE_ROCEV2 flow-key type so the RSS engine
can distribute RoCEv2 traffic across receive queues using the destination
Queue Pair (QP) field. Without this, all RoCEv2 flows hash the same
way and land on a single queue.

Both changes target the admin-function driver to improve overall hardware
parsing infrastructure.

Changelog:
v2:
- Fixed coding style in patch 1 and patch 2.

Kiran Kumar K (2):
  octeontx2-af: reserve 4 PKINDs for skip-size custom use
  octeontx2-af: Add RSS hashing support based on RoCEv2 header

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  9 +++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 43 +++++++++++++++++--
 5 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.48.1


