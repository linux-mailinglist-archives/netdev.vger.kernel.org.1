Return-Path: <netdev+bounces-307327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VOlcDvmZVWrJqgAAu9opvQ
	(envelope-from <netdev+bounces-307327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9C75046E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=hI3Bg5jg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307327-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307327-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF27303D305
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5237A48D;
	Tue, 14 Jul 2026 02:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFE360745;
	Tue, 14 Jul 2026 02:04:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994680; cv=none; b=Vjqnr3CIasPJ53pw+cUdaukTTapHQfn/WBvpcqrJ045naF9kCqZlM3sl2D994YdI1k/LhgTSKS8doAihVlNSv6kWPZOlUDUmPaDrYPvcLBRtl3o3T7QJMgmZQlmLWN5nfQnq3D6WK0s7CyPWLDwgj6eShVpfe06oy277IpfyHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994680; c=relaxed/simple;
	bh=vVo0w/Zc0HtX0MG2dLc1q8BXoTZLzNUxMBX3JzcJ/0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GH8iiw31ajsbY8KneZHEDsOd+oWBhHUtXX/D/vY6ReGQn58+8XkmxHdkHydkM5vVMVtgOvUgn9qxvR6WFqbjkGLQHuNShkzEILIEUc3EPWWcIRWmgE3z8KzIxs3veGJp8lgRkoxf4um1WrwZjZCj+n8skYyR+tI4stiVBbUzODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hI3Bg5jg; arc=none smtp.client-ip=44.245.243.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994678; x=1815530678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Np8erMcwp8rzH3Givzf38W/R8LbiSdcNfK7ZRUqGBNQ=;
  b=hI3Bg5jgFI2BN3tGawC+xQb88ICyb9qJfqw7IWmaDKuW+ZDgi87+gyuI
   mCPvii8m0REeiYLl+b+qmVEKQFjqSNRWDAKisdxoqY9iJvg+yyOFQubv5
   zIxmtRo84Wstog30QvzvxX0GkO9SRiOJe5bC8bNPmFr94SuBCy1oimYNp
   y3e57lQRxR8WcNk/ZRgDT6RoLJHICSrJcXHlxAzyUB/h5RRPUcHD5JFoW
   jJM6zsszpAIDIZ59NMHzr79roSF1WwSFPJmyX6XLRW6ph/wh9d0m3EEta
   EyhrFFhgmY1mitPCo1wuRMpCiEjiNugcZQnI/u97dGKU5oW3uBJYssCTW
   g==;
X-CSE-ConnectionGUID: afEw7aAVTqOs4LAPGH9mcw==
X-CSE-MsgGUID: hPscahfNQBGU6n7JaqQ/nA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23104627"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:12918]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id 4a280d02-faa2-423d-8b66-642816a67496; Tue, 14 Jul 2026 02:04:35 +0000 (UTC)
X-Farcaster-Flow-ID: 4a280d02-faa2-423d-8b66-642816a67496
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:35 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:30 +0000
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
Subject: [PATCH v4 net-next 5/7] net: ena: Update PHC admin interface for error bound support
Date: Tue, 14 Jul 2026 02:03:06 +0000
Message-ID: <20260714020340.25014-6-akiyano@amazon.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307327-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDE9C75046E

Extend the ENA admin interface to support error bound.

Add error_bound to the PHC response structure.
Introduce a feature version mechanism to indicate device supports
error_bound, and add an error flag for error_bound retrieval failures.

This enables the driver to retrieve error_bound information from the
device alongside timestamps.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 .../net/ethernet/amazon/ena/ena_admin_defs.h    | 17 +++++++++++------
 drivers/net/ethernet/amazon/ena/ena_com.c       | 11 ++++++-----
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 898ecd96b96a..2d132c4bc590 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -128,12 +128,14 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
-enum ena_admin_phc_type {
-	ENA_ADMIN_PHC_TYPE_READLESS                 = 0,
+enum ena_admin_phc_feature_version {
+	/* Readless with error_bound */
+	ENA_ADMIN_PHC_FEATURE_VERSION_0             = 0,
 };
 
 enum ena_admin_phc_error_flags {
 	ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP   = BIT(0),
+	ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND = BIT(1),
 };
 
 /* ENA SRD configuration for ENI */
@@ -1035,10 +1037,10 @@ struct ena_admin_queue_ext_feature_desc {
 };
 
 struct ena_admin_feature_phc_desc {
-	/* PHC type as defined in enum ena_admin_get_phc_type,
-	 * used only for GET command.
+	/* PHC version as defined in enum ena_admin_phc_feature_version,
+	 * used only for GET command as max supported PHC version by the device.
 	 */
-	u8 type;
+	u8 version;
 
 	/* Reserved - MBZ */
 	u8 reserved1[3];
@@ -1224,7 +1226,10 @@ struct ena_admin_phc_resp {
 	/* PHC timestamp (nsec) */
 	u64 timestamp;
 
-	u8 reserved2[12];
+	u8 reserved2[8];
+
+	/* Timestamp error limit (nsec) */
+	u32 error_bound;
 
 	/* Bit field of enum ena_admin_phc_error_flags */
 	u32 error_flags;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 297fb36ab8c1..40d1fd64bc34 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1682,11 +1682,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
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
@@ -1694,10 +1694,11 @@ int ena_com_phc_config(struct ena_com_dev *ena_dev)
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
-- 
2.47.3


