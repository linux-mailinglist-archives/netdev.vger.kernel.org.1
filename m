Return-Path: <netdev+bounces-287654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OBOGqyZBGqwLwIAu9opvQ
	(envelope-from <netdev+bounces-287654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C65CF536356
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81DC931BCB03
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97B4779BC;
	Wed, 13 May 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="T0s3jKQD"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01045481FB2;
	Wed, 13 May 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685431; cv=none; b=b2WmDa4Uz+RyimnJHKGTK8dk/I+4XmNIQIVtTXeSsY+4YmUlb6jmVYCrF0L+S/ixQz6rSpIJivc9YFMc9HAYzW33tIFMnMNoLme4c7phfSTWOaFBZ70fEt9B9R7RWzhDNtzcRT7+wcQIivo3yCQ1l3/QTOpaCdX2dVMR7nX5fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685431; c=relaxed/simple;
	bh=ZM5gzCvwWYIBBxziDW9WBSmxrqFpPJaE7twnJznT7xw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QqDSwBZWIyuF/RJNL5HelSHqoarvPD+r/rSW6jsskKHgO8g6t4C88EKQC6qzjwfcUaGNbBe3Vk17XCeC9MDmGGlMLs1hp2w5C6qG/BdFcbqHWaZO9wWCYDmYpYbpTjK5kUsOriazdHlJESGLovVBsS4h1s++1mRZcMYuZIfL5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=T0s3jKQD; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9126; q=dns/txt;
  s=iport01; t=1778685430; x=1779895030;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=m8eRXQhL5VGh3GYjDpKA62hOzCccW1LK+66FB+K9mMw=;
  b=T0s3jKQDllJT8Kb3ADse9NCsWHPqFY0YfZW/nF5lEUEbYV1zKVo53DcK
   VFVJTBQcF8m6kBELW3Nhx43BNznA1mwLyHqYRv9gxiCXpP3VawBvBkSmm
   kGEhrhteWXHWPwWuOr1033c4qFEk+TtKIn2QNmGNLvqVLslnSyS1vxrB+
   ldi+ASEAV3WjiZRfzdBgC5wryHhdZS7CqYxEH6cZJV0yd2+f1gpG/SLfv
   0AtH+HDVzShbQh2uVWdWoYw5R8XsDMCuL5c+lGtXB/4QkOFpuw3n4ZLx5
   U0vNLXYY4y+sakEhGaNoDPIsw8ne21Ry9q3cZmanGhhXqCT4V1p38TIJj
   g==;
X-CSE-ConnectionGUID: x5h0E3yPS2O/I5aDGXodbA==
X-CSE-MsgGUID: 0GggVvPRS4qtWbSeG+36Ig==
X-IPAS-Result: =?us-ascii?q?A0A6AACnlARq/5D/Ja1aHQEBAQEJARIBBQUBTIEwCAELA?=
 =?us-ascii?q?YNIXkNJA4RUiByHN4IhgRaQN4xQFIERA1cPAQEBD0QNBAEBhQZRFYxOAiY0C?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Thk8Nhl0nBFI1AhEVA?=
 =?us-ascii?q?kgWARKDAgGCcwMRBQGydXp/M4EBhH3ZRIFqBhWBCi4BhXGCZwGBcIQGO4RAJ?=
 =?us-ascii?q?xuBSUSBFAGCcnaDfAkVAQQLWIMcgmkEgQ6CIoEQgiiDL4JihS8JP4ECHANZL?=
 =?us-ascii?q?AFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzNYGwcFgUuCBXIUM?=
 =?us-ascii?q?QQhgQKEX3gjLANOgUMDCxgNSBEsNwYOGwQ9AW4Hij8dD4E/PBUfAQE8GwEiC?=
 =?us-ascii?q?QsHDBgYNwFBMg0YFQUFDA0SAQopDwKSRiUTAiWDPI1da4E1n1mEJoFkijqVV?=
 =?us-ascii?q?AEyl2aTBZkGIo1nih+LQwUMJoUfgWg8OYEgMxoIGxWDIlMZD5V1gUHDSCcyA?=
 =?us-ascii?q?gU4BwIHDgKGUYsiAQMNF4FVAQE?=
IronPort-Data: A9a23:TMZEiq1+OJI2KHYGh/bD5Q5wkn2cJEfYwER7XKvMYLTBsI5bpzABx
 jFKCG+GO6yKZzTzedl0aNnn8RwOvZ6Dy4BjQAI/3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX4
 rsen+WFYAX7g2MtaTpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGHBw2ZaBD695MW0YJ1
 KERBB89aRyJrrfjqF67YrEEasULNsLnOsYb/3pn1zycValgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUicC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+Oe2b4OLJIbRGK25mG7Ai
 W3JwXrBOCpGLcCgwwGI3TH32M7AyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0gZ+zYnqoA++UaqR9+7WAe3yFaJsgMZUshdD8U17waCzqeS6AGcbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBJySQl/Eu
 D0PnNKTqbhRS5qMjyeKBu4KGdlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:9jO+k6uZeSPOxht0JR8dSuFA7skD6NV00zEX/kB9WHVpmwKj5q
 STdZMgtSMc6QxxZJhOo7y90cW7K080lqQa3WBuB9iftWDd0QPCEGgI1+bfKlPbakjD398Y/v
 olTrN3At/xClYSt7eY3CCIV/wgyN6I/OSJqI7lvhVQZDAvRq1+4wJ+EwqBVm97VGB9dOMEPa
 vZy8ZZqz+nYHgNKv66CH4MQvTZq7Tw5fTbiGY9dnkawTjLqy+047jnFBXd9BIfXzRThYoGyw
 H+4nTEDmHJiYDA9vcavFWjlKhrpA==
X-Talos-CUID: 9a23:PR1HmWCVBbkCcZb6Ezk69BY5QdEdSSf6i1aNKmOXOWFlQpTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AU2Sh9Q4vFamrEnkDMIKykQUExowwzKuhNl41q65?=
 =?us-ascii?q?aotW7Pxd9FHTG0hW4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="737166235"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:00 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 1A85E1800020F;
	Wed, 13 May 2026 15:16:00 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v7 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Wed, 13 May 2026 08:15:37 -0700
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmVBGoC/5XOwUrEMBAG4FdZcjYynUnS1JPvIR7iJHEDbipNC
 StL391sESz1UDzO/MP3z02UMKVQxNPpJqZQU0ljbkP/cBJ8dvk9yOTbLBDQgAIlQ04sy5TGKit
 K5y8py/tlDh/3BYNzFAZrLZFoyOcUYrquBS8ih1nmcJ3Fa0vOqczj9LU2127Nf0rMUUntJEiLz
 Ko3ZFxvnzkVHh95vKx0xS1nDzlsnAftPRmk6GnP0f84alzn1TAMDogD7zm14brukFONi6CR0DA
 63e85veGQDjndOHZuiBqUI//nO/PLaTjmTOPARRXfGL01fssty/IN4vyqbGECAAA=
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685359; l=9284;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZM5gzCvwWYIBBxziDW9WBSmxrqFpPJaE7twnJznT7xw=;
 b=BpBlXf2GGnuqd/ur2Cza34pEOfkd8f/QGHytB5iuR4hGCCNlpuOreU64ekPZ0Tpy/w6377c2E
 Yv7zdgoup0OCLXjGW5V9SkesT87nw88Ae4UKQT5E032ovXfQMPJiQQb
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: C65CF536356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287654-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:mid,cisco.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,lunn.ch:email,msgid.link:url]
X-Rspamd-Action: no action

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
      enic: add admin CQ service with MSI-X interrupt and NAPI polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  38 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 595 +++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 279 +++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 615 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 ++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  13 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 12 files changed, 1667 insertions(+), 20 deletions(-)
---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>


