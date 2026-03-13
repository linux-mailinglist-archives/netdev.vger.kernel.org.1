Return-Path: <netdev+bounces-267468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLpbHlwbtGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:12:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D210F284A68
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA093278582
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFC3314B7;
	Fri, 13 Mar 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zTKUO5Dm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD7336897;
	Fri, 13 Mar 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410799; cv=none; b=aPJigecIIOIQJUc9Z1nUqu0LFO/uJA57UFYBeACMYNgEzpuXO4LLvyX1BDGzQ4AytoMWxfpCm5SOoZuEq5gPkKJkrH64GwQJCav/vH2EaV2wvoC1weigQ1alANRYCJ9zCCEFstcNd73rZn8xHV68P+Ga5T4BFIo4eKAMjkabj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410799; c=relaxed/simple;
	bh=FiWJuaTAV456KJEFIeJ+agwFPFQTg9TTp2utqg9M0Sg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dpy888eiUHtSXCXk/9yjj4UIlhRcOrGSttLUFZxFlUVr4ytflZQpV6VPJWaBP17EPEuQMCDG6CjX8euvOwgv8JMYjC0UZoDE9M3pOJre9uHuYsRkCMvsJ41Xi49kaHWLJOgD5OjmAymk4osjYb2YR6NDJxeoH9ctw6wXV8jE3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zTKUO5Dm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773410798; x=1804946798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FiWJuaTAV456KJEFIeJ+agwFPFQTg9TTp2utqg9M0Sg=;
  b=zTKUO5DmlVDJXjDZwIN8OXWO+e5Et47X760YUgbRQxHwl/dJELhsViSM
   O45CMZziSfQTG+Wg0VVR2q6AwFtBLxYIQd2sPZIpB+ou22PJN2jMeP5tI
   A5CSUz2v+K7TCNsi0O3WqSNwRmOjpRM2wZrg9XRaIRIg/yiPtRaWnnCMn
   mYs/O/XfazXkEmR/FwEoTmYYF8ral4RmJnWXOVvFAADGVgfnZQxYOVoK1
   s/4JkejqulhUqXLS5xYKG7FjpRjkmJTwM4VjRm0Wgp39BsEu/tAJcEzV4
   mExpHgXE5Whj70xyHKvB1xs583iAkVZV2qXNClLLx07VEhfS2/55DDi/x
   w==;
X-CSE-ConnectionGUID: CnTz56B+RliMtS1TY5Pc2A==
X-CSE-MsgGUID: tdVpSKU7TfaqqIFKJLwr8w==
X-IronPort-AV: E=Sophos;i="6.23,118,1770620400"; 
   d="scan'208";a="53872935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2026 07:06:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Mar 2026 07:06:32 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Mar 2026 07:06:31 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 0/3] Initial support for PIC64-HPSC/HX Ethernet endpoint
Date: Fri, 13 Mar 2026 07:06:07 -0700
Message-ID: <20260313140610.3681752-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267468-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: D210F284A68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
revision register reads 0x220c010e.

One particularity of this instantiation of GEM is that the MDIO controller
within the GEM IP is disconnected from any physical pin and the SoC rely on
another standalone MDIO controller.

The maximum jumbo frame size also seems to be different on PIC64-HPSC/HX
(16383) than what most other platforms use (10240). I've found that I need
to tweak a bit the MTU calculation for this, otherwise the RXBS field of
the DMACFG register overflows. See patch 2 for more details.

PIC64-HPSC/HX also supports other features guarded behind CAPS bit like
MACB_CAPS_QBV but I've omitted those intentionally because I didn't test
these.

Thanks,
Charles

Changes in v3:
  - Fix one more "p64h" -> "pic64hpsc"
  - Remove .clk_init assignation since it's no longer required (patch 3)

Changes in v2:
  - Use separate compatibles for PIC64-HPSC and PIC64HX
  - "p64h" -> "pic64hpsc"
  - Merge patch 2 into patch 1

Charles Perry (3):
  dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
  net: macb: add safeguards for jumbo frame larger than 10240
  net: macb: add support for Microchip pic64hpsc ethernet endpoint

 .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c      | 15 +++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.47.3


