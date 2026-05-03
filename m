Return-Path: <netdev+bounces-283584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJiyMaYw92lbdQIAu9opvQ
	(envelope-from <netdev+bounces-283584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:25:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F94B543D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5E23028831
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D43319858;
	Sun,  3 May 2026 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Bz1XEIGY"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D51F3BA4;
	Sun,  3 May 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807404; cv=none; b=obGx81QCIb4KSwsTW6f5cySAnFGSLpywU7jYfQSWNQM+UElA526D/E5YbRUaYl1oTRKRxPGU6UT0urh/nkhKYOARaMNGJMMJYsUE0VJweN+MUgQmIKRqLaCdp+oEc8fRtiFmG2971SBveft7l7XKN4rjHMRT0YK99xpZTJduEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807404; c=relaxed/simple;
	bh=saClKdv6+PJFQbjaNUe4UQGf9bbPyujqvQyyVmamJmQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WLXuiK1jQm/kjnkeGB7u6nqpumuAhx6/CEvCLl78oJwEfvTISRj28DUm39R2wtoldxjx66/RWPWxNzovOScaSAkv0KFXAOZ24cNWvscKpnzsEKBy6NYJ0IBfT9NOOKwfVvWc7EW3qYDUuykkjYjiB5c8Ap50aRoRZ/O9iuL2EC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Bz1XEIGY; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6775; q=dns/txt;
  s=iport01; t=1777807403; x=1779017003;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=gS/D0U1PKxYLqmd6xijruZ/gf1koyq32kPGafNX6CHY=;
  b=Bz1XEIGYL4CHiByyNOOwX6Z0cWwg5M+vFEr6Di0Nqm3HwzttF1d08Z5A
   3p51bLJjpoL84S2Kh4zx4JGUxqvCN8Xuk06b6p4xJ0xcruTD/WBw/Udj3
   qzLVb6JDKt8hLOdFqToSMhWId4Zgj4Xlkt7JVR4On7WqospUoE1OAmTp9
   SxZpyG4bUu3PM0dsAmyajHI3oigt2KrkWBuZUNdx/Zr7sf+MbgfM+8JMU
   yZT65VOJtXh4mbmnSwnrPUSHUf0c5k6iDCMRpyxmNguqxJlWlmSfnNmVH
   thByvfa/NtAlzcBktk7GAUtmh6ptUg/ao1i9g7SOY3ugh6V6x6FDJYKGy
   g==;
X-CSE-ConnectionGUID: 83AIf4NtTTWNwNjHrg8UOw==
X-CSE-MsgGUID: YegfjEYuQSqBdcphE0JCeQ==
X-IPAS-Result: =?us-ascii?q?A0AnAADHL/dp/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQFMg?=
 =?us-ascii?q?TAHAQELAYNHXkNJA4RUiByHN4IhgRaQN4xQFIERA1cPAQEBD0QNBAEBhQZRF?=
 =?us-ascii?q?YxNAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZPD?=
 =?us-ascii?q?YZdJwRSNQImAkgWARKDAgGCcwMRBQG0B3p/M4EBhH3ZQ4FqBhWBCi4BhXGCZ?=
 =?us-ascii?q?gGBcIQGO4Q/JxuBSUSBFAGCcnaEBRUFC4N0gmkEgQ6CIocygjOFNgk/gQIcA?=
 =?us-ascii?q?1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbBwWBS4MAb?=
 =?us-ascii?q?RQxBCGBBYRgeCMsA05yAwsYDUgRLDcGDhsEPQFuB4pmHQ+BP3ABATwbASIJC?=
 =?us-ascii?q?wcMGE8BQTINGBowAQopkw8CJYM8jV1rgTWfWYQmgWSKOpVUATKXZpMFmQYij?=
 =?us-ascii?q?WeKH4tDESaFH4FoPDmBIDMaCBsVgyJTGQ+VdYFBwGomMgIFNwEHAgcOAoFzh?=
 =?us-ascii?q?F6LIhEXgVUBAQ?=
IronPort-Data: A9a23:jL8tKa1R8W/q5Itx8fbD5Q5wkn2cJEfYwER7XKvMYLTBsI5bp2MBy
 2VLC2GCPf3ZZGOhf9FzaonkoR8P78PSnIAyT1M53Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX4
 rsen+WFYAX7g2MsaTpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGXBofHINE3PpLPV5o6
 toaCCoCPi2kmLfjqF67YrEEasULNsLnOsYb/3pn1zycVaxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNU+RC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+Oe2aYeLI4fVHa25mG6pq
 23I/UnIHyghLfaTwiKF3yqOreL2yHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0gZ+zYnqoA++UaqR9+7WAe3yFaJsgMZUshdD8U17waCzqeS6AGcbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBJySQl/Eu
 D0PnNKTqbhUS5qMjyeKBu4KGdlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:W/fK3KvnOBn9Os9J3qNrWj2j7skD6NV00zEX/kB9WHVpmwKj5q
 STdZMgtSMc6QxxZJhOo7y90cW7K080lqQa3WBuB9iftWDd0QPCEGgI1+bfKlPbakjD398Y/v
 olTrN3At/xClYSt7eY3CCIV/wgyN6I/OSJqI7lvhVQZDAvRq1+4wJ+EwqBVm97VGB9dOMEPa
 vZy8ZZqz+nYHgNKv66CH4MQvTZq7Tw5fTbiGY9dnkawTjLqy+047jnFBXd9BIfXzRThYoGyw
 H+4nTEDmHJiYDA9vcavFWjlKhrpA==
X-Talos-CUID: 9a23:hDtPFm245+oFbvn+nMbe27xfSpsMU3OB6mvsH3CeFkBraKeaGWK35/Yx
X-Talos-MUID: 9a23:oy9FHAk3H3A4gd6eQlbgdnpTOchm4YmfFXk2iL8KsNGEGHRSEDqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="731561370"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:22:55 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 28BE418000341;
	Sun,  3 May 2026 11:22:55 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v6 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Sun, 03 May 2026 04:22:37 -0700
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0v92kC/5XOwW7DIAwG4FepOI+J2EDITnuPqQdknBVpJRNEq
 FWVdx+NdshyiXa0f+v7/RCFc+Qi3k4PkbnGEqfUBvtyEnTx6ZNlDG0WoMAqrbTkFEmWHKcqK0g
 frjHJ52Xir+eClPfIg3MOUTTkO/MYb2vBh0g8y8S3WZxbcollnvJ9ba7dmv+W2KOS2kklHRDp3
 qL1vXunWGh6pem60hW2nDvkoHFBmRDQAo4B9xz+j8PGdUEPw+AVEtOe0xuu6w453bhRGUCwBN7
 0e85sOMBDzjSOvB9Go7TH8Oe7ZVl+ADDHFSwSAgAA
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807374; l=6910;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=saClKdv6+PJFQbjaNUe4UQGf9bbPyujqvQyyVmamJmQ=;
 b=GX8sFj2vDtek2sFGEphcSwyAX9kxxi/xCjIPa6O4Sb44H+qz9tZ572kbI9TQzp3M1whQ6kHyb
 gxM06x3Eg2oCsrOWZsnQYRJ1COb8O04zGfJyrT5wSx7muJSKvOd/SO4
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: 2F8F94B543D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283584-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,cisco.com:email,cisco.com:dkim,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

This series adds the admin channel infrastructure and mailbox (MBOX)
protocol needed for V2 SR-IOV support in the enic driver.

The V2 SR-IOV design uses a direct PF-VF communication channel built on
dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

Firmware capability and admin channel infrastructure (patches 1-4):
  - Probe-time firmware feature check for V2 SR-IOV support
  - Admin channel open/close, RQ buffer management, CQ service
    with MSI-X interrupt and NAPI polling

MBOX protocol and VF enable (patches 5-10):
  - MBOX message types, core send/receive, PF and VF handlers
  - V2 SR-IOV enable wiring with admin channel setup
  - V2 VF probe with admin channel and PF registration

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
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
      enic: add admin CQ service with MSI-X interrupt and NAPI polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  38 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 588 +++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 255 ++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 605 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 ++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 11 files changed, 1617 insertions(+), 18 deletions(-)
---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>


