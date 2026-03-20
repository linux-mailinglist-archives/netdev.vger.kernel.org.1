Return-Path: <netdev+bounces-270081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Iw3EKfBvWmEBQMAu9opvQ
	(envelope-from <netdev+bounces-270081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D82472E1807
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9169D3034562
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB013D410E;
	Fri, 20 Mar 2026 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKIMs8hE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE83C1971;
	Fri, 20 Mar 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043554; cv=none; b=MO0jdWp+UKUmKbMh9lpafuSqfef/YBpDwZqxOD+D2K9AqbyqaFJACAHdTO7SC31t1of5XViFGzM8tht+b2yzEqQh50mJIfpEVx3JvMYXJvzr+aQTd5gO5gRN7X4aKSd2QtaKtNj6CgYN5N9/3gAOIxCiIqc7FYhCR9aWizZbM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043554; c=relaxed/simple;
	bh=M0I3ndahwkZr+MEHB3Vx2V5eheqtMdzjJq/PBnLXitg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LiqnBRqeAaxCnHGRWkdDBbdYvxXZSHdoKnqnjZWv111vpcBwBBQyPRYrxXmkn4L5fwKYdh9oepUmhjxcbD9TKXbVpupTaHam+ufcH0N5lGmGqUNCdpuLPZX2Mskmduc/B3odeEExvmkZACT6R9Bii5Ki/kKpHWU4PCAbHhWexOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKIMs8hE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774043554; x=1805579554;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M0I3ndahwkZr+MEHB3Vx2V5eheqtMdzjJq/PBnLXitg=;
  b=HKIMs8hE/YDibvRWi1Awf7l3nVzwp3vztiLxttkSdHZl5YszDZG39cUs
   2lNO5xoa7J8vNggry1n+nNAih/AI9wvZB1qml9fU3rWbbK4JfGG+XW+iA
   epOJIWzyQB/e/Sfmu+99MiE6SyvzL03HtMELm5U11DZC+LyOhCT8dnxHR
   VRl012guiArIpfe3TcQwQmJQZkO3cwOD7rsgNCrBKVhHWYFIuOl3kTpet
   buxv9o0I0rcnhUlBSUwdGfCHe22avj7BqzcoYnnczq4nVde9uH50+Fxk0
   aKn03pUYmTcHPpTz5ixm3xqCaMENmxsoKjWBw7RMg2C6XabA2SoDooKi9
   A==;
X-CSE-ConnectionGUID: 2r1qOfy8Rdim9M9/POffTQ==
X-CSE-MsgGUID: C4a502BxTn2preRM1fC1bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85763242"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="85763242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:52:33 -0700
X-CSE-ConnectionGUID: 0TejrzDcRTWTvEcgfq5FYw==
X-CSE-MsgGUID: ZQwWWatoR72xaPEdv0P4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="225293719"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2026 14:52:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 108A995; Fri, 20 Mar 2026 22:52:31 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 1/1] nfc: microread: Drop unused include
Date: Fri, 20 Mar 2026 22:52:29 +0100
Message-ID: <20260320215230.3236005-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270081-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: D82472E1807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver includes the legacy header <linux/gpio.h> but does
not use any symbols from it. Drop the inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/microread/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index 113b2e306e35..f00cff7f9693 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 
 #include <linux/nfc.h>
 #include <net/nfc/hci.h>
-- 
2.50.1


