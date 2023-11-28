Return-Path: <netdev+bounces-51789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45507FC0A5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BBD1C20AF9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9C39AD4;
	Tue, 28 Nov 2023 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM1d/s3u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC793;
	Tue, 28 Nov 2023 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193986; x=1732729986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AVNjVyUanOhTTHDIFmk7Tc/GQGOGXheE7jl3n156kCE=;
  b=CM1d/s3uxXKFB5YXllQog69orGExDLLSjI5cQg01wr78IMhRct3uECKh
   y0SFfZIAbTIkV+s0yizVaLhHTIXqIImsq+tfxkWS5/Xm6HTpma3ydSSUO
   y2Dmddx4ZCWkJ2LH1nHI3S14zufTqLwwmpJk3y2KRWpfK/lI86JpJsk3b
   0CRQrh7oPOYSOvwhexxZKjDE0IvabCl83+J3X+1sD2nHzoSYvJBsWyI7v
   11en+yRKiBJAMZNaG1mJbkCTfmYxVaRdoE4JazwW3U96tZliTILLzFgAD
   t4WCmm9NTROqIMJdenmf0ad/gM7WFf6iCdwtvEhkG3+g/R21odeoFHaDH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373160118"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373160118"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942001260"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="942001260"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2023 09:48:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A98A823E; Tue, 28 Nov 2023 19:48:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of the copy of a definition
Date: Tue, 28 Nov 2023 19:48:13 +0200
Message-ID: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BYTES_PER_KBIT is defined in units.h, use that definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/sched/sch_cbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 9a0b85190a2c..beece8e82c23 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -57,6 +57,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/units.h>
+
 #include <net/netevent.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
@@ -65,8 +67,6 @@
 static LIST_HEAD(cbs_list);
 static DEFINE_SPINLOCK(cbs_list_lock);
 
-#define BYTES_PER_KBIT (1000LL / 8)
-
 struct cbs_sched_data {
 	bool offload;
 	int queue;
-- 
2.43.0.rc1.1.gbec44491f096


