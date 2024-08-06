Return-Path: <netdev+bounces-116086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE41949088
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5001C23549
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B51D2F64;
	Tue,  6 Aug 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byjG6dwI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACF1D2F54;
	Tue,  6 Aug 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950004; cv=none; b=n0L8ALHJ3ZK6Rzmb2asksGQuGweO+ZWKSRqxbYg/+rvrCXrAIECjzUwy72trpokeJBYTeCHlrHaorihsYrHtWO9wd6gz8ysYXROm9/1hKVaqDAi8vlMHHsp8uLpZ3DgGadyMhYUV9dOQxLuy2egCIV6vJuugA4lZnjaFNUlFOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950004; c=relaxed/simple;
	bh=Ea6dfARgeRod6WyIOKsyRDBZrgbxzdAn+2JMu0mRaz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X02Z1s4VHay++eHYjdo/2cz/hESBt/ozpSgSZnJ+TGsP+80+yBpzDnr9fSitgI5qmcTK6T8cTQDDvmlARKUy7U8sUqgIZndN5F8A80AX/jyC1wWnw2TSt60ulWKbNRu9VDp9UT+I4QkKbc9M6Qpi/QupB5wc8+tp5Xs/oGqNaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byjG6dwI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722950003; x=1754486003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ea6dfARgeRod6WyIOKsyRDBZrgbxzdAn+2JMu0mRaz8=;
  b=byjG6dwI8fv5JEWnIQwHo8mQ/cB/H8F+HSYPukqeZZawCZW+VsmeiAhk
   lv3HisGsYI8UpS2g3fAWxpAGFYRTS08Zne9hjwwrmOt9yGPu7vbugyDfn
   Q5ZJLA1on+MUBo4KtjAu2cByDZW0pwDDDCJ28z0ftMx4PjVdjInH/V6U5
   kYEm6uxHp/nEapmuHpGOPyiKB06JHbs4XPqWYGA4RgMcFtgcEcKg6LgUp
   t44oMyLLz/MIhWlwp8N7TiQMo1FjA1ChoQd/oy5E3VUouubYppXeUuoav
   uLff+FIn8Qw0ndg+vZkZc44Z1K/GzH+REZ0ebbFRJekMseb6DlEdJEVlk
   Q==;
X-CSE-ConnectionGUID: jkJXdafGR9aZw3DQZbTeYw==
X-CSE-MsgGUID: Y7H21os1ROeICHZoisXe2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20842117"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20842117"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:13:23 -0700
X-CSE-ConnectionGUID: xG9Oux22T3usMNGx8VYx3g==
X-CSE-MsgGUID: rwwRdc0URd6tARQb2RKy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56475812"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 06:13:20 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 5/9] netdevice: add netdev_tx_reset_subqueue() shorthand
Date: Tue,  6 Aug 2024 15:12:36 +0200
Message-ID: <20240806131240.800259-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131240.800259-1-aleksander.lobakin@intel.com>
References: <20240806131240.800259-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a shorthand similar to other net*_subqueue() helpers for resetting
the queue by its index w/o obtaining &netdev_tx_queue beforehand
manually.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6e0b3ca5914..573226033d34 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3562,6 +3562,17 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 #endif
 }
 
+/**
+ * netdev_tx_reset_subqueue - reset the BQL stats and state of a netdev queue
+ * @dev: network device
+ * @qid: stack index of the queue to reset
+ */
+static inline void netdev_tx_reset_subqueue(const struct net_device *dev,
+					    u32 qid)
+{
+	netdev_tx_reset_queue(netdev_get_tx_queue(dev, qid));
+}
+
 /**
  * 	netdev_reset_queue - reset the packets and bytes count of a network device
  * 	@dev_queue: network device
@@ -3571,7 +3582,7 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
  */
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-	netdev_tx_reset_queue(netdev_get_tx_queue(dev_queue, 0));
+	netdev_tx_reset_subqueue(dev_queue, 0);
 }
 
 /**
-- 
2.45.2


