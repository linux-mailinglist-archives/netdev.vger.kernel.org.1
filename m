Return-Path: <netdev+bounces-272408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLYDH0MxxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:26:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04A3405F5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388CB30D01DD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34F3CD8A3;
	Fri, 27 Mar 2026 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5tkeRIv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1025EFBE
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596236; cv=none; b=orCpYweGixnAHclqYHEjws1QxJKuLejUKZoKKcl4SF7VjTDqB1PHrKgpKotdaskdowK0ao/MbbXzUFOYwF38+RcqLddd9dXG8vmhv4wQYqiFElFVtmrGWrECrQWH1fI7M3/OdxOT53k+KfJRRS9UZsAbi+g5dqNdNyexmZ82aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596236; c=relaxed/simple;
	bh=SkeueQB1As0bMn8ZudMMXCS+i2wWNrQl5dDeglS+N8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpkCnmi/oYqSsKGZKXqHP4Ce3d6Z50Ebd92lRYqiHfVdVDMZCb3krGrfSS50NRRrN+8tfq/MydrrGORiijpFsaEOXccun49/O8Xp7LjsBAjTT8x0GQAnirCqCdeuqFNQUnfUHcFVxFVSV2HjJNUUFIUDv+mePBaMZjeNbXRYSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5tkeRIv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596231; x=1806132231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkeueQB1As0bMn8ZudMMXCS+i2wWNrQl5dDeglS+N8g=;
  b=L5tkeRIv1yhahRCwn2EXoR3qD0+H/U5Tcm0HjikPyeZDis7epCzCER4k
   yfeVOhtLHhpPp0u9IHZrIKltBxDNtJbxUTMOx/5OSSwlX4AEZ1SkmGfcg
   JCy+VAKVe5rvy+QeWwGzNJDj5dg6Icw90Hiq3tgqBP4p0R/ifatZYc08S
   xA+AOgAcuFmonabS3bb0sEpKcKrzcNymbUbq2sGgSe3WHvgEWDXt0ESjW
   ZZlo2i+XdK9wV1cwnhzkzW3JeEgof90Oc1x1zKVAA6qAks5fwgITJEo+R
   FXzmJ2tp0cVLyMMlt5LDYT0j4xFcOWuVcgvZBH6tH6ZdXhPQ4Qf5oCxzz
   A==;
X-CSE-ConnectionGUID: tcv/ycyjR9qzTB/AFGi2Xg==
X-CSE-MsgGUID: X5xbvaZcTwmnha7TaXzH2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733985"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:48 -0700
X-CSE-ConnectionGUID: 3TZ/1urxTieR8aq8K8zFlA==
X-CSE-MsgGUID: rjKNCQ8+ThubfTMcLNb9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739124"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:47 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH net] ice: use READ_ONCE() to access cached PHC time
Date: Fri, 27 Mar 2026 08:23:32 +0100
Message-ID: <20260327072332.130320-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-272408-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0D04A3405F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ptp.cached_phc_time is a 64-bit value updated by a periodic work item
on one CPU and read locklessly on another.  On 32-bit or non-atomic
architectures this can result in a torn read.  Use READ_ONCE() to
enforce a single atomic load.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8b0530b..2ea4dbc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -350,7 +350,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 		return 0;
 	}
 
-	return ice_ptp_extend_32b_ts(pf->ptp.cached_phc_time,
+	return ice_ptp_extend_32b_ts(READ_ONCE(pf->ptp.cached_phc_time),
 				     (in_tstamp >> 8) & mask);
 }
 
-- 
2.52.0


