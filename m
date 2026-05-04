Return-Path: <netdev+bounces-283887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHupMiCy+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03F4C00F7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F39330162BA
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07533DBD65;
	Mon,  4 May 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mzVlF+Yh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA63793D5;
	Mon,  4 May 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905839; cv=none; b=Mjl0RhKlV8HTgx9DVD3iM2bCmAKnVIFQgF2dkIDfhnGXzZUJwOCdZ7pzlwoCQOxyHtK01hrI3IKwUkM8xgLULxdDlkE9GiMSr/ZNDi2eFgaUXkKAZdaz62nt/i6F2MzA+c53KL5cNgH2VTG8fp2Fge1caIK/HstzV5cza/4XXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905839; c=relaxed/simple;
	bh=B+3rQXr1c2ofu+6dPdrlrqmBajJw+3mDKksw7VUmPAE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=UMSeoEKqZTuIXma/AnknLxhNuqitjxFXg0HKt+QALXPj5ldoNInQBFYP5uTAR9cnajY0FxClvImx4len/DdJ/JhaGryLpnMG9LvXE9oCCVCS4y2FuzpzIMFQW/MStriO369r4ofec9Coz8eWzfTcuizp6E/nUWqe7AGYp4lJm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mzVlF+Yh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777905839; x=1809441839;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=B+3rQXr1c2ofu+6dPdrlrqmBajJw+3mDKksw7VUmPAE=;
  b=mzVlF+YhFG43GrbpaQDxdYZnW9IqgQKWcOnzZMAu5H2qhNu+yvfDNklo
   IbrhLp7Z7OKxZYneGRgr0T+zFDeKGc+R0cpkjvtWNCx1eEYDBEdNbUbbd
   CuVPrfTJm/qilj2kA3AoUDKtQDLjeicbTvBNSsWEND3F3afUd0AK5WGBO
   b1v/r8RnzcYU2BxQivyrKkmnIJv6ewPpP2J2aztd6t6KSgfWHhEYBddfx
   weOQHb5RTyHpDQml5Ef/EtbMq0CJc9rSLXsCCWnnVPve5kd8dp/80sh8Z
   hyV+7DNp8sE7NE8su31KfayCt4VXr7dbwDEve9PvonfF8OuQGP/Qz0Au4
   A==;
X-CSE-ConnectionGUID: 8/7Yu0V2ShWirtJf/0Cq8w==
X-CSE-MsgGUID: dWSrV0FGR5u3iTC6/vjMmw==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="288370922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:43:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 4 May 2026 07:43:57 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:43:53 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net 0/4] net: sparx5: misc fixes for sparx5 and lan969x
Date: Mon, 4 May 2026 16:43:41 +0200
Message-ID: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2w+GkC/x3LQQqEMAxA0atI1hOoRav1KoOLWqMGtEojUhDvb
 nH54P8bhCKTQFfcEOli4T1klL8C/OLCTMhjNmiljap0ixuLx4kTCcrhYqpxdcEam3Dw2prS1Y2
 aBsj/Eenr8v6HQCf0z/MCs//EO3AAAAA=
X-Change-ID: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 4E03F4C00F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series fixes various issues in the sparx5 driver, which also
serves lan969x.

Details are in the individual commit descriptions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (4):
      net: sparx5: defer VCAP debugfs creation until after netdev registration
      net: sparx5: fix sleep in atomic context in MAC table access
      net: sparx5: fix wrong chip ids for TSN SKUs
      net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

 drivers/net/ethernet/microchip/sparx5/Makefile     |  3 ++-
 .../net/ethernet/microchip/sparx5/sparx5_debugfs.c | 26 ++++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_mactable.c    | 24 ++++++++++----------
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  4 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 19 +++++++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  3 ++-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  6 -----
 7 files changed, 57 insertions(+), 28 deletions(-)
---
base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
change-id: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


