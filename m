Return-Path: <netdev+bounces-307326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/FtNOSZVWrCqgAAu9opvQ
	(envelope-from <netdev+bounces-307326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6FA75045F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=GKYBX9+T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307326-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E418030037C5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D1367285;
	Tue, 14 Jul 2026 02:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88B360745;
	Tue, 14 Jul 2026 02:04:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994675; cv=none; b=HsKaVLXYKj74fvW0J1p3h6sVFg04P/QdIyZfCMjLsuel3hAfHNXP3YiFhrCxIu1/exsbZ9q5TDhAjE4C7lIiiLIw3U1Ave3KzsZUZRFu7uLnnSKfWeKXMX6+CtHW1SzWVLku9KhTI9bFQ6HqjEwthj0c/A9ndBReqfU/1CbANk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994675; c=relaxed/simple;
	bh=0gZ+dTHFKFmv1ul5vka6o638pJ2ALW3kiQv5bsZRT78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8wgSys7pkwJuAIKbI76nW+HnY0weUF/2TSB3X50hNqEVr8QTByY1dSWkGwIh2YkdlvOe7hlfelmG5HcfyyXWym0TjE/CZDtnpF7YrlAnZixSLlcmjCNeIa7iymps8mKP2W6JbovSfF/oz0VzWPCOZoiwSsgvPW5q1MJE6kPc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GKYBX9+T; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994673; x=1815530673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S79GI6iOtPnRI+y3FioZBpKmKkt5t32X6Gac9VYEvlY=;
  b=GKYBX9+TXpGv8RCws+QCT/riqhTmbek+L8uACNZcD9pN5Pz5kpCBki+u
   hpUAFRDk/0hRIXNoxlHVoDLq7dz+h705CukVj/I7Z/VmoxgTsV086AWqB
   xaSt0PhhcB48I7Mes+Sey/3UZqLBVNVX2ODP46731KrNuow8dVJd2J3M2
   6IP+TxqfBRWJ6FmTAsxUo4iWBQoNPiivlh8uydEr421nlb3v7kfDJduHs
   hs02saeizpWl7jP+PYPykgCnt7d1alfszoI/AtC2xylEg1FLyXz9VZegK
   HUfuuN9BX0lBV3rWm4Ca1RRH4uphK9SQTBTktx8jUiLX8Y5jtyRG2BAaB
   g==;
X-CSE-ConnectionGUID: q2EFlYPXRRiHzfoFAb6aMQ==
X-CSE-MsgGUID: r+71RSJwQFmNUWHhPjmcuQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23499537"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3497]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525] with esmtp (Farcaster)
 id 1991f950-38a9-4a61-99f7-c68d937732ca; Tue, 14 Jul 2026 02:04:30 +0000 (UTC)
X-Farcaster-Flow-ID: 1991f950-38a9-4a61-99f7-c68d937732ca
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:30 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:25 +0000
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
Subject: [PATCH v4 net-next 4/7] ptp: ptp_vmclock: Implement attributes ioctls
Date: Tue, 14 Jul 2026 02:03:05 +0000
Message-ID: <20260714020340.25014-5-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714020340.25014-1-akiyano@amazon.com>
References: <20260714020340.25014-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:akiyano@amazon.com,m:richardcochran@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw2@infradead.org,m:tglx@linutronix.de,m:mlichvar@redhat.com,m:andrew+netdev@lunn.ch,m:guwen@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:dwmw@amazon.com,m:ysarna@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:amitbern@amazon.com,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[amazon.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,lwn.net,linuxfoundation.org,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6FA75045F

Implement the gettimexattrs64 and getcrosststampattrs callbacks in the
ptp_vmclock driver to provide clock quality attributes through the new
PTP_SYS_OFFSET_EXTENDED_ATTRS and PTP_SYS_OFFSET_PRECISE_ATTRS ioctls.

The ptp_vmclock device exposes:
- error_bound: Derived from time_maxerror_nanosec, accumulated with
  counter frequency error (counter_period_maxerror_rate_frac_sec) over
  elapsed counter ticks
- clock_status: Mapped from the device's clock_status field
- timescale: Always reports TAI (UTC sources are converted by tai_adjust()
  before the attributes are populated)

The legacy ioctls return -EINVAL when clock_status is UNRELIABLE since
they have no way to communicate clock state to userspace. The attrs
ioctls have a status field for this purpose, so they treat UNRELIABLE
as success and let userspace check the status field.

To avoid a race where the hypervisor could update clock_status between
the timestamp call and the UNRELIABLE check, the clock state is captured
inside the seq_count loop for a consistent snapshot with the timestamp.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/ptp/ptp_vmclock.c | 197 ++++++++++++++++++++++++++++++++++----
 1 file changed, 181 insertions(+), 16 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index eebdcd5ebc08..16b728c0f591 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -53,6 +53,17 @@ struct vmclock_state {
 	char *name;
 };
 
+/**
+ * struct vmclock_crosststamp_ctx - context for get_device_system_crosststamp()
+ * @st: vmclock device state
+ * @attrs: optional output for PTP clock attributes, populated inside the
+ *         seq_count loop for a consistent snapshot with the timestamp
+ */
+struct vmclock_crosststamp_ctx {
+	struct vmclock_state *st;
+	struct ptp_clock_attrs *attrs;
+};
+
 #define VMCLOCK_MAX_WAIT ms_to_ktime(100)
 
 /* Require at least the flags field to be present. All else can be optional. */
@@ -95,13 +106,111 @@ static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 	return false;
 }
 
+static uint8_t vmclock_get_ptp_timescale(uint8_t vmclock_time_type)
+{
+	switch (vmclock_time_type) {
+	case VMCLOCK_TIME_UTC:
+		return PTP_TIMESCALE_UTC;
+	case VMCLOCK_TIME_TAI:
+		return PTP_TIMESCALE_TAI;
+	case VMCLOCK_TIME_MONOTONIC:
+		return PTP_TIMESCALE_MONOTONIC;
+	default:
+		return PTP_TIMESCALE_UNKNOWN;
+	}
+}
+
+static uint8_t vmclock_get_ptp_status(uint8_t vmclock_status)
+{
+	switch (vmclock_status) {
+	case VMCLOCK_STATUS_UNKNOWN:
+		return PTP_CLOCK_STATUS_UNKNOWN;
+	case VMCLOCK_STATUS_INITIALIZING:
+		return PTP_CLOCK_STATUS_INITIALIZING;
+	case VMCLOCK_STATUS_SYNCHRONIZED:
+		return PTP_CLOCK_STATUS_SYNCED;
+	case VMCLOCK_STATUS_FREERUNNING:
+		return PTP_CLOCK_STATUS_FREE_RUNNING;
+	case VMCLOCK_STATUS_UNRELIABLE:
+		return PTP_CLOCK_STATUS_UNRELIABLE;
+	default:
+		return PTP_CLOCK_STATUS_UNKNOWN;
+	}
+}
+
+static void vmclock_populate_ptp_attributes(struct vmclock_state *st,
+					    struct ptp_clock_attrs *att,
+					    uint64_t delta)
+{
+	uint64_t maxerror_ns = UINT_MAX;
+
+	if (!att)
+		return;
+
+	/* Only calculate if the base error is flagged as valid
+	 * by the hypervisor.
+	 */
+	if (VMCLOCK_FIELD_PRESENT(st->clk, time_maxerror_nanosec) &&
+	    (le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_TIME_MAXERROR_VALID)) {
+		maxerror_ns = le64_to_cpu(st->clk->time_maxerror_nanosec);
+
+		/* If frequency error is also valid, accumulate it
+		 * over the delta.
+		 */
+		if (VMCLOCK_FIELD_PRESENT(st->clk, counter_period_maxerror_rate_frac_sec) &&
+		    (le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_PERIOD_MAXERROR_VALID)) {
+			uint64_t maxerror_rate, err_hi, err_frac, growth_ns;
+
+			if (st->clk->counter_period_shift >= 128) {
+				maxerror_ns = U64_MAX;
+				goto saturate;
+			}
+
+			maxerror_rate = le64_to_cpu(st->clk->counter_period_maxerror_rate_frac_sec);
+			err_frac = mul_u64_u64_shr_add_u64(&err_hi, delta,
+							   maxerror_rate,
+							   st->clk->counter_period_shift,
+							   0);
+
+			if (err_hi >= U64_MAX / NSEC_PER_SEC) {
+				maxerror_ns = U64_MAX;
+				goto saturate;
+			}
+
+			growth_ns = (err_hi * NSEC_PER_SEC) +
+				    mul_u64_u64_shr(err_frac, NSEC_PER_SEC, 64);
+
+			/* Guard against overflow */
+			if (U64_MAX - growth_ns < maxerror_ns)
+				maxerror_ns = U64_MAX;
+			else
+				maxerror_ns += growth_ns;
+		}
+	}
+
+saturate:
+	/* PTP UAPI error_bound is 32-bit nanoseconds */
+	att->error_bound = (maxerror_ns > UINT_MAX) ?
+		UINT_MAX : (uint32_t)maxerror_ns;
+	att->valid |= PTP_ATTRS_VALID_ERROR_BOUND;
+	att->timescale = vmclock_get_ptp_timescale(st->clk->time_type);
+	/* tai_adjust() already converted UTC to TAI before we're called */
+	if (st->clk->time_type == VMCLOCK_TIME_UTC)
+		att->timescale = PTP_TIMESCALE_TAI;
+	att->valid |= PTP_ATTRS_VALID_TIMESCALE;
+	att->status = vmclock_get_ptp_status(st->clk->clock_status);
+	att->valid |= PTP_ATTRS_VALID_STATUS;
+}
+
 static int vmclock_get_crosststamp(struct vmclock_state *st,
 				   struct ptp_system_timestamp *sts,
 				   struct system_counterval_t *system_counter,
-				   struct timespec64 *tspec)
+				   struct timespec64 *tspec,
+				   struct ptp_clock_attrs *attrs)
 {
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
 	uint64_t cycle, delta, seq, frac_sec;
+	uint8_t clock_status = VMCLOCK_STATUS_UNKNOWN;
 
 #ifdef CONFIG_X86
 	/*
@@ -121,9 +230,6 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 		 */
 		virt_rmb();
 
-		if (st->clk->clock_status == VMCLOCK_STATUS_UNRELIABLE)
-			return -EINVAL;
-
 		/*
 		 * When invoked for gettimex64(), fill in the pre/post system
 		 * times. The simple case is when system time is based on the
@@ -164,6 +270,17 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 		if (!tai_adjust(st->clk, &tspec->tv_sec))
 			return -EINVAL;
 
+		/*
+		 * Capture clock state inside the seq_count loop for a
+		 * consistent snapshot with the timestamp. The attrs path
+		 * reports it to userspace via the status field; the legacy
+		 * path saves it for the UNRELIABLE check after the loop.
+		 */
+		if (attrs)
+			vmclock_populate_ptp_attributes(st, attrs, delta);
+		else
+			clock_status = st->clk->clock_status;
+
 		/*
 		 * This pairs with a write barrier in the hypervisor
 		 * which populates this structure.
@@ -181,6 +298,17 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 		system_counter->cs_id = st->cs_id;
 	}
 
+	/*
+	 * If attrs is set, attributes were already populated inside the
+	 * seq_count loop. Return success even for UNRELIABLE — the attrs
+	 * ioctl can report the status to userspace.
+	 */
+	if (attrs)
+		return 0;
+
+	if (clock_status == VMCLOCK_STATUS_UNRELIABLE)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -193,7 +321,8 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 					    struct ptp_system_timestamp *sts,
 					    struct system_counterval_t *system_counter,
-					    struct timespec64 *tspec)
+					    struct timespec64 *tspec,
+					    struct ptp_clock_attrs *attrs)
 {
 	struct pvclock_vcpu_time_info *pvti = this_cpu_pvti();
 	unsigned int pvti_ver;
@@ -204,7 +333,8 @@ static int vmclock_get_crosststamp_kvmclock(struct vmclock_state *st,
 	do {
 		pvti_ver = pvclock_read_begin(pvti);
 
-		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec);
+		ret = vmclock_get_crosststamp(st, sts, system_counter, tspec,
+					      attrs);
 		if (ret)
 			break;
 
@@ -233,17 +363,19 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 				   struct system_counterval_t *system_counter,
 				   void *ctx)
 {
-	struct vmclock_state *st = ctx;
+	struct vmclock_crosststamp_ctx *vctx = ctx;
+	struct vmclock_state *st = vctx->st;
 	struct timespec64 tspec;
 	int ret;
 
 #ifdef SUPPORT_KVMCLOCK
 	if (READ_ONCE(st->sys_cs_id) == CSID_X86_KVM_CLK)
 		ret = vmclock_get_crosststamp_kvmclock(st, NULL, system_counter,
-						       &tspec);
+						       &tspec, vctx->attrs);
 	else
 #endif
-		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec);
+		ret = vmclock_get_crosststamp(st, NULL, system_counter, &tspec,
+					      vctx->attrs);
 
 	if (!ret)
 		*device_time = timespec64_to_ktime(tspec);
@@ -251,12 +383,11 @@ static int ptp_vmclock_get_time_fn(ktime_t *device_time,
 	return ret;
 }
 
-static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
-				      struct system_device_crosststamp *xtstamp)
+static int ptp_vmclock_do_getcrosststamp(struct vmclock_crosststamp_ctx *vctx,
+					 struct system_device_crosststamp *xtstamp)
 {
-	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
-						ptp_clock_info);
-	int ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn, st,
+	struct vmclock_state *st = vctx->st;
+	int ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn, vctx,
 						NULL, xtstamp);
 #ifdef SUPPORT_KVMCLOCK
 	/*
@@ -273,13 +404,23 @@ static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
 		    systime_snapshot.cs_id == CSID_X86_KVM_CLK) {
 			WRITE_ONCE(st->sys_cs_id, systime_snapshot.cs_id);
 			ret = get_device_system_crosststamp(ptp_vmclock_get_time_fn,
-							    st, NULL, xtstamp);
+							    vctx, NULL, xtstamp);
 		}
 	}
 #endif
 	return ret;
 }
 
+static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
+				      struct system_device_crosststamp *xtstamp)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+	struct vmclock_crosststamp_ctx vctx = { .st = st };
+
+	return ptp_vmclock_do_getcrosststamp(&vctx, xtstamp);
+}
+
 /*
  * PTP clock operations
  */
@@ -306,7 +447,29 @@ static int ptp_vmclock_gettimex(struct ptp_clock_info *ptp, struct timespec64 *t
 	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
 						ptp_clock_info);
 
-	return vmclock_get_crosststamp(st, sts, NULL, ts);
+	return vmclock_get_crosststamp(st, sts, NULL, ts, NULL);
+}
+
+static int ptp_vmclock_gettimexattrs(struct ptp_clock_info *ptp,
+				     struct timespec64 *ts,
+				     struct ptp_system_timestamp *sts,
+				     struct ptp_clock_attrs *att)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+
+	return vmclock_get_crosststamp(st, sts, NULL, ts, att);
+}
+
+static int ptp_vmclock_getcrosststampattrs(struct ptp_clock_info *ptp,
+					   struct system_device_crosststamp *xtstamp,
+					   struct ptp_clock_attrs *att)
+{
+	struct vmclock_state *st = container_of(ptp, struct vmclock_state,
+						ptp_clock_info);
+	struct vmclock_crosststamp_ctx vctx = { .st = st, .attrs = att };
+
+	return ptp_vmclock_do_getcrosststamp(&vctx, xtstamp);
 }
 
 static int ptp_vmclock_enable(struct ptp_clock_info *ptp,
@@ -324,9 +487,11 @@ static const struct ptp_clock_info ptp_vmclock_info = {
 	.adjfine	= ptp_vmclock_adjfine,
 	.adjtime	= ptp_vmclock_adjtime,
 	.gettimex64	= ptp_vmclock_gettimex,
+	.gettimexattrs64 = ptp_vmclock_gettimexattrs,
 	.settime64	= ptp_vmclock_settime,
 	.enable		= ptp_vmclock_enable,
 	.getcrosststamp = ptp_vmclock_getcrosststamp,
+	.getcrosststampattrs = ptp_vmclock_getcrosststampattrs,
 };
 
 static struct ptp_clock *vmclock_ptp_register(struct device *dev,
-- 
2.47.3


