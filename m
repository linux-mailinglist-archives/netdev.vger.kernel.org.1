Return-Path: <netdev+bounces-307328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ToPMJgmaVWrOqgAAu9opvQ
	(envelope-from <netdev+bounces-307328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC075047C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:08:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=OOcdN28r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307328-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65EEA3031830
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0C36EAB2;
	Tue, 14 Jul 2026 02:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163537B019;
	Tue, 14 Jul 2026 02:04:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994683; cv=none; b=m4h7XuWn6rodb+q1HTvrJXzfH0T6EZssJUDge3KjagjVa4qE/4IW7irUwaykMSacfBXs7T+6epIztVcjP83ieQ1IrKUt9M1ALKg7FwE3SIp7iwcEsrRIjexQCAivHZ7n75j0LPhLddCwbSOsYrAWPttRBU5v6ID7DY8MkcLfQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994683; c=relaxed/simple;
	bh=T4Hh38LzTfT2h9W/b2wEHGR8lbYgIvaEEW4sRmp3xWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXmC5unnWxKdKZjsvlOhs1825k2HB0AeBNVjCOIDAbOSIFrxWGnQd1DO0pICoRLRcrw9X/lBUoq3cd7/fy7EESeTjlVzD1rZSZ25HCAIbQQzYvWJO33Wgv1EvtqomMhJvW3zYpRaVyviPJk1z2R6aZgljXehpTCd29ABx54WZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OOcdN28r; arc=none smtp.client-ip=34.218.115.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994681; x=1815530681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmJYWSJtg51SSXlz6MGtRxUzQbBgmM0IDhi1HfKohOM=;
  b=OOcdN28r12r7J62l0vlMclbLT6b4seNp72NzAZU4X6W4/BaU4guwThFV
   S2hpkGXJVkRlpU5WRJFXjIDmmO90IOwn5HNS7QghVJfQ8gIaiEiFAENSS
   /qQJNR2zxXmU935Ch6YBDJzy37zP7UGjwCfIzDo0I/RUmLd5/6FmQDJbs
   ZmuTHayI/Uw5PeQieGwUoMK5//9eKM48A09+odKsfTewMnJhLEe9JSvOL
   AXmJOaYXuJOkIqWx8X1V4D8fR2pUacCcdKb/bNk9uwyxpiapxWdg0SAMD
   olGKLRiioOyXwOfR0c9ttR9fbkFIRbGFgC8mjc0ei/OZ4lGIkefJkVg5k
   A==;
X-CSE-ConnectionGUID: RuSHHGwYTcC55I4zklGFrQ==
X-CSE-MsgGUID: Nb2hB7znSMGn19oztmQQ3Q==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23406389"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:24119]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525] with esmtp (Farcaster)
 id 0caf871d-4a90-49eb-b1be-9d334c7936bc; Tue, 14 Jul 2026 02:04:40 +0000 (UTC)
X-Farcaster-Flow-ID: 0caf871d-4a90-49eb-b1be-9d334c7936bc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:40 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:35 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v4 net-next 6/7] net: ena: Add error bound to PHC communication layer
Date: Tue, 14 Jul 2026 02:03:07 +0000
Message-ID: <20260714020340.25014-7-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714020340.25014-1-akiyano@amazon.com>
References: <20260714020340.25014-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307328-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:akiyano@amazon.com,m:richardcochran@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw2@infradead.org,m:tglx@linutronix.de,m:mlichvar@redhat.com,m:andrew+netdev@lunn.ch,m:guwen@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:dwmw@amazon.com,m:ysarna@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:amitbern@amazon.com,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,lwn.net,linuxfoundation.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0CC075047C

Extend the ENA PHC communication layer to retrieve error bound from
the device.

Update ena_com_phc_get_timestamp() to retrieve error_bound alongside
timestamps.
Add error handling and statistics for error_bound retrieval failures.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  2 +
 drivers/net/ethernet/amazon/ena/ena_com.c     | 40 ++++++++++++-------
 drivers/net/ethernet/amazon/ena/ena_com.h     |  5 ++-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |  3 ++
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  3 +-
 5 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 14784a0a6a8a..ce9ba84bfd01 100644
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
index 40d1fd64bc34..353cb88e880e 100644
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
@@ -1726,7 +1727,7 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
 	if (phc->expire_timeout_usec > phc->block_timeout_usec)
 		phc->expire_timeout_usec = phc->block_timeout_usec;
 
-	/* Prepare PHC feature command */
+	/* Prepare PHC config feature command */
 	memset(&set_feat_cmd, 0x0, sizeof(set_feat_cmd));
 	set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
 	set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
@@ -1781,7 +1782,8 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 	phc->virt_addr = NULL;
 }
 
-int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp,
+			      u32 *error_bound)
 {
 	const ktime_t zero_system_time = ktime_set(0, 0);
 	struct ena_com_phc_info *phc = &ena_dev->phc;
@@ -1828,6 +1830,8 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			 * a PHC error, this occurs if device:
 			 * - exceeded the get time request limit
 			 * - received an invalid timestamp
+			 * - received an excessively high error bound
+			 * - received an invalid error bound
 			 */
 			netdev_err(ena_dev->net_device,
 				   "PHC get time request 0x%x failed (error 0x%x)\n",
@@ -1835,9 +1839,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -1864,9 +1870,9 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -1881,20 +1887,21 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			continue;
 		}
 
-		/* Ensure PHC payload (timestamp, error_flags) is read
-		 * after req_id update is observed
+		/* Ensure PHC payload (timestamp, error_bound, error_flags)
+		 * is read after req_id update is observed
 		 */
 		dma_rmb();
 
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
@@ -1902,12 +1909,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 
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
index 64df2c48c9a6..fcbff1a9eb7a 100644
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
index 46ed80986724..db9d1843996b 100644
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
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index c2a3ff1ef645..2bcb5af564e2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -40,7 +40,8 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 	ptp_read_system_prets(sts);
 
 	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev,
-				       &timestamp_nsec);
+				       &timestamp_nsec,
+				       NULL);
 
 	ptp_read_system_postts(sts);
 
-- 
2.47.3


