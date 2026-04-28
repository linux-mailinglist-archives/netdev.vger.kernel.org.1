Return-Path: <netdev+bounces-282000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH8LLNLq8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A9489B71
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDD83062506
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F033BBB1;
	Tue, 28 Apr 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="goQ2dP6j"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBC324B1F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395499; cv=none; b=QXWlO9ngHtigegGh/IAYbRKuqk7mNxIsbDYS8Opp9BK1y8h6kWPWkq07OQ8kHmW6RERYDhd8//XtPxwEmU1cy2+Z6Jht+UZNVNl3yW9maQ/cxcqpSgyIqpMC+slGqZZQMCqLOd2jwjZFO5DbXd5wZLpUm/3HKw+ziABwXQMGT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395499; c=relaxed/simple;
	bh=bTPPqmT7x+IW4gEmA3BTTneXavZZK2SJYTTUk/aaYxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVf8AkNCtDP6Bcl1UBCLlRIfrVzgUAPFWwM7CAA1BfDfjCwUABe1gpxf9L9z9AWo8IXY4Ettv5v0qMupMiFqWgl8/8FiDv2TMcUOMDGl/ntWxug9P2q9jZpSiBQ38+flzBLTdlQR/XbZjtIdF0Wn6M/DA0MAfddqMjtJLUR5EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=goQ2dP6j; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395497; x=1808931497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Q0EoOfI3lqauDDaKILIiBCa939Q2y58eWQqS8Ei5k8=;
  b=goQ2dP6j0PlPctHIWsAiLh8jL9hJu8dQx37gWB6GvND/BUT9hZk8AuST
   Jv3VOJltZpUqlMC0Ny/JKMtdWN/0XUWHk+H9jsWGlLmwLS/76l/ky5hhz
   d33VYOgXD+keOalLe7Jy6vrt+/1hzlvYFj8POHv1D3WRT3pr6cj0cU+pn
   Z9kcBzy38IooZD3S3xRMGoEQHwqVkruzqMwynkdxPHL6VoKD4Ln2r6N61
   Nk3sv8ev/vXSkn7sYG9TyoyiTgZ2YpjXzwQSmUZiArUtCXs8JEmhbF9BB
   h3Z+ZtIAW+z9apKw63kQ5wMdLP4tQVx+a7ECaa/FDLKWJyZXDSaSQaXTG
   Q==;
X-CSE-ConnectionGUID: 2n86Z9TXRoy7RjHn3ZEJ+g==
X-CSE-MsgGUID: FzprzwutQ4e7wkcNJEjktg==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="17913022"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:18581]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id e5a25666-c921-4878-9f9f-a69f87a4f19c; Tue, 28 Apr 2026 16:58:14 +0000 (UTC)
X-Farcaster-Flow-ID: e5a25666-c921-4878-9f9f-a69f87a4f19c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:12 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:08 +0000
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
 Ofir" <ofirt@amazon.com>
Subject: [PATCH net-next 0/8] ptp: Add PHC timestamp quality attributes
Date: Tue, 28 Apr 2026 16:54:18 +0000
Message-ID: <20260428165659.2811-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 3B6A9489B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282000-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

This series adds quality attributes to PTP Hardware Clock (PHC)
timestamps, allowing userspace to obtain error bound, clock status,
timescale, and raw counter values alongside timestamps in a single
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
the extended (multi-sample) and precise (cross-timestamp) paths,
with a shared attributes structure.

Design
------
This series introduces two new ioctls that extend the existing
extended and precise timestamp paths with per-timestamp quality
attributes: error bound (nanoseconds), clock synchronization
status, timescale, and raw hardware counter values.

A capability flag is added to ptp_clock_caps so userspace can
discover attributes support.

Patches 2-3 add testptp support for the new ioctls.

Patch 4 implements the attributes for ptp_vmclock, reporting
error bound, clock status, timescale, and raw counter values.

Patches 5-8 implement the attributes for the ENA driver,
reporting error bound from the device's PHC layer.

[1] https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon.com/

Arthur Kiyanovski (8):
  ptp: Add ioctls for PHC timestamps with quality attributes
  selftests/ptp: Extract print_system_timestamp helper in testptp
  selftests/ptp: Add testptp support for attributes ioctls
  ptp: ptp_vmclock: Implement attributes ioctls
  net: ena: PHC: Check return code before setting timestamp output
  net: ena: Update PHC admin interface for error bound support
  net: ena: Add error bound to PHC communication layer
  net: ena: Implement gettimexattrs64 callback for PTP attributes

 .../device_drivers/ethernet/amazon/ena.rst    |   2 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  17 +-
 drivers/net/ethernet/amazon/ena/ena_com.c     |  47 ++--
 drivers/net/ethernet/amazon/ena/ena_com.h     |   5 +-
 drivers/net/ethernet/amazon/ena/ena_debugfs.c |   3 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     |  67 +++++-
 drivers/ptp/ptp_chardev.c                     | 137 ++++++++++-
 drivers/ptp/ptp_clock.c                       |   4 +-
 drivers/ptp/ptp_vmclock.c                     | 195 +++++++++++++--
 include/linux/ptp_clock_kernel.h              |  30 +++
 include/uapi/linux/ptp_clock.h                | 225 +++++++++++++++++-
 tools/testing/selftests/ptp/testptp.c         | 175 ++++++++++----
 12 files changed, 799 insertions(+), 108 deletions(-)

-- 
2.47.3


