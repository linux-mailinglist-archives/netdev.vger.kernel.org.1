Return-Path: <netdev+bounces-123625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DD965D13
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20201F21311
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D808172BD0;
	Fri, 30 Aug 2024 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBD16D4CB;
	Fri, 30 Aug 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010638; cv=none; b=HGzMQAZ2v40xlvd+GT+jG9R2WqfgCOabrC0Pt865MstobQaXnKVRlaEawo86gS/JnHjJk4rfXzY8hEvQWgus9FvZcd7PbcC7rD8lwPUerFs8l/X7eEjQLYwei4c8SLwdmXzPVVFft6l/gAKwSRsT1xn6wyPkRhrS72/0KrhomcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010638; c=relaxed/simple;
	bh=JBRetFRoHlBnteFis9LBMUSr1ZJS3FTbovyfvlWYLtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irWfJnddQoWHh5jGZ8q7mCvFCxJX4C2ur76DbOk3ZlOQjRqmHCr9aEFpSSGlKkEhvzpc27psq81q3WeX+jTrQdbccmlD55pPip5lbFRFh513L3WS+R7cYwcB71ZeidvwM0HhVC4x0EAXkGphTCvhgWK2tw4imCUo599QTcaAKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwChP3sGhzyQtF;
	Fri, 30 Aug 2024 17:36:21 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 90B67140360;
	Fri, 30 Aug 2024 17:37:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 17:37:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 0/3] cleanup chelsio driver declarations
Date: Fri, 30 Aug 2024 17:33:35 +0800
Message-ID: <20240830093338.3742315-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

v2: correct patch 3 commit citation

Yue Haibing (3):
  cxgb3: Remove unused declarations
  cxgb4: Remove unused declarations
  cxgb: Remove unused declarations

 drivers/net/ethernet/chelsio/cxgb/common.h      | 2 --
 drivers/net/ethernet/chelsio/cxgb/tp.h          | 2 --
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h | 2 --
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      | 5 -----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h  | 1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h  | 1 -
 6 files changed, 13 deletions(-)

-- 
2.34.1


