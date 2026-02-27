Return-Path: <netdev+bounces-261862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BsSJsaxoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:01:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728051B9612
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E3830BE2F7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F542B74F;
	Fri, 27 Feb 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2nJ+EFhg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AED42B73B;
	Fri, 27 Feb 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204250; cv=none; b=rhDiPG0HjLNWhW6KVcV03qph2xF75kG3ZZ2KZThpCZjwcH4r3qT5SJIvYUXJIpPVJKpNM3yii5P7Vtu7/9QgyMIVkTtDSWjNBPQJGstbtDRiuJrZ3V20iq/GBv865Diar1ER/F9lEvjpkpMpYlVprRMbDZG4VoZTazRAg0/lmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204250; c=relaxed/simple;
	bh=Ow4BaL7t8+ptDhmm93kvq3SCgaiHZrjMuwhCUtx9vBY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kT+kp1GVxJaccfLMSUjvE9SLx3ZwBP+PSxKTahOhQOE/kJL/rKt9ET06OSLNlIFdkukhz2nLIODAqcuFVeYYIxrarbCQ0kiWuikVhcEt4ui8poGf6rFRTRb0M+4fZaHpjcYJpWcQm8Ru9eLhVyGafG1oxouJecG8gF2pPSXeMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2nJ+EFhg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204247; x=1803740247;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Ow4BaL7t8+ptDhmm93kvq3SCgaiHZrjMuwhCUtx9vBY=;
  b=2nJ+EFhgaeN+aVsfSwHxZBNhO2tJyxFBS6+sPUzbxMqs74aL4Ncg49Mu
   VMpA16spwbxAGI4zaEhQIAHmIR6Oq7A3XJD0jBbggW0Zs6A2IaLrf0afB
   5uYje6bAYlN2A8E/SNsmfJkmhwafOO2fnzqQU8Ymk4wPlD6qq1DCdOHjS
   QmnvdQSWNer+agh62zUGdHKHSLzEDj0ZeUiVvRw+tiZoFtyLx/23puu7N
   wMx6eDXq09gq2iu8vhRciVHRh8XN6BlhQfanpP+Ogouy1I2ST5NDdUG2n
   /vFSSFAGyp0wCRRWbpcdx2CUa15JltAMdVONb3tYNZOV3zeAjF7bRq9Gi
   w==;
X-CSE-ConnectionGUID: kLDX0HSLSkif0YfeYYLp1A==
X-CSE-MsgGUID: sKY45YYqSf+b1MKrmg4FDg==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="61420721"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:57:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Feb 2026 07:56:58 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:56:56 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/9] net: sparx5: clean up probe/remove init
 and deinit paths
Date: Fri, 27 Feb 2026 15:56:38 +0100
Message-ID: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKawoWkC/22NwQ6DIBBEf8XsudsABqw99T8aDxbXugfBACE2x
 n8vodeeJi+TeXNApMAU4d4cEChzZO8KqEsDdhndm5CnwqCEMkJJg3Ebw66RHSecqIZoOztLo61
 RBGW4BZp5r9InOEroaE8wlGbhmHz41Lcsa/8TK/1PnCUK7DvRGn0Tr34Wj5Vt8Hbh7Wr9CsN5n
 l+bo0/NwgAAAA==
X-Change-ID: 20260216-sparx5-init-deinit-037cf165c62e
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <maxime.chevallier@bootlin.com>,
	<rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 728051B9612
X-Rspamd-Action: no action

This series refactors the sparx5 init and deinit code out of
sparx5_start() and into probe(), adding proper per-subsystem cleanup
labels and deinit functions.

Currently, the sparx5 driver initializes most subsystems inside
sparx5_start(), which is called from probe(). This includes registering
netdevs, starting worker threads for stats and MAC table polling,
requesting PTP IRQs, and initializing VCAP. The function has grown to
handle many unrelated subsystems, and has no granular error handling —
it either succeeds entirely or returns an error, leaving cleanup to a
single catch-all label in probe().

The remove() path has a similar problem: teardown is not structured as
the reverse of initialization, and several subsystems lack proper deinit
functions. For example, the stats workqueue has no corresponding
cleanup, and the mact workqueue is destroyed without first cancelling
its delayed work.

Refactor this by moving each init function out of sparx5_start() and
into probe(), with a corresponding goto-based cleanup label. Add deinit
functions for subsystems that allocate resources, to properly cancel
work and destroy workqueues. Ensure that cleanup order in both error
paths and remove() follows the reverse of initialization order.
sparx5_start() is eliminated entirely — its hardware register setup
is renamed to sparx5_forwarding_init() and its FDMA/XTR setup is
extracted to sparx5_frame_io_init().

Before this series, most init functions live inside sparx5_start() with
no individual cleanup:

  probe():
    sparx5_start():              <- no granular error handling
      sparx5_mact_init()
      sparx_stats_init()           <- starts worker, no cleanup
      mact_queue setup             <- no cancel on teardown
      sparx5_register_netdevs()
      sparx5_register_notifier_blocks()
      sparx5_vcap_init()
    sparx5_ptp_init()

    probe() error path:
      cleanup_ports:
        sparx5_cleanup_ports()
        destroy_workqueue(mact_queue)

After this series, probe() initializes subsystems in order with
matching cleanup labels, and remove() tears down in reverse:

  probe():
    sparx5_pgid_init()
    sparx5_vlan_init()
    sparx5_board_init()
    sparx5_forwarding_init()
    sparx5_calendar_init()         -> cleanup_ports
    sparx5_qos_init()              -> cleanup_ports
    sparx5_vcap_init()             -> cleanup_ports
    sparx5_mact_init()             -> cleanup_vcap
    sparx5_stats_init()            -> cleanup_mact
    sparx5_frame_io_init()         -> cleanup_stats
    sparx5_ptp_init()              -> cleanup_frame_io
    sparx5_register_netdevs()      -> cleanup_ptp
    sparx5_register_notifier_blocks() -> cleanup_netdevs

  remove():
    sparx5_unregister_notifier_blocks()
    sparx5_unregister_netdevs()
    sparx5_ptp_deinit()
    sparx5_frame_io_deinit()
    sparx5_stats_deinit()
    sparx5_mact_deinit()
    sparx5_vcap_deinit()
    sparx5_destroy_netdevs()

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:

v2 mainly addresses the comment from Russell on v1, saying that a
minimal initialization should be done after netdev publication. This is
now done by moving initialization in sparx5_start out to proper init
functions. This also means that no initialization is done after netdev
publication in v2.

- Drop v1 patch 1 ("call sparx5_start() last in probe()"); PTP IRQ
  handling is now a separate commit and sparx5_start() is eliminated
  in the final patch.
- Add patch to move PTP IRQ handling out of sparx5_start() into its
  own init/deinit with cleanup label.
- Add patch to extract FDMA/XTR initialization from sparx5_start()
  into sparx5_frame_io_init() with cleanup label.
- Add patch to rename sparx5_start() to sparx5_forwarding_init() and
  change return type to void, eliminating sparx5_start() entirely.

Link to v1: https://lore.kernel.org/r/20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com

---
Daniel Machon (9):
      net: sparx5: move netdev and notifier block registration to probe
      net: sparx5: move VCAP initialization to probe
      net: sparx5: move MAC table initialization and add deinit function
      net: sparx5: move stats initialization and add deinit function
      net: sparx5: move calendar initialization to probe
      net: sparx5: move remaining init functions from start() to probe()
      net: sparx5: move PTP IRQ handling out of sparx5_start()
      net: sparx5: move FDMA/XTR initialization out of sparx5_start()
      net: sparx5: replace sparx5_start() with sparx5_forwarding_init()

 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  15 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   9 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |  34 ++-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 253 ++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  12 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  18 ++
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   2 +-
 7 files changed, 196 insertions(+), 147 deletions(-)
---
base-commit: 17d0056f71b13050317a662a505b1a36fb7009e5
change-id: 20260216-sparx5-init-deinit-037cf165c62e

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


