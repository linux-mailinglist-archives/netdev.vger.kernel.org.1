Return-Path: <netdev+bounces-290305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C0NBivJDmoACQYAu9opvQ
	(envelope-from <netdev+bounces-290305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:58:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCCB5A1AA8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A6FF30252B2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02951357D05;
	Thu, 21 May 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEDK9bog"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCE363C6C
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353841; cv=none; b=MtCQbXoo47C4qyyOftQUNiNa53Nr762NEAMJn0NE8bYbJM+8E+QjrYvBCW68iEgrDRbahLQDo8doxbkZGXhc8oamJJFMNkE2OCQXczeVD62Q5BeY3MzxcxoyuZKH5B6NP0Pjw0ogZ8obnsigq8cU7F74MlezL4/Yl5L5yuOBCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353841; c=relaxed/simple;
	bh=FTqWKc6Gxc/0tUOdH3YpvJvhqjzqY8tSDA5ezTotmKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6aHjFk1BwVR/em/cwoy9jLbBORLSA0od1AZHg1Ot2ku3FDG3rRnfMdjcPOiXKmn7wGhbhLqiX+CUOZfcyEscHRTWIzyML60MrJ8pQ/bK7oeqBWxv6lDaMSNf623bHP/dVifqA4svxS1jOoWOM+NhlhekYaGoftUXIZd01aHmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEDK9bog; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779353840; x=1810889840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FTqWKc6Gxc/0tUOdH3YpvJvhqjzqY8tSDA5ezTotmKQ=;
  b=CEDK9bogNcVTkMLyM2NLPSfof+egLI4oYx5Kh5Ml56afXk34IBFx+4U8
   jLOqv84s5FI4FusgDpGsm1PJ6jSjm1/3ZvyIcjhqft+DCy2DFsL6Mp+TF
   JqtI5vD2XM2hw8jr0n4n9sY3Jws4eklK1u9t7tllD59w4J3MjzmcioAeH
   Yki085MUmh9bOuWRUxDtFo8SjxUlfvbosT5+HonZTS4SwOAw/jn7zgCkP
   iN6u2Qz+Y5qncbqowyEIxflDWf3GMYt0I3+fs4t3dhff3pjxX8IdZ76TY
   D3aZCOu8eTyKWnfhTNsLk6tZ2OAzc4HF1x8cdAZR1jTDl2ky/HrhZELm0
   A==;
X-CSE-ConnectionGUID: JdVZPGMmQi2EzYBkgOlOrw==
X-CSE-MsgGUID: VWvgvKV4ScOVAnCuvdy+Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79417398"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="79417398"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:57:19 -0700
X-CSE-ConnectionGUID: zqTZeTNFRuKIBhBReAoWCQ==
X-CSE-MsgGUID: dA12pg/lTl+xYJkuGC/hzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="245506392"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2026 01:57:17 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: e1000-patches@eclists.intel.com
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	konstantin.ilichev@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] idpf: add padding to PTP virtchnl structures
Date: Thu, 21 May 2026 10:54:06 +0200
Message-ID: <20260521085428.117991-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.5
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290305-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: ADCCB5A1AA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add padding to virtchnl2 PTP structures to match the Control Plane
expected message sizes:
- virtchnl2_ptp_get_dev_clk_time: 8 -> 16 bytes
- virtchnl2_ptp_set_dev_clk_time: 8 -> 16 bytes
- virtchnl2_ptp_get_cross_time: 16 -> 24 bytes

Reproduction steps:
On ACC, run: ptp4l -i ACC_pf -m
Observe: failed to open /dev/ptp0: Permission denied

Fixes: bf27283ba594 ("virtchnl: add PTP virtchnl definitions")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 02ae447cc24a..ba953dd5fb67 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -1572,13 +1572,16 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_vport_tx_tstamp_latches);
  * struct virtchnl2_ptp_get_dev_clk_time - Associated with message
  *					   VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME.
  * @dev_time_ns: Device clock time value in nanoseconds
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to receive the time from the main timer.
  */
 struct virtchnl2_ptp_get_dev_clk_time {
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_dev_clk_time);
 
 /**
  * struct virtchnl2_ptp_get_cross_time: Associated with message
@@ -1586,26 +1589,32 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
  * @sys_time_ns: System counter value expressed in nanoseconds, read
  *		 synchronously with device time
  * @dev_time_ns: Device clock time value expressed in nanoseconds
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to receive the cross time.
  */
 struct virtchnl2_ptp_get_cross_time {
 	__le64 sys_time_ns;
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_cross_time);
+
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_get_cross_time);
 
 /**
  * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
  *					  VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME.
  * @dev_time_ns: Device time value expressed in nanoseconds to set
+ * @pad: Padding for future extensions
  *
  * PF/VF sends this message to set the time of the main timer.
  */
 struct virtchnl2_ptp_set_dev_clk_time {
 	__le64 dev_time_ns;
+	u8 pad[8];
 };
-VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_set_dev_clk_time);
+
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_set_dev_clk_time);
 
 /**
  * struct virtchnl2_ptp_adj_dev_clk_fine: Associated with message

base-commit: 4548d565aa80aad80274e2f3bff4d7cd914c703e
-- 
2.43.5


