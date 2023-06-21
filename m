Return-Path: <netdev+bounces-12534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C64737F5B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895331C20E0B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD46DF6F;
	Wed, 21 Jun 2023 10:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64991C2DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:17:22 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036F1FF6;
	Wed, 21 Jun 2023 03:17:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L68TN5028452;
	Wed, 21 Jun 2023 03:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=5u6BWBK/bo7oif1Y/e08ARqz5El6m4nveuOvMD1hy5U=;
 b=LgzQjzqoYgMeRZbXUOMsSjW7oODOev9Nxjhdfkzkg7REodSgyreBa1arBi/60AOyFTtL
 lBwqhhAoS7e+NonSb9djmLNj6eVdePmGbkrCZ05PskjVDugmpsSlSlA8sOphIyqgTtBx
 u2AUrefzcwasp6nxGIOP99WMVF4qn7NpqiFcnKpFv7Db0aVUearr6ujIcF8x2KXaqC66
 qH2eqs3RHluoo13HfxOU6MnN6lV1+KQKLyf4KTavLoN03tQ4SykGc5afxod4RLR7ZSjx
 MHKghW0wFh2VsiO9CJAwBRTO5lVXHhxgdZ+iMQPKK2Dl1+SdPH+17Sdbvl7P031fjvBf jg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rb5b35n74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 03:16:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 21 Jun
 2023 03:16:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 21 Jun 2023 03:16:53 -0700
Received: from setup-1.sclab.marvell.com (unknown [10.106.25.74])
	by maili.marvell.com (Postfix) with ESMTP id 8B00F3F705F;
	Wed, 21 Jun 2023 03:16:53 -0700 (PDT)
From: Sathesh Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>
CC: <sedara@marvell.com>
Subject: [PATCH v2] MAINTAINERS: update email addresses of octeon_ep driver maintainers
Date: Wed, 21 Jun 2023 03:16:49 -0700
Message-ID: <20230621101649.43441-1-sedara@marvell.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LaiyW7-dh_srrfRSeJaF4dIL3z7PJtvn
X-Proofpoint-ORIG-GUID: LaiyW7-dh_srrfRSeJaF4dIL3z7PJtvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update email addresses of Marvell octeon_ep driver maintainers.
Also remove a former maintainer.

As a maintainer below are the responsibilities:
- Pushing the bug fixes and new features to upstream.
- Responsible for reviewing the external changes
  submitted for the octeon_ep driver.
- Reply to maintainers questions in a timely manner.

Signed-off-by: Sathesh Edara <sedara@marvell.com>
---

v2: added maintainer responsibilities

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 081eb65ef865..23d91becf43a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12538,7 +12538,7 @@ F:	drivers/mtd/nand/raw/marvell_nand.c
 
 MARVELL OCTEON ENDPOINT DRIVER
 M:	Veerasenareddy Burru <vburru@marvell.com>
-M:	Abhijit Ayarekar <aayarekar@marvell.com>
+M:	Sathesh Edara <sedara@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/marvell/octeon_ep
-- 
2.37.3


