Return-Path: <netdev+bounces-282007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDR9Guno8GlObAEAu9opvQ
	(envelope-from <netdev+bounces-282007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDA489942
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF00310C0FD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36833F394;
	Tue, 28 Apr 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TCwZ/QYR"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804333E358
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395534; cv=none; b=hkiWhaeNsnzJQX+wGLXeADtBL8hvc4kXVFQMPpbfInzeR46jhi05sOqQ5uZgtbcfwJFX9RHC2DIfXy1ac9rIyJayHfdz0cvfjQrLBSCCvnmDEUERkkbA/J66qYZuD3v+J2pkXmyH0Kaykt0cgt1HhUF4gM0B31yibcaGpmAZCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395534; c=relaxed/simple;
	bh=sEzQ4QQOtPfNW6FxEMLR1OcPnH9SNIe4D3ehgcpMfC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGkuwTRMOul17TcMX7DxdiN9BXDYdtBJEHjdyQdogaJzCmJlD9VkNShWE0Wb4Cw7v61lRf3hmcbxmlA7fzBA/qGvYGlrG3rkrIRdkFbTZmcTLG7hYaXpmYb2J1kVAnHKGRHxH54sAaQXrsP3WSG6s4pJMXhL7Rs6pDL9B3CUqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TCwZ/QYR; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395532; x=1808931532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+mDGcC9OzEklqG5fjS6d0nxWetShAcWkuMgTAeQDHo=;
  b=TCwZ/QYRoUdWWko6bRxhHEh1+/uh1gzeEd7E39Y5X5awIXvVBGS53kIV
   YgFXLxZbJc0bsqj3EXbFsLJxO+ehTHjwqrFHt8CtvE13R+l9Rz7o7HMpx
   gsxoU7A1xMUs6C1MzCHyyBYE5503OJvums0DuJuTUTCVU9Fi1rQm3u/Rk
   xbomUfMz4EJD7GCGvT6JVylIZ2Zk/djE6Zw6wxB0NUaLY3HID0HfcEaHL
   r3prs6hITgpGjZbDPp3lQ+i98gB3sX0tykx3+5jUXW7tRxW4J8zYGWaCN
   xEOE5bJx9vCLadaKXFArz6e6AM5RSfDu096+lSdSvgLmfwLv3GLVDQb9c
   A==;
X-CSE-ConnectionGUID: q5IY87RfS+yAQt471tKeZg==
X-CSE-MsgGUID: orbozqh1R0i0hFSHt4WDHg==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="18269240"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:22647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id c43763e1-74a1-4d64-a5f6-47b937f85ba0; Tue, 28 Apr 2026 16:58:52 +0000 (UTC)
X-Farcaster-Flow-ID: c43763e1-74a1-4d64-a5f6-47b937f85ba0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:51 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:47 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>
Subject: [PATCH net-next 7/8] net: ena: Add error bound to PHC communication layer
Date: Tue, 28 Apr 2026 16:54:25 +0000
Message-ID: <20260428165659.2811-8-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428165659.2811-1-akiyano@amazon.com>
References: <20260428165659.2811-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 01EDA489942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282007-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Extend the ENA PHC communication layer to retrieve error bound from
the device.

Update ena_com_phc_get_timestamp() to retrieve error_bound alongside
timestamps.
Add error handling and statistics for error_bound retrieval failures.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  2 +
 drivers/net/ethernet/amazon/ena/ena_com.c     | 47 ++++++++++++-------
 drivers/net/ethernet/amazon/ena/ena_com.h     |  5 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  3 ++
 4 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 14784a0..ce9ba84 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -306,6 +306,8 @@ PHC errors must remain below 1% of all PHC requests to maintain the desired leve
 **phc_err_dv**      | Number of failed get time attempts due to device errors (entering into block state).
 **phc_err_ts**      | Number of failed get time attempts due to timestamp errors (entering into block state),
                     | This occurs if driver exceeded the request limit or device received an invalid timestamp.
+**phc_err_eb**      | Number of failed get time attempts due to error bound errors (entering into block state),
+                    | This occurs if device received an excessively high or invalid error bound.
 =================   ======================================================
 
 PHC timeouts:
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e67b592..981e8e4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -45,7 +45,8 @@
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
 #define ENA_PHC_REQ_ID_OFFSET 0xDEAD
-#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP)
+#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP | \
+			     ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND)
 
 /*****************************************************************************/
 /*****************************************************************************/
@@ -1682,11 +1683,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_cmd set_feat_cmd;
 	int ret = 0;
 
-	/* Get device PHC default configuration */
+	/* Get default device PHC configuration */
 	ret = ena_com_get_feature(ena_dev,
 				  &get_feat_resp,
 				  ENA_ADMIN_PHC_CONFIG,
-				  0);
+				  ENA_ADMIN_PHC_FEATURE_VERSION_0);
 	if (unlikely(ret)) {
 		netdev_err(ena_dev->net_device,
 			   "Failed to get PHC feature configuration, error: %d\n",
@@ -1694,10 +1695,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 		return ret;
 	}
 
-	/* Supporting only readless PHC retrieval */
-	if (get_feat_resp.u.phc.type != ENA_ADMIN_PHC_TYPE_READLESS) {
+	/* Supporting only PHC V0 (readless mode with error bound) */
+	if (get_feat_resp.u.phc.version != ENA_ADMIN_PHC_FEATURE_VERSION_0) {
 		netdev_err(ena_dev->net_device,
-			   "Unsupported PHC type, error: %d\n",
+			   "Unsupported PHC version (0x%X), error: %d\n",
+			   get_feat_resp.u.phc.version,
 			   -EOPNOTSUPP);
 		return -EOPNOTSUPP;
 	}
@@ -1725,7 +1727,7 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	if (phc->expire_timeout_usec > phc->block_timeout_usec)
 		phc->expire_timeout_usec = phc->block_timeout_usec;
 
-	/* Prepare PHC feature command */
+	/* Prepare PHC config feature command */
 	memset(&set_feat_cmd, 0x0, sizeof(set_feat_cmd));
 	set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
 	set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
@@ -1780,7 +1782,8 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 	phc->virt_addr = NULL;
 }
 
-int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp,
+			      u32 *error_bound)
 {
 	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ktime_t zero_system_time = ktime_set(0, 0);
@@ -1824,6 +1827,8 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			 * a PHC error, this occurs if device:
 			 * - exceeded the get time request limit
 			 * - received an invalid timestamp
+			 * - received an excessively high error bound
+			 * - received an invalid error bound
 			 */
 			netdev_err(ena_dev->net_device,
 				   "PHC get time request 0x%x failed (error 0x%x)\n",
@@ -1831,9 +1836,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 				   resp->error_flags);
 			phc->stats.phc_err_ts += !!(resp->error_flags &
 				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+			phc->stats.phc_err_eb += !!(resp->error_flags &
+				ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND);
 		} else {
 			/* Device updated req_id during blocking time
-			 * with valid timestamp
+			 * with valid timestamp and error bound
 			 */
 			phc->stats.phc_exp++;
 		}
@@ -1860,9 +1867,9 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 	/* Stalling until the device updates req_id */
 	while (1) {
 		if (unlikely(ktime_after(ktime_get(), expire_time))) {
-			/* Gave up waiting for updated req_id, PHC enters into
-			 * blocked state until passing blocking time,
-			 * during this time any get PHC timestamp will fail with
+			/* Gave up waiting for updated req_id,
+			 * PHC enters into blocked state until passing blocking
+			 * time, during this time, any request will fail with
 			 * device busy error
 			 */
 			ret = -EBUSY;
@@ -1878,14 +1885,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 		}
 
 		/* req_id was updated by the device which indicates that
-		 * PHC timestamp and error_flags are updated too,
-		 * checking errors before retrieving timestamp
+		 * PHC timestamp, error_bound and error_flags are updated too,
+		 * checking error flags before retrieving timestamp and
+		 * error_bound values
 		 */
 		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
-			/* Retrieved invalid PHC timestamp, PHC enters into
-			 * blocked state until passing blocking time,
-			 * during this time any get PHC timestamp requests
-			 * will fail with device busy error
+			/* Retrieved timestamp or error bound errors,
+			 * PHC enters into blocked state until passing blocking
+			 * time, during this time, any request will fail with
+			 * device busy error
 			 */
 			ret = -EBUSY;
 			break;
@@ -1893,12 +1901,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 
 		/* PHC timestamp value is returned to the caller */
 		*timestamp = resp->timestamp;
+		if (error_bound)
+			*error_bound = resp->error_bound;
 
 		/* Update statistic on valid PHC timestamp retrieval */
 		phc->stats.phc_cnt++;
 
 		/* This indicates PHC state is active */
 		phc->system_time = zero_system_time;
+
 		break;
 	}
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 64df2c4..fcbff1a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -216,6 +216,7 @@ struct ena_com_stats_phc {
 	u64 phc_skp;
 	u64 phc_err_dv;
 	u64 phc_err_ts;
+	u64 phc_err_eb;
 };
 
 struct ena_com_admin_queue {
@@ -462,9 +463,11 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev);
 /* ena_com_phc_get_timestamp - Retrieve PHC timestamp
  * @ena_dev: ENA communication layer struct
  * @timestamp: Retrieved PHC timestamp
+ * @error_bound: maximum possible deviation of the timestamp (nanosecond)
  * @return - 0 on success, negative value on failure
  */
-int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp);
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp,
+			      u32 *error_bound);
 
 /* ena_com_set_mmio_read_mode - Enable/disable the indirect mmio reg read mechanism
  * @ena_dev: ENA communication layer struct
diff --git a/drivers/net/ethernet/amazon/ena/ena_debugfs.c b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
index 46ed809..db9d184 100644
--- a/drivers/net/ethernet/amazon/ena/ena_debugfs.c
+++ b/drivers/net/ethernet/amazon/ena/ena_debugfs.c
@@ -32,6 +32,9 @@ static int phc_stats_show(struct seq_file *file, void *priv)
 	seq_printf(file,
 		   "phc_err_ts: %llu\n",
 		   adapter->ena_dev->phc.stats.phc_err_ts);
+	seq_printf(file,
+		   "phc_err_eb: %llu\n",
+		   adapter->ena_dev->phc.stats.phc_err_eb);
 
 	return 0;
 }
-- 
2.47.3


