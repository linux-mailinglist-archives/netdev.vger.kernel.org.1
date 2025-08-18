Return-Path: <netdev+bounces-214447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA89B2994F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80D3BBEC7
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4726FA5E;
	Mon, 18 Aug 2025 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sNgfHIAY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A417A300;
	Mon, 18 Aug 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497131; cv=none; b=cm+1ciJd3SxnYEivQ/41OIJRNqIaawSRSRj/KH+qbVKkESGG5dBMpCFC5nIXMjBfOJmRnHZ4KCDQdS9JyVJciz55ZviQa42tqx1YD6KYYLV7bn/Bf76YbZ2FId1Bn//9bJgAg5be6AkI3bNRcoMHTMO+2sQCdE+b079ne/T3gQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497131; c=relaxed/simple;
	bh=b4y+xOJAyeQJFHpsb9bHaRAMa5KHZrCIkkWSVJFpknI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPwcYiRQOYblHv3189cIXy5jLzUWAA7dsZNkj3Z1PrQoeFpIsd2wDmEkIYARm1VxGpxwYltNTp+zFODf91mAnw+DZ9gnEUTiFd+lSSsAtt0pguXhi4+CDfLeX0roxYLIyuGorXFA0406UQo2+94yaIbN7bsi9kKm30YbUllvf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sNgfHIAY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755497129; x=1787033129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b4y+xOJAyeQJFHpsb9bHaRAMa5KHZrCIkkWSVJFpknI=;
  b=sNgfHIAY29D2qflws8C4h6UvD6yOfqT+FAm9tmby7+IXHotrwIVEV5+0
   4FCMMocsZ414W052yOnBvQJXmk3w4q+4/piaS7/WAAJx2Rnwb3X40yu9N
   P9T/eF3pS4UQGzdQwL4f0WPbhOqLQAuW7oyQYOw4SzJNPTvSm53+mlAKf
   XbriZ2AWU4rDCYv+4JTUMdYHgXHbD/R6dqWuwTi4SaNKwIGa5sHpkdsD3
   MFllSbpn93T/LfQl2biBdrxXpfkXM1K9mDjg4kGY5pxNUTzZp8lYyN5dG
   jA3W+6Xde0U6oygzss3D5nURO+Pr2W74pzfYQfe5Bt+xZ/5xFwlUT451S
   Q==;
X-CSE-ConnectionGUID: wiCCt1P6SCqaq7ADjJVoNA==
X-CSE-MsgGUID: yqvyF2tXSE2Y0lMIiA2/8g==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="44766265"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2025 23:05:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 17 Aug 2025 23:05:20 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 17 Aug 2025 23:05:17 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net v2 0/2] Fixes on the Microchip's LAN865x driver
Date: Mon, 18 Aug 2025 11:35:12 +0530
Message-ID: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series includes two bug fixes for the LAN865x Ethernet MAC-PHY
driver:

1. Fix missing transmit queue restart on device reopen
   This patch addresses an issue where the transmit queue is not restarted
   when the network interface is brought back up after being taken down
   (e.g., via ip or ifconfig). As a result, packet transmission hangs
   after the first down/up cycle. The fix ensures netif_start_queue() is
   explicitly called in lan865x_net_open() to properly restart the queue
   on every reopen.

2. Fix missing configuration in the Microchip LAN865x driver for silicon
   revisions B0 and B1, as documented in Microchip Application Note AN1760
   (Rev F, June 2024). These revisions require the MAC to be configured for
   timestamping at the end of the Start of Frame Delimiter (SFD) and the
   Timer Increment register to be set to 40 ns, corresponding to a 25 MHz
   internal clock.

Both patches address issues introduced with the initial driver support and
are marked with the appropriate Fixes: tag.

v2:
- Updated the register name details with proper names instead of using
  generic "fixup" labels
- Revised the cover letter description of the second patch to reflect the
  latest changes.

Parthiban Veerasooran (2):
  microchip: lan865x: fix missing netif_start_queue() call on device
    open
  microchip: lan865x: fix missing Timer Increment config for Rev.B0/B1

 .../net/ethernet/microchip/lan865x/lan865x.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)


base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
-- 
2.34.1


