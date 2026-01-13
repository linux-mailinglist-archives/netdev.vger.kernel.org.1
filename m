Return-Path: <netdev+bounces-249541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B0D1AC7C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91B53046560
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC330DD1E;
	Tue, 13 Jan 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cM0WICSy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AA30F811
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327290; cv=none; b=NXoYiYZqkLavtJD9HAcfuKxqqvghNYDBxG4bgZVoLWIl38CSyyrzLgeRXl46MhfJZNRuZpo/t4vi8QcBKaoRJLmp4EOtj3pSadiahCoPDw9/G5z5Xa+gjMVJuqhZCu+FzeQch1zRAadGjS/k+KJSSBtCTREQq5ONKz7TVtQgEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327290; c=relaxed/simple;
	bh=C7/h/yMHwzAFrC90V61WazgaAYBmCRbi7WqmJYLsack=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkCBmXoWb3dTo/cAZqFIEJvtvvSSntmJPqNXTFTS6VnFkd+UJNZQJds6dSngmOX20cDec0teFURY0KukISASE6sv6kjlFCgJd1yVtdi2Ogwms9pZumkXZJU5Fz9O9Yc9uhm0OsPgC+i1WZsTU6mWV5iwCyE39hUuKt7LJxBughI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cM0WICSy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768327289; x=1799863289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C7/h/yMHwzAFrC90V61WazgaAYBmCRbi7WqmJYLsack=;
  b=cM0WICSy4ZsNzQKdpOSemgCtBe/9eYFHHis6xPCoEnXEM2DtnSMswg2+
   vx/kF5Umxt9skYeT+3glnSh9V00CCLWd1mQgxkH7gB8RRrG7KY42oT+q2
   2x8ABpG4MJkzTFl63GlHaRVdQJKsGxvtyAXl0U+EYRNRxzVNrRyutDkC3
   49WOmUca5e5tQnb5lTjo89jiu9NRMajLXPVR1fK/dmRi8qk3jCcy+H10O
   NJ7RcnJQkFAAuIUJw4iRd2DDXw1XxLid8Yx0XBYHpOxKD8dJ3Q1ixErJJ
   OmVCDvqGw9a0Io2jPPodN1OnZemk7goFGSGf2UOR5h8o0+pq/ZwV2U55i
   g==;
X-CSE-ConnectionGUID: RlCYceiiQWyUtqv8J+jVWQ==
X-CSE-MsgGUID: 0VuSyLh8TQqsA8Ku3fVoKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69603401"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69603401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:01:28 -0800
X-CSE-ConnectionGUID: gzRybBr/RRKFjHdsBDp/9A==
X-CSE-MsgGUID: IxdieCaESjKbzSp+CSYvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204472276"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa007.jf.intel.com with ESMTP; 13 Jan 2026 10:01:28 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] idpf: Fix flow rule delete failure due to invalid validation
Date: Tue, 13 Jan 2026 12:01:13 -0600
Message-Id: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deleting a flow rule using "ethtool -N <dev> delete <location>",
idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
though ethtool doesn't populate this field for delete operations. The
uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
rule deletions. Remove the unnecessary sideband action enable check and
ring_cookie validation during delete operations since action validation
is not required when removing existing rules.

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 2efa3c08aba5..49cefb973f4d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -307,9 +307,6 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 	vport_config = vport->adapter->vport_config[np->vport_idx];
 	user_config = &vport_config->user_config;
 
-	if (!idpf_sideband_action_ena(vport, fsp))
-		return -EOPNOTSUPP;
-
 	rule = kzalloc(struct_size(rule, rule_info, 1), GFP_KERNEL);
 	if (!rule)
 		return -ENOMEM;
-- 
2.25.1


