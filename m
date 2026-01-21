Return-Path: <netdev+bounces-251933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGgaFPDqcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:04:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E158E72
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 465917632EB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A363480967;
	Wed, 21 Jan 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tdy0eYmE"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71998423A64;
	Wed, 21 Jan 2026 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006062; cv=none; b=j0JKPfrGBuQjIgHFLSN5CpItJ/oz4ucKDWS8QHKQT5RW1l4BNE8tfj9NeQPWqtfXgCg1Il0X4rgfKUAUduMv/57fRAqcHRiR3/AcCkG2gBngDwNNjYt6GxDOzZ+o8mA6UBS0rY8Cc/1B9nZYVJhe5jOpwsXFC6w0UhVHpcRsp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006062; c=relaxed/simple;
	bh=MPUpUJgzzfHudJXEi5vg0C4okW8qVV8H4BssMKuJ9vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0P1dZKG4e0IImHZ8vSGm7MEh5XVbcWAGDkY+JHKsaiU77CLUj0/fF87xRx6+zWfrcn++4nepn9avyG2Be6O1Jwwu0h+ehPVX1zq2fFTTaB/MwqsKSD48nbjuuGt9h8QQ/0kkXe5z0lED1H8Wm26P7ZsTViHIuWXA2K5gIspqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tdy0eYmE; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006060; x=1800542060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKwikhUEneq7kTC3ndykcYJektlKHtMVROcOvRNkC0s=;
  b=Tdy0eYmEUQzNp7qTRXK22cp009URlr2IyL4P63bYbhMwlYu1Q93geW1c
   tVkjTfSuD/nGjaoZogKnpSGnABQTF2wq7wDRLaRuzgY1pbzkWme+cUNpq
   xT7m6KZeKkqlEoZkeLgco53VZMgksPihjB6mQUSTgn96Z6IVlkpViwV96
   ENWzZz3XifCZ6BJJCX15QeQke5cDZadbseQQy0+h6xvNJdnGHQ0Y2Jtf1
   b0+AHu0P6Ibtw3QNWcBfRLYZ0m6SbfuWecDFOEit61heeTchyCk2jWtod
   5e47lo+ggEkSoNpy4PP84hVD4qA8GW2jydif+mcGG1StRNaEW+3YwcL/l
   Q==;
X-CSE-ConnectionGUID: W+lsB/mDRYGqtppXNXnRFQ==
X-CSE-MsgGUID: Opv0/6nQRmOBvmtnU6E1jw==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11089716"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:19109]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.11:2525] with esmtp (Farcaster)
 id 52e7a185-456f-449e-b682-b71aedfc8ed8; Wed, 21 Jan 2026 14:34:17 +0000 (UTC)
X-Farcaster-Flow-ID: 52e7a185-456f-449e-b682-b71aedfc8ed8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:17 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:14 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <dwmw2@infradead.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.co.uk>
Subject: [PATCH v6 1/7] ptp: vmclock: add vm generation counter
Date: Wed, 21 Jan 2026 14:33:38 +0000
Message-ID: <20260121143402.3092-2-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121143402.3092-1-itazur@amazon.com>
References: <20260121143402.3092-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-5.96 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251933-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,infradead.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[amazon.com,quarantine];
	DKIM_TRACE(0.00)[amazon.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amazon.es:email];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E68E158E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Babis Chalios" <bchalios@amazon.es>

Similar to live migration, loading a VM from some saved state (aka
snapshot) is also an event that calls for clock adjustments in the
guest. However, guests might want to take more actions as a response to
such events, e.g. as discarding UUIDs, resetting network connections,
reseeding entropy pools, etc. These are actions that guests don't
typically take during live migration, so add a new field in the
vmclock_abi called vm_generation_counter which informs the guest about
such events.

Hypervisor advertises support for vm_generation_counter through the
VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT flag. Users need to check the
presence of this bit in vmclock_abi flags field before using this flag.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/uapi/linux/vmclock-abi.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-abi.h
index 2d99b29ac44a..937fe00e4f33 100644
--- a/include/uapi/linux/vmclock-abi.h
+++ b/include/uapi/linux/vmclock-abi.h
@@ -115,6 +115,12 @@ struct vmclock_abi {
 	 * bit again after the update, using the about-to-be-valid fields.
 	 */
 #define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
+	/*
+	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will
+	 * bump the vm_generation_counter field every time the guest is
+	 * loaded from some save state (restored from a snapshot).
+	 */
+#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)
 
 	__u8 pad[2];
 	__u8 clock_status;
@@ -177,6 +183,15 @@ struct vmclock_abi {
 	__le64 time_frac_sec;		/* Units of 1/2^64 of a second */
 	__le64 time_esterror_nanosec;
 	__le64 time_maxerror_nanosec;
+
+	/*
+	 * This field changes to another non-repeating value when the guest
+	 * has been loaded from a snapshot. In addition to handling a
+	 * disruption in time (which will also be signalled through the
+	 * disruption_marker field), a guest may wish to discard UUIDs,
+	 * reset network connections, reseed entropy, etc.
+	 */
+	__le64 vm_generation_counter;
 };
 
 #endif /*  __VMCLOCK_ABI_H__ */
-- 
2.47.3


