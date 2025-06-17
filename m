Return-Path: <netdev+bounces-198362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81761ADBE5D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFFC171EE9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F915B0EC;
	Tue, 17 Jun 2025 01:09:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4C2BF01B;
	Tue, 17 Jun 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122599; cv=none; b=A/MPbzRtBU2V0An2fBks+VRJc3CHzVznSzcO3PNXFJCtuNZC6slc77kOd1XGL76cqqwiMfKOgKvGPu2GBfInzHIDMbNik5DGnhGU+iRRGqGWBMSzcCw3iutASY9i2i4ZsB0Dt96bNcwsFbOOl42hc3mA9t4UtIh4yxW/3yDBvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122599; c=relaxed/simple;
	bh=AQhDa7n5uATpCYj9Iz8vGOiSb2YuSaeo8cQ//4swucE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nc0iC78kqh/xhePns41ukVERM1bvqvvhMFxoVL/gGgIE4hqS1DvEy3voMghDEyTEvEpqynHiwAS7fEM6zxDBv57NHUg6qqZmBiKvvvanDlx8+uoU7/IBK9962GTlTn9W8DbptoSnbnvgy9MXX3Legq7pBhVLBiG076zOzzntDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLpbD06Rtz2Cfdh;
	Tue, 17 Jun 2025 09:06:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C002714010D;
	Tue, 17 Jun 2025 09:09:53 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 09:09:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 0/8] There are some cleanup for hns3 driver
Date: Tue, 17 Jun 2025 09:02:47 +0800
Message-ID: <20250617010255.1183069-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some cleanup for hns3 driver

---
ChangeLog:
v1 -> v2:
  - Change commit message and title, suggested by Michal Swiatkowski.
  v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: set the freed pointers to NULL when lifetime is not end

Jijie Shao (4):
  net: hns3: fix spelling mistake "reg_um" -> "reg_num"
  net: hns3: use hns3_get_ae_dev() helper to reduce the unnecessary
    middle layer conversion
  net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle
    layer conversion
  net: hns3: add complete parentheses for some macros

Peiyang Wang (2):
  net: hns3: add \n at the end when print msg
  net: hns3: clear hns alarm: comparison of integer expressions of
    different signedness

Yonglong Liu (1):
  net: hns3: delete redundant address before the array

 .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 10 +--
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 38 +++++-----
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  4 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 75 ++++++++++---------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 15 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 38 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  8 +-
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 27 +++----
 13 files changed, 120 insertions(+), 110 deletions(-)

-- 
2.33.0


