Return-Path: <netdev+bounces-307323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5KMIDZ2ZVWqwqgAAu9opvQ
	(envelope-from <netdev+bounces-307323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:06:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 800EC75043C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=cMnqpp38;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307323-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307323-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFAB300F129
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570836EAB2;
	Tue, 14 Jul 2026 02:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95172E8DEB;
	Tue, 14 Jul 2026 02:04:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994651; cv=none; b=p053QvzSoBEjMX1ZqZBWeFm7WmDXw2qevdKm1AaXa4jqmigfOckGN5h5Dp/2JXcsbKCMYxiVHr3Nf4KW2wqStp0OF3t6zZzoWDK5Mps4ih8IvTRIah2ChgRLlxDNtHiBHUpN6DLBMJkwcOIko7tAG/MI1WS1ublxFzX5E8Kq6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994651; c=relaxed/simple;
	bh=MvttNtHPdrx8iRVq4JQuWjaNFcm7xvvV0NIh357Vjvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIpgk5syS26eZ1oH90rFapvTvOnqruufAtwEHxtfVQ6N03TT9KdjCTlf2tb17FUjLX7nrfEnxvVUBd9lfoL1bv3d5Vs3LpPvGtJ6Qz8/aY4WxMA4n4TX567+EzaitRHkUTB7/LDo4m/QI5PaartLHwnjA3sqvjJ/yASTcgLezGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cMnqpp38; arc=none smtp.client-ip=34.218.115.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994649; x=1815530649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u8oUVnE6AdRV4BZKSyAJ8ARdsFSNimm3G7OqWn7t/bQ=;
  b=cMnqpp38IURFwWP5/5a9zR4Yc2eY6yDyxCTA8f6OXSV/UPtPUSO38z/9
   Vn767gCkLXvUyatxt97SrG8hrKsO8l3ylXJkuKlOSksoYesiA9lM+zup6
   1msAGL1vxtFnxFWQdY+k2P4YiZQ4VBqNo9M9fZR2ewNnw7EvtJFF3vNrF
   ygtaAXRS9bLWZyxqzvg/OvuQEnNx9USrvCNqYXlEOUtMwGqy7ieGWqbH7
   y/QoLNIpBgAO/NXi1toRvOtCyGsRXDTzdNvoGBM5HNL6XYviCaZHEWJ7e
   7fheQLFA5fwN3gR9+BdhSpxzCgU6DxuKXwnyJTbCgUN24fGLeuoeYgP9x
   w==;
X-CSE-ConnectionGUID: ClvggqVkRxWLZ6n5gZe3gw==
X-CSE-MsgGUID: +ijeD6SDR/mSp13KJJSgNA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23406345"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:20691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id ecbf810a-d1a6-40b4-82c0-848f36580941; Tue, 14 Jul 2026 02:04:06 +0000 (UTC)
X-Farcaster-Flow-ID: ecbf810a-d1a6-40b4-82c0-848f36580941
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:06 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:01 +0000
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
Subject: [PATCH v4 net-next 1/7] ptp: Add ioctls for PHC timestamps with quality attributes
Date: Tue, 14 Jul 2026 02:03:02 +0000
Message-ID: <20260714020340.25014-2-akiyano@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
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
	TAGGED_FROM(0.00)[bounces-307323-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 800EC75043C

Introduce two new ioctls that extend existing PTP timestamp interfaces
with clock quality information:

- PTP_SYS_OFFSET_EXTENDED_ATTRS: Extends PTP_SYS_OFFSET_EXTENDED
- PTP_SYS_OFFSET_PRECISE_ATTRS: Extends PTP_SYS_OFFSET_PRECISE

These ioctls provide quality attributes alongside timestamps:

1. error_bound: Maximum deviation from true time (nanoseconds), based
   on device's internal clock state
2. clock_status: Synchronization state (unknown, initializing,
   synchronized, free-running, unreliable)
3. timescale: Time reference (TAI, UTC, etc.)
4. counter_value: Raw system counter (e.g. TSC ticks) captured by the
   timekeeping core alongside each system timestamp
5. counter_id: Identifies the counter source (e.g. TSC, ARM arch counter)

This supports three use cases:

1. Managed PHC devices (e.g., ENA, vmclock) that maintain their own
   synchronization and can report quality metrics directly to userspace
   without requiring ptp4l

2. Applications that need complete time quality information in a single
   call, regardless of how the PHC is synchronized

3. VMMs that need raw system counter values paired
   with PTP timestamps for feed-forward clock calibration, avoiding the
   feedback loop inherent in NTP-style synchronization

Timescale definitions use a Continuity/Discipline framework to describe
timeline properties and steering behavior consistently across all
entries.

This implementation is based on the original RFC and the UAPI design
discussion linked below.

Link: https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/
Link: https://lore.kernel.org/all/87se7ht25o.ffs@tglx/
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/ptp/ptp_chardev.c        | 166 ++++++++++++++++++--
 drivers/ptp/ptp_clock.c          |   4 +-
 include/linux/ptp_clock_kernel.h |  30 ++++
 include/uapi/linux/ptp_clock.h   | 254 ++++++++++++++++++++++++++++++-
 4 files changed, 439 insertions(+), 15 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index dc23cd708cfe..be33f8ead727 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -190,6 +190,8 @@ static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
 		.cross_timestamping	= ptp->info->getcrosststamp != NULL,
 		.adjust_phase		= ptp->info->adjphase != NULL &&
 					  ptp->info->getmaxphase != NULL,
+		.extended_attrs		= ptp->info->gettimexattrs64 != NULL,
+		.precise_attrs		= ptp->info->getcrosststampattrs != NULL,
 	};
 
 	if (caps.adjust_phase)
@@ -347,11 +349,28 @@ typedef int (*ptp_gettimex_fn)(struct ptp_clock_info *,
 			       struct timespec64 *,
 			       struct ptp_system_timestamp *);
 
+static int ptp_validate_sys_offset_clockid(__kernel_clockid_t clockid)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		return 0;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+}
+
 static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 				    ptp_gettimex_fn gettimex_fn)
 {
 	struct ptp_sys_offset_extended *extoff __free(kfree) = NULL;
 	struct ptp_system_timestamp sts;
+	int err;
 
 	if (!gettimex_fn)
 		return -EOPNOTSUPP;
@@ -363,23 +382,13 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 	if (extoff->n_samples > PTP_MAX_SAMPLES || extoff->rsv[0] || extoff->rsv[1])
 		return -EINVAL;
 
-	switch (extoff->clockid) {
-	case CLOCK_REALTIME:
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		break;
-	case CLOCK_AUX ... CLOCK_AUX_LAST:
-		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
-			break;
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
+	err = ptp_validate_sys_offset_clockid(extoff->clockid);
+	if (err)
+		return err;
 
 	sts.clockid = extoff->clockid;
 	for (unsigned int i = 0; i < extoff->n_samples; i++) {
 		struct timespec64 ts;
-		int err;
 
 		err = gettimex_fn(ptp->info, &ts, &sts);
 		if (err)
@@ -404,6 +413,131 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset_extended_attrs(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_attrs *data __free(kfree) = NULL;
+	struct ptp_system_timestamp sts;
+	unsigned int n_samples;
+	int err;
+
+	data = memdup_user(arg, sizeof(*data));
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (data->request.valid ||
+	    data->request.num_samples > PTP_MAX_SAMPLES ||
+	    data->request.num_samples == 0)
+		return -EINVAL;
+
+	err = ptp_validate_sys_offset_clockid(data->request.clock_id);
+	if (err)
+		return err;
+
+	n_samples = data->request.num_samples;
+	sts.clockid = data->request.clock_id;
+	kfree(data);
+	data = kzalloc(struct_size(data, timestamps, n_samples), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->request.num_samples = n_samples;
+
+	for (unsigned int i = 0; i < n_samples; i++) {
+		struct ptp_clock_attrs att = {};
+		struct timespec64 ts;
+
+		if (ptp->info->gettimexattrs64)
+			err = ptp->info->gettimexattrs64(ptp->info, &ts,
+							 &sts, &att);
+		else if (ptp->info->gettimex64)
+			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
+		else
+			return -EOPNOTSUPP;
+
+		if (err)
+			return err;
+
+		/* Filter out disabled or unavailable clocks */
+		if (!sts.pre_sts.valid || !sts.post_sts.valid)
+			return -EINVAL;
+
+		data->timestamps[i].pre_systime.sys_time =
+			ktime_to_ns(sts.pre_sts.systime);
+		data->timestamps[i].pre_systime.sys_rawtime =
+			ktime_to_ns(sts.pre_sts.monoraw);
+		data->timestamps[i].pre_systime.sys_counter =
+			sts.pre_sts.cycles;
+		data->timestamps[i].pre_systime.sys_counter_id =
+			sts.pre_sts.cs_id;
+		data->timestamps[i].devtime.device_time.sec = ts.tv_sec;
+		data->timestamps[i].devtime.device_time.nsec = ts.tv_nsec;
+		data->timestamps[i].devtime.attrs = att;
+		data->timestamps[i].post_systime.sys_time =
+			ktime_to_ns(sts.post_sts.systime);
+		data->timestamps[i].post_systime.sys_rawtime =
+			ktime_to_ns(sts.post_sts.monoraw);
+		data->timestamps[i].post_systime.sys_counter =
+			sts.post_sts.cycles;
+		data->timestamps[i].post_systime.sys_counter_id =
+			sts.post_sts.cs_id;
+	}
+
+	return copy_to_user(arg, data,
+			    struct_size(data, timestamps, n_samples)) ? -EFAULT : 0;
+}
+
+static long ptp_sys_offset_precise_attrs(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_attrs *data __free(kfree) = NULL;
+	struct system_device_crosststamp xtstamp;
+	struct ptp_clock_attrs att = {};
+	struct timespec64 ts;
+	int err;
+
+	data = memdup_user(arg, sizeof(*data));
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (data->request.valid ||
+	    data->request.num_samples != 1)
+		return -EINVAL;
+
+	err = ptp_validate_sys_offset_clockid(data->request.clock_id);
+	if (err)
+		return err;
+
+	kfree(data);
+	data = kzalloc(struct_size(data, timestamps, 1), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (ptp->info->getcrosststampattrs)
+		err = ptp->info->getcrosststampattrs(ptp->info, &xtstamp, &att);
+	else if (ptp->info->getcrosststamp)
+		err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
+	else
+		return -EOPNOTSUPP;
+
+	if (err)
+		return err;
+
+	ts = ktime_to_timespec64(xtstamp.device);
+	data->timestamps[0].systime.sys_time =
+		ktime_to_ns(xtstamp.sys_systime);
+	data->timestamps[0].systime.sys_rawtime =
+		ktime_to_ns(xtstamp.sys_monoraw);
+	data->timestamps[0].systime.sys_counter =
+		xtstamp.sys_counter.cycles;
+	data->timestamps[0].systime.sys_counter_id =
+		xtstamp.sys_counter.cs_id;
+	data->timestamps[0].devtime.device_time.sec = ts.tv_sec;
+	data->timestamps[0].devtime.device_time.nsec = ts.tv_nsec;
+	data->timestamps[0].devtime.attrs = att;
+
+	return copy_to_user(arg, data,
+			    struct_size(data, timestamps, 1)) ? -EFAULT : 0;
+}
+
 static long ptp_sys_offset(struct ptp_clock *ptp, void __user *arg)
 {
 	struct ptp_sys_offset *sysoff __free(kfree) = NULL;
@@ -539,11 +673,17 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 		return ptp_sys_offset_precise(ptp, argptr,
 					      ptp->info->getcrosststamp);
 
+	case PTP_SYS_OFFSET_PRECISE_ATTRS:
+		return ptp_sys_offset_precise_attrs(ptp, argptr);
+
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
 		return ptp_sys_offset_extended(ptp, argptr,
 					       ptp->info->gettimex64);
 
+	case PTP_SYS_OFFSET_EXTENDED_ATTRS:
+		return ptp_sys_offset_extended_attrs(ptp, argptr);
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		return ptp_sys_offset(ptp, argptr);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d6f54ccaf93b..849aef8191c5 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -112,7 +112,9 @@ static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp)
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	int err;
 
-	if (ptp->info->gettimex64)
+	if (ptp->info->gettimexattrs64)
+		err = ptp->info->gettimexattrs64(ptp->info, tp, NULL, NULL);
+	else if (ptp->info->gettimex64)
 		err = ptp->info->gettimex64(ptp->info, tp, NULL);
 	else
 		err = ptp->info->gettime64(ptp->info, tp);
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a910595..b2a418081687 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -123,11 +123,34 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimexattrs64:  Reads the current time from the hardware clock and
+ *                    optionally also the system clock with additional clock
+ *                    attributes.
+ *                    parameter ts: Holds the PHC timestamp.
+ *                    parameter sts: If not NULL, it holds a pair of
+ *                    timestamps from the system clock. The first reading is
+ *                    made right before reading the lowest bits of the PHC
+ *                    timestamp and the second reading immediately follows that.
+ *                    parameter att: If not NULL, it holds the maximum error
+ *                    bound for the returned PHC timestamp in nanoseconds,
+ *                    the timescale for the returned PHC timestamp and the
+ *                    clock's qualitative synchronization status.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
  *                   where system time is realtime and monotonic.
  *
+ * @getcrosststampattrs:  Reads the current time from the hardware clock and
+ *                        system clock simultaneously with additional data on
+ *                        hardware clock accuracy and reliability.
+ *                        parameter cts: Contains timestamp (device,system)
+ *                        pair, where system time is realtime and monotonic.
+ *                        parameter att: If not NULL, it holds the maximum error
+ *                        bound for the returned PHC timestamp in nanoseconds,
+ *                        the timescale for the returned PHC timestamp and the
+ *                        clock's qualitative synchronization status.
+ *
  * @settime64:  Set the current time on the hardware clock.
  *              parameter ts: Time value to set.
  *
@@ -209,8 +232,15 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimexattrs64)(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts,
+			       struct ptp_clock_attrs *att);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
+	int (*getcrosststampattrs)(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *cts,
+				   struct ptp_clock_attrs *att);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
 	int (*getcycles64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*getcyclesx64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 46d45f902486..88c2da6bc8c6 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -79,6 +79,137 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+/*
+ * Clock status values for struct ptp_clock_attrs.status
+ */
+enum ptp_clock_status {
+	/* Clock synchronization status cannot be reliably determined */
+	PTP_CLOCK_STATUS_UNKNOWN      = 0,
+
+	/* Clock is acquiring synchronization */
+	PTP_CLOCK_STATUS_INITIALIZING = 1,
+
+	/* Clock is synchronized and maintained accurately by the device */
+	PTP_CLOCK_STATUS_SYNCED       = 2,
+
+	/* Clock is drifting but remains within acceptable error bounds */
+	PTP_CLOCK_STATUS_HOLDOVER     = 3,
+
+	/* Clock is drifting without adjustments or synchronization */
+	PTP_CLOCK_STATUS_FREE_RUNNING = 4,
+
+	/* Clock is unreliable, the error_bound value cannot be trusted */
+	PTP_CLOCK_STATUS_UNRELIABLE   = 5
+};
+
+/*
+ * Clock timescale values for struct ptp_clock_attrs.timescale.
+ *
+ * These definitions describe the mathematical properties and reference
+ * epochs of the timescale provided by the PHC.
+ *
+ * Discipline: Describes the frequency/phase steering behavior.
+ * Continuity: Describes whether the timeline is uninterrupted.
+ */
+enum ptp_clock_timescale {
+	/* Unknown or unspecified timescale */
+	PTP_TIMESCALE_UNKNOWN = 0,
+
+	/********************* Absolute Atomic Timescales *********************
+	 * These timescales are continuous, monotonic standards based on atomic
+	 * physics. They do not experience phase jumps.
+	 **********************************************************************/
+
+	/**
+	 * International Atomic Time (TAI)
+	 * Epoch: 1958-01-01 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Primary atomic reference; no phase jumps.
+	 */
+	PTP_TIMESCALE_TAI = 1,
+
+	/**
+	 * Terrestrial Time (TT)
+	 * Epoch: 1958-01-01 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Defined as TAI + 32.184s constant offset.
+	 */
+	PTP_TIMESCALE_TT = 2,
+
+	/**
+	 * Global Positioning System (GPS) Time
+	 * Epoch: 1980-01-06 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Defined by the GPS constellation; fixed offset from TAI.
+	 */
+	PTP_TIMESCALE_GPS = 3,
+
+	/****************** UTC-Based Timescales (Civil Time) *****************
+	 * These timescales are derived from TAI but adjusted to align with
+	 * the Earth's rotation, primarily through leap seconds.
+	 **********************************************************************/
+
+	/**
+	 * Coordinated Universal Time (UTC) - Wall-clock (CLOCK_REALTIME)
+	 * Epoch: 1970-01-01 00:00:00 (Unix epoch).
+	 * Continuity: Discontinuous; subject to 1-second leap second
+	 *             phase jumps.
+	 * Discipline: Frequency steered; incorporates leap second corrections.
+	 *
+	 * Note: Leap-smeared UTC MUST NOT be advertised as PTP_TIMESCALE_UTC.
+	 * Smear algorithms are not standardized and the resulting timescale
+	 * is ambiguous. Implementations using smeared UTC MUST advertise
+	 * PTP_TIMESCALE_UNKNOWN or PTP_TIMESCALE_PROPRIETARY instead.
+	 */
+	PTP_TIMESCALE_UTC = 4,
+
+	/**
+	 * POSIX Time (Unix Time)
+	 * Epoch: 1970-01-01 00:00:00.
+	 * Continuity: Discontinuous; leap seconds handled by
+	 *             repeating/skipping values.
+	 * Discipline: Follows UTC frequency steering and phase jumps.
+	 */
+	PTP_TIMESCALE_POSIX = 5,
+
+	/****************** System-Relative Monotonic Clocks ******************
+	 * These timescales are relative to a system event (like boot)
+	 * and are not synchronized to an external atomic standard.
+	 **********************************************************************/
+
+	/**
+	 * Monotonic System Clock (CLOCK_MONOTONIC)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic; no leap seconds.
+	 * Discipline: Frequency steered to match system reference;
+	 *             does not advance during suspend.
+	 */
+	PTP_TIMESCALE_MONOTONIC = 6,
+
+	/**
+	 * Raw Monotonic System Clock (CLOCK_MONOTONIC_RAW)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic; no leap seconds.
+	 * Discipline: Raw hardware oscillator; no frequency steering
+	 *             or discipline.
+	 */
+	PTP_TIMESCALE_MONOTONIC_RAW = 7,
+
+	/**
+	 * Boot Time System Clock (CLOCK_BOOTTIME)
+	 * Epoch: Arbitrary (System boot time).
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Frequency steered to match system reference;
+	 *             advances during suspend.
+	 */
+	PTP_TIMESCALE_BOOTTIME = 8,
+
+	/********************** Vendor-Specific Timescale *********************/
+
+	/* A proprietary or vendor-specific timescale with custom rules. */
+	PTP_TIMESCALE_PROPRIETARY = 9,
+};
+
 /*
  * struct ptp_clock_time - represents a time value
  *
@@ -94,6 +225,119 @@ struct ptp_clock_time {
 	__u32 reserved;
 };
 
+/*
+ * Hardware counter identifiers for struct ptp_sys_time.sys_counter_id
+ */
+enum ptp_counter_id {
+	/* Counter value not available or type not specified */
+	PTP_COUNTER_UNKNOWN = 0,
+
+	/* x86 Time Stamp Counter (TSC) */
+	PTP_COUNTER_X86_TSC = 1,
+
+	/* ARM Generic Timer virtual counter */
+	PTP_COUNTER_ARM_ARCH = 2,
+};
+
+/* Valid flags for struct ptp_clock_attrs.valid */
+#define PTP_ATTRS_VALID_ERROR_BOUND	(1 << 0)
+#define PTP_ATTRS_VALID_TIMESCALE	(1 << 1)
+#define PTP_ATTRS_VALID_STATUS		(1 << 2)
+
+/**
+ * struct ptp_clock_attrs - quality attributes for a PHC timestamp
+ *
+ * @valid:       Bitmask of PTP_ATTRS_VALID_* indicating which fields
+ *               are populated. Zero means no attributes available.
+ * @error_bound: Maximum error in nanoseconds. Valid only when
+ *               PTP_ATTRS_VALID_ERROR_BOUND is set.
+ * @timescale:   Clock timescale (enum ptp_clock_timescale). Valid only
+ *               when PTP_ATTRS_VALID_TIMESCALE is set.
+ * @status:      Synchronization status (enum ptp_clock_status). Valid
+ *               only when PTP_ATTRS_VALID_STATUS is set.
+ * @rsv:         Reserved for future use, must be zero.
+ */
+struct ptp_clock_attrs {
+	__u32 valid;
+	__u32 error_bound;
+	__u32 timescale;
+	__u32 status;
+	__u32 rsv[4];
+};
+
+/**
+ * struct ptp_sys_time - system time snapshot with counter value
+ *
+ * @sys_time:       System time in nanoseconds (clock selected by request).
+ * @sys_rawtime:    CLOCK_MONOTONIC_RAW time in nanoseconds.
+ * @sys_counter:    Raw clocksource counter value (0 = unavailable).
+ * @sys_counter_id: Identifies the counter (enum ptp_counter_id).
+ * @rsv:            Reserved for future use, must be zero.
+ */
+struct ptp_sys_time {
+	__s64 sys_time;
+	__s64 sys_rawtime;
+	__u64 sys_counter;
+	__u32 sys_counter_id;
+	__u32 rsv;
+};
+
+/**
+ * struct ptp_dev_time - device timestamp with quality attributes
+ *
+ * @device_time: PHC timestamp value.
+ * @attrs:       Quality attributes for this timestamp.
+ */
+struct ptp_dev_time {
+	struct ptp_clock_time device_time;
+	struct ptp_clock_attrs attrs;
+};
+
+/**
+ * struct ptp_timestamp - a complete timestamp sample
+ *
+ * For PTP_SYS_OFFSET_EXTENDED_ATTRS: pre_systime and post_systime bracket
+ * the device read (ABA sandwich).
+ * For PTP_SYS_OFFSET_PRECISE_ATTRS: only systime (union with pre_systime)
+ * is meaningful; post_systime is zeroed.
+ */
+struct ptp_timestamp {
+	union {
+		struct ptp_sys_time systime;
+		struct ptp_sys_time pre_systime;
+	};
+	struct ptp_dev_time devtime;
+	struct ptp_sys_time post_systime;
+};
+
+/**
+ * struct ptp_attrs_request - request parameters for attrs ioctls
+ *
+ * @valid:       Bitmask for future request extensions. Must be zero for now.
+ * @clock_id:    Clock base for system timestamps (CLOCK_REALTIME, etc).
+ * @num_samples: Number of timestamp samples requested.
+ *               For PTP_SYS_OFFSET_PRECISE_ATTRS must be 1.
+ * @rsv:         Reserved for future use, must be zero.
+ */
+struct ptp_attrs_request {
+	__u32 valid;
+	__kernel_clockid_t clock_id;
+	__u32 num_samples;
+	__u32 rsv[3];
+};
+
+/**
+ * struct ptp_sys_offset_attrs - unified data structure for attrs ioctls
+ *
+ * Used by both PTP_SYS_OFFSET_EXTENDED_ATTRS and
+ * PTP_SYS_OFFSET_PRECISE_ATTRS. Userspace allocates space for
+ * request.num_samples entries in the timestamps array.
+ */
+struct ptp_sys_offset_attrs {
+	struct ptp_attrs_request request;
+	struct ptp_timestamp timestamps[];
+};
+
 struct ptp_clock_caps {
 	int max_adj;   /* Maximum frequency adjustment in parts per billon. */
 	int n_alarm;   /* Number of programmable alarms. */
@@ -106,7 +350,11 @@ struct ptp_clock_caps {
 	/* Whether the clock supports adjust phase */
 	int adjust_phase;
 	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
-	int rsv[11];       /* Reserved for future use. */
+	/* Whether the clock supports extended timestamps with attributes */
+	int extended_attrs;
+	/* Whether the clock supports precise cross-timestamps with attributes */
+	int precise_attrs;
+	int rsv[9];       /* Reserved for future use. */
 };
 
 struct ptp_extts_request {
@@ -252,6 +500,10 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED_CYCLES \
 	_IOWR(PTP_CLK_MAGIC, 22, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_PRECISE_ATTRS \
+	_IOWR(PTP_CLK_MAGIC, 23, struct ptp_sys_offset_attrs)
+#define PTP_SYS_OFFSET_EXTENDED_ATTRS \
+	_IOWR(PTP_CLK_MAGIC, 24, struct ptp_sys_offset_attrs)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occurred. */
-- 
2.47.3


