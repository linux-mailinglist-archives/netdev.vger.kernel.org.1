Return-Path: <netdev+bounces-257645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P18OsQqhmnMKAQAu9opvQ
	(envelope-from <netdev+bounces-257645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:54:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512710182D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F374C30934B2
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3704266A5;
	Fri,  6 Feb 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pwsu2x8u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C5428466
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400161; cv=none; b=U0BHdwO7kJHbh61ppoSUyan2L0YjM/nI4f9Ue7uo+3GK8UUn9tOPZIdBoEEOzwGjpRqraJjVWA+HVRrvFBfj1HitUMy7kakjt8jTDxp/oaKJj0YqrEjjupGAVqSUdgdpS+k6sun0wq1f1Dfes1d8KEIII7Eggpon1/HZihAH6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400161; c=relaxed/simple;
	bh=ytepuY22OlVNr54CCrS/0+EiaVWmLBEpbKURMQi7258=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzK49TA8aS4A4MMOjd9hh+q+DjDvC3E/qpI6hqVfHkdFxhqvci7f/8ZBwXLtPNWbJSTJ+LpiDe+BWHK89NfvageRlHRvasw95CSPxz5PnubJCcUDHeeNrZ2tnkRMH5kT2juCRCNRUDUuqb7CLlZtS5owVym1L97X8rsfjLNhGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pwsu2x8u; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770400162; x=1801936162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytepuY22OlVNr54CCrS/0+EiaVWmLBEpbKURMQi7258=;
  b=Pwsu2x8uX8v4iE3sWyYAQZO0C7e2l4V9qwWh22l8BcdTjeGmkPlYiTOx
   PYsD6E0ldzaX6y3RFJuhM3aRp2IRT2rzmjD/H+z3Ay9Bt89TZ8rCvb5Tj
   XXFpE3Tzfe3PgvU8AjLXc15ZJCRSsgmFTNjy8CtKz2X03VMsTJHdpAhEL
   gGjf6kwsJEy5/0N6NYt1jOlqdG+tfifeJXOAk4cpjPmIVz2Pe6l19P4Al
   JHZoWT4LREV6kWwAumImW5xV4LFgaRwVVtRgElRqaEvVRtKCRDf7h/qIf
   eq8wVIMC+94QRXnDP8ijPUEiI1pe9VWEByeSkKne7aJ4SHyUJg6dE0cwN
   w==;
X-CSE-ConnectionGUID: i1Vinpa3RpSNCqjCig7DfA==
X-CSE-MsgGUID: IFYFRgt6TEuo0/OfFb+mPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71793158"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71793158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:49:21 -0800
X-CSE-ConnectionGUID: C7eiPcfhREaK/ur+DOSicw==
X-CSE-MsgGUID: 0VN1sXAPS+CPw5XMy0GNRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215495420"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 09:49:20 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 8/9] i40e: Add missing header
Date: Fri,  6 Feb 2026 09:49:05 -0800
Message-ID: <20260206174910.4066255-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
References: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257645-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5512710182D
X-Rspamd-Action: no action

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 480e3a883cc7..967711405919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include <linux/wordpart.h>
+
 #include "i40e_alloc.h"
 #include "i40e_io.h"
 #include "i40e_register.h"
-- 
2.47.1


