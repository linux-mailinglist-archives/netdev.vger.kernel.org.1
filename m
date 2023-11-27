Return-Path: <netdev+bounces-51370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E328D7FA63A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5F9B20E6A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5A364B6;
	Mon, 27 Nov 2023 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UvVpQtvY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52743DE;
	Mon, 27 Nov 2023 08:21:50 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR9Kn2s020532;
	Mon, 27 Nov 2023 08:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=kOtadE82wwPJ4D6Q4wg4bsRXrZgUe/TOuvjciDl+/L8=;
 b=UvVpQtvYFUtLmFhMM1OXebCY+KeD6ZB72sQ6G8pqqyJ8Psiy2Bymt5D7Mu9N2cke0rME
 zSM8wNkHYQ78Qa1HDuxkDDIs7B0n4qYOBwPG2A4/+jW5cu5pN/lFC+BgddGQWsXj6iY6
 catnnTbxjOiN2TtD0UTOK3Xo4dokhXhT8m27UH4XWcmtASwSB8B+TXZljy7EfKeVh8KX
 sTQzwsuOFHiDhnu9ccCDVduOM2LiGbBsQulnr4WEc9fCuyBD3G8o+giwY9dhoWN2sNRw
 x+PpWu5jY652NEIUqUynk2BXYL4nZbe8+uETm88NFiOw77LTaxTcJTUpuNZKeg9dWX8h Xg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3umrcu99ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 08:21:39 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Nov
 2023 08:21:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 27 Nov 2023 08:21:37 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id AEE5F3F7055;
	Mon, 27 Nov 2023 08:21:37 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v1 0/2] support OCTEON CN98 devices
Date: Mon, 27 Nov 2023 08:21:33 -0800
Message-ID: <20231127162135.2529363-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mzNhK5v1MrKQFTaEssXb8CtvXOQ8ixeA
X-Proofpoint-ORIG-GUID: mzNhK5v1MrKQFTaEssXb8CtvXOQ8ixeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02

Implement device unload control net API required for CN98
devices and add support in driver for the same.

Shinas Rasheed (2):
  octeon_ep: implement device unload control net API
  octeon_ep: support OCTEON CN98 devices

 .../ethernet/marvell/octeon_ep.rst            |  1 +
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 24 +++++++++++++++----
 .../marvell/octeon_ep/octep_ctrl_net.c        | 16 ++++++++++++-
 .../marvell/octeon_ep/octep_ctrl_net.h        | 11 +++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c   |  4 ++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  4 ++++
 7 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.25.1


