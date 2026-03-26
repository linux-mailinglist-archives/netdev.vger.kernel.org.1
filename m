Return-Path: <netdev+bounces-271833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKnLKaTCxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EADC32F57F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA99930500DF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97B336881;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj0lUSOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFE327BFB;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502339; cv=none; b=hlaLv5/5gmQwajqwrK/Fr68Vexz8J3NRmHCTwzYuXjxiE8Plg97ghxj7gGRMPhad1sW92MJd7Qn0YEPQjsBxtvoUA2Uj2VmzHL/GQKoJ8dq3WZeVyTGVQ10MAzZgWE30qPBCk0zVfVogerfUysURe3s1pvejABhnC7WX0Hlh/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502339; c=relaxed/simple;
	bh=RYIDhb40pciHyjxA9d9rEgw6W+Ol3a6na/ntr3tvrXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eIuXS3JOolWPLA/BhdENDTkQY0HX5xdNeu0Xo3tr1dFiWVLCbb/EqjCrxI8+YZgLW/WCgTFe1fSKtnTKm5fjidZFcgj+S8Rd9Sq0NiSOFLnIrDIgKaA2+cCviqDS5lO0fqWUZ+rGlr1T25zj5+fkGN6wHWgqKdCpLUhPuAgnOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj0lUSOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 208A4C19423;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774502339;
	bh=RYIDhb40pciHyjxA9d9rEgw6W+Ol3a6na/ntr3tvrXU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nj0lUSOlTpQtFWdsLV+Fil1MFbnKiJXeGI6sPDuidksnyrhc6WnH8rfmwQSo6ERlc
	 3REmOyCjwjm8WPndvLcOFFgUK+Iufysc/HtoPxpdglJpmLczzHOcLu1wTItDBhwn63
	 70F6TRD9e2h/lAHpa8EjLB4EpU2dxHOyIWnVVxakSyjMCj78C08Ie5ja4EFkZckQ1N
	 bixlbfQyae36m1bfxJhu+qZKtQ2uMHZA+s6qDNhhCClzzx4pCjSXCRkxa3Uo4eyQ+f
	 DT59HQzc4mdQmO357sCzqseZdfoxguy4K52zl3vwslcX6MNex3YTvTqGFhDWQHYB6g
	 hPcknZzB6zZVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B4109E536;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v2 0/6] enic: SR-IOV V2 preparatory infrastructure
Date: Wed, 25 Mar 2026 22:18:58 -0700
Message-Id: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLBxGkC/22NwQrCMBBEf6Xs2ZUkrSKe/I/SQ91u7B5MShJCp
 eTfDcGjx5nHvDkgchCOcO8OCJwlinc1mFMHtM7uxShLzWCUuareDMhOCGMQnzEb3AJvaCxrnp/
 UL6ShDmtpZW/SERwndLwnmCpZJSYfPu0t68Z/4ss/cdaocLhZNRBrrYgeJJH8mfwbplLKFyWfT
 7a+AAAA
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774502338; l=3312;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=RYIDhb40pciHyjxA9d9rEgw6W+Ol3a6na/ntr3tvrXU=;
 b=XcxxjsWLxIc6TY47kNkGFQ+RDeEC6m9O99JU5KavoK5gotZWar1R6/w/3lmho8acSpKkDEzY1
 2WlC3ShviH5B8uWS6l4T+Pel5ZGgORwzBMk8BWy1NIR2ySuH/IvhIjw
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271833-lists,netdev=lfdr.de,satishkh.cisco.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,cisco.com:email,cisco.com:replyto,cisco.com:mid,davemloft.net:email]
X-Rspamd-Queue-Id: 0EADC32F57F
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

 drivers/net/ethernet/cisco/enic/enic.h          | 18 +++++++++++
 drivers/net/ethernet/cisco/enic/enic_dev.c      | 17 +++++++---
 drivers/net/ethernet/cisco/enic/enic_main.c     | 42 ++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_res.c      | 11 +++++--
 drivers/net/ethernet/cisco/enic/vnic_cq.c       | 14 +++++++--
 drivers/net/ethernet/cisco/enic/vnic_cq.h       |  3 ++
 drivers/net/ethernet/cisco/enic/vnic_dev.c      | 10 ++++++
 drivers/net/ethernet/cisco/enic/vnic_intr.c     | 12 +++++--
 drivers/net/ethernet/cisco/enic/vnic_intr.h     |  2 ++
 drivers/net/ethernet/cisco/enic/vnic_resource.h |  4 +++
 drivers/net/ethernet/cisco/enic/vnic_rq.c       | 14 +++++++--
 drivers/net/ethernet/cisco/enic/vnic_rq.h       |  3 ++
 drivers/net/ethernet/cisco/enic/vnic_wq.c       | 14 +++++++--
 drivers/net/ethernet/cisco/enic/vnic_wq.h       |  3 ++
 14 files changed, 148 insertions(+), 19 deletions(-)
---
base-commit: b1c803d5c8167026791abfaed96fd3e6a1fcd750
change-id: 20260324-enic-sriov-v2-prep-2fe1eabc3dc1

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



