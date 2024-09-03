Return-Path: <netdev+bounces-124518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD1969D78
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E6028575E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB91C9875;
	Tue,  3 Sep 2024 12:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226391C985B
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366371; cv=none; b=HO2iArRFeeC2rayTx64wAUSY+TPKyJYRgDWmTJrNc1+8WWaWhUj2yyZX2Rb9zTpXJapwxbGA2FKESxjpBezS7Bdr7oqzQH8BeoYp8B/adBec8dmJQ/2qfjrDOw0CddHE3EB5O7ZLBwxrO8jX6iZKD6JdyWe9AZVuz+Dizlc6IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366371; c=relaxed/simple;
	bh=ZMSBscz5UWWYuVG1FbKUfk/NkbgSe7lpgcnG1IEthR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HuJMjDFKvs76NPojINckmTdqY6wbjgbxXGJB+Sl1pVwIOepIQbYPnKZDIepxkfE21T4W23qLjZaEiuBrjNe6HZ7AGCXVygv9z1PLjSd/55SfcXzH3gj+GNBBkUegjVODd90b0BVaJjS802pDxcHknvkFxpYlaWqCVbCA6P+Nz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wyl8j3jvfz20nRs;
	Tue,  3 Sep 2024 20:21:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 90E671A016C;
	Tue,  3 Sep 2024 20:26:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 20:26:04 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ahmed.zaki@intel.com>, <yuehaibing@huawei.com>, <richardcochran@gmail.com>,
	<michal.swiatkowski@linux.intel.com>, <amritha.nambiar@intel.com>,
	<mateusz.polchlopek@intel.com>, <jacob.e.keller@intel.com>,
	<maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/3] Cleanup intel driver declarations
Date: Tue, 3 Sep 2024 20:22:31 +0800
Message-ID: <20240903122234.964218-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)


Yue Haibing (3):
  iavf: Remove unused declarations
  igb: Cleanup unused declarations
  ice: Cleanup unused declarations

 drivers/net/ethernet/intel/iavf/iavf.h           | 10 ----------
 drivers/net/ethernet/intel/iavf/iavf_prototype.h |  3 ---
 drivers/net/ethernet/intel/ice/ice_eswitch.h     |  5 -----
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h   |  3 ---
 drivers/net/ethernet/intel/ice/ice_lib.h         |  2 --
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h      |  3 ---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h    |  1 -
 drivers/net/ethernet/intel/igb/e1000_mac.h       |  1 -
 drivers/net/ethernet/intel/igb/e1000_nvm.h       |  1 -
 9 files changed, 29 deletions(-)

-- 
2.34.1


