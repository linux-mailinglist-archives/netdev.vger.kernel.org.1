Return-Path: <netdev+bounces-247001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C5CF36A0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A852309C3AD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79613346BA;
	Mon,  5 Jan 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JTz5j2Pn"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CA334681;
	Mon,  5 Jan 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614410; cv=none; b=GJaI9Vd6X7rrdCmXbhJMuotzpFmNZ2feIMT5Vd0VdjYCXUx2S3IaVGgse0EQrKmk2mbCuAQgnEG65G8aha/LiAo305lbCDKKvbEqIwbe9LlzhDkP6W/jEdDQAN9tSabRpY6j8cBb2uNuyX7a3afkYuPHUEYx05vufOo6oJp3zRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614410; c=relaxed/simple;
	bh=83e85h+P4XAdW21RDXPLl/BdUOaF6CIC+zqld7yeDV0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P6rem+YDBrIxUzKQT31yl/IDreObtywio0DX0kHnxHATcpjImEdtEGC1dNV/gNK8IaDJ/IFskPVLzWHuWOtvk/od7+nLJ4JvHrZEUxh3xMTY0orlEO7QH+i0uYfCqBj7TU4Rw5AeAwn8d5zExwzs1RFWpI5/yjuWk9r8tl1HmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JTz5j2Pn; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767614397; bh=HsQN+LjsQ7x+jgQekkX3zGf1yUPhzeVvR7BJTXKig0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTz5j2PnQn5GPlSchiputctKmGa+YRZ0bnXO1S+QmZIICH35QE4fe/DZOIxL7WWEB
	 NJ46VaXKky56914mMLw0SQplpL91XNXWyX16Q4s4CFFAoNbeCblHE8Cz5sAKf3bxYk
	 VNA7zLdRnH08RFRQ/SX8bNeqYtveCnBValyDUz4g=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id EF714E12; Mon, 05 Jan 2026 19:59:55 +0800
X-QQ-mid: xmsmtpt1767614395t10ab52fo
Message-ID: <tencent_44B556221480D8371FBC534ACCF3CE2C8707@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3ipsCvfcnKCvyjqv8ekmf+ebMWrVPiBuv6RLMOQg5RL/RofiVd/
	 Q/z8tsTMMuxCqfp1mNxK0B08WagzH9XhTgD1B9WV1hvlj+Lzg8foGl+qLGjy03r0jv+9XRU+5Ms5
	 /6OvCfvdsB8TRaFJPIO0yr+c0fhtyLqZf8Zxcb2EZCxUh0b6e+Af33TuzTx91bDYYOsVBHILtzLr
	 pYnVQtVz0WvJB9vd50Ty3jgyBD0PPzq2CxEljCGGB7Y4l+ZKjJ1U1JOY82W+BmkQfdagH3bWnOgs
	 NRhcJS1wlIAffD6EtP/UfmY4o/VMwXJxa4rPGv0GWkfgqKy9nT75xlpIwRi5dOpCUI8yAO3evEKw
	 +iYS2/F4Jcysrxif1i9rlSGRekiMlxJyt/lWbzwXz3kaWXBaMv0t42cpg3UrDAaeOUr1u7aCUuww
	 ZdhBXLMvkXPY4m2kvs4bwU5WB/bXo8GonwHb2dEwLQhqdLJ4NIbXdfTAqJFaomRMtT4IthprlGBj
	 qBpKnOZKWE8FKkd6CB32o1O3JQDVEZaeRfdyips3Sp4p/JKLx6ZQ+RV8Un67a1jFWdZfwicDD4+S
	 UbbprhBuUISqDbkEdcQNr+zCoTN9kBVLxKZfNqUIEQYQtvISq0iOY2U6PvJJZHnehrFF+fURZdkD
	 0kLRsIn2yzbK0RlNkJA1apzeP6B9dyYaUKvgm2ejyA2d/JsCsblIbXMyhVEGmDbkq0EqwuBX34ZX
	 oCKi2MD5fUgIzKL3dGbOxyn7qhAUElkZX4wkWeRcUhpyisyTwI55IWfAL7iHOUg1kiv71YWn2x4a
	 7j6XVxUJagzDVY98UYARJlJvfrVLX+6Xq2CN0EtiFg6r7ugWTUIt/Iq5kJnX8LrtLeJoSAtCo/PO
	 w1N9KS6nQZxF3WQypLCBHllfpIn1sTkJdLRdLUbzlk27P/qtZtgIvvQmLNhua0W3puXU/1+6waCt
	 U14GRXvhIwqjDzYcxI7CApZ/Lc3jVZvh/rzoydt7XRh7ew6zGgKdHiXUdoT146a6t2wqol3VID3Y
	 wzWqFRXTB88MyvZgXPmSLRxfUs5XWgmYSO5sr8Wf6vJMEQ2FBhBPAF6vYhktga2MoBo1pVi1I0zr
	 oihXCzGJqucmWVAGBsMb2A5qLzpg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: wujing <realwujing@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lance Yang <lance.yang@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	wujing <realwujing@qq.com>
Subject: [PATCH v3 1/1] mm/page_alloc: auto-tune watermarks on atomic allocation failure
Date: Mon,  5 Jan 2026 19:59:43 +0800
X-OQ-MSGID: <20260105115943.1361645-2-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260105115943.1361645-1-realwujing@qq.com>
References: <tencent_C5AD9528AAB1853E24A7DC98A19D700E3808@qq.com>
 <20260105115943.1361645-1-realwujing@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a mechanism to dynamically boost watermarks when critical
atomic allocations (GFP_ATOMIC, order-0) fail. This prevents recurring
network packet drops or other atomic failures by proactively triggering
kswapd to reclaim memory for future atomic requests.

The mechanism utilizes the existing watermark_boost infrastructure. When
an order-0 atomic allocation fails, watermarks are boosted in the
relevant zones, which encourages kswapd to reclaim pages more
aggressively. Boosting is debounced to once every 10 seconds to prevent
adjustment storms during burst traffic.

Testing has shown that this allows the system to recover quickly from
sudden spikes in network traffic that otherwise would cause persistent
allocation failures.

Observed failure logs:
[38535641.026406] node 0: slabs: 941, objs: 54656, free: 0
[38535641.037711] node 1: slabs: 349, objs: 22096, free: 272
[38535641.049025] node 1: slabs: 349, objs: 22096, free: 272
[38535642.795972] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535642.805017] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535642.816311] node 0: slabs: 854, objs: 42320, free: 0
[38535642.823066] node 1: slabs: 400, objs: 25360, free: 294
[38535643.070199] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535643.078861] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535643.089719] node 0: slabs: 841, objs: 41824, free: 0
[38535643.096513] node 1: slabs: 393, objs: 24480, free: 272
[38535643.484149] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535643.492831] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535643.503666] node 0: slabs: 898, objs: 43120, free: 159
[38535643.510140] node 1: slabs: 404, objs: 25424, free: 319
[38535644.699224] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535644.707911] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535644.718700] node 0: slabs: 1031, objs: 43328, free: 0
[38535644.725059] node 1: slabs: 339, objs: 17616, free: 317
[38535645.428345] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.436888] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535645.447664] node 0: slabs: 940, objs: 40864, free: 144
[38535645.454026] node 1: slabs: 322, objs: 19168, free: 383
[38535645.556122] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.564576] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535649.655523] warn_alloc: 59 callbacks suppressed
[38535649.655527] swapper/100: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
[38535649.671692] swapper/100 cpuset=/ mems_allowed=0-1

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 mm/page_alloc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7..a2959fee28d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3975,6 +3975,10 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	mem_cgroup_show_protected_memory(NULL);
 }
 
+/* Auto-tuning watermarks on atomic allocation failures */
+static unsigned long last_boost_jiffies = 0;
+#define BOOST_DEBOUNCE_MS 10000  /* 10 seconds debounce */
+
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -4947,6 +4951,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
+	/* Auto-tuning: boost watermarks if atomic allocation fails */
+	if ((gfp_mask & GFP_ATOMIC) && order == 0) {
+		unsigned long now = jiffies;
+
+		if (time_after(now, last_boost_jiffies + msecs_to_jiffies(BOOST_DEBOUNCE_MS))) {
+			struct zoneref *z;
+			struct zone *zone;
+
+			last_boost_jiffies = now;
+			for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
+				if (boost_watermark(zone))
+					wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+			}
+		}
+	}
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
-- 
2.39.5


