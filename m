Return-Path: <netdev+bounces-284729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIh0F8rt+mn3UQMAu9opvQ
	(envelope-from <netdev+bounces-284729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:29:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE64D73AC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647C5303FFA3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2334371045;
	Wed,  6 May 2026 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LiCVY/yE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CC35E955;
	Wed,  6 May 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052371; cv=none; b=GX1qKVBu6hhG8SyblxXFTIqojhI+NxyWKB6F+t0Yw98SD/vP1sMF1uIHyI+qjy7ej1wUPdTd2Jqmr9Hw1G+hf29jENMuerz4FSkXh9PUmQAnLMBgn984b79HB2oMaXT4Zd+B2Kugu/rFGGMMlV9y6VbgMFDpvbTPAjLipVnV4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052371; c=relaxed/simple;
	bh=FUgqcwlqHZvuXQFkTp2cH0PZJLSFbwKOjopx/wLUl0s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nch8XZMVVvwpzqhsbGGJbPqzFv5xOzNZEii3lr8LhuryoKLEZxmuTMFf3sh2zv57BW3A+yIsD/yPYNfWiDqgK+tqiDuWbu2iRUvwfba11CIuL/SKlXYyQ2w+6EJSLkH0z/5NS+/YosZ6NzwuzR4giTb8Lld8gQ3Ak+vio8/bO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LiCVY/yE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052369; x=1809588369;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=FUgqcwlqHZvuXQFkTp2cH0PZJLSFbwKOjopx/wLUl0s=;
  b=LiCVY/yEz5UogSg6oR3mknMHbfh0y+VfEpwDJhO0Cdw4ydfsQTfCXuBE
   6ICQF/86Yq/mEMTzELNdpp5/clzv/qILoGzzY3vd4iBBhB+L0wHDdp4Mg
   j10/dz5GSkKv9CkH9Jv0Srb4aT/oTMorYuFqHBusO5qrQTo3jjEFN6P00
   ciyn9BuQSGYlmssP1pHH2ifpkqRzancStT0lQf4YDFhV/bRAtz14EnhRr
   ZtHqXBTXzJ6vRbugOfPMwZSroN03gZIfnniagCejs5Q0vCe0Nz9qKCdLH
   hlCUfCXuCcIPijaxUkx7car/w36E40OeWuTpz7H7yNLFS7s9jxy+eU7TL
   A==;
X-CSE-ConnectionGUID: mdJjxWYtRtGSZSmgn51qzA==
X-CSE-MsgGUID: wDek4DCXQ9qsBUc39xrVEQ==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="57515437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:26:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 00:26:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v2 0/4] net: sparx5: misc fixes for sparx5 and lan969x
Date: Wed, 6 May 2026 09:25:35 +0200
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/s+mkC/31OSw6DIBC9ipl1p0EUrF31Ho0LpFgnqUAYY2yMd
 y/hAF2+/zuAXSLHcK8OSG4jpuAzkJcK7Gz82yG9MgYppBatvOFCbHGi3TFyNGlX+DG+1/2Oo5W
 9ro3qxDRCzsfkii/Hn+DdCkMmZ+I1pG/Z2+oilWol2j/VW40CdT7QCD2qrm0eC9kU7EzxasMCw
 3meP+2h4lPLAAAA
X-Change-ID: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B7FE64D73AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

This series fixes various issues in the sparx5 driver, which also
serves lan969x.

Details are in the individual commit descriptions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Rework patch #2 to use ndo_set_rx_mode_async (Jakub)
- Link to v1: https://lore.kernel.org/r/20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com

---
Daniel Machon (4):
      net: sparx5: defer VCAP debugfs creation until after netdev registration
      net: sparx5: fix sleep in atomic context in MAC table access
      net: sparx5: fix wrong chip ids for TSN SKUs
      net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

 drivers/net/ethernet/microchip/sparx5/Makefile     |  3 ++-
 .../net/ethernet/microchip/sparx5/sparx5_debugfs.c | 26 ++++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  4 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 17 +++++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  8 ++++---
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  3 ++-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  6 -----
 7 files changed, 49 insertions(+), 18 deletions(-)
---
base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
change-id: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


