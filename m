Return-Path: <netdev+bounces-118043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0999505FE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6EE1F23C12
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D819B5BB;
	Tue, 13 Aug 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0p3j5Y+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A619AD7B
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554500; cv=none; b=rnubE9mkiFy4rY/l6UqXh5pLRs0/XxMSD6jCknf96c7oXgYP2tKtcSOVt4RGanr8jrReZsZHJ3nUKw8QSHYj62coFQbXKUoXf0RLrQJ7OEJTw+xVaYrmjoeCYEXaRJDw7GH/bdDakomcXTbicOuzQy1VAg7IjAGNDw4zOtYBDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554500; c=relaxed/simple;
	bh=vYOq0X3vriL6Y3+5Ik1amyHftkdSD9vqOjjhXqp7dFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6KMnMPG6HZzayo+rCunV1A1eWZCJZD6fxAczI+018XSN1AkaHuPpQxvSjPgtM9/JTfHZlHMdOOCsJJXQswsRnYXrnGK2ndzM8ED1gqjZR5Jt3gcNhq7LXcL0edSZaZ/xAk8esQ+LI6oBVzZV1Ie1zxSE9gO7OURHVZgbjrlZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0p3j5Y+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554499; x=1755090499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vYOq0X3vriL6Y3+5Ik1amyHftkdSD9vqOjjhXqp7dFw=;
  b=A0p3j5Y+WYbCkk8a+raXjOu1oo/Bp1VVN24vyXjbZIt5v7xbqs6YJhdP
   8MT6wPs5jZmANRp5G9fuLWzeNgBsXmp23+I6+Frab9V5uq+O9TZ/fspGI
   FVk2IslmsfvPh/XBZk2XQHWQzI+RB56Z5WoQ1ZPIANgMHGTMyRG0CI2iX
   y/DFcGs9HrfSkic9iB1+cscst7qS1kDAiLgySpMzvV33CTY0PDwjH1c3/
   mMvzKDAjTpD+TPXyZeoxcHfr69t24BCwtDb/XbH1x8Kt6hlOEfdYLrD+y
   zLw7Lv8RP8zYrU1r5v6JDvDpoRK7Z1aqp1VGh15EnSzhUzz9f6HmktTTb
   w==;
X-CSE-ConnectionGUID: Oh9e5Hg6TN2ahmFsL7wf+w==
X-CSE-MsgGUID: sV7oVMJmSNutUk9imSqNeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32290933"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32290933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:08:15 -0700
X-CSE-ConnectionGUID: jJ6iu9epQoKNuYvL45fKsw==
X-CSE-MsgGUID: Zm5SjNR6QmakxqIhipe/GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59417149"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 06:08:13 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 403F332C8B;
	Tue, 13 Aug 2024 14:08:11 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v9 08/14] iavf: periodically cache PHC time
Date: Tue, 13 Aug 2024 08:55:07 -0400
Message-Id: <20240813125513.8212-9-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
References: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The Rx timestamps reported by hardware may only have 32 bits of storage
for nanosecond time. These timestamps cannot be directly reported to the
Linux stack, as it expects 64bits of time.

To handle this, the timestamps must be extended using an algorithm that
calculates the corrected 64bit timestamp by comparison between the PHC
time and the timestamp. This algorithm requires the PHC time to be
captured within ~2 seconds of when the timestamp was captured.

Instead of trying to read the PHC time in the Rx hotpath, the algorithm
relies on a cached value that is periodically updated.

Keep this cached time up to date by using the PTP .do_aux_work kthread
function.

The iavf_ptp_do_aux_work will reschedule itself about twice a second,
and will check whether or not the cached PTP time needs to be updated.
If so, it issues a VIRTCHNL_OP_1588_PTP_GET_TIME to request the time
from the PF. The jitter and latency involved with this command aren't
important, because the cached time just needs to be kept up to date
within about ~2 seconds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 52 ++++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index d709d381958f..956087ff273c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -153,6 +153,55 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+/**
+ * iavf_ptp_cache_phc_time - Cache PHC time for performing timestamp extension
+ * @adapter: private adapter structure
+ *
+ * Periodically cache the PHC time in order to allow for timestamp extension.
+ * This is required because the Tx and Rx timestamps only contain 32bits of
+ * nanoseconds. Timestamp extension allows calculating the corrected 64bit
+ * timestamp. This algorithm relies on the cached time being within ~1 second
+ * of the timestamp.
+ */
+static void iavf_ptp_cache_phc_time(struct iavf_adapter *adapter)
+{
+	if (time_is_before_jiffies(adapter->ptp.cached_phc_updated + HZ)) {
+		/* The response from virtchnl will store the time into
+		 * cached_phc_time.
+		 */
+		iavf_send_phc_read(adapter);
+	}
+}
+
+/**
+ * iavf_ptp_do_aux_work - Perform periodic work required for PTP support
+ * @info: PTP clock info structure
+ *
+ * Handler to take care of periodic work required for PTP operation. This
+ * includes the following tasks:
+ *
+ *   1) updating cached_phc_time
+ *
+ *      cached_phc_time is used by the Tx and Rx timestamp flows in order to
+ *      perform timestamp extension, by carefully comparing the timestamp
+ *      32bit nanosecond timestamps and determining the corrected 64bit
+ *      timestamp value to report to userspace. This algorithm only works if
+ *      the cached_phc_time is within ~1 second of the Tx or Rx timestamp
+ *      event. This task periodically reads the PHC time and stores it, to
+ *      ensure that timestamp extension operates correctly.
+ *
+ * Returns: time in jiffies until the periodic task should be re-scheduled.
+ */
+long iavf_ptp_do_aux_work(struct ptp_clock_info *info)
+{
+	struct iavf_adapter *adapter = clock_to_adapter(info);
+
+	iavf_ptp_cache_phc_time(adapter);
+
+	/* Check work about twice a second */
+	return msecs_to_jiffies(500);
+}
+
 /**
  * iavf_ptp_register_clock - Register a new PTP for userspace
  * @adapter: private adapter structure
@@ -172,6 +221,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 dev_driver_string(dev), dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
 	adapter->ptp.clock = ptp_clock_register(ptp_info, dev);
 	if (IS_ERR(adapter->ptp.clock)) {
@@ -211,6 +261,8 @@ void iavf_ptp_init(struct iavf_adapter *adapter)
 		return;
 	}
 
+	ptp_schedule_worker(adapter->ptp.clock, 0);
+
 	adapter->ptp.initialized = true;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 0bb4bddc1495..88f2a7bc4506 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -14,5 +14,6 @@ void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap);
 void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
+long iavf_ptp_do_aux_work(struct ptp_clock_info *ptp);
 
 #endif /* _IAVF_PTP_H_ */
-- 
2.38.1


