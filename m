Return-Path: <netdev+bounces-178782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0DA78E05
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB46F3AB0AC
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8323959E;
	Wed,  2 Apr 2025 12:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB323906A;
	Wed,  2 Apr 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596190; cv=none; b=DcbBaLSWQH8clNZ4lmKN7kntk1DWMr+cVsT+LtiLm8a9bANENfzd4RFo0CVWeuqF0wyZ0B2D45s9+W38jKcfm5xDimSoc7RH4hTBzbeOP5gYtOZ1t3ROAx6IY2aflARpfoSqCvajLpcVpacH/J1zHf2imXiTgUiI2ey61uiHORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596190; c=relaxed/simple;
	bh=fWgDe162ymGW0UVRpoazuwJcXWLWtrwI5CNZvgR4upU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qv7xYzAKFMjryshAJMK6d7l5F5gQN6usbXEH25AurM+XI8CrMlS/CLhNAQT1Y/Wa2FBor1KvwQdzwDR70du9gdFNjn1ApFBBN0gnfKpmG7wN/Qd8/1S3EmbPf3FZnL7xcbClJQzLm71iEVqI4m8PYKoC5H9I3CRH2QfJ/Cy7MMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZSP1c2w3xz1R7ZV;
	Wed,  2 Apr 2025 20:14:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D50161402A5;
	Wed,  2 Apr 2025 20:16:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:16:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Wed, 2 Apr 2025 20:09:58 +0800
Message-ID: <20250402121001.663431-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There are some bugfix for the HNS3 ethernet driver

Hao Lan (1):
  net: hns3: fix spelling mistake "reg_um" -> "reg_num"

Jian Shen (1):
  net: hns3: store rx VLAN tag offload state for VF

Yonglong Liu (1):
  net: hns3: fix a use of uninitialized variable problem

 .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 25 ++++++++++++-----
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  3 ++-
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 27 ++++++++++---------
 4 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.33.0


