Return-Path: <netdev+bounces-248487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A1D09A90
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 680943055180
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AC35B151;
	Fri,  9 Jan 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2k5IXV+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6B35B12E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961575; cv=none; b=IAQJNOGW1rKNVH9UM4Fal0doMU1raJsnOAtf+SlM0OpWe4umtL8y72OZi9nF2BypoWaGATYi9/fVkiSiJ++KpPniqjWA5HdZdD9Xus0bawZiNiKaJ7+1A+8SLRSkR2OrqGidEYbArMov4Sqa/bwXyHqDIvNjo0I5NLIrQqJkrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961575; c=relaxed/simple;
	bh=4x3rxTdPKMdDQfKbJXC39mIXbE5u9GGrZhMysH1lItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUvWgcjKDgzxzIjeGtO5kJeSCnyVfYzIfKy0c/JUQlFxCLZ/2f+OlbGyXCRPTmqD1Z9cbvLhqTO9pmchIHZo6XL77siTSiKYnd9IiGd3Gw0Ez2Znh76Z6kLZ3WI3z/+1NUNhLmkjmsoqnlPeIVCC3NKtem5TP+AnihdArfIBoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2k5IXV+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961574; x=1799497574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4x3rxTdPKMdDQfKbJXC39mIXbE5u9GGrZhMysH1lItA=;
  b=Y2k5IXV+NZ1LCLP14enaUVenlg0k17cjRkchmrmySS/YWH4DlETileZ+
   ve35OxEuLs4/uoxN0WcEficdMkLxy45t0qaES5Cyvz8yLPKn7uQ63f4nP
   zaulMcm6tJPPNwSruwzCBOP2Hb7qmdUsNVwZiU+59B5LETnq0UvJHPqR4
   Qr8h6F8x2MwLtRNWMI1yaHdRfH9zKcaaEfWoM+OxSzgB0l/zdBGQcGwgb
   kAeGM8LVvMneqX9oLQZ42n+8/AA5mJILe6I29eMd0TOFb7FMc3FAY6B1H
   U9ZNvTpAiuqc43yMDI4ySXERSX3Br17gozLCh8JzFCnrUtFHVDwo/XVGc
   A==;
X-CSE-ConnectionGUID: PKOhwMfARRWjyVdazylqEg==
X-CSE-MsgGUID: vVupCppXTM2KEC/lS2oITQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79981315"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79981315"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:11 -0800
X-CSE-ConnectionGUID: CeVquu6CRXC7fMAoEc1w4g==
X-CSE-MsgGUID: KgallUqPSiigNQQPUrgcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="208516492"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 09 Jan 2026 04:26:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E38279D; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Simon Horman <horms@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND net-next v2 3/5] net: ethtool: Add define for SPEED_80000
Date: Fri,  9 Jan 2026 13:26:04 +0100
Message-ID: <20260109122606.3586895-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB4 v2 link used in peer-to-peer networking is symmetric 80 Gbps so in
order to support reading this link speed, add it to ethtool.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/uapi/linux/ethtool.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..181243a2d700 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2190,6 +2190,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_40000		40000
 #define SPEED_50000		50000
 #define SPEED_56000		56000
+#define SPEED_80000		80000
 #define SPEED_100000		100000
 #define SPEED_200000		200000
 #define SPEED_400000		400000
-- 
2.50.1


