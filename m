Return-Path: <netdev+bounces-53820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A632804BBE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C39B20D70
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874BC39FC2;
	Tue,  5 Dec 2023 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ie156mfx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE583;
	Tue,  5 Dec 2023 00:04:50 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56OgUu010784;
	Tue, 5 Dec 2023 00:04:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=2v7hVOtPK2yq7lmi8EzueIP6M2JLGBrzUhoc6+whsqk=;
 b=Ie156mfxVJHHbH42QonTw7YCf4tYLLJm1xxk4zexw10Wx2Veh03TxjjPyoXNVV85HtsB
 qmANy4GiZ5IPtFhvxNgYyVTI9vokEuFuKuJem2WTTwTnrPU7RZkIorMfd2QzVlFxRlnh
 6INqkKiyigSHCj6ue1iJ6uvLe1nDuanhkDLnpInLOK5679hYu0PEM8WsHSpbeKXS3fXn
 UGlktK7a7yBBvwt501+pWNcP84rthrqdn50ZIVNZN5nJFl99OMe4v7pqlnhNyFejftgo
 FoIY5VwrjfDsgWAOzBp/BP9ERPQj6V7uRjs+Wf0wJhV67g49saQzQR5KASSmCnc4TKSD Sw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrrq47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 00:04:42 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 00:04:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 00:04:39 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 126F93F70A6;
	Tue,  5 Dec 2023 00:04:35 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>
Subject: [net v4 PATCH 0/5] octeontx2-af: miscellaneous fixes
Date: Tue, 5 Dec 2023 13:34:29 +0530
Message-ID: <20231205080434.27604-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _BV2wP90xjzwZb79cZQC_tV7oOqsKo0Z
X-Proofpoint-ORIG-GUID: _BV2wP90xjzwZb79cZQC_tV7oOqsKo0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02

The series of patches fixes various issues related to mcs
and NIX link registers.

v3-v4:
 Used FIELD_PREP macro and proper data types.

v2-v3:
 Fixed typo error in patch 4 commit message.

v1-v2:
 Fixed author name for patch 5.
 Added Reviewed-by.

Geetha sowjanya (3):
  octeontx2-af: Fix mcs sa cam entries size
  octeontx2-af: Fix mcs stats register address
  octeontx2-af: Add missing mcs flr handler call

Nithin Dabilpuram (1):
  octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

Rahul Bhansali (1):
  octeontx2-af: Update Tx link register range

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +-
 .../net/ethernet/marvell/octeontx2/af/mcs.c   | 16 ++++++++--
 .../net/ethernet/marvell/octeontx2/af/mcs.h   |  2 ++
 .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  3 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  8 +++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.c   |  4 +--
 8 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.25.1


