Return-Path: <netdev+bounces-241690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F666C875AE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96063AD692
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2833C194;
	Tue, 25 Nov 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKt1U039"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192D33AD82
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110208; cv=none; b=SRo3nYF1ZsxUMjtJT3gqC/Nh6nXXyfrKBaRuR49JRDCwa/575VzMqWiNjATQDHGXG0omR4rSW0+qXkJdcJ5h7Lr9OEgHWQuI2dOY6xvwznEWtfKrzgaMI/nitlo8eU9UtgBE0c8KQHlHk5otIZhkrylBFr72wnMQdDw8FahRtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110208; c=relaxed/simple;
	bh=A3VJx/0A5iYoFbRM/b8yDhSwH2Q2XuEUmD1x6G24g7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvjwUfbA8HXS1FK94A+pO5EFxAOG2el3LRexEd+bXu9FobSa4D33/GkFL4zy9sbSI2i2ayKXfeavMqllyBJH3+QxRAGsOMap6P5tWzlwjkbFQ5Eaqpwuaxx5BLe4tdhMG++B9QiRmuStKEMTB4j6LDZkY0mYhpPtMi4NmFQxLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKt1U039; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110206; x=1795646206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3VJx/0A5iYoFbRM/b8yDhSwH2Q2XuEUmD1x6G24g7I=;
  b=bKt1U039brL6dGvolklL/ChTwyEMsSF3ht3IE038P0AiVYMI83xr+e/0
   ppQCQkqQeFO7jwvo6I2U2Biq6OZUsbE5RkrmoXr0PK7+kinambD75niTZ
   QJGINEGo/pU4Ky1NgD3FKu1vHdGugLPVIOFyVO+dk8mnb/955MPkPzfBN
   ekvAKxUgxW/+oF7yBRvWDkXh4v5EQ3xxvqjVnNzj1IsL8SkvedMkdBwrp
   5EGpy4psxyFUUwyTGjWv1HMRfoux9ZPMULjzs07aMpWJqCBkTQKPF1een
   dEIknM0IUSA+Nfvtgz0o8FLzWSR99kCpgq/lXBd9LlBvAs4o3zD2DMuQ2
   w==;
X-CSE-ConnectionGUID: qBSvA8WWR0aQ/lOtkaHACg==
X-CSE-MsgGUID: ULLmG88wSFmLha1KKoDBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729933"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729933"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:43 -0800
X-CSE-ConnectionGUID: w6rvQ6bgRV2FQ2shx4EQzA==
X-CSE-MsgGUID: +YE/30XKRvqzuRoN0JbR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209578"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	alok.a.tiwarilinux@gmail.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 11/11] iavf: clarify VLAN add/delete log messages and lower log level
Date: Tue, 25 Nov 2025 14:36:30 -0800
Message-ID: <20251125223632.1857532-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

The current dev_warn messages for too many VLAN changes are confusing
and one place incorrectly references "add" instead of "delete" VLANs
due to copy-paste errors.

- Use dev_info instead of dev_warn to lower the log level.
- Rephrase the message to: "virtchnl: Too many VLAN [add|delete]
  ([v1|v2]) requests; splitting into multiple messages to PF\n".

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 34a422a4a29c..88156082a41d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -793,7 +793,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN add (v1) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -838,7 +839,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN add (v2) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
@@ -941,7 +943,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN delete (v1) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -987,7 +990,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN delete (v2) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
-- 
2.47.1


