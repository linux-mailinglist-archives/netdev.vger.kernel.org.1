Return-Path: <netdev+bounces-249730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA89D1CC15
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9522301D655
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDD374176;
	Wed, 14 Jan 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ByxIy096"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C79374162;
	Wed, 14 Jan 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373905; cv=none; b=AO15L3NawE8/08oSUwz6tTf8nVbVay0jEZmF5jeasDOoZ7HnQOA8Y15U6vF3wwSr/LB+hO4Kp+1aou37Wii/7uao1FVPFg5BRZ16dg18yf0cqZn7GbCA3qvHbit60eRIDp60egKWPtHeu4L1xf1GvtpNTlJWGMiEqy7u1fjHhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373905; c=relaxed/simple;
	bh=5+YZOVExginY7oXeSU0UhzFz3jdULyuCNWU/0mhsiQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQQmWpYTCwkuBbtetOVLWLzQlj9/KsRAX7qnOmKnOAW3EbLAOLvw8Hv+Oso51fp6hTJmT2f5T5Gi224O1zMrvY4gGNDc/zX5G2D3gv7fvUj4G9yhE+5poMp5m3bRg6rlRUSecORbOsx2afix0Na7UcoziiDmOKKULqt6P1S/uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ByxIy096; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E6bnCu2027616;
	Tue, 13 Jan 2026 22:57:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ugrBEaiioyVo1sIUG92Xz5J
	CNvIZaJWrFtYycTUxaUM=; b=ByxIy096X+bLUwLOpWdS9gmDKmhOGCU072JWFJi
	+3R6nfM8A+cdihy+uqPu9/Dz9UBFtV+APY4EIXPUGFjmeMbfbil/cSln57YkMVKv
	/MUhNQ/+e8P9VEdGsm05RLo18OJJNx1QSu7Kjw0VTeoAaL+vssHvGe985qzdNtAh
	KDhhTxDhXd6SVa2zpCFKawvpDpQrA44P3U7daxlU42IJR5nllRjKkEzeB9CVleTC
	w34V7fqqOWpG5vvJMWusXGL5CweHxxd4jrILd6RQrl4dYGBHO8z5/k2tWPsqMRAK
	Z/HHUC2f7vA2TSEPXZHCzR1MrsgA6Um6LiK+KwPHnc3m7/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bngnqb65r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 22:57:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 22:57:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 22:57:48 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 664E53F704F;
	Tue, 13 Jan 2026 22:57:44 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 0/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Wed, 14 Jan 2026 12:27:41 +0530
Message-ID: <20260114065743.2162706-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DLeCIiNb c=1 sm=1 tr=0 ts=69673e6d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yfvZBKtj2kfplXi_T7QA:9
X-Proofpoint-GUID: yCXgwOt5QJxFrMhRwjhoFBG365S4bv_y
X-Proofpoint-ORIG-GUID: yCXgwOt5QJxFrMhRwjhoFBG365S4bv_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1MiBTYWx0ZWRfXzm2utbeOACPP
 xOd4vbti6tFBSdv9eqD9ad8Nh3vmxeCHlfXd24gwr5gwiK842XTOVMnKCszs8iFHuAxMI+3WWaS
 X+fg6CBGVFtY5nwHPrVl8gfdzuC5u1HFpvMgDKFP7tHpxgtTTC5zR/9XJfQbZA+zJfcd9iaFj8n
 HzES5C+ExyvtifA7yvaSdfd4FMV9BrZFVJkLe3v/L07nXNGO4SqA9i4W/p2TuQwfSaQi5olBtjt
 bMHsgbQEGHmovRuFLA/bMTmhIrS4ZXIBNgsi1EZ1Nl5hZV1ZkGlBpsXe1UtQKM0/n6K9S+B0EWU
 o/orsVPc0+GiXlnWJtLn2QXFzfspSG45fkummzF+NjCzKMG2rCB2j0io5VC/HnOBe+WvE7IgxLF
 SdqYdPaJXQsHy7WMLHuNEJfm6f/5D4l0/k7ihLcR75rCwJM8Td8z4J6/kdAQDQqxku8oQEYNKuD
 xVavIXyNNlkQmSvKH+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01

Octeontx2/CN10K silicon MAC blocks CGX/RPM supports DMAC filters.
These patches add devlink trap support for this functionality.

Patch 1: Introduces mailbox handlers to retrieve the DMAC filter 
         drop counter.

Patch 2: Adds driver callbacks to support devlink traps.

Hariprasad Kelam (2):
  octeontx2-af:  Mailbox handlers to fetch DMAC filter drop counter
  Octeontx2-pf: Add support for DMAC_FILTER trap

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  11 ++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |   2 +
 .../marvell/octeontx2/af/lmac_common.h        |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   |  18 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  20 +++
 .../marvell/octeontx2/nic/otx2_devlink.c      | 160 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  28 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 10 files changed, 254 insertions(+), 2 deletions(-)

-- 
2.34.1


