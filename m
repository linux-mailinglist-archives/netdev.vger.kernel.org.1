Return-Path: <netdev+bounces-280796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrhGclK6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF6454FC8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA6F30479D5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55837E2F7;
	Thu, 23 Apr 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="K3Pm7V4I"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC137DE85;
	Thu, 23 Apr 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961812; cv=none; b=j5UA/l+5J1IzkhyoxIYvbQXnEzUsSZKpY0UmK+tRgLpwHzfnisoCErn+B3/ALOnaAMz587Mrfh8jnKeHJhw723Bo+ZFXwrdgZcoOBPV4TbhI6nSAZ4vZEy+63zXbA8yhTXlmzUr9klnajuSeMVM0iqHlxZJcT3Teu9AUuP6kSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961812; c=relaxed/simple;
	bh=FoGZ5LVnczYfdIZAkq7k5BU8OmH/kvHWXo1eXXH7Be8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RlGIxmAqPOPBXgLDTgJYL00u0DMeEnrXSLbWrjjFmK1Kd62oSVJ20cll9THejgQkwyLS7GjbouVbevuAjBm/a+jbqIMWYtBuuE5jhI706NDcqwbH85O72pce7soqqvRMQHmRCKdj7ek9H7nwcQGLQUMSx8Es5cdOoy3DdiymU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=K3Pm7V4I; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4898; q=dns/txt;
  s=iport01; t=1776961810; x=1778171410;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/XrC9I5eIRpF4H5DkdAaRDE0Dz1L31UzD/4K/mukuiE=;
  b=K3Pm7V4ISpZUxR1AW5GM8AHAk0zjeivUdh1F/CAi/sQuHUXicnGF99kp
   Bqmu4WHLLHxVsf/cobf8oktM5YTfxMkfvHlZre6wfxnxbRjBLftO72vxr
   ZBuLfpOcwQlAnv4iB8NfmxMt2NRep/GfD1YJFMMYCxWoLZvyYvagAxbrc
   5l3tBxEMnxschrsgfAeby4ZFCOJFkG+ya/lxkkaqotGWl7zs4t4aCuAf5
   b+U1tflWN6cL0C5EcW0bh+tNshx0ICreScyDtfUqCELh5SVAG7ibbRJfD
   GpQVBxtqKu/jBWnh/LrnhyntdrpvoQXYnlW0UpGMouFWzcxdu7WxMyRbb
   Q==;
X-CSE-ConnectionGUID: zC9Nimq7Q4iT/Luh6Zkyjw==
X-CSE-MsgGUID: e8XfDn+jR9Ou++4qIMa4jQ==
X-IPAS-Result: =?us-ascii?q?A0ANAAAkSOpp/4//Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUyBMAYBAQELAYNHXkNJA4RUiByHN4IhkU2MUBSBaw8BAQEPRA0EAQGFB?=
 =?us-ascii?q?lEVjEgCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?k8Nhl0nBFI1AiYCSBYBEoMCAYJzAxEFAbM6en8zgQGEfdlCgWoGFYEKLgGFc?=
 =?us-ascii?q?YJmAYFwhAY7hD8nG4FJRIEUAYNohAUVBQuDdIJpBIEOgiKCIIV0gViFMgk/g?=
 =?us-ascii?q?QIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbBwWBS?=
 =?us-ascii?q?4QJbRQxBCGBC4MqgTaBAQMLGA1IESw3Bg4bBD0BbgeKNiAPgTlwAQFXASIJC?=
 =?us-ascii?q?xMYTwFBMg0YGjABCimTDwKDYY1da6EOhCaBZIo6lVQBMpdmkwWZBiKNZ4ofi?=
 =?us-ascii?q?0MRJoUfgWg8gVkzGggbFYMiUxkPlXSBQcAcJjICBTgHAgcOAoZRiyIRF4FVA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:1JmICK8tEyu0i2hOhHbZDrUDXX+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 jdKCj3QbvuPYDT3fYx1O42w8k0OvJ7Ux9E1QAU5pSxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mpyyHjEAX9gWAsbjhPs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kkFtw+++NuXlgS9
 MBfDC0NMCKAluCplefTpulE3qzPLeHxN48Z/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Yn1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3Fb4COIIDQG5sN9qqej
 m+Wz2rVBFIYDo241HnGrmuNo+aTnxquDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ8/icvsaE13ECmRNj0WVu/unHslhMQRt9ZAeAmwA6KzaXQ7kCSAW1sZj1cYtUOt8IsQzEuk
 FiTkLvBDDpjqrCKCnSQ6ruZsxu2JC4Ta2QCDQccRAEI5djLuow/jhvTCN1kFcaditzzBCG1w
 D2QqiU6r6scgNRN1Kih+13DxTW2qfDhSAMp6gjJdnyq4xk/Z4O/YYGsr1/B4p59wJ2xVFKNu
 j0A3sOZ9u1LVc/Lny2WS+JLF7asjxqYDADhbZdUN8FJ31yQF7SLJOi8PBkWyJ9VD/s5
IronPort-HdrOrdr: A9a23:N63j0K/Zd6uTD6+f1YRuk+BGI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rPoB17737JYVkqNE3I9errBEDiex3hHOBOjrX5VI3KNGLbUQCTQb2Kg7GSpgHIKmnUq6phzq
 9rcah4BrTLfDtHpPe/ygixFNgthPmrmZrY59v2/jNBQR5nbqd44xw8KAqKe3cGPTVuNN4VGI
 WR48xfqyHlQ3QYacynGmIINtKzweEj7KiWBiIuNloA9BSEiy+u5frRFhiV2QpbbhZ0qI1SiV
 QsV2fCl9+eWzbR8G6m61Pu
X-Talos-CUID: =?us-ascii?q?9a23=3AOXdRpmovwRb5if/J4MstE1LmUdIOI1vcyW6PGhO?=
 =?us-ascii?q?5NSFNVb3Le1yB+rwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A7x7rZwx28hhd4wNj1Q30caUjFeSaqKn+OE4hl9Y?=
 =?us-ascii?q?EgZijKG8zZy68qT3rQLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="723242660"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:02 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 50FD01800039B;
	Thu, 23 Apr 2026 16:29:01 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v5 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Thu, 23 Apr 2026 09:28:01 -0700
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFI6mkC/5XNQW7DIBAF0KtErEsFMxjjrnqPqgs0jBukBiKwU
 KrIdy+xurCysbr880fv30XlErmKt9NdFG6xxpx6GF5Ogs4+fbGMoWcBCqwyykhOkWQtMTfZQPp
 wiUk+PhN/Pw6kvEeenHOIoiPXwnO8bQMfIvEiE98W8dmbc6xLLj/bctNb/zdij0aalko6IDKjR
 etH906xUn6lfNnoBnvOHXLQuaCGENACzgGfOfwfh53TwUzT5BUS0zNndpzWh5zp3KwGQLAEfhj
 33LquvwyNdabDAQAA
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=5013;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=FoGZ5LVnczYfdIZAkq7k5BU8OmH/kvHWXo1eXXH7Be8=;
 b=C5TrJ6BA5ciqoi6QtmKkv8KJ7jQERrndF6cjODOnU/bNxLAO76dLMO/B6Pwlbee78/qaWe0oi
 tfOSeHMyZcxD2h64Pai2YnHpQmfI/QteqzChZe4JqFGMp0rxaSDJhsm
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
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
	TAGGED_FROM(0.00)[bounces-280796-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: D6FF6454FC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This series depends on "enic: SR-IOV V2 resource discovery and VF
type detection" (Series 1), which has been accepted.

Depends-on: 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
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
      enic: add admin CQ service with MSI-X interrupt and NAPI polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  30 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 525 ++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 237 ++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 569 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 +++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 11 files changed, 1495 insertions(+), 15 deletions(-)
---
base-commit: 3e6ef4fb822c971b464d44910a1561b4e7f9efa7
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>


