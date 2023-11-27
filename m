Return-Path: <netdev+bounces-51194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C67F97D0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA9BB20760
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE314C8F;
	Mon, 27 Nov 2023 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fbKyWrM2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E0138;
	Sun, 26 Nov 2023 19:05:08 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR0QDe4014892;
	Sun, 26 Nov 2023 19:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=nwz7gHQwCxsIA25GsAN6j3mVI3rNzFWMQ+mDMHa3nbs=;
 b=fbKyWrM2k0wWn71/m3sV4OQl5SziRKTEGLDWovv1RVyAW80ppwDDs5zp5hEeEiCcgKBR
 xNhQRzSEPQck4ak36ykFSe/uUZRPX0lmuPZd5F0edYS4xyY5iwVjUy8EdLZI8TFgy6ae
 MrI7meush5ZfPzYtYmbhHV9D9z02F4MKGgpP811LQKeLnkt6qpXFjiDy4wcD90OcXj0v
 D+iR3z00tMfeaMTQJ0nX3pyCsYl8+5xiDvwEDwDpmGhP9thTei688N009mcMHvfo01U/
 H8YPfkiMBrJjfj+fXwyxwo+z9IMw11+FqXov3BDtuuHZDnSyt+pATN+5JOxY9FhCv2k5 gQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ukf5x3bk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 19:05:00 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Nov
 2023 19:04:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 26 Nov 2023 19:04:40 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 16FF53F7093;
	Sun, 26 Nov 2023 19:04:36 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v2 PATCH 0/5] octeontx2-af: miscellaneous fixes
Date: Mon, 27 Nov 2023 08:34:30 +0530
Message-ID: <20231127030435.17278-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: sQlOaX69Hm-dW_d4EQntZ63jGxRxWKg-
X-Proofpoint-ORIG-GUID: sQlOaX69Hm-dW_d4EQntZ63jGxRxWKg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02

The series of patches fixes various issues related to mcs
and NIX link registers.

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


