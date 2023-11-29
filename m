Return-Path: <netdev+bounces-52009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A257FCE16
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A07D1C210AB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEB6FB2;
	Wed, 29 Nov 2023 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cf7pphZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0710E7;
	Tue, 28 Nov 2023 20:53:58 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3jmWc006444;
	Tue, 28 Nov 2023 20:53:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=opgqyZX6LMVrmkQX5DCOWm0LZevDwASGJmt2zGyiYfA=;
 b=cf7pphZ0DfoQv1234ijBTwjtKhRvMlsQd1cb0+TjAAdIE7re0SBi94+9sh4Glhj1EtwX
 vDf7mcXm2Yjfe+EWhJr3uiBJoyb4ZVX5Ap/0FZ94o6ERg67Ls19SIgm7jtjVRjjyrsWZ
 HoE1DJtLkpsjGAiI8w8Yosgo1J+zOe33k2+jDfonjRQoSNnuxnM9Z3rn5Pnzmprb4wek
 SPqg55Ju8FcmCljqkbwzLZjv9unWkZzNZVnV9eQJNEuhwmAO1rbEXVT71MODUZmg+Ott
 vvadVSjwvQhe5UqXybNHIH1tWg84okkr9SaSIeu/tKorwfiTKnFUVFObvgCRAsJrQD3S 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4dmdra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 20:53:53 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 20:53:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 20:53:51 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 85EE63F7043;
	Tue, 28 Nov 2023 20:53:50 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/2] support OCTEON CN98 devices
Date: Tue, 28 Nov 2023 20:53:46 -0800
Message-ID: <20231129045348.2538843-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: X_1OoNhzm7c87nwF5OHdvZsYAuJtKUFG
X-Proofpoint-ORIG-GUID: X_1OoNhzm7c87nwF5OHdvZsYAuJtKUFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_01,2023-11-27_01,2023-05-22_02

Implement device unload control net API required for CN98
devices and add support in driver for the same.

Changes:
V2:
  - Changed dev_info print to dev_dbg in device_remove API

V1: https://lore.kernel.org/all/20231127162135.2529363-1-srasheed@marvell.com/

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


