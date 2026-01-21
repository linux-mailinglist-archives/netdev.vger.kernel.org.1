Return-Path: <netdev+bounces-251932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LWVDIP1cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:49:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1F59754
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 728447626DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F23BB9EF;
	Wed, 21 Jan 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dSBBJYVi"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91538BF76;
	Wed, 21 Jan 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006056; cv=none; b=JT+sPtkGH6sXkPFI61Pk2gHTpd/x8tqNgA1fN80gxrRBRBeoW/UOdKeAU69KZdPEZ11XUCZBrFLEYCvvatxpVd0qOHPrC5zoxiUZgZcCCjy5ghiH8PGzuC9o2kYEZ/ycjmb+lAs3PkHpx5ZjYihDn//WuMeicRzzA8k0DdyJ2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006056; c=relaxed/simple;
	bh=UkybVa4iglQJevh4tjQXjAarTyAQN26qkiccOPSAoFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d1G7MjerIDYrl5ZBBYo0KTWZWuO0+BOXFrxSsZivpHvTeoDdvq2Y5ubgwBrL3D9xPYOdhJK8Nc6bRpj0SfEiSOtwD46fnGThq1HN1NSjhaM+U54OlMzaeXiwZe6r1gAmemMit4vlJCay5KbzHf3EaU3uN3hXh4lVLfXT0dZjJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dSBBJYVi; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006054; x=1800542054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ELHgxPhylfHIGisXjkEpjfj6a2UfPL6W+WX8Ou3bPmM=;
  b=dSBBJYViic3UJaPgRxPsEVsJWne9kinwP3J7ljoq161wzqWPYpZpJ5pT
   WSyybnOEmJnc9w0eT36gsw2NHZtahNwUGl+juvAlHzXk19alRyMqcrzUE
   LBOwSkNR/0mSuuN3z6Qi1Lgig/Lkn5QXt+colDCJkAKt3FZOHTgmPzTpX
   gdo5nTpQYage9/UbCWwS5yHOYyaPTBMsf3xt9Lpfs5P/b/SVdZqho9yPR
   wSjaU/QDYsbAcX0+7KguYbBhrjh5JnrklXWR6z9mBHrp28d0VUY/FQGiR
   7+fsOZB+tUwWeoCgwZgIbTa11PoiaXKDwLcWD4E1aMtaTjwYiqahek8fP
   w==;
X-CSE-ConnectionGUID: EAIQxHMeRLujC6TPSY48pQ==
X-CSE-MsgGUID: gGg1lajBR7eKhiKcKl05Eg==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11118581"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:25172]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.231:2525] with esmtp (Farcaster)
 id 8368d7a3-840b-441c-8759-77408f989319; Wed, 21 Jan 2026 14:34:10 +0000 (UTC)
X-Farcaster-Flow-ID: 8368d7a3-840b-441c-8759-77408f989319
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:10 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:07 +0000
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
Subject: [PATCH v6 0/7] ptp: vmclock: Add VM generation counter and ACPI notification
Date: Wed, 21 Jan 2026 14:33:37 +0000
Message-ID: <20260121143402.3092-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
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
	TAGGED_FROM(0.00)[bounces-251932-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,checkpatch.pl:url];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBE1F59754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similarly to live migration, starting a VM from some serialized state
(aka snapshot) is an event which calls for adjusting guest clocks, hence
a hypervisor should increase the disruption_marker before resuming the
VM vCPUs, letting the guest know.

However, loading a snapshot, is slightly different than live migration,
especially since we can start multiple VMs from the same serialized
state. Apart from adjusting clocks, the guest needs to take additional
action during such events, e.g. recreate UUIDs, reset network
adapters/connections, reseed entropy pools, etc. These actions are not
necessary during live migration. This calls for a differentiation
between the two triggering events.

We differentiate between the two events via an extra field in the
vmclock_abi, called vm_generation_counter. Whereas hypervisors should
increase the disruption marker in both cases, they should only increase
vm_generation_counter when a snapshot is loaded in a VM (not during live
migration).

Additionally, we attach an ACPI notification to VMClock. Implementing
the notification is optional for the device. VMClock device will declare
that it implements the notification by setting
VMCLOCK_FLAG_NOTIFICATION_PRESENT bit in vmclock_abi flags. Hypervisors
that implement the notification must send an ACPI notification every
time seq_count changes to an even number. The driver will propagate
these notifications to userspace via the poll() interface.

Changes:

* RFC -> v1:
  - Made the notification support optional. Hypervisor needs to
    advertise support for the notification via a flag in vmclock_abi.
    Subsequently, poll() will return POLLHUP when the feature is not
    supported, to avoid having userspace blocking indefinitely waiting
    for events that won't arrive
  - Reworded the comment around vm_generation_counter field to avoid
    speaking about "jumping forward in time".
* v1 -> v2:
  - Correctly handle failures when calling vmclock_setup_notification to
    setup notifications.
  - Use atomic_t for fst->seq and handle the case of concurrent
    read()/poll() accesses.
  - Initialize fst->seq to 0 rather than what is currently stored in the
    shared page. This is to avoid reading odd numbers.
  - Add DT bindings similar to existing VMGenID ones.
* v2 -> v3:
  - Include missing header file and drop unused variables in PATH 2/4.
  - Include missing Reviewed-by in PATCH 1/4.
  - Fix DT node name to be generic (s/vmclock/ptp).
  - Include missing maintainers.
* v3 -> v4:
  - Added bindings file as maintained by David as part for PTP VMCLOCK
    SUPPORT.
  - Use le64_to_cpu() to access clk->flags.
  - Reference public specification.
  - Pass struct vmclock_state * in the of IRQ handler
  - Included three new patches from David:
    * Making ACPI optional for the driver.
    * Adding "VMCLOCK" to ACPI match.
    * Return TAI instead of UTC.
* v4 -> v5:
  - Use IF_ENABLED instead of #ifdef
  - Use reverse christmas tree order in variable declaration
  - Fix empty changelog
* v5 -> v6:
  - Fix blank line CHECKs reported by checkpatch.pl

Chalios, Babis (2):
  ptp: vmclock: add vm generation counter
  ptp: vmclock: support device notifications

David Woodhouse (5):
  dt-bindings: ptp: Add amazon,vmclock
  ptp: ptp_vmclock: Add device tree support
  ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
  ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
  ptp: ptp_vmclock: return TAI not UTC

 .../bindings/ptp/amazon,vmclock.yaml          |  46 ++++
 MAINTAINERS                                   |   1 +
 drivers/ptp/Kconfig                           |   2 +-
 drivers/ptp/ptp_vmclock.c                     | 196 ++++++++++++++++--
 include/uapi/linux/vmclock-abi.h              |  20 ++
 5 files changed, 251 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml

-- 
2.47.3


