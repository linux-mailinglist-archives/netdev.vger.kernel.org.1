Return-Path: <netdev+bounces-288378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAnpDUBPB2rBxgIAu9opvQ
	(envelope-from <netdev+bounces-288378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D965540FC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9A3830672E0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8764BC006;
	Fri, 15 May 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CxqYso8q"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE03D0935;
	Fri, 15 May 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863313; cv=none; b=KVWbfQlqHu/+qurJkNi9dQXsLtTmVGaMIe1GhPGGQ6bYioxr7KDsHWlV2pW23utLZ+EXyI2zEQIcVQxIiwUyKmiSG/HymyIF0mec5RvvJFKXo7iJc7WPT65Cih+QD1/JvaOGGVeyI/CbySM57iPIVkmAh9CKOxHc+akLYAdpSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863313; c=relaxed/simple;
	bh=DAFC+ZaaN79MifMm64XqWct6Mk8lq9MbQmW+ZZUWSFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAMkEWB2aFioXxoirwDFT0x9GIa76btA5NtoTgKS38tfsI3kQQZ+m8SZuAnbP2p9aZkVyD6W4ljH6MQdvBKBYWpTj/hp3k56kD1+x8xA+ET//sxIXHkPGzdOGmuLupRJGBqTy1YzAAGYIBCDfsQw/U50EFyeUMYp5HolHrlP114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CxqYso8q; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778863309; x=1810399309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VGZkiF1B9OY2H21fQp6P6Jj+QAw+qoELIJoBTkOvDs=;
  b=CxqYso8qisVvhsYJZm/mrasc2bu5NBLP8cX/gk3EzsJz7TEWynauuY7x
   cmfcR5c97yKpoFz4glAMu/M3uPob39KYwt6EFntVFWuHbIsoe+2PUZQKy
   93j4CItSvnK3/EYSf1EzWMqeNa2c8uXpYvE/j4JahHXEQS4NiMwWhZvyL
   4zXH4Ra6O/fiqjmcH2Rt0CC3K3GLKGMc1iqZ3ecS1BbPrGEBqHMdw0JEs
   uPXFyhHHrvDL+8PDQDDeJHnPiqUN5DVdY542J62h+9hJyxz9DZ1+Om4Wd
   FJH/Z9GgzCpKfVElAKSH7E+AUAmwJ5Ax3ldIlJSD5SxO8PjDKk5TL6DaB
   Q==;
X-CSE-ConnectionGUID: Fe9hdCVDTaGDLZzUP/2vGQ==
X-CSE-MsgGUID: m6A4o2juTGqWfbnB1ke9UQ==
X-IronPort-AV: E=Sophos;i="6.23,236,1770595200"; 
   d="scan'208";a="19546447"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:41:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:14269]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.21:2525] with esmtp (Farcaster)
 id ca268612-881d-440c-ae62-54336403f6f1; Fri, 15 May 2026 16:41:45 +0000 (UTC)
X-Farcaster-Flow-ID: ca268612-881d-440c-ae62-54336403f6f1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:41:45 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 16:41:40 +0000
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
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v3 net-next 7/7] net: ena: Implement gettimexattrs64 callback for PTP attributes
Date: Fri, 15 May 2026 16:40:27 +0000
Message-ID: <20260515164033.6403-8-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515164033.6403-1-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 35D965540FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288378-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement the gettimexattrs64 callback in the ENA driver to support
the PTP_SYS_OFFSET_EXTENDED_ATTRS ioctl.

This enables applications to retrieve PHC timestamps with quality
attributes through the standard PTP ioctl interface.

The ENA device currently reports only error_bound.
Other attributes are set to default values.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_phc.c | 61 +++++++++++++++++++----
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 2bcb5af..6bfa971 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -25,6 +25,46 @@ static int ena_phc_feature_enable(struct ptp_clock_info *clock_info,
 	return -EOPNOTSUPP;
 }
 
+static int ena_phc_gettimexattrs64(struct ptp_clock_info *clock_info,
+				   struct timespec64 *ts,
+				   struct ptp_system_timestamp *sts,
+				   struct ptp_clock_attributes *att)
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
+		att->status = PTP_CLOCK_STATUS_UNKNOWN;
+		att->timescale = PTP_TIMESCALE_UNKNOWN;
+		att->counter_id = 0;
+		att->counter_value = 0;
+	}
+
+	return 0;
+}
+
 static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
@@ -62,16 +102,17 @@ static int ena_phc_settime64(struct ptp_clock_info *clock_info,
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


