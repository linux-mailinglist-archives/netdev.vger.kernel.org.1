Return-Path: <netdev+bounces-95983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C948C3F26
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3111F21EB9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5414C14F9F9;
	Mon, 13 May 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOY2yKWC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F214C58A;
	Mon, 13 May 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596742; cv=none; b=MLm4pitTS5IJMVp+YQec6xS6X8xzJpOgvtFN/S50Ns7v6S52NFXPowDQJNNuTkxpBFXG9pA+zErKNEGAvh3TNiJbdm0+9MPzstgIXaTZZGBEkMBoIlPgb0D+BXUQG4vgfWW6KChKFrzmDJiAReR1WbQq96EkiMtzRl6twPkq0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596742; c=relaxed/simple;
	bh=nsT1fHcZuDOMnnkyajwqgfQmhXr/KNG+7QbC/xy9bQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NU3ho0S6wOTzjC6KsNLLiUoOCxFPCx++EcWktom2+5Rkfe+JCxLmD0KA8LonNsrsN79cWM5ML5jio2A1EWVSWQzo47KfDmJFNdqXOV+4Ql6zwaCUh84ChQWst9HZVwbCry8AivD30QKqWTtSvpaa7bRoKJ9OsANd9pMBufOCtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOY2yKWC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596741; x=1747132741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsT1fHcZuDOMnnkyajwqgfQmhXr/KNG+7QbC/xy9bQU=;
  b=TOY2yKWC7zt3CJWHVAvS8K0tlXt2oo5ETMbWZyGC2Q1VKtJNLb/QVqHd
   PxNPATwwfDKqSUI0nS6R9MvyT4wwIyAZW+0W73xNzwRBmGBwf3DJuVdvF
   8Fz4UTbKsxcOU+VPDztipO4iPi/aEOO15r2biozSVUvI7z+Dif3iftyco
   TCjjyC9j3ckFXOfbDl0097BbyMAcR+fVNOC2uttziMjF199B8S8hT0t8C
   nfk1FFV76LPCV8fiU3foaNkoekwJ6PAgTr8qwiCrEkqDwLRIqEwT6hLUF
   E3KjGx77Hg7eHjLAUgY2KVs+a0YwolRmAbVP4k/mu4lXgaqdsKDsV1DKs
   g==;
X-CSE-ConnectionGUID: VRixzVImR0uro4A98GXwtA==
X-CSE-MsgGUID: 2SVzH7/kSv+pNZWOerwgbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29039050"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29039050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:38:59 -0700
X-CSE-ConnectionGUID: ope2bwsRT4iZirmy/ZYHcA==
X-CSE-MsgGUID: KgRrq/WQTWSQrAxXBtqbWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481740"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:53 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v8 06/12] ALSA: hda: remove convert_art_to_tsc()
Date: Mon, 13 May 2024 16:08:07 +0530
Message-Id: <20240513103813.5666-7-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The core code provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

All what is required is to store the ART clocksoure ID and the cycles
value in the provided system_counterval structure.

Replace the direct conversion via convert_art_to_tsc() by filling in the
required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 206306a0eb82..6f648fae7a7b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -463,7 +463,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


