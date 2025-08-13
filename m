Return-Path: <netdev+bounces-213296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3AB24769
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627517216CC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF282F546F;
	Wed, 13 Aug 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZYzT0yNr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EB2F4A1F;
	Wed, 13 Aug 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081277; cv=none; b=n70dH+a6ZhxoiKGYTxZe55sMPBV03/euQHHMXYusf8Ymt6w5L2Jl56ZdABzQALqgtI5y5AgP7JAU4qvfo/EdRnCYqS42cLsIk6kvRN1ON1ITlRP9TvzZs3JU/ZBgheqFa6B+LHlAn0WluzCKSoDsu2Fl9TRmi0i59/5Aygx8ufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081277; c=relaxed/simple;
	bh=iRbkjK7yfKoB6p9YpxYiCHv3PRSbvUknBU0PCEu5ziA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ldko+C9y1JVbNdzOwzI5kc4N+lRJ2qm7KNu2hAi0Du1gM4g2SnflGC/CDSESgG8OeNfxXyFcw4yPUG2cp/1ZlSwjJYecLOL6JG917OKOyWlAwDRU88MUShuIZ5dtFtZizQkU8ZoR+wn8wwFdY/F8MVy4fSReJvwHYuot1U4idyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZYzT0yNr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755081275; x=1786617275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iRbkjK7yfKoB6p9YpxYiCHv3PRSbvUknBU0PCEu5ziA=;
  b=ZYzT0yNr8QBUrR90GS84EqYPfbWXbtzLXQ//G8mJJ4zJ1xj7FYahljol
   GvBOVn+OnhaLO3h5l8p3UhL+okG29k4HQbihTF1WwZdFndlDBZ8at4lUH
   RsTxA3yHoEsP2bvVRZQqaqA4jr/KP239+cFPRIgaoEzY7Bkzd9M0W3+63
   55pvt5hLYW1f8VvFdTA1b4yM5zs5YZ7bHZM2YPxwNlOfALeZEIYJD04K6
   8PBhrEuViIc0M+/JpJQhBU1kU3Bx4A/6/WroKcAlLK1jXNBTaL49KgT/B
   FSD6W63g5xs5ZnHpn1j/yHXB1q99N/YQ3sGUAJpjoYPbJEhemFMTYiCq/
   w==;
X-CSE-ConnectionGUID: hStUVHZhSPyX69GTAUHirw==
X-CSE-MsgGUID: obYHH2/DQh2crVmfHQgXRA==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44602921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2025 03:34:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 13 Aug 2025 03:34:03 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 13 Aug 2025 03:34:01 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net 0/2] Fixes on the Microchip's LAN865x driver
Date: Wed, 13 Aug 2025 16:03:53 +0530
Message-ID: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
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

2. Fix missing configuration for LAN865x Rev.B0/B1 hardware
   This patch applies a required configuration for LAN865x silicon
   revisions B0 and B1, as specified in Microchip Application Note AN1760.
   Without this fix, affected hardware may not initialize or function
   correctly. The patch programs register 0x10077 with the value 0x0028
   during initialization, ensuring compatibility with these hardware
   revisions.

Both patches address issues introduced with the initial driver support and
are marked with the appropriate Fixes: tag.


Parthiban Veerasooran (2):
  microchip: lan865x: fix missing netif_start_queue() call on device
    open
  microchip: lan865x: fix missing configuration for Rev.B0/B1 as per
    AN1760

 .../net/ethernet/microchip/lan865x/lan865x.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)


base-commit: fdbe93b7f0f86c943351ceab26c8fad548869f91
-- 
2.34.1


