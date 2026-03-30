Return-Path: <netdev+bounces-273053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAHPNsDjyWlC3QUAu9opvQ
	(envelope-from <netdev+bounces-273053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:45:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CB354D73
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 518DD3006F3D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10663939AC;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3WMlg+Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981336C9D0;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838717; cv=none; b=SAUnpH5V5Imy5QnEiuNmMZtQwcWiQKxKd4lqD2Tb/ivSpORZPREbV8YJAG2vtY7KjqgBB0obirp+mFwxSKvhthaYJqtmycmicDC2RcnPBdDfVSJKx2xEOGr1Ht19flKiY8ptW7Wp3klb0QAsPOf0inJGOK92w8WuYltRbVYV/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838717; c=relaxed/simple;
	bh=EUgvJUu5JMz2u17CJzY6/EHPhU84LC0U5uuI3sWTPmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PKOjz3H7Q+3oAlQ+Z6g/fZvlIdYcjImnLTcBwgDbSsgVrKCVkkyyI4Ga/ET9EuSOqrKoF8UNBgnjxwG02WG+aqGDZ6voTkEWSb8NXxdHX6YjSJywe1amQ946OEYwbVAGCfhRn2jMlD9zayuMvqZnv9AU2BqxQ16H7jYeBTygOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3WMlg+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C531C116C6;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774838717;
	bh=EUgvJUu5JMz2u17CJzY6/EHPhU84LC0U5uuI3sWTPmM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O3WMlg+ZzuyfD0ewR7Pqq9X9kHXS2bIymelWpJMscggEmQgngacGXY8fu61ED2Cqf
	 WtrCQG8YPayn7/yjjcLuIhDounfKrAXXCbDIBDgkyvpNUvSLNghOfNQl+1CUOHMeoc
	 zTYGOckK+8wimIwEvAJJCWU6V9vaw0JHPcigOR6JW6yEZ+/JlsWzHwx8iEPgISupuj
	 7NDM96epm/IykRViFHIOfFcSy/lI8OQjVCSt07kbDMRsjo/JwE2jaztBSLFtTu9/m2
	 lqIIN5HFeIcxk6D4q/bKx/GXhRS9NzhE58hPnVTCRtbu9ZnfETtHdHkejfS+h0TPN6
	 r0HyC4Ki7agAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F75FF492F;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v3 0/6] (no cover subject)
Date: Sun, 29 Mar 2026 19:45:16 -0700
Message-Id: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzjyWkC/4XNMQ7CMAwF0KtUmTFK3NIiJu6BGFrXoR5IqqSKi
 qrenShiYEBi/P76z5uKHISjulSbCpwkinc51IdK0dS7B4OMOSvU2OoaG2AnBDGIT5AQ5sAzoGX
 D/UD1SEblYT5aWQt6U44XcLwu6p6bSeLiw6t8S6b0H/j0C04GNDRnqxtiYzTRlSSSP5J/Fi7hf
 wIzYTsk25mWB9t/E/u+vwH2XjxZAQEAAA==
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774838716; l=3907;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=EUgvJUu5JMz2u17CJzY6/EHPhU84LC0U5uuI3sWTPmM=;
 b=sX65B2f1sAugzBzovoPK6r9Bbgd9twhOYQbfvlU9Pha6DtWf+CtsXeYceJtxzQ87pjPLtGRK2
 OnU5DaH8OjQBoxxDVYbwB4mxi/bEWCSXAtxZ42TTIyNwTolGUawBDZB
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273053-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 645CB354D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

enic: SR-IOV V2 preparatory infrastructure

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



