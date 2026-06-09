Return-Path: <netdev+bounces-297170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Q3hJGpDKGoIBQMAu9opvQ
	(envelope-from <netdev+bounces-297170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AED6628CD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=XO0C4AM9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297170-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297170-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75267311D429
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCC4BC01E;
	Tue,  9 Jun 2026 16:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA73B840F;
	Tue,  9 Jun 2026 16:32:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022775; cv=none; b=PuQjI6QCukY+gHX57fv0RUlhOKSe7DOcO7I2bTbAB1xzOa90tjnwD8r3JME6FRxxWnNyYr23Le8aAFvXyqIGzNzrClFbbADd5qhmbn7eN/JoLUQJqJ1yEE1Cxze1+3hkVFLdrv7voOqhfpQqGwl/oL/hFL/TsEXz9LUokuIVhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022775; c=relaxed/simple;
	bh=lGNZ8CeS2bJBoSZ2RG50WbOrX43H7C33qdkt7lcsxGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DJKzlZNcQGNa9CKgqzSfOH0PiqeoLMFNqWeOJGyPYP6s/m9i4I8Nzytze/c668upPrBfauqPW21Ov7+MOtXpk414XqyQsO6tJbBXO+vv2DXLILoUCLwyR/OrcPSDwhh/9/pw/VaN7bqIcXmVDcI425H+IBDeTABamWoF9Qct8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=XO0C4AM9; arc=none smtp.client-ip=173.37.86.75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10549; q=dns/txt;
  s=iport01; t=1781022773; x=1782232373;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=VlBXF0vBlTfWK3ihRb6IkkeWyzDpVIv9/VDipuro3WA=;
  b=XO0C4AM9+rbun+L3cs0BPhduJP/G1/WDFHQmPa+7PkOEVQOeK35C97Av
   MitIrXnGVQd5uK4cTqIes0+zGKi5KnZ1Jnof46JRJwEGm30pkcLXH2d07
   /q1AD9E93GzHbqatMeCMWlDQQtlMhHwHSBHy5jj3/yXeFXZbPHp+kPrOt
   JOfehnuEeZrdQ+0YC6DKL8qQDplQB7WQ7CpYzKQjIpY7uVslCOg48o0/J
   YXSddP8oD5T0/ER3qFXHlMJhyzwZg+Q4oRZSvfImq3237s1pnSsvy0qSv
   DqxwnjqJTfKg/4OaYP6EyCRX6kAOcrNDsR/OCgOFF+223Pbz9T/GDSKlP
   w==;
X-CSE-ConnectionGUID: kq09lQhnRsWE7Ddl3mFkrQ==
X-CSE-MsgGUID: 4zM32TffTG6Mv5063Fa//w==
X-IPAS-Result: =?us-ascii?q?A0AEAAAaPyhq/4//Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBTIEwBQEBAQELAYNKXkNJA4RUiByHN4IhgRaQN4xRFIEQA1cPA?=
 =?us-ascii?q?QEBD0QNBAEBhQZRFYxTAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8Nhl0nBAsBNBI1AhEVAkgWARKDAgGCcwMRBQG1CXp/M4EBhH3ZR?=
 =?us-ascii?q?YFsBhWBCi4BhXCCaQGBcIQGO4RBJxuBSUSBFAGCcnaDfAkVAQQLWIMcgmoEg?=
 =?us-ascii?q?Q6CIIEQgT6DGYUshVQJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PB?=
 =?us-ascii?q?BYyHXAMJxIsFzRYGwcFgUqBOxQxBCGBBYUSIx8DOYEVgXyBKGdpFTE1TQMLG?=
 =?us-ascii?q?A1IESw3Bg4bBD0BbgeMOhcPgUg8FR8BATwbASIJCwcMGBgKLQFBMg0YFQUFD?=
 =?us-ascii?q?A0SAQopDwKSRiUTAiWDPI5KgTWfWYQmgWaKO5VUATKXZ5MEmQYijWeKHosVL?=
 =?us-ascii?q?gUMBCKFH4FoPDmBIDMaCBsVgyJTGQ+VdYFBwwsnMgIFOAcCBw8ChlGLIgEDA?=
 =?us-ascii?q?woXgVUBAQ?=
IronPort-Data: A9a23:TgSCEamN6NPIZfVHJlmvDWbo5gxcJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOWz+DOPbbZzenKNFwO9u39B4B6pTQz99rT1c9rXthRFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZG31GONgWYubDpKs/Pb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FY4BordzOGFIz
 +cnBW8hYhTYgsy12ovuH4GAhux7RCXqFJkUtnclyXTSCuwrBMidBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYT/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKJK4bTH5QMxBbwS
 mTuo3bcWUsmOtKj5mSg7C/02LThlGS8R9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIqoKku/UuDQtT3XhS+5nmesXY0VtZNFuQo5R2lxa3T7AKUQGMDS1Zpa8Esvec1SCYs2
 1vPmMnmbRRmtrGPRG3e8LqIoT6sESwIK2lEbi9sZRMM6dTloakpgx7PR8olG6mw5vXxGDft0
 3WJoTI4irE7k8EGzeO48ErBjjbqoYLGJiYz6xnbU3yN8Ax0fsimapau5Fyd6uxPRLt1VXGbt
 3QC3szb5+cUANTVymqGQf4GG/ei4PPt3CDgvGOD1qIJr1yFk0NPt6gKiN2iDC+F6vo5RAI=
IronPort-HdrOrdr: A9a23:Xeq9TqBVySjjoiLlHeky55DYdb4zR+YMi2TDGXoBLSC9Ffb5qy
 nOppUmPHDP5Ar5NEtLpTniAse9qA3nmqKdiLN5VdyftWLd1VdAQrsSiLfK8nnKRmnC7eZW16
 dmfcFFeb7NJGk/p8fz5we1V/YMqeP3kpyAtKPyw2hgSAdyZ7olzQtoYzzra3FedU1qCYU0EZ
 yE6tECnTqvfnwLct+2b0N1OdQr3+e7867OUFohGwMt7hWIgHeD7b73FAXd4zIlOgk/uYvLNQ
 P+4nbEDmLJiYDB9iPh
X-Talos-CUID: 9a23:+JHVzmN3Wik1ou5DWzA/pUotGsYfaULwk1vcJxS9J2VzcejA
X-Talos-MUID: 9a23:c0HeeQv2N+8T5oZalc2n2CNHb51U7aqSJx4oj8he5ZKqPGs3JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492129128"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:47 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 3E92218000268;
	Tue,  9 Jun 2026 16:32:46 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v8 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Tue, 09 Jun 2026 09:32:26 -0700
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABpAKGoC/5XOwU7EIBAG4FfZcBYDM0CpJ9/DeGAHcElcakpD1
 mz23WUbE2s9EI//zOT758pKmFMo7OlwZXOoqaQpt2AfDoxOLr8FnnzLDAQYoYTiISfiZU5T5RW
 48+eU+f0yh/f7gIRzGEZrLSJryMccYrqsBS8sh4XncFnYa9ucUlmm+XNtrnLdf5eYXkmVXHALR
 GowaNxgnykVmh5pOq90hS1nuxw0zgvtPRrA6HHP4f84bJz0ahxHJ5AC7Tm14aTscqpxUWhAMAR
 OD3tObzjALqcbR86NUQvl0P/5zvxwWvQ50zjhoopHAm+N33PDhpN9bmicsccxKqlkVL++u91uX
 +5h1iawAgAA
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=10717;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=lGNZ8CeS2bJBoSZ2RG50WbOrX43H7C33qdkt7lcsxGg=;
 b=aeyAOtWyDD1/u8vRdElvtDGHHBK9m3FOcm29nUIW3A47R3i29o6Qip3hkCPyYG9U2PVOSMgbM
 ODzsBTkk3aUAOkZ8zniI3kp0boztfPJ0KypeSfw8Th1wYu5wUPqNULW
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.186];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.186, [10.25.128.186]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297170-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davemloft.net:email,vger.kernel.org:from_smtp,lunn.ch:email,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07AED6628CD

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

To: Satish Kharat <satishkh@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>

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
 drivers/net/ethernet/cisco/enic/enic.h        |  30 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 575 ++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 289 +++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 618 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 ++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  13 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 12 files changed, 1652 insertions(+), 20 deletions(-)
---
base-commit: da1ab4ec5542e0bc314a911d9410a6094b302ce0
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>


