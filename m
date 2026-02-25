Return-Path: <netdev+bounces-260808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGcgNQa8nmnwWwQAu9opvQ
	(envelope-from <netdev+bounces-260808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:08:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F7194A9A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B6D302C2BB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6C376BF8;
	Wed, 25 Feb 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gigsq7bb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F936E499;
	Wed, 25 Feb 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010412; cv=none; b=RA7b64hb0kqaG9LReB5Bkt0bG5+V1EpdIxcU8If4SIPdFeAvFFueZtER6d3o91Pg8l/kEFawS1CqMAaYkszX4bbsZhbnFnX30YE7L2V5xiaLZJ9p+EGUIv4CagsT6tAlFcKuQqer+KlxKOw5YmaeyLdeUBFc7hdJIor4qa0qb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010412; c=relaxed/simple;
	bh=Rd8pBFRnXnJ5AAxlXaHhnrRJoWW4lC1dGDjHsSzEHx4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=axQnReYGvRxk0aU1yrBNWH6n5+Hp89D/KRhxoHOu7ug4m1JgzA46w3wV2iSXaxYiFlW9odniwG+4h0pUQnPnQPAwtkpJt/l4YYpeSGw3YjmfiG9eV5S57TkKs60nSNxY3/CosMIL+FIsDu+l3wa7ilzD292T/gxEUK5PL3OEWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gigsq7bb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010407; x=1803546407;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Rd8pBFRnXnJ5AAxlXaHhnrRJoWW4lC1dGDjHsSzEHx4=;
  b=Gigsq7bbvYvUr8xntrZg0MHCqpUdcZZDav5cRDxBgybyeWy7nnLUS92+
   QF5lMgvf7N23qoj+ptMgi0eJHi4biHqryrqzB5bVoL0+Gt2ARWdIuk+Eg
   jVzNxbam5QDlINkxA/te5IevX01zeDEdMbiTNAJvB8cVQoC77LQGHIiXd
   aNTPb/59FVHk68t4Vqy4ceVGqvLoupJRZkFdq1yCrCcp++8ODZpblecLk
   QWq6iqIzW15Np5dJhpKDs1kxovGDlw53dfAasaJqYL3BxENuVO1UVP+iZ
   CBOcSD4wjqWsvmiI9DInhF1mMZShOx87b8ktf3MVagoDgYuDGoAJy1Vyy
   A==;
X-CSE-ConnectionGUID: BbhGCtIlQZOkUhkWOAVukw==
X-CSE-MsgGUID: rC2Dz5dBSou9sgbq3vMbFw==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="221112785"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:06:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 25 Feb 2026 02:06:07 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/7] net: sparx5: clean up probe/remove init and
 deinit paths
Date: Wed, 25 Feb 2026 10:05:23 +0100
Message-ID: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFS7nmkC/x2MwQqAIBAFfyX23IIaGfQr0SHsVXvZQiWE6N+TT
 sMcZh5KiIJEY/NQxC1JTq1i24bCsegOlrU6OeO8cdZzupZYehaVzCt+mG4Im/V98A5Uwytik/J
 PJ1JkVpRM8/t+7oHzwm4AAAA=
X-Change-ID: 20260216-sparx5-init-deinit-037cf165c62e
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260808-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA4F7194A9A
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
paths and remove() follows the reverse of initialization order. What
remains in sparx5_start() is only hardware register setup and FDMA/XTR
initialization that does not require cleanup.

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
    sparx5_ptp_init()
    sparx5_vcap_init()
    sparx5_mact_init()
    sparx5_stats_init()
    sparx5_register_netdevs()
    sparx5_register_notifier_blocks()
    sparx5_start()

  remove():
    sparx5_unregister_notifier_blocks()
    sparx5_unregister_netdevs()
    sparx5_stats_deinit()
    sparx5_mact_deinit()
    sparx5_vcap_deinit()
    sparx5_ptp_deinit()
    sparx5_destroy_netdevs()

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (7):
      net: sparx5: call sparx5_start() last in probe()
      net: sparx5: move netdev and notifier block registration to probe
      net: sparx5: move VCAP initialization to probe
      net: sparx5: move MAC table initialization and add deinit function
      net: sparx5: move stats initialization and add deinit function
      net: sparx5: move calendar initialization to probe
      net: sparx5: move remaining init functions from start() to probe()

 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  15 ++-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   9 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |  27 +++-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 149 ++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  12 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  13 ++
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   2 +-
 7 files changed, 135 insertions(+), 92 deletions(-)
---
base-commit: 17d0056f71b13050317a662a505b1a36fb7009e5
change-id: 20260216-sparx5-init-deinit-037cf165c62e

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


