Return-Path: <netdev+bounces-271425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMqZDxiNw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF13209CC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21A5F3035A5B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63A29ACDD;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3AAjvec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F34FF78;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423299; cv=none; b=LSBks3e9pAOsF0/bgbRqiTwCP+7BXQ2US1EzKeFIEshOGoo7/J8E+o+uJkic7fWAnqGUovbv+CyltP01AncbC1VNOvACahJodZmvplcpJvnwmahTCchzgS74ekTZCDIr3ZUQFAofeqygv1vH5u18iz/vy30dymQYZyiUXz+s5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423299; c=relaxed/simple;
	bh=qSy9N+gRPs52hh9frh1cA4g+VCjg2QwryN4lX/B1p7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PP808iHufTfPAAUPIFFNxghbGIAmSxW4k4bTK5roEnJDUBMcd1VqPXJa//M61A0joUh3H+jAQ58KEDkXWrsuV6Eo6BECtjMW54Wa/5ZY37k054sGisCk4wuomITtHzrjHSeIGHIX8z6nViTegvdwjaNHAeYFgnREik23yFQ5RGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3AAjvec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A343C4CEF7;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=qSy9N+gRPs52hh9frh1cA4g+VCjg2QwryN4lX/B1p7w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e3AAjvecKLfoOpsE0YgLruGAWi/53OWyTZwwcFP1er02WNNzoCEWEz0DVaOEl7mpP
	 xV2rPK9hBHC17gT5UFSPZO5qpo3FOTJH/jrXajz3bPFLDmt00Bc/E3o0/6X3iPJDLG
	 /ngJbskQM8mn+FQXuLUDLkZC9k352FR4c860Si7Pt00oI39BilpB3+9bqjbfm/HO6H
	 AIMrDLcCgdPOU84q+1fZTtU4m4OycXyUvf5UbBQ6u5+8Ie2mJRuxTInCfZsWJJACw1
	 ZNoeCQw5Th+kjuRICwuoqtkBmdDZhnIWGoqL314t2uK3kl/ocflMDz4lwLGd2HSRCx
	 /QCqF1MBnw1oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A454FEA820;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next 0/6] enic: SR-IOV V2 preparatory infrastructure
Date: Wed, 25 Mar 2026 00:21:38 -0700
Message-Id: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKNw2kC/x2MsQqAMAwFf0UyG7BRHPwVcdD61CxRWimC9N8tj
 ndw91JEUEQaqpcCkkY9rYCrK/LHbDtY18IkjfRNKx3D1HMMeiZOwlfAxbLBYV58u3pHJSxy0+e
 fjmS42fDcNOX8Ae/5tDtuAAAA
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=2762;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=qSy9N+gRPs52hh9frh1cA4g+VCjg2QwryN4lX/B1p7w=;
 b=xI6mgt/ThBwIf5b/RTtJnNp69cE+vRfqz0zwMpLG6jcbQtnA6dl2PPpj8gMamiOLMiYmACtmG
 0S+Y2Al5FIgABktOVSOuXZw+NYMfr+mSX2eziO/vyKiK6DvDmHLqawj
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271425-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: E3BF13209CC
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
 drivers/net/ethernet/cisco/enic/enic_res.c      | 10 ++++--
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
 14 files changed, 147 insertions(+), 19 deletions(-)
---
base-commit: b1c803d5c8167026791abfaed96fd3e6a1fcd750
change-id: 20260324-enic-sriov-v2-prep-2fe1eabc3dc1

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



