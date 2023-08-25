Return-Path: <netdev+bounces-30637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A1788519
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1191B1C20FA7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C2C2FA;
	Fri, 25 Aug 2023 10:40:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659D1843
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:40:48 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF78E67;
	Fri, 25 Aug 2023 03:40:46 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3YDUR025426;
	Fri, 25 Aug 2023 03:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ULGo5y56IIkJmUKVD4/PVXleacDfOWY6lBq/dDiq/kM=;
 b=X0OE+EeRVzHCYWlpWifR1etrebnj54mTyCQmZY0sz0m0tdrpRgXY5FdjnXZphCiKY0WW
 TyJyg5JYcX/IBfNJW3KTbQpBJJiDAkKYIPXNnKovi8mli+FK3fDzGuAYxLfgF2+lYV+J
 wfEGTq8W6TGyB+D+aQQkQyNm7mjNQj0pZHBl3AgF7A3u9Aix3H54HX7wc5lIU/mZMeFg
 QtOSQkt9j2Ucef13bIKbes9Uhh2QSg9CRi3KnqfjgglyfVRnJ6NMiaBzhxdWhH1FldOy
 tFhWkh6Sn0KCH6tI5r6T52K/1cG2z8AyYKFU+8pW2esJBGClim4vWrsQ+BnYZ7ynGBdU hQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3spmgvs3nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 03:40:29 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:27 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id DFFEB3F70B7;
	Fri, 25 Aug 2023 03:40:23 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 0/4] octeontx2-af: misc MAC block changes
Date: Fri, 25 Aug 2023 16:10:18 +0530
Message-ID: <20230825104022.16288-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: w82loodIsWPj5_R9WZree4Sm2v-68rBE
X-Proofpoint-ORIG-GUID: w82loodIsWPj5_R9WZree4Sm2v-68rBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series of patches adds recent changes added in MAC (CGX/RPM) block.

Patch1: Adds new LMAC mode supported by CN10KB silicon

Patch2: In a scenario where system boots with no cgx devices, currently
        AF driver treats this as error as a result no interfaces will work.
        This patch relaxes this check, such that non cgx mapped netdev
        devices will work.

Patch3: This patch adds required lmac validation in MAC block APIs.

Patch4: Prints error message incase, no netdev is mapped with given
        cgx,lmac pair.

Hariprasad Kelam (3):
  octeontx2-af: CN10KB: Add USGMII LMAC mode
  octeontx2-af: Add validation of lmac
  octeontx2-af: print error message incase of invalid pf mapping

Sunil Goutham (1):
  octeontx2-af: Don't treat lack of CGX interfaces as error
---
v2 * Removed patch #4 which is replacing generic error codes with driver
     specific error codes.


 drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 11 ++++++++---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h     |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c |  7 ++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

--
2.17.1

