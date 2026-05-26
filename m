Return-Path: <netdev+bounces-291654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHtFp56FWp8VgcAu9opvQ
	(envelope-from <netdev+bounces-291654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B385D461A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E1A3025938
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3B3DC4A8;
	Tue, 26 May 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hPPpA8S1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483D34CFCD;
	Tue, 26 May 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792477; cv=none; b=G04KC8f6D3UI1fTqv2HAuWcDU26fpl5EVAuO+/jH6OWCDGQMV8W/C6Lo6uBuxk+PH4D1w3EfLeh0iT0nRRogNf0qEC8kzaoz7i/1eC9eeOJPy/Y4xP3FBGN0nmjcqacI7aTruTlwN7LA4oWwh6h8JoEbJPrqzzfiAI9giuiVpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792477; c=relaxed/simple;
	bh=qHwSDXLH8uF7rDuy+ncmgr+Ep/hEmSC7eLTXc8CMOtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyCyyPkXqHgy+31/kWwZ4I/rMsURCLL5VbWd/CLghMWI3jKM/pCWO90g8btLGNnVaJQHj6BByN0Ia4kFpClGQABuGuSBM4uER2XDhjWSrjLMDdmEebErwKZ3KLHhhfWcxSCdtQe8aRjlP9nM6rdZw0ZeJfOxT5O29LnXgGj6wzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hPPpA8S1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLmlDd1306274;
	Tue, 26 May 2026 03:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=AkvO4txROLxeP2ercTtpzWZnnrZRWF/vialTRPE0iYg=; b=hPP
	pA8S1OL5XT8e9MmvXo9830b3PzATZbldExF/e6pHnJ/fAJwamn4NzifBGGF8BvZy
	QGMSKGdkgTEHulqN8RbmY5dYW8MWXBuMRBJnXXMZy0Csqh0LEZ0rawLDcmY715kV
	VSE5hdRB1MJQFjW1fMDQ4cD2HCb0hsJvO9ov+aHDHSoEcpyDNtBMyvu+aquKPu1n
	ZsSNgVAN1s3lU0DtK53WFwG/L2THa37LwpC/Yh6Nz5R2HA3kR6azhlPicDHHAqsl
	2u00CsaszrH2URHgkYyI6HI8lOlwnFLrip0+TtKe7XlHxoBRTlfEw6DV8jS/9nwt
	WvGvlRsQwdDUlv2K5sw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ecb6tvggt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:47:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 03:47:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 03:47:33 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 41C7F3F7045;
	Tue, 26 May 2026 03:47:30 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v6 0/5] octeontx2: CN20K NPA Halo context support
Date: Tue, 26 May 2026 16:17:22 +0530
Message-ID: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MyBTYWx0ZWRfX29t0G8ytnfWl
 r2zhsrZHtzMcusP1pr7NDAwqs1ROLhwibHCR0XqnIu84+/xB1pqf8yCkpCTMHJJqM8kes3rTxc7
 nBs/Fkp/aHhnEkEQL7IRzzwa1xlOP++wKsktzrbIZbaxfvasQhRGGYZwmtmcJD3NUsn/kwxOoyR
 bS3XKZOLW9fnJUnZNvhedf6tedFSY5HDmSKeNZIpCvK4lD1RWj7FeOE7wzODIAlFbbb+N9/KwLq
 3C2ZPnguMCF4zA2+Qpcl9r4wmCx/dcPppL0BjX1lYljAONsWrbrSSo8/ia2TMAN4qiM9YDqWfVc
 967AIUqZiLjBvQj8FWpYxsbVchQYvnwvstioWSSzUEeEiJmVBawhKnRJB31JkIaXPwUgUX4XVcc
 CW9kclacqZbJiGGB8bn8vyKrqCPHrYHL3qrX/+daQ3ewzQs1n3ELYJG+sQ7/Yxviykoj6Doju2N
 ardC5UaJE61HCBjkIIw==
X-Authority-Analysis: v=2.4 cv=JtbBas4C c=1 sm=1 tr=0 ts=6a157a46 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-GUID: 4YYt3SVIzlNH10li9qRAeJXG2Sril1IU
X-Proofpoint-ORIG-GUID: 4YYt3SVIzlNH10li9qRAeJXG2Sril1IU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291654-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D3B385D461A
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

Changes for v6:
 Fixed possibility of stack corruption and double free
 errors as per Sashiko reviews. 
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

Subbaraya Sundeep (2):
  octeontx2-af: Simplify NPA context writing and reading
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   3 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 139 ++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   4 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  71 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  96 ++++++--
 .../marvell/octeontx2/af/rvu_struct.h         |   7 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 209 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 15 files changed, 587 insertions(+), 131 deletions(-)

-- 
2.48.1


