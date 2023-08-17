Return-Path: <netdev+bounces-28389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF477F504
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174A81C2132F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A531412B8F;
	Thu, 17 Aug 2023 11:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFAE1C38
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:24:23 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A330C4;
	Thu, 17 Aug 2023 04:24:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9bgU8018403;
	Thu, 17 Aug 2023 04:24:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=gPPMVMWj7vDkd7shrVVNLUJGIrS0Xs2WNwmq999TxVQ=;
 b=ZG1QV3olUrseMbiog2HExthnBrHOooqOgfno2xlhx3d8EnKvcsSTCYCnz4f/wEYBS7nJ
 sttQH0/dfiwxanoo34SHmBIM2t4ozBthaW29VuDuIWZ+zQmJnu7Bi9+kAQHqvUjNmdz1
 RWVj2rPLQAR1dN4qT+AUOYkZpyaFAHDxi60hNR8kZE1JcK85WE9n4sLlunEVudJMkFpo
 0LZijl/XrBd0Lrq8b7BV7UQiQXyPaQGDF2PXLITbFDxTvumIUUA25q7/7MApRs2adFhn
 IlzhHMyRUwZYqBWvrm09C6IDC4NW+1Ivr0y5u0jOL1L54C5VlzTTCK9uiMj3fWrbHLeG nQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3shh34g8qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 17 Aug 2023 04:24:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 04:24:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 17 Aug 2023 04:24:05 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 369423F705A;
	Thu, 17 Aug 2023 04:23:59 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch 0/5] octeontx2-af: misc MAC block changes
Date: Thu, 17 Aug 2023 16:53:52 +0530
Message-ID: <20230817112357.25874-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Ly74Je9upIffJrGTO8zr5aDMPHB9Vj3Z
X-Proofpoint-ORIG-GUID: Ly74Je9upIffJrGTO8zr5aDMPHB9Vj3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
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

Patch4: This patch replaces generic error codes with driver specific error
        codes for better debugging.

Patch5: Prints error message incase, no netdev is mapped with given
        cgx,lmac pair.


Hariprasad Kelam (4):
  octeontx2-af: CN10KB: Add USGMII LMAC mode
  octeontx2-af: Add validation of lmac
  octeontx2-af: replace generic error codes
  octeontx2-af: print error message incase of invalid pf mapping

Sunil Goutham (1):
  octeontx2-af: Don't treat lack of CGX interfaces as error

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 11 +++++--
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 31 +++++++++++--------
 3 files changed, 27 insertions(+), 16 deletions(-)

--
2.17.1

