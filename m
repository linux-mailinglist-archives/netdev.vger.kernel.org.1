Return-Path: <netdev+bounces-290652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC0EKzbGD2qJPgYAu9opvQ
	(envelope-from <netdev+bounces-290652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB705AE320
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC233028024
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471930FC39;
	Fri, 22 May 2026 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIClFodu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBEA30FF05
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418629; cv=none; b=Zju/gp0tcnSP9CtLy3D371wMn4QNwQVFergMtihrF6MH1lQnRRGuD1N9ifCIW5lV7jyPkLQDuMhqyvvjgk+x98M6bUF/8pVbM7FZ3XBWDcZxuQIpM3URExRcv92Yn7gBOCp5IG9Ja4XOMoQaemAioEmjfgh66alp6shNn2/07UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418629; c=relaxed/simple;
	bh=iDYVmdU7KPjlJnWt7RP1IYqONrzUpPJ7SuVhXGur0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBeXVlWbFQ7nMlbeo5zHtHnD18Xlg+mdY6tHHM2HXKA4n1wHXFLVlBqA/kfVQoHqA+U0wf+oPTBgNMQcu8ddM73rg+FVrRs0j957flxybLXFYpZMZhQxlM6a/Nr+ZMV0qz1v0f0NEBaM9P81P6Twc75XkgTcLX0+W9CiWy6Iipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIClFodu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779418626; x=1810954626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDYVmdU7KPjlJnWt7RP1IYqONrzUpPJ7SuVhXGur0Fc=;
  b=iIClFoduxmydMO541FqbOHmvXyIdrZuyM67c0YoEWlLnbG9Fq+jxTOwK
   iSkUF/0Em4tZ0Iqo+MU1xk9DF9vduj7sgTkbB8nMW2oDylymsBpqFWzUI
   YsbceHKUBHd3tAcNOtSJlun47RR0PwhwSP5sMu6hODuNItdIlEY+uFDZu
   tIFpUcW2MuU00C/aHeXtWhYL/HFZ4+6NuKrrqzA6BtHjAnQv0CvlhiRp5
   OJK/tu6aXzr7ewXGswevC9fWvq77OkgmKDMCpKQ2K3g8BMkPTsgRW9uic
   2d0e0MbC+mBfxe2Nbdr6YhZOGZAilh2mNMmQvUhK1ZA/X2mtd8IGiGVAW
   g==;
X-CSE-ConnectionGUID: Uz35LELpSv+2nqkZ153xIg==
X-CSE-MsgGUID: IgAzwe+bR1qkcxjJ3tQhww==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105811759"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105811759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:57:06 -0700
X-CSE-ConnectionGUID: gNwPiJRbTf6dGXSPDP1yNw==
X-CSE-MsgGUID: 57qkA9xFTf69hXJ8yPA3pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245035641"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 21 May 2026 19:57:06 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 1/2] iavf: log PF diagnostic message on cloud filter add failure
Date: Fri, 22 May 2026 04:57:01 +0200
Message-ID: <20260522025702.1764129-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
References: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290652-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BB705AE320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the PF rejects a cloud filter add request it may include a
diagnostic string in the virtchnl response. Use dev_info() to log it
so operators can diagnose offload failures without enabling verbose
tracing.

Use %.*s with an explicit length bound to avoid reading past the end of
the message buffer when the PF fills all 4096 bytes and leaves no NUL
terminator. Add the missing cloud_filter_list_lock around both the
VIRTCHNL_OP_ADD_CLOUD_FILTER and VIRTCHNL_OP_DEL_CLOUD_FILTER error
paths to close a pre-existing race against iavf_add_cloud_filter() and
iavf_del_cloud_filter(). Apply the same %.*s fix to the equivalent
VIRTCHNL_OP_ADD_FDIR_FILTER error path which carried the same bug.

Suggested-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4f2defd..146fc680 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2388,6 +2388,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		case VIRTCHNL_OP_ADD_CLOUD_FILTER: {
 			struct iavf_cloud_filter *cf, *cftmp;
 
+			spin_lock_bh(&adapter->cloud_filter_list_lock);
 			list_for_each_entry_safe(cf, cftmp,
 						 &adapter->cloud_filter_list,
 						 list) {
@@ -2398,16 +2399,23 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 							       v_retval));
 					iavf_print_cloud_filter(adapter,
 								&cf->f);
+					if (msglen)
+						dev_info(&adapter->pdev->dev,
+							 "%.*s\n",
+							 (int)msglen,
+							 (const char *)msg);
 					list_del(&cf->list);
 					kfree(cf);
 					adapter->num_cloud_filters--;
 				}
 			}
+			spin_unlock_bh(&adapter->cloud_filter_list_lock);
 			}
 			break;
 		case VIRTCHNL_OP_DEL_CLOUD_FILTER: {
 			struct iavf_cloud_filter *cf;
 
+			spin_lock_bh(&adapter->cloud_filter_list_lock);
 			list_for_each_entry(cf, &adapter->cloud_filter_list,
 					    list) {
 				if (cf->state == __IAVF_CF_DEL_PENDING) {
@@ -2419,6 +2427,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 								&cf->f);
 				}
 			}
+			spin_unlock_bh(&adapter->cloud_filter_list_lock);
 			}
 			break;
 		case VIRTCHNL_OP_ADD_FDIR_FILTER: {
@@ -2434,8 +2443,10 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 							       v_retval));
 					iavf_print_fdir_fltr(adapter, fdir);
 					if (msglen)
-						dev_err(&adapter->pdev->dev,
-							"%s\n", msg);
+						dev_info(&adapter->pdev->dev,
+							 "%.*s\n",
+							 (int)msglen,
+							 (const char *)msg);
 					list_del(&fdir->list);
 					iavf_dec_fdir_active_fltr(adapter, fdir);
 					kfree(fdir);
-- 
2.52.0


