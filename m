Return-Path: <netdev+bounces-132950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64397993D17
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 04:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E19D1C212B4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90F20326;
	Tue,  8 Oct 2024 02:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929991DFE8;
	Tue,  8 Oct 2024 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356124; cv=none; b=coqOiJQF8Uj467ztZpgj8R3fhbvRE1QNzVUK5wFEKcIn1O5WtYGZQESh+qKgZhRRFVv8rIN7VntyAUR1tt1h2a/duPLxYldhSfGXpLmvv7enZvjlO0I9ik/0Jat21u6USjdocxsefo5pz+3XRdoDF6cq5UeMO4svXZpUps/Vv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356124; c=relaxed/simple;
	bh=m3REQMajuojqU7D/8ydp9dE7FPZa3F7zPbfZ1xTBsUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nf5fykTXsOi1GWdIHjKQnl7Ma6sK1Kkn9kW43kKEMEQyIvIZvKptU4cNr+sYEkcRkD/pTHLaTKOEl1YoBywlAYxR5LmgAbhFI+r0c/B00wyTDcoyhneoYIzSJc71wRX9ygTqcNebRLTVkPmMup/KOAWtIH5QepSqhuADHsijaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XN0vM6DcxzpWdj;
	Tue,  8 Oct 2024 10:53:19 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E621A140415;
	Tue,  8 Oct 2024 10:55:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:55:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: hns3/hns: Update the maintainer for the HNS3/HNS ethernet driver
Date: Tue, 8 Oct 2024 10:48:36 +0800
Message-ID: <20241008024836.999848-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Yisen Zhuang has left the company in September.
Jian Shen will be responsible for maintaining the
hns3/hns driver's code in the future,
so add Jian Shen to the hns3/hns driver's matainer list.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..58380aeafbf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10267,7 +10267,7 @@ F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
-M:	Yisen Zhuang <yisen.zhuang@huawei.com>
+M:	Jian Shen <shenjian15@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
 M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
@@ -10276,7 +10276,7 @@ W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
-M:	Yisen Zhuang <yisen.zhuang@huawei.com>
+M:	Jian Shen <shenjian15@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.33.0


