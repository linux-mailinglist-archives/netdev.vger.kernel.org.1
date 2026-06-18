Return-Path: <netdev+bounces-300290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /4QbNjxQM2qj/QUAu9opvQ
	(envelope-from <netdev+bounces-300290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D67169D152
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Xyq9H2wc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300290-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F293046D52
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75E2E22BD;
	Thu, 18 Jun 2026 01:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91382D838E;
	Thu, 18 Jun 2026 01:53:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747637; cv=none; b=PgmEwMAQMYseZFfRxaCx/rXjeq5jHptzb2SM4iTrd0UxMXZBsr87WrR/igj1wlVBtsefA4totJnco/3kuQMXJ1i64D+a7m9UHfQwUZntRVKH5o5Rivguox0DdwOgiCgN8k0pOwSPtWPLxea706iYHTF/tLeXHfZKT3LZOqq42v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747637; c=relaxed/simple;
	bh=YUW6tVOCa4XAecpU0Ypp6OD93mCldfX+YcUxEo/S3+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dOBEtkxhJgwYg4lzbvJwlljnSsn4vKiRikLAC4elPUuc/U2LDGLErpwCTkWRUc8gtc0iacm66DK81IbJAqFjHd52sNZS8rAXl03vLhVRu2bO2wT11elQgrEWpNOUF84xGn17LoO6bMGPlR262CIn8cEiM+wSw1uY4swGlwz95Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Xyq9H2wc; arc=none smtp.client-ip=173.37.86.75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11582; q=dns/txt;
  s=iport01; t=1781747635; x=1782957235;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dztMfc64pEQ8p6lIXooINFMF+gI9XFL/8xKjhMjaNMI=;
  b=Xyq9H2wc4TpXOSntzhEGVIaMtAD+wk7IFYXwnT10AGEoqNxIsV4sGTAr
   AAzBmzea6EBcNp03qTyOc7b5J5zbq7enjmV5WTXKrk0tUBd1hb9PeS/Ky
   ycBbC9+t4z1R1ZX3hkdptw+1uLF8FRPByOEnl42e/79HdfG4HUjXnWVdQ
   HfYSqd/F/BeVP2WHOIw8r3o//JusWZ+YcfspdmeIACS3nkVbs9VObchjw
   5xIzTIT3PrN/X7Hh3o4zkdJfumNvPZ/lE0IXqvagkZ33KpKTrPT/lrJor
   1Z8FFApcaw3Rb39RMQllwYOBlAPppGCaok6NEzVx519vlAF//JiNZrugC
   g==;
X-CSE-ConnectionGUID: WU9zRLuOQgi/scQwYvHtZQ==
X-CSE-MsgGUID: +1o+TYGURGGvVSVIRsMfIQ==
X-IPAS-Result: =?us-ascii?q?A0AEAABwTjNq/4r/Ja1aGgEBAQICAQEBAwEBARQBAQECA?=
 =?us-ascii?q?gEBAU2BMAUBAQEMAYNKXkNJA4RUiByHN4IhgRaQN4xRFIFqDwEBAQ9EDQQBA?=
 =?us-ascii?q?YUGURWMYAImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZPD?=
 =?us-ascii?q?YZdJwQLATQSNQIRFQJIFgESgwIBgnMDEQUBslJ6fzOBAYR92UaBbAYVgQouA?=
 =?us-ascii?q?YVwgmoBgXCEBjuEQScbgUlEgRQBgnN2g3wJFQEEC1iDHIJqBIEOgiCBDYE9g?=
 =?us-ascii?q?mSGGoVfCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSL?=
 =?us-ascii?q?Bc0WBsHBYEegScvBCGBA4UDIx8DOX+BbYElZ2YVMDWBAQERHwqBGwMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bBD0BbgeMeRcPgUw8FRAPAQE8GwEiCQsHDBgYCi0BIxAOMgoDGBUFB?=
 =?us-ascii?q?QwNEgEKKQ8CkkYlEwIlgzyOSoE1n1qEJ4FmijuVVAEyl2eTBZkII41nih6LF?=
 =?us-ascii?q?i4FDAQihR+BaDyBWTMaCBsVgyJTGQ+VdYFBwG4nMgIFOAcCBw8ChlGLIgEDA?=
 =?us-ascii?q?woXgVUBAQ?=
IronPort-Data: A9a23:/n+2oqrfz8ECghZJNPOcYU/nTjpeBmLFZBIvgKrLsJaIsI4StFCzt
 garIBmEa/rbMGfyKownbIrk9x9XucfdzYVjTQc+ryxjFHsb9OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgPNNwJcaDpOtfrd8Uw34JwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0tlKUHN00
 eE/ET8MKQuIvv2H3pKneNA506zPLOGzVG8ekmtrwTecCbMtRorOBv2To9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5MWPrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TWFJsPxRrD+
 DOuE2LRQUgdd+Cu5ge/3V2yuNTxvBngfYwzLejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA2+U23R97VUxCyoXeC+BkGVLJ4HuEn7Qifx7b87AGeCWwJCDVGbbQOt9I8TBQp2
 0WPktevAiZg2JWcT36H+6jXqz6uNSULBWsfYylCRgtty8Hqqow1jzrVQ9pjGbLzhdrwcRn0w
 jaXvG09iq8VgMojyaq25xbEjiiqq5yPSRQ6ji3RU36p4x1ReoGofcqr5ELd4PIGK5yWJmRtp
 1AekMSYqeRLBpaXmWnVGaMGHaqi4LCONzi0bUNTIqTNPg+FoxaLFb28KhknTKu1Gq7ooQPUX
 XI=
IronPort-HdrOrdr: A9a23:mWLA1anRRQ21JLIyXjwARGeJkyvpDfKy3DAbv31ZSRFFG/FwWf
 re+MjzsiWVtN9xYhAdcL+7VJVoLUm3yXcX2+cs1MmZMzUO0VHAROpfBODZrgEIdReOk9J15O
 NKLuxCE9X7D1h8g6/BkWqFOudl6tiO966lwcfypk0dLz1CWuVM4xh0DwCDHlYzZgVXbKBJba
 a0145rqyWtfHIPYt/+PHkKWODfu8bG/aiWByLufyRXjzWmvHeP9KPwFQSe01M1VjNCxqpnzE
 3++jaJnplKd5qAu2XhP6i51eUspOfc
X-Talos-CUID: 9a23:7ceHt2FANJdRWLNPqmJYyR8GIOQ4VUTSzTDLKHanOHhJVI+sHAo=
X-Talos-MUID: 9a23:7l7xjQu2B8e17c5ai82nx2hld/tZzJmUJ28Tr644mvOfECJRAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,210,1774310400"; 
   d="scan'208";a="496234369"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Jun 2026 01:53:49 +0000
Received: from [127.0.0.1] (unknown [10.25.128.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 8735E180001C2;
	Thu, 18 Jun 2026 01:53:48 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v9 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Wed, 17 Jun 2026 18:53:23 -0700
Message-Id: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJNPM2oC/5XSS27DIBAG4KtErEsFM4Chq96j6gIP0CA1OLItK
 1WUu5dYlWI5C9TlPPT9s5grm+KY48TeDlc2xiVPeSi1cC8HRkdfviLPodYMBBihhOKxZOLTmIe
 FL8B9OOXC75slft8bJLzH6Ky1iKwi5zGmfFkDPliJMy/xMrPPOjnmaR7GnzV5kev8L8S0QhbJB
 bdApDqDxnf2nfJEwysNp5VeYMvZJgeVC0KHgAYwBdxz+D8OKyeDcs55gRRpz6kNJ2WTU5VLQgO
 CIfC623N6wwE2OV058t4lLZTH8HSdeXBatDlTOeGTSj1BsCbsuW7DyTbXVc7Y3iUllUzq6Tr74
 IxwTc7eH8UH2/u+7y2YLXe73X4BkjlP1P8CAAA=
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781747628; l=11763;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=YUW6tVOCa4XAecpU0Ypp6OD93mCldfX+YcUxEo/S3+I=;
 b=0v+Lb7l9GHwrKaAdHKB0MJ+WwqzWR7Oz45TvgVdmwyAfoIGB2A2BR52ZREOWSLuslyNS+e8JZ
 JZDc0MzZoMoDGOiIrbp1DX6uC2ag8TF6JvaxFthPetMCwF1LeFqs//u
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.189, [10.25.128.189]
X-Outbound-Node: rcdn-l-core-01.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D67169D152

This series adds the admin channel infrastructure and mailbox (MBOX)
protocol needed for V2 SR-IOV support in the enic driver.

The V2 SR-IOV design uses a direct PF-VF communication channel built on
dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

Firmware capability and admin channel infrastructure (patches 1-4):
  - Probe-time firmware feature check for V2 SR-IOV support
  - Admin channel open/close, RQ buffer management, CQ service
    with MSI-X interrupt and workqueue-based polling

MBOX protocol and VF enable (patches 5-10):
  - MBOX message types, core send/receive, PF and VF handlers
  - V2 SR-IOV enable wiring with admin channel setup
  - V2 VF probe with admin channel and PF registration

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v9:
- Use dma_rmb() instead of rmb() when reading admin RQ completion
  descriptors written by DMA (patch 4) [Sashiko]
- Use GFP_KERNEL instead of GFP_ATOMIC for admin RQ refill and for
  received-message allocation; both run in workqueue (process)
  context after the v8 NAPI-to-workqueue switch (patch 4) [Sashiko]
- Correct the enic_admin_msg comment to describe the workqueue
  enqueue path rather than NAPI (patch 4) [Sashiko]
- Set mbox_send_disabled in enic_admin_channel_close() so a MBOX
  send cannot race with channel teardown (patch 6) [Sashiko]
- Send the actual PF carrier state to a VF on registration instead
  of unconditionally reporting link up (patch 7) [Sashiko]
- Call reinit_completion() before setting mbox_expected_reply so a
  reply arriving between the two is not missed (patch 8) [Sashiko]
- Defer PF->VF link state notification to a workqueue and gate it on
  carrier transitions; enic_link_check() runs in the notify (atomic)
  context while the MBOX send sleeps on a mutex/completion (patch 9)
  [Sashiko]
- Clear ENIC_SRIOV_ENABLED and cancel the link-notify work before
  freeing per-VF state in the SR-IOV disable path, closing a
  use-after-free window against a concurrent link notification
  (patch 9) [Sashiko]
- Link to v8: https://patch.msgid.link/20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com

Changes in v8:
- Replace NAPI polling with workqueue for admin CQ service — admin
  channel is low-frequency control traffic, not data path (patch 4)
  [Jakub Kicinski]
- Use explicit enum value (= 4) for VIC_FEATURE_SRIOV instead of
  placeholder VIC_FEATURE_PTP entry (patch 1) [Breno Leitao]
- Remove unnecessary rmb() in WQ CQ service (patch 4) [Jakub Kicinski]
- Remove admin_msg_drop_cnt counter (patch 4) [Simon Horman]
- Drop NAPI reschedule on RQ refill failure — the NAPI-to-workqueue
  switch removes the livelock and budget issues (patch 4) [Simon Horman]
- Remove unnecessary READ_ONCE/WRITE_ONCE on admin_rq_handler — all
  access is serialized by probe/remove (patch 6) [Jakub Kicinski]
- Fix checkpatch line-length warnings (patches 3, 5, 6)
- Rate-limit link state send failure and ACK error warnings (patch 7)
  [Jakub Kicinski]
- Correct enic_link_check comment to describe actual PF link state
  notification flow (patch 7) [Simon Horman]
- Correct mbox_expected_reply comment — serialization is by
  RTNL/probe, not mbox_lock (patch 8) [Jakub Kicinski]
- Wire enic_mbox_send_link_state() from enic_link_check() so PF
  notifies VFs on carrier change (patch 9) [Simon Horman]
- Fix commit message wording about MSI-X reservation (patch 10)
  [Simon Horman]
- Link to v7: https://patch.msgid.link/20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com

Changes in v7:
- Replace magic numbers in admin channel init with named macros
  and inline comments for MBOX descriptor encoding
  (patches 2, 6) [Paolo Abeni]
- Add defense-in-depth bounds check on admin RQ bytes_written (patch 4)
- Force NAPI reschedule on admin RQ refill failure (patch 4)
- Always unmask admin interrupt even with zero credits (patch 4)
- Reorder NAPI init before request_irq in admin channel open (patch 4)
- Remove redundant netdev_warn on admin msg enqueue kmalloc failure
  (patch 4) [Paolo Abeni]
- Add netdev_warn on admin WQ/RQ disable failure in close path
  (patch 2)
- Remove incorrect RES_TYPE_SRIOV_INTR interrupt allocation from
  admin channel open (patch 2); interrupt setup handled entirely
  in patch 4 using RES_TYPE_INTR_CTRL
- Rate-limit VF register/unregister log messages (patch 7) [Paolo Abeni]
- Add __aligned(8) to admin message data[] for strict-alignment
  safety (patch 4)
- Rate-limit MBOX handler error warnings (patch 7)
- Pre-allocate port profile array before pci_disable_sriov in V1
  disable path to avoid half-torn-down state on alloc failure (patch 9)
- Account for admin channel interrupt reservation in
  enic_set_intr_mode() and enic_adjust_resources() (patch 9) [Paolo Abeni]
- Clear admin_rq_handler in enic_admin_channel_close (patch 9)
- Quiesce admin channel (mask interrupt, disable NAPI, block MBOX
  sends) around soft reset (patch 9)
- Use WRITE_ONCE/READ_ONCE for mbox_send_disabled and
  admin_rq_handler across data-path/reset boundaries
  (patches 4, 6, 9)
- Fix commit message: reference enic_adjust_resources() alongside
  enic_set_intr_mode() (patch 10)
Investigated findings from automated review (Simon Horman / Sashiko):
- Race between probe-time feature check and VF proxy: false positive;
  detection runs at probe, enable runs from sriov_configure
- Struct alignment of __le32 after 2-byte mbox_hdr_embed: compiler
  inserts correct padding, no manual alignment needed
- Stale MBOX reply matching / reinit_completion race: single-flight
  design with mutex serialization prevents this
- cancel_work_sync vs MBOX unregister race: work cannot be
  re-triggered during the close window
- Link to v6: https://patch.msgid.link/20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com

Changes in v6:
- Add explanatory comments documenting admin_cq[0] (WQ CQE size) and
  admin_cq[1] (RQ CQE size matching firmware enic_ext_cq() programming)
  allocations (patch 2)
- Enforce bytes_written from CQ descriptor when enqueuing admin RQ
  message; previously buf->len (allocation size) was passed, exposing
  uninitialized buffer memory beyond the real payload (patch 4)
- Drop admin RQ messages with TRUNCATED set or FCS_OK clear, gated by
  netdev_warn_once() (patch 4)
- Disable interrupt_enable on admin_cq[0]: WQ completions are polled
  synchronously inside enic_mbox_send_msg() and never raise an
  interrupt; matches admin_cq[1] (RQ) which does NAPI polling (patch 4)
- Add mbox_expected_reply gating in VF reply handlers (capability,
  register, unregister): drop replies whose type does not match the
  current waiter's expected type, avoiding spurious wakeup of an
  unrelated waiter from a stale reply that arrives after timeout
  (patch 8)
- Distinguish error returns in enic_mbox_vf_unregister(): -ETIMEDOUT
  (no reply received), -EACCES (PF rejected the unregister), 0 on
  success.  Previously all paths collapsed to a single -ETIMEDOUT
  (patch 8)
- Reserve one extra MSI-X slot in enic_set_intr_mode() when
  has_admin_channel is set so enic_admin_setup_intr() always has room
  to allocate at intr_count without exceeding intr_avail bounds when
  data queue count is maxed out (patch 10)
- Clarify in commit messages that .sriov_configure is intentionally
  not yet wired in this series and will be added in a follow-up after
  the necessary devcmd hardening lands (patch 9)
- Link to v5: https://patch.msgid.link/20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com

Changes in v5:
- Fix DMA-into-freed-memory race: call enic_admin_qp_type_set() before
  disabling RQ/WQ in both error and close paths (patch 3)
- Fix DMA mapping leak: enic_admin_wq_buf_clean() now unmaps and frees
  WQ buffers still held at close time after a send timeout (patch 3)
- Log rate-limited warning on admin RQ refill failure (patch 4)
- Add missing linux/types.h and linux/bits.h includes to enic_mbox.h
  (patch 5)
- Guard mbox_lock/mbox_comp init with mbox_initialized flag to prevent
  re-initialization on sriov_configure re-entry (patch 7)
- Clear VF registered state before sending unregister reply so PF does
  not treat a dead VF as still registered (patch 8)
- Gate VF-facing log messages with net_ratelimit() to prevent malicious
  VF from flooding PF dmesg (patch 8)
- Reject VF port profile requests when V2 SR-IOV is active since
  enic->pp is not reallocated for V2 VFs (patch 9)
- Move enic_sriov_detect_vf_type() before auto-enable check; skip
  probe-time auto-enable for V2 VFs (patch 9)
- Move admin channel close and VF unregister before unregister_netdev()
  in enic_remove() to prevent use-after-free on netdev (patch 10)
- Add comment in enic_reset() documenting that admin channel is not
  recovered after soft reset (patch 10)
- Bypass RES_TYPE_SRIOV_INTR check for V2 VFs in admin channel
  capability detection (patch 10)
- Link to v4: https://patch.msgid.link/20260411-enic-sriov-v2-admin-channel-v2-v4-0-f052326c2a57@cisco.com

Changes in v4:
- Fix reverse xmas tree variable ordering (patches 1, 6)
- Use kzalloc_obj instead of kzalloc with sizeof (patch 9)
- Add NULL check for pp allocation in V1 SR-IOV disable path (patch 9)
- Link to v3: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com

Changes in v3:
- Use early-return pattern in enic_sriov_detect_vf_type to reduce
  nesting (patch 1) [Breno Leitao]
- Link to v2: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com

Changes in v2:
- Fix lines exceeding 80 columns (patches 4, 6, 7, 8)
- Add __maybe_unused to enic_sriov_configure and enic_sriov_v2_enable;
  .sriov_configure wiring deferred to a later series after devcmd
  hardening is in place (patch 9)
- Guard probe-time auto-enable to skip V2 VFs (patch 9)
- Link to v1: https://lore.kernel.org/r/20260406-enic-sriov-v2-admin-channel-v2-v1-0-82cc47636a78@cisco.com

---
Satish Kharat (10):
      enic: verify firmware supports V2 SR-IOV at probe time
      enic: add admin channel open and close for SR-IOV
      enic: add admin RQ buffer management
      enic: add admin CQ service with MSI-X interrupt and workqueue polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  34 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 586 ++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 349 +++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 630 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 ++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  13 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 12 files changed, 1739 insertions(+), 20 deletions(-)
---
base-commit: 2319688890d97c63da423a3c57c23b4ab5952dfc
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>


