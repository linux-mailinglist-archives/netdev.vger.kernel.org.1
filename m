Return-Path: <netdev+bounces-247314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC5CF6E12
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 07:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99DB3029E8D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 06:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917372FFFB5;
	Tue,  6 Jan 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LUCDwfzl"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA62AD2C;
	Tue,  6 Jan 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767680410; cv=none; b=VjtiZ4cBnxnXyVxqCvWdeCqCVKmatUbEbb/DzcbWdQPL06qEWN4y0DViYVSJl1duOwbHRHxZOmpJCDExBiMOh0v/aj79ZwEek43ETri/j22R9/I58Rsru10Vl8LIuAQrEwXU2Bxo/KO/z/uwkq8VmSoVkSP8VHb3xdUQ4+hb7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767680410; c=relaxed/simple;
	bh=TLJKUg88Xmh39qZyN8sUQZ5Clvpo8tqYIQyYIOetJo8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bieHcHQM5yiBuZvI2Y4vcaSvJCspwfOY3s399zdV60r+f0lasEI+K60E+iq/uvOkBQg1rBNoqynT7Tg9vB9C8EVaZSqXXU+JD+6B3FvqBMzWJLBveNvfH/D+49Y1NWUxq2ZWYzBVa7xAZ/T/FSangrWxJh2illEUF8uJouW211U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LUCDwfzl; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767680399; bh=oWeQ2kJjEGjK3YYXF0wMYljSTvgST0B5Lrw1NuuCIhI=;
	h=From:To:Cc:Subject:Date;
	b=LUCDwfzlEF0iCImRcmtUELsHQUtSyaiNOVFRTqdrgKF0+vpzHlmnxEBirKVge0w4x
	 gw3CQp0UMGEy4JGbD2yMJGxy6E/3wNjOqfdNeUzikLcqyZIVyVYTzgWZC7MeKiY5cR
	 ueS60Cr6NJdNKOLKqfW0bYCrnjhh9o6fQ6EbqoTQ=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4F7A747B; Tue, 06 Jan 2026 14:19:55 +0800
X-QQ-mid: xmsmtpt1767680395txvn5w2w5
Message-ID: <tencent_B8B6D067EF7417B3B0D3DCC1A01505453F05@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0Cvri/+gbwmiEf1SPmZO+uovLwR+3auWS2LMDQ/JvJVZ+Fp2i9WJ
	 VFkeB+X9PJICG0pUtfJ1N3oN9jK9f1EcrkKcNaSxHdWONZ7ffI5JE7SGomS8XbAhA2fbI55ATAkb
	 +AduTmMh/if6V1CIr+BLjL2HQjBhIcqOkimAt6+OBg9r4/ajGFFCs0bLY1ip3KobaBUws7RWcL5Z
	 Hgm6rRZ1g5zcCKEp73Rqsj2ifISu139Ro5+0smzr7FiZoi31gawc10CxtmHAOyM6byGs6vrlgKOD
	 vCJu6IXoKDsvuJRkHN9KhqlX4WsXGUGpfbEnhcSLJb3RbL49lwPYvVICxa6h8k2ZOS892wNVT1Rw
	 sLg+Mj20QmxdPTu//FswU8NqPc2gNlbLtv17qRbVpd+ZIw70oLqJIVEIkgDR9xyzlfOvYMqyAKit
	 VOqpnfLqEenZ+gla1q1HpW7+m86xoiJWN6h+TjqV6Tt8RmKpFW5hMT5yuFVfAybbyIttNny9+6Ej
	 qutWVYvW2C3hH+DWHg05s4Gv2I0/jL4Zrmywq3Lt/k1dOQtTEfc2dYJnzOTTudG3TPEmBeanr3FI
	 4XyezwoEkeN1Lw5EYT2TqbOioWGUDF3sdWgowY13LMA92Nz+4oWqSKSCGHsbJVFVEeTQTxMw5j0a
	 1nxQBC5l777/ulllfTxDszpwhFcXPJu1c9f6XoIScc9rGzMUU15ICLNWK9OT7SgGE+QKXosC3dAM
	 Ljes1MYr9Y3ClC8130PznLWxYnapGH8Yi4a+9w1+Mv9zv7tIO6egB1se9c6/ftqBplBFzkIjy/h4
	 8pQjtIf9OK2DIQOj4jV8ao5a8gFNMMfQirM9GQrRw4oRe0h4mx6hNzqERNm1+srlR6vlGnP18IaF
	 oK752lzUfg7fxu+xGK4mEB1k5ovjoSRiQ6IDeED3IuQDLPnvMD32XDN09ew7OXKWVCvlZwbfISll
	 OxCofWXZV6bSwXZ1QlMYkfWGA3cS73Xy42O4aiVyzb/G8aZaFGjL4s6pqBh0oC+Tn6wQf3IhFSms
	 pRKihYxr/iJmhJJQOIo0IXGXs3W54=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: wujing <realwujing@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lance Yang <lance.yang@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@qq.com>
Subject: [PATCH v4 0/1] mm/page_alloc: auto-tune watermarks on atomic allocation failure
Date: Tue,  6 Jan 2026 14:19:49 +0800
X-OQ-MSGID: <20260106061950.1498914-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


wujing (1):
  mm/page_alloc: auto-tune watermarks on atomic allocation failure

 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 55 +++++++++++++++++++++++++++++++++++++++---
Hi Andrew, Vlastimil, Michal, and others,

This is v4 of the patch to introduce reactive auto-tuning for GFP_ATOMIC 
allocations. This version incorporates significant architectural 
refinements based on feedback from Michal Hocko and the community.

### Addressing Michal Hocko's Feedback (v3 -> v4):

1. "Reactive is too late":
   Michal correctly noted that boosting only after failure is 
   sub-optimal for non-sleepable contexts. 
   -> v4 introduces **Proactive Soft-Boosting**. When a GFP_ATOMIC request 
   enters the slowpath but has not yet failed, a lightweight boost is 
   triggered, replenishing reserves *before* exhaustion occurs.

2. "Use watermark_scale_factor instead of complex knobs":
   Michal suggested that scaling the reclaim aggressiveness is more 
   idiomatic than just boosting the watermarks.
   -> v4 implements **Hybrid Tuning**. We now introduce 
   `zone->watermark_scale_boost`. When pressure is detected, we not 
   only boost the base watermark (via boost_watermark) but also 
   temporarily increase the recovery aggressiveness (via scaling).

3. "Smooth transition":
   There were concerns about the "cliff-edge" effect of resetting tuning 
   parameters instantly.
   -> v4 implements **Gradual Decay** for the scale boost (-5 per 
   kswapd cycle), ensuring a stable fallback to the baseline.

### Core v4 Optimizations:

1. Per-Zone Debounce: Moved the 10s debounce timer to struct zone to 
   ensure independent pressure responses across NUMA nodes.

2. Scaled Boosting Intensity: Boost strength is now dynamically scaled 
   by ~0.1% of managed pages, ensuring TB-scale systems get a 
   meaningful response.

3. Precision Pathing: Both failure-path and proactive boosts now only 
   target the preferred zone (precision break) to prevent unnecessary 
   background reclaim overhead.

4. Strict Bitmask Verification: Tightened the tuning trigger to a 
   strict (gfp_mask & GFP_ATOMIC) == GFP_ATOMIC check to focus solely 
   on mission-critical allocations.

Testing in simulated burst environments shows that the combination of 
proactive boosting and hybird scaling provides a significantly 
more robust defense against packet drops than simple reactive boosting alone.

Special thanks to Vlastimil Babka, Andrew Morton, Matthew Wilcox, Lance Yang, 
and Michal Hocko for the foundational critiques that led to this design.

Thanks for the reviews!

---

wujing (1):
  mm/page_alloc: auto-tune watermarks on atomic allocation failure

 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 55 +++++++++++++++++++++++++++++++++++++++---
 mm/vmscan.c            | 10 ++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.39.5


