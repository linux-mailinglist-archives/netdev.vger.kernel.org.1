Return-Path: <netdev+bounces-274885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD4PHEVTz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79EC391285
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD8930530C6
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274DF356A24;
	Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaWOLbYw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD730C632
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194837; cv=none; b=HeIU9A6fDLr4Z4LboZih0msnIfjWc+RqV4BOoWzw65uA/713UAZEVNGzWkgiGClpFkTuVKTYDb7QB/oKFIxZ4i+x3n9GvQ3Ig+6DYlHskxndHg4ZCKH/S10NqPFyoHgpqSGlROoUlsi3nnd8whu4dDl6FIZVqptAwmQDwX74xtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194837; c=relaxed/simple;
	bh=5i52DSlag8ooB9dvEM2JShL1gCTUtifV13OheZYkeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z34ZpxaYIEMehLHxUtlz/oeCAqagMdbvZEe7tWtoxruwwwVtFkJlAFMcYETP5mZr2E7gmDXDRhxuPd/r0FizYjAxAtnVnOmf6k+w41HyKDGqS5ZtISA5cQTpTvSFCIroT0sbfMKhEvlickCvI+pG354IsXta3cs49jlvwG1Iez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaWOLbYw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194836; x=1806730836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5i52DSlag8ooB9dvEM2JShL1gCTUtifV13OheZYkeQY=;
  b=NaWOLbYw1KFWAgXi68e3zSQnxIuaaIEH0h4KTzHZ6n7UWuHvHCfCKZg9
   1dgEVVYmmZvXFigqUsm3igVlBFN2hrWp8Bz7RjE9SOrqGvDKJEZZv07yl
   Svf8MihR+MYkNf0SuMw/DP6lqVkcBJMIFps82beTj3hxcGgA0bZqJY4GV
   olusQzAMoLSktcXAz3ouaZU2eziQbgX/9E56HUFOwEIeKgNGvq9Bncko9
   enmJVcpHIEXxI7OBMm2I7UHV5AuCK3FJo8GAzN4VUZ6Qg0EjxCU8+nFWz
   8Skv3WrVHO3F7UF0jdcmq8wFblDl6MyXUx/w+/pu56xBlUr20vkjzl2Dv
   w==;
X-CSE-ConnectionGUID: s0bh9PwxTDGALcw58ka1BA==
X-CSE-MsgGUID: Y0qRuuR1RdyJicTt9R0CMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981744"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:36 -0700
X-CSE-ConnectionGUID: XGEOCKz+TqCNZh4w12tywg==
X-CSE-MsgGUID: bxWItmfeRa+BDBmhC4o+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904920"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH iwl-net 3/10] ice: disallow service task to run while driver is unloading
Date: Fri,  3 Apr 2026 07:40:21 +0200
Message-ID: <20260403054029.3789616-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274885-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E79EC391285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dave Ertman <david.m.ertman@intel.com>

When the driver has entered the unload path (specifically ice_remove())
the service task should not be running. If a tick of the service task
has already been scheduled, it needs to be intercepted.

Add a check in the service task for the ICE_SHUTTING_DOWN bit.

Fixes: 9162a897d234 ("ice: stop DCBNL requests during driver unload")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b5adb13..60b2558 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3056,6 +3056,7 @@ static void ice_service_task(struct work_struct *work)
 	/* bail if a reset/recovery cycle is pending or rebuild failed */
 	if (ice_is_reset_in_progress(pf->state) ||
 	    test_bit(ICE_SUSPENDED, pf->state) ||
+	    test_bit(ICE_SHUTTING_DOWN, pf->state) ||
 	    test_bit(ICE_NEEDS_RESTART, pf->state)) {
 		ice_service_task_complete(pf);
 		return;
-- 
2.52.0

