Return-Path: <netdev+bounces-274156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMdFLh09zWn5awYAu9opvQ
	(envelope-from <netdev+bounces-274156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:43:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1537D5AC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F49130CF6DA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349135BDC7;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm6KiD4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F497314B62;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057475; cv=none; b=BcsAKm1Fx18UsCvtdLonxGJ3gPRjrqsyUrGAev8iVBetE2kgUzNdyNeq8ogQJ73u/yGBHrel7EOIxdDFc4cNSPPa6ghxXiR/DyMTl23MY4xfwCPieE4+iMHE+bVsML99eSRkRAZ/8d+o9/KTN7lxjWnv+zjWDS9ev0Cb5p1Myoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057475; c=relaxed/simple;
	bh=McHxxk4iXE1QL7Kb3bVI5Yay+sCfLULmAtHo/d2Afgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P7vq6afvU13ZVu6NSb/0ZPaZP870o6qFySyndC2HpPwx8bQw0gDB0SgNbtWsPckQ5baC896RY3jl8Qhmvwvo7Tj1RAQ2hs5BUR+i4Z4ToKkMfYDjMP3jlcPGOGU8RRaRPxhic+8+KUZ/5HeBSj47cAGGiw9+VCaiG+1iCsug2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm6KiD4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 291F0C2BCB0;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775057475;
	bh=McHxxk4iXE1QL7Kb3bVI5Yay+sCfLULmAtHo/d2Afgw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Xm6KiD4brU89+vdklKXGAs8TR3ztl3lcp1sh3qDPyohbb8pgbTEiwzOoN41J/1A1l
	 BQLBbal6RAx5i7r9L4FwLgUU5BxWNux8psQfJwQSjyi/piH79bnsanTDT0+gqDwpPG
	 csHtz6vnMMb2yofQxrmDfPWW1UdEoSLwQkgwY2JgnUfG0C9a3cXRnyhMTmg92TpN77
	 k3R7yVqqxbYD0DWsamv2GkDQm/GufRSym/H8dLUvXcz4xMF0+geknt4r4HOT/qmpz/
	 OCFDO/Twjk198vveEIYC2Dv25lQVlcj4Wccq7xGvrdMfQOIGGnFxHrR5ffqt9QGdDJ
	 BQ6yrcm6WWOgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB052D35173;
	Wed,  1 Apr 2026 15:31:14 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v4 0/6] enic: SR-IOV V2 preparatory infrastructure
Date: Wed, 01 Apr 2026 08:31:10 -0700
Message-Id: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD46zWkC/4XNMQ7CMAwF0KtUmTFK3NIiJu6BGFrXoR5IqqSKi
 qrenShiYEBi/P76z5uKHISjulSbCpwkinc5NIdK0dS7B4OMOSvU2OoaG2AnBDGIT5AQ5sAzoGX
 D/UD1SEblYT5aWQt6U44XcLwu6p6bSeLiw6t8S6b0H/j0C04GNDRnqxtiYzTRlSSSP5J/Fi7hf
 wIzYTsk25mWB9t/E/u+vwHuO9/dAQEAAA==
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775057474; l=4032;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=McHxxk4iXE1QL7Kb3bVI5Yay+sCfLULmAtHo/d2Afgw=;
 b=pdYMjw+uZJFM2vUgWEW2TXQqMLcYceUJVAIOHoqqsBO1Q61V/3+bzI5gaJlKmEq8+FgKxGVyq
 IfBI0kEID2MCpcyecDymkMIiXh0bWuX7w4Vozdofw6uwweUEj53+3kp
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274156-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid,davemloft.net:email]
X-Rspamd-Queue-Id: 3AC1537D5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is the first of four series adding SR-IOV V2 support to the enic
driver for Cisco VIC 14xx/15xx adapters.

The existing V1 SR-IOV implementation has VFs that interact directly
with the VIC firmware, leaving the PF driver with no visibility or
control over VF behavior. V2 introduces a PF-mediated model where VFs
communicate with the PF through a mailbox over a dedicated admin
channel. This brings enic in line with the standard Linux SR-IOV
model, enabling full PF management of VFs via ip link (MAC, VLAN,
link state, spoofchk, trust, and per-VF statistics).

This preparatory series adds detection and resource helper code with
no functional change to existing driver behavior:

  - Extend BAR resource discovery for admin channel resources
  - Register the V2 VF PCI device ID
  - Detect VF type (V1/V2/usNIC) from SR-IOV PCI capability
  - Make enic_dev_enable/disable ref-counted for shared use by data
    path and admin channel
  - Add type-aware resource allocation for admin WQ/RQ/CQ/INTR
  - Detect presence of admin channel resources at probe time

Tested on VIC 14xx and 15xx series adapters with V2 VFs under KVM
(sriov_numvfs, VF passthrough, ip link VF configuration, VF traffic).

Based in part on initial work by Christian Benvenuti.

To: Satish Kharat <satishkh@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v4:
- Repost to fix cover letter subject accidentally sent as "Changes in v3:"
  instead of "enic: SR-IOV V2 preparatory infrastructure". No code changes.

Changes in v3:
- Thanks to the reviewers for the feedback on v2, all comments have
  been addressed in this revision.
- Patch 4/6: check enic_dev_enable() return value in enic_open() and
  add proper error unwind path so the enable reference count stays
  consistent if the firmware command fails.
- Patch 6/6: use ARRAY_SIZE(enic->admin_cq) for the admin CQ resource
  count check, since the driver allocates two admin CQs and both must
  be backed by hardware.
- Link to v2: https://lore.kernel.org/r/20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com

Changes in v2:
- Add RES_TYPE_SRIOV_INTR to the has_admin_channel check in patch 6/6
- CC all netdev maintainers per cc_maintainers CI feedback
- Link to v1: https://lore.kernel.org/r/20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com

---
Satish Kharat (6):
      enic: extend resource discovery for SR-IOV admin channel
      enic: add V2 SR-IOV VF device ID
      enic: detect SR-IOV VF type from PCI capability
      enic: make enic_dev_enable/disable ref-counted
      enic: add type-aware alloc for WQ, RQ, CQ and INTR resources
      enic: detect admin channel resources for SR-IOV

 drivers/net/ethernet/cisco/enic/enic.h          | 18 ++++++++
 drivers/net/ethernet/cisco/enic/enic_dev.c      | 17 +++++--
 drivers/net/ethernet/cisco/enic/enic_main.c     | 59 ++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_res.c      | 12 ++++-
 drivers/net/ethernet/cisco/enic/vnic_cq.c       | 14 ++++--
 drivers/net/ethernet/cisco/enic/vnic_cq.h       |  3 ++
 drivers/net/ethernet/cisco/enic/vnic_dev.c      | 10 +++++
 drivers/net/ethernet/cisco/enic/vnic_intr.c     | 12 +++--
 drivers/net/ethernet/cisco/enic/vnic_intr.h     |  2 +
 drivers/net/ethernet/cisco/enic/vnic_resource.h |  4 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.c       | 14 ++++--
 drivers/net/ethernet/cisco/enic/vnic_rq.h       |  3 ++
 drivers/net/ethernet/cisco/enic/vnic_wq.c       | 14 ++++--
 drivers/net/ethernet/cisco/enic/vnic_wq.h       |  3 ++
 14 files changed, 165 insertions(+), 20 deletions(-)
---
base-commit: b1c803d5c8167026791abfaed96fd3e6a1fcd750
change-id: 20260324-enic-sriov-v2-prep-2fe1eabc3dc1

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



