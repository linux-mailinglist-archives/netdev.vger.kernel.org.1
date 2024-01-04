Return-Path: <netdev+bounces-61644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E16824773
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7531C1C20DE2
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9A24B5E;
	Thu,  4 Jan 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GyzC/eRc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD4286AD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 404Dv8ue023391;
	Thu, 4 Jan 2024 09:26:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=s2048-2021-q4;
 bh=YARxCu+rFd3JxwwrXq8pUmPnBL2LQ8pxLwMIXRg3ntU=;
 b=GyzC/eRc+SjtzarTVqzidObT2VWcGU9L5cWdo9usecQwd/Lo+xgCpxoHjeNoo0tiJwb5
 /kK3/DLbc6Dss+QmDXdQSvaunJUI3iiwFh40IoO5I6+xmUUDZyhIGfOFRPZ545TYUevP
 avgsGA8G3XJr/CMQqC6Kz6erd6J4L/Jt4MaJEjv3ZWh2GGvPH03WEqV6gCknKnvPfZhr
 d/rf7zcqUbrbVjzkY9rv38IhHWBNZlW3wrlyR2oUFaoMM/CLUDtstn1IA8BmmMbUHm/n
 /p1hvXNxmu/U610Am+3F5gIhsryier0MfsQR4FfURgNMHh6/+KkK36/mPghaOIGiY/3d QA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3vdqnbkkmg-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 04 Jan 2024 09:26:52 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.34; Thu, 4 Jan 2024 09:25:58 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
CC: Vadim Fedorenko <vadfed@fb.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] ptp_ocp: adjust MAINTAINERS and mailmap
Date: Thu, 4 Jan 2024 09:25:40 -0800
Message-ID: <20240104172540.2379128-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sIhJgYDEvaqZf5aj33Wdc2QXAwW7CWLa
X-Proofpoint-ORIG-GUID: sIhJgYDEvaqZf5aj33Wdc2QXAwW7CWLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_10,2024-01-03_01,2023-05-22_02

From: Vadim Fedorenko <vadfed@fb.com>

The fb.com domain is going to be deprecated.
Use personal one for kernel contributions.

Signed-off-by: Vadim Fedorenko <vadfed@fb.com>
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 68e72a6017a0..601b413899ff 100644
--- a/.mailmap
+++ b/.mailmap
@@ -603,6 +603,9 @@ Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Uwe Kleine-König <ukleinek@strlen.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
+Vadim Fedorenko <vadim.fedorenko@linux.dev> <vadfed@fb.com>
+Vadim Fedorenko <vadim.fedorenko@linux.dev> <vadfed@meta.com>
+Vadim Fedorenko <vadim.fedorenko@linux.dev> <vfedorenko@novek.ru>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
 Vara Reddy <quic_varar@quicinc.com> <varar@codeaurora.org>
 Varadarajan Narayanan <quic_varada@quicinc.com> <varada@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index e5670722d3d0..aea8f859fb6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16156,7 +16156,7 @@ F:	include/dt-bindings/
 
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Jonathan Lemon <jonathan.lemon@gmail.com>
-M:	Vadim Fedorenko <vadfed@fb.com>
+M:	Vadim Fedorenko <vadfed@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/ptp/ptp_ocp.c
-- 
2.39.3


