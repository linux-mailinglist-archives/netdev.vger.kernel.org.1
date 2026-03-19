Return-Path: <netdev+bounces-269418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA5XNmviu2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:47:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DE2CA93E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B43B3008E21
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D093C73F9;
	Thu, 19 Mar 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L/VBcNdY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53513C9ED4;
	Thu, 19 Mar 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920858; cv=none; b=LBnqPnev1H64QqknV9Ggk1ybuBKhI6udHIQ1or96S7kqXYJo4raqXa1Pm1ro1xaoL0cultsmJO4lwyZs3xIEXvC/liyc82Srj+Ou3pv5QyYSfJ+SvsdqMY5lDLMMLDI7W3WQNQEMxnW7S2nT0Y1Xv5funRemljJjztxnh1gQvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920858; c=relaxed/simple;
	bh=RvLRMMdR/jwSVFuhFWg6BqTlwACjjNZ4SExBu/pGFxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzAAo8hkDmNALvXallImO/N0xQ2a2j4/PPe4dKuvPyjkuAzgFvdl7rH5+Ez3Dix4Y0e8Owqvv1hPzlXQC01w6ZMBkeW+70PUgc5VfmsuSqnsOSzyuDOBarhJ/RRllDJyEMWcxbEjjzBd/gXpU32SYEV3BxNbdXETsLM5oacV/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L/VBcNdY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4wfFR080683;
	Thu, 19 Mar 2026 04:47:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=jbAZ7okQ8lAA/cq8CmxsunkFqqeHbOQC0RhviSb9l6M=; b=L/V
	BcNdYA2OUv/Bn3tsTkqEiTcY6oJh3QFtSf6uXTu7RPOmMKPi9VsfStwrilW+sM+g
	Eo3yBSmRJAcE7TNDXqAH+UOwQZekB46094zY3KkXzrZSNprI9oYZV+xeaZbNiKZs
	A4ojPlXBnB1qdPxOJHkCXwVKuuymb44T2230S5w+7nA6zfkDNVAmjUR6Ri6h6j3i
	bAmNXrKlLgOWbWNd3wSaUplbih4SpgRP4PnYSH2FJW1MsbN3CuWPpmnPMMF/1llQ
	b/U92oJGYlonSTZNVATCSMTDSWmshReRiCQelj5Lv8fdXCxUWeG4eewBcpb8AHw7
	eXyv3vj+QnmqDEL0FiQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cyxmh2hm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 04:47:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Mar 2026 04:47:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 19 Mar 2026 04:47:20 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B738B3F7071;
	Thu, 19 Mar 2026 04:47:16 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v2 0/4] octeontx2: CN20K NPA Halo context support
Date: Thu, 19 Mar 2026 17:17:02 +0530
Message-ID: <1773920826-16985-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 38zQujw9DrJrKbSDpuDIyg_VEvs4xTDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NSBTYWx0ZWRfX5HgtJRk81t0c
 azf7/gFZHcLbL9aKtS1faBBTqPyTcBM9+fMhMi5Z7NYDBrezqSbXzPULoP0Q7sHtUWpC1LGP0Lh
 C7CRSTWhQwGh6UeSbQQEQc3FogWpuzNO7r/yVWvEONbKOCEs6g+TGXIwwHEIHF6+24qTQPuCQoe
 JwONzgpdffrzvOTmFNjarT8Q/LzfrDxAjEgoBSvjLCNLb3AFD7NT6/X4U82fidqv/I0ZwmHUkg4
 3CbsmLZrM0tcWnOYvNfSXY+Sfma4fur3nsNu0rxSYnLt/bEoJVII/a9MiG5aDd3Lxj+AnS8pdL/
 8gCyQg1y5a9kVW7ayrCzHSsQO9i15iE2Bmw71rMl5mKd5Pq/M7/QEPrjsRaouXg+ecyvpImiJiL
 LBw+4cnLg+4dC/4gLSD52ZSO8PKzg2PY2eqJtokz78xFk+U8cc1kHnJMwQMFjNs6LnDpkMT9WAf
 YL1ylsYn/TMOy/U/x2w==
X-Authority-Analysis: v=2.4 cv=KvNAGGWN c=1 sm=1 tr=0 ts=69bbe249 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-ORIG-GUID: 38zQujw9DrJrKbSDpuDIyg_VEvs4xTDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269418-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.976];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 932DE2CA93E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds NPA Halo support for CN20K in the octeontx2 AF and
PF drivers. On CN20K, NPA supports a unified "Halo" context that combines
aura and pool contexts in a single structure. This is a simplification
in hardware so that there is no need to initialize both Aura and Pool
contexts for queues. Separate Aura and Pool contexts are needed say if
we have to point many Auras to a single pool but we always use 1:1 Aura
and Pool map in Octeontx2 netdev driver. Hence for CN20K use Halo
context for netdevs.

The series:

  1) Adds Halo context type, mbox handling, and halo_bmap tracking in AF.
  2) Adds NPA DPC (diagnostic/performance counters) 32 counters with
     per-LF permit registers, mbox alloc/free, and teardown handling.
  3) Adds debugfs for Halo (halo_ctx file and NPA context display/write
     for HALO ctype).
  4) Switches the CN20K PF driver to use the unified Halo context and
     allocates a DPC counter for the NPA LF.

Changes for v2:
 Fixed all AI reviews
 Removed inline and added const for npa_ctype_str(as per Simon)
 Fixed build warning flagged with W=1 


Thanks,
Sundeep

Linu Cherian (3):
  octeontx2-af: npa: cn20k: Add NPA Halo support
  octeontx2-af: npa: cn20k: Add DPC support
  octeontx2-af: npa: cn20k: Add debugfs for Halo

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 143 ++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  74 ++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  77 ++++++-
 .../marvell/octeontx2/af/rvu_struct.h         |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 207 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +
 15 files changed, 580 insertions(+), 119 deletions(-)

-- 
2.48.1


