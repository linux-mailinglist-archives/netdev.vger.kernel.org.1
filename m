Return-Path: <netdev+bounces-307322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y79dOYiZVWqtqgAAu9opvQ
	(envelope-from <netdev+bounces-307322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:06:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CC750431
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:06:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=otIJdulI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307322-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FDB306EC8A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE236C0CD;
	Tue, 14 Jul 2026 02:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1D2E8DEB;
	Tue, 14 Jul 2026 02:04:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994646; cv=none; b=pC8asCpPaHt8PPfIiCa0WHpuLojOSgH9i+t6hV/RQ2E3uGn4Xcqh9M4nSrp/mp7an+17vIX8CQCYjMVNSUyirXdbL4h5FrNSY6MhE4vjaKRd8NeSTZqjpl2aJ5X6GlXlr93IMxYaBmT0aXVZ7WCYPOtvXVqnC53imlRBsk13UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994646; c=relaxed/simple;
	bh=W4xS7u8aIfCDP9Xdp+2fPuHvD9e/O6vm2IroUcHwpq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D02GWaNv+67vnS/mUrB8t3D/SJJyXPV8lZu6MjkzQmP8NRU4rKKB4txFa3P2kzbdkU415s7qTXAjZ6TB0xquGBg5gZEOaDcr1z+lCQ5fYUba6jzG32B0nR0LpXFMdqL6og8MoJRKFVlyD79GBPriAWnCMLfLvU1bxsM21G7OGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=otIJdulI; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783994644; x=1815530644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fIBN2F56Wu25/m+SUVfW47wZOlGL1b8hDI5bp5VSEUw=;
  b=otIJdulIuzYNgz1m2bslSB0Qz9Us3+arScgsanLt49C6HKiNY1o9D0Vr
   w58Pt314akWGe8RG50AK3dm4Yn3kbu7MJgJ/54YvUvzevvWqdPzJGygfm
   uStUXE7rmb1RfnPFU2A57wCDYJwLj3lkVzabPRrwnGSDhynqu6MD4toYf
   LlQMqnS7WyjEDa/h+q9uNR1biF+IPQuxIl5+aBo7E7jmuvh8TZaLZTWVD
   98bDmG2NfpS8smu+0Z1fEMjpjSnaTf3cXvXvxcUcWuJ/H8KLVI6pyLX2b
   MKLI+uEPkjJPZl2vmUCiaV1C3kQoK/h5yFXoM+EXHhrgkvLBia17mWtSg
   A==;
X-CSE-ConnectionGUID: NkwsRLxiSy+uT1KTxPwSvg==
X-CSE-MsgGUID: dbGt8I7mSvi4zKyuezDIPQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23627315"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:04:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:25871]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id e599d138-fc55-4611-b910-4e80013aec45; Tue, 14 Jul 2026 02:04:01 +0000 (UTC)
X-Farcaster-Flow-ID: e599d138-fc55-4611-b910-4e80013aec45
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:04:01 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 02:03:56 +0000
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
Subject: [PATCH v4 net-next 0/7] ptp: Add PHC timestamp quality attributes
Date: Tue, 14 Jul 2026 02:03:01 +0000
Message-ID: <20260714020340.25014-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
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
	TAGGED_FROM(0.00)[bounces-307322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:akiyano@amazon.com,m:richardcochran@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw2@infradead.org,m:tglx@linutronix.de,m:mlichvar@redhat.com,m:andrew+netdev@lunn.ch,m:guwen@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:dwmw@amazon.com,m:ysarna@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:amitbern@amazon.com,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 832CC750431

This series adds quality attributes to PTP Hardware Clock (PHC)
timestamps, allowing userspace to obtain error bound, clock status,
timescale, and system counter values alongside timestamps in a single
call.

Motivation
----------
The existing PTP APIs return timestamps without any indication of
their quality. Applications that need clock accuracy and
synchronization status commonly rely on external tools such as
ptp4l, which implement synchronization logic and can export their
measurement of clock accuracy. For managed PHC devices — such as
the ENA network adapter, whose clock is synchronized by the device
without userspace involvement — these tools are not available, and
the existing APIs lack a way to report quality metrics to consumers
of time.

This was previously proposed as an RFC [1] with a single ioctl.
Based on community feedback, the design was reworked to cover both
the extended (multi-sample) and precise (cross-timestamp) paths.

Design
------
The UAPI was redesigned based on Thomas Gleixner's proposal [2]:

- A unified data structure (struct ptp_sys_offset_attrs) is used
  for both extended and precise ioctls.

- A u32 valid bitmask in struct ptp_clock_attrs indicates which
  attributes are populated, replacing sentinel values. Drivers
  set only the bits for attributes they provide.

- System counter values (cycles + counter_id) are carried in
  struct ptp_sys_time alongside each system timestamp. These are
  populated by the timekeeping core cross-timestamp infrastructure,
  which is now merged in net-next [3] — drivers do not fill them.
  This series therefore applies directly to net-next with no
  out-of-tree dependency.

- Graceful degradation: the attrs ioctls work even on devices
  without attrs callbacks, falling back to gettimex64 /
  getcrosststamp and returning attrs.valid = 0.

A capability flag is added to ptp_clock_caps so userspace can
discover attributes support.

Patches 2-3 add testptp support for the new ioctls.

Patch 4 implements the attributes for ptp_vmclock, reporting
error bound, clock status, and timescale.

Patches 5-7 implement the attributes for the ENA driver,
reporting error bound from the device's PHC layer.

v4:
- Complete UAPI redesign per Thomas Gleixner's proposal [2]:
  unified data structure with u32 valid bitmask, system counter
  in ptp_sys_time (populated by core, not drivers), graceful
  degradation for devices without attrs callbacks. (Thomas Gleixner,
  David Woodhouse)
- Counter values moved from driver attrs callback to timekeeping
  core infrastructure — drivers no longer set counter_id or
  counter_value.
- Flexible array member for timestamps[] (kernel bounds the copy,
  userspace allocates for num_samples requested).
- Drop separate ptp_clock_attributes kernel struct — driver
  callbacks fill the UAPI ptp_clock_attrs directly.

v3:
- Remove patch 5/8 from v2 (return-code bugfix) — sent separately
  as [PATCH net] to the net tree.
- Zero-initialize struct ptp_clock_attributes in PTP core ioctl
  handlers to prevent stack leak of unset fields. (Simon Horman,
  sashiko)
- ptp_vmclock: validate counter_period_shift < 128 to prevent
  undefined behavior on untrusted hypervisor input. (sashiko)
- ptp_vmclock: add overflow check on err_hi * NSEC_PER_SEC to
  prevent silent wraparound producing erroneously small error
  bound. (sashiko)
- ptp_vmclock: report PTP_TIMESCALE_TAI after tai_adjust() to
  avoid timescale mismatch. (sashiko)
- ENA: set counter_id = 0, counter_value = 0 in gettimexattrs64
  for defense-in-depth. (sashiko)

v2:
- Fix build bisectability: move ena_com.c consumer updates into
  patch 6/8 and ena_phc.c caller update into patch 7/8 so each
  patch compiles independently.
- Add missing Cc for Amit Bernstein (co-author of ENA patches).

[1] https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/
[2] https://lore.kernel.org/all/87se7ht25o.ffs@tglx/
[3] https://lore.kernel.org/all/20260526165826.392227559@kernel.org/

Arthur Kiyanovski (7):
  ptp: Add ioctls for PHC timestamps with quality attributes
  selftests/ptp: Extract print_system_timestamp helper in testptp
  selftests/ptp: Add testptp support for attributes ioctls
  ptp: ptp_vmclock: Implement attributes ioctls
  net: ena: Update PHC admin interface for error bound support
  net: ena: Add error bound to PHC communication layer
  net: ena: Implement gettimexattrs64 callback for PTP attributes

 .../device_drivers/ethernet/amazon/ena.rst    |   2 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  17 +-
 drivers/net/ethernet/amazon/ena/ena_com.c     |  51 ++--
 drivers/net/ethernet/amazon/ena/ena_com.h     |   5 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |   3 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  61 ++++-
 drivers/ptp/ptp_chardev.c                     | 166 +++++++++++-
 drivers/ptp/ptp_clock.c                       |   4 +-
 drivers/ptp/ptp_vmclock.c                     | 197 ++++++++++++--
 include/linux/ptp_clock_kernel.h              |  30 +++
 include/uapi/linux/ptp_clock.h                | 254 +++++++++++++++++-
 tools/testing/selftests/ptp/testptp.c         | 181 ++++++++++---
 12 files changed, 862 insertions(+), 109 deletions(-)

-- 
2.47.3


