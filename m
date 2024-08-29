Return-Path: <netdev+bounces-123259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88540964532
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF3F1C24C12
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91FB1B3F19;
	Thu, 29 Aug 2024 12:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20B1B3B39;
	Thu, 29 Aug 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935353; cv=none; b=oZsC777cJ2vaRsbw7wR2bXELbjNOjd/Agv4mUzR1TWuu6LnD+1lN7KrB8qj2JTXPizyiLWtSNBzj+cXQ/HaLCOhUBPeBU1NGdkW6uElPDKw1mwyqnl78+d+hAmHrD8UYa1nEA5a8rflsKQZcy1/6Slsrdc0sfhvVu2TQP4MCPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935353; c=relaxed/simple;
	bh=Z981t5JZQAzEO9cQP3qxerhjjxc0kbCIKLu90mkxdQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FHERnK1doKF5AqIb2mhIV9CMn/kVvh84rEWkOc8u7pg74tTEtgSzXP5J2gEge+9OMOTkbLVAsQR5HrvDGSoRz259YHSygIxdAd9Qq9bOiwpkgIu3Jd9TcYGFAoAICj97ayyQnivVTUO6Zw43YwuAhhIPPQqqdJ7lgbWB1rrNSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvgqD1lf4zLqsc;
	Thu, 29 Aug 2024 20:40:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A5A5D18007C;
	Thu, 29 Aug 2024 20:42:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 20:42:28 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/3] cleanup chelsio driver declarations
Date: Thu, 29 Aug 2024 20:37:04 +0800
Message-ID: <20240829123707.2276148-1-yuehaibing@huawei.com>
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


