Return-Path: <netdev+bounces-283714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIqzA5VL+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A314B95EF
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D773A3004257
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC72D836D;
	Mon,  4 May 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K2XGO7lc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109572857EA;
	Mon,  4 May 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879952; cv=none; b=rgUG72XfQNJgVvPz9VKfNEG+WyvXqShE3ZDee1cocItoYCPeV0brV9/4jwT7VAzsXWKxvS9jLg2TRs6TSKPdzjK0F4NYs2ykhDDCgdzLnnYD26KCnNPXJYRKi2PRUVAvz4EE8BgfBy2A9KzL0XT5BV4eDIL3HqfEX5Tdw5SGtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879952; c=relaxed/simple;
	bh=mZPf7BigUouzlgJ++tCMblfW/BSOaFOArE/ZWfXG1JE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJqchH7PXZearm/DpysDcC353g1q6vYF3D9+hU4zfV9yBA+nfFYklhzro8f+qsnExEfNr5+et1Rh5ymiIAH9wQmaefE29I/mO7jeBtyAaORksPngWgtgMi5Z34HjxD+YEvtj4yBYvDdU8AZndVVcD4p/szi9W4pFo3ssSe1yY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K2XGO7lc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643NoNof280108;
	Mon, 4 May 2026 00:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=tqXQATzsnol0D2p2ROL/PVlRbZrFDmx5Zm86JYlVTUI=; b=K2X
	GO7lc3m46aYyeWE2cuiVqs35+tWrkcaiX+ZUETbA8Qdrs4TWK3hLpxirE6D+2+ji
	V9YDmzhXHJOqiW0IWicZViZXyOLmkHSgz0BPaCKx/QHMMtTt97TaXUrtq0o0EMSS
	9ZlBB5eK+KToayJYZBSz087T0ikTY0Tp01nVAaHk+dnlYxlwWJbqExPBJiorzAw/
	U0REcWWMstmFNDVMmVK+0LN8E2uic59Ua1gDhvVWgQQdAxz2ZLVKGTQ3C04wjxGh
	1ghKmoA4IFMVrBK4eDBgcoWxXYLWIHQdZIZXuJAHrl1PZtYeawwbKZctdrmoGa3B
	4SSaycUDg/1+ZSKwNLA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dx218svxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 00:32:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 00:32:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 00:32:07 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 0DA0B3F707E;
	Mon,  4 May 2026 00:32:03 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v5 0/4] octeontx2: CN20K NPA Halo context support
Date: Mon, 4 May 2026 13:01:57 +0530
Message-ID: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MCBTYWx0ZWRfX7Svk6h7gH5hG
 JKjr14xO1llvwSOEaA6bw63kRdKbKkYoYZmR1n1fvuO9EZtGvWwtOoypUeKLGtOjGkO1BAF18Ug
 m5T8XNL2TdzPMmr4e1p3xpPGMMqNfYoLEb/gvt72IVO7k34W3AUWy3BwAekmmz2lkfDI25ipFeZ
 CgEmNR0OdcEsYZa+nipW2/TaPfNZdyYvfLYaoc0j9RQMUx/kh58TuWuk53OeJwG45kwLR8LizoK
 TM+fQ5SnL8cXy18ixCO4SlXHwGnsyvAS23w6n4EdMwgIfujGzJCTvgnElyspBMFYUTItb3QEWwW
 jUQSoFlkhGXcBaNiuvB9GuGBlcG8WAF8AtlHTrn0f0PY6l30FhGdbQ1i7PwgiioPAax5xgSftqM
 CaeURpQZKoeRN2c8ApbsiV8RcrZieeztXhRKUCdlUA+RMoza5/mvDpDPVB9xE+mgbWqIkuP1r4P
 lE64vv5SqSjwbZU1+pw==
X-Proofpoint-ORIG-GUID: GBa2eTZPmt0EP9iPUn4yBqCHIjZg83wt
X-Authority-Analysis: v=2.4 cv=coqrVV4i c=1 sm=1 tr=0 ts=69f84b78 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-GUID: GBa2eTZPmt0EP9iPUn4yBqCHIjZg83wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 77A314B95EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283714-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

Changes for v5:
 Fixed double free of DPC counter in error path as per AI review
 Modified commit message to state that backpressure
 is not supported currently
Changes for v4:
 Fixed DPC counter leak as per AI review
Changes for v3:
 Fixed all AI reviews
 Removed inline for npa_ctype_invalid(as per Simon)

Changes for v2:
 Fixed all AI reviews
 Removed inline and added const for npa_ctype_str(as per Simon)
 Fixed build warning flagged with W=1


Linu Cherian (3):
  octeontx2-af: npa: cn20k: Add NPA Halo support
  octeontx2-af: npa: cn20k: Add DPC support
  octeontx2-af: npa: cn20k: Add debugfs for Halo

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 156 +++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  71 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  77 ++++++-
 .../marvell/octeontx2/af/rvu_struct.h         |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 215 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 15 files changed, 601 insertions(+), 119 deletions(-)

-- 
2.48.1


