Return-Path: <netdev+bounces-307329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdOKKxuaVWrZqgAAu9opvQ
	(envelope-from <netdev+bounces-307329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168BB750484
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=LsHiFM15;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307329-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 659FE303A718
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748636EAAB;
	Tue, 14 Jul 2026 02:04:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB23624B2;
	Tue, 14 Jul 2026 02:04:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994689; cv=none; b=rl8KTr/Gw8j5IXuS4YBosjWErnzhvsAKgpRSJu6k/rMEvTB2IDG/2lY35vnW8CXnSjln1pBk97xPMlMLuyUEtDHuuXkU/1npUTXmyKJj6riWzcubldyQfhN4VX09a9GNj0vR6/8B9CbfJq/06hW4fZGlxv5gc3z2sAmO/G7dda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994689; c=relaxed/simple;
	bh=57qGqSE9tP6lPRw/YAUHjWMVC1tvGg7x5fped7GmMnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRh/Yfr8uMQ/Cu8UJxak0jIifm1UmUbrve3skrTzLOo66js1+sf2hUU8lnpz4rw0R3J0GvryDAlm09I/hT2T/pjDnpFzBqsX5heodmXhVlbwSQirSeeMTiVHRPYvaPdJLyLVOYShQjZN24/3drSyLsgxM9fJYqTp6knnHKhqe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LsHiFM15; arc=none smtp.client-ip=52.12.53.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994688; x=1815530688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zkFcRd5mu9B02BIWtTtfZKps/G89UKhgagGL2Z3qRE=;
  b=LsHiFM15McvgCm6z7Gz3Nsio2K7iZexrFFVFdEkpeCIoWrjnXeNc7Xo1
   6v4YDeQ8PsHdTnMawUyqWX5mQ6GsR9ZX9wDq8rHfqVhTgYK8QYzc1Ehln
   uKy+lGSUzb2Du/SW/KIUwB04rxVJ2e/UNe2ofLGbwfT8DkoyQcD7M/3/Q
   b0d2c9nL+FZ66zCNbVYbUKS194rrxe+HlCh/dz02ApIJkq7jxEWzqDvQ8
   wyoSKdIT1I6qzBg6E1hnmvTykreafzCeNsUjoCi3UC13IuWeJrq8ZdWp7
   UYBPPMy86sK5QEdacHkxcDilLzpbIWUthTRzL/SMmPDrf9TFvBzYNQs5i
   A==;
X-CSE-ConnectionGUID: y7v2r35uTYu6w8WzA4mRKg==
X-CSE-MsgGUID: 5sXAcwIOS5CtsvdHvYfpJw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23479313"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:30374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.123:2525] with esmtp (Farcaster)
 id f6d831c8-97fc-40a5-b045-0777f5a74624; Tue, 14 Jul 2026 02:04:45 +0000 (UTC)
X-Farcaster-Flow-ID: f6d831c8-97fc-40a5-b045-0777f5a74624
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:45 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:40 +0000
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
Subject: [PATCH v4 net-next 7/7] net: ena: Implement gettimexattrs64 callback for PTP attributes
Date: Tue, 14 Jul 2026 02:03:08 +0000
Message-ID: <20260714020340.25014-8-akiyano@amazon.com>
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
	TAGGED_FROM(0.00)[bounces-307329-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 168BB750484

Implement the gettimexattrs64 callback in the ENA driver to support
the PTP_SYS_OFFSET_EXTENDED_ATTRS ioctl.

This enables applications to retrieve PHC timestamps with quality
attributes through the standard PTP ioctl interface.

The ENA device currently reports only error_bound (valid bit set).
Other attributes are not reported (valid bits unset).

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_phc.c | 58 +++++++++++++++++++----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 2bcb5af564e2..725c36fe3f6e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -25,6 +25,43 @@ static int ena_phc_feature_enable(struct ptp_clock_info *clock_info,
 	return -EOPNOTSUPP;
 }
 
+static int ena_phc_gettimexattrs64(struct ptp_clock_info *clock_info,
+				   struct timespec64 *ts,
+				   struct ptp_system_timestamp *sts,
+				   struct ptp_clock_attrs *att)
+{
+	struct ena_phc_info *phc_info =
+		container_of(clock_info, struct ena_phc_info, clock_info);
+	u32 error_bound_nsec;
+	unsigned long flags;
+	u64 timestamp_nsec;
+	int rc;
+
+	spin_lock_irqsave(&phc_info->lock, flags);
+
+	ptp_read_system_prets(sts);
+
+	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev,
+				       &timestamp_nsec,
+				       &error_bound_nsec);
+
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&phc_info->lock, flags);
+
+	if (rc)
+		return rc;
+
+	*ts = ns_to_timespec64(timestamp_nsec);
+
+	if (att) {
+		att->error_bound = error_bound_nsec;
+		att->valid |= PTP_ATTRS_VALID_ERROR_BOUND;
+	}
+
+	return 0;
+}
+
 static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
@@ -62,16 +99,17 @@ static int ena_phc_settime64(struct ptp_clock_info *clock_info,
 }
 
 static struct ptp_clock_info ena_ptp_clock_info = {
-	.owner		= THIS_MODULE,
-	.n_alarm	= 0,
-	.n_ext_ts	= 0,
-	.n_per_out	= 0,
-	.pps		= 0,
-	.adjtime	= ena_phc_adjtime,
-	.adjfine	= ena_phc_adjfine,
-	.gettimex64	= ena_phc_gettimex64,
-	.settime64	= ena_phc_settime64,
-	.enable		= ena_phc_feature_enable,
+	.owner		   = THIS_MODULE,
+	.n_alarm	   = 0,
+	.n_ext_ts	   = 0,
+	.n_per_out	   = 0,
+	.pps		   = 0,
+	.adjtime	   = ena_phc_adjtime,
+	.adjfine	   = ena_phc_adjfine,
+	.gettimexattrs64   = ena_phc_gettimexattrs64,
+	.gettimex64	   = ena_phc_gettimex64,
+	.settime64	   = ena_phc_settime64,
+	.enable		   = ena_phc_feature_enable,
 };
 
 /* Enable/Disable PHC by the kernel, affects on the next init flow */
-- 
2.47.3


