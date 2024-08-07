Return-Path: <netdev+bounces-116632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0794B38B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991311C2090F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0F155301;
	Wed,  7 Aug 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rBJF8ekD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9B1509A5;
	Wed,  7 Aug 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072842; cv=none; b=T9Kk0eeHNaZtzVXztTi223ATrTqgHSoWr9eGdYd/ppw+asaJcCM+Wa41/2j15NNeFwI0J1qbHwu6/q4qvRZ49NTshvO/NEfxyMePUpKz9UfLIjBescmQ1jQyqa+RCDmZKK6ktYSS5yCLQmdluKuzAHxSu4j8ffM6/gId6zBPv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072842; c=relaxed/simple;
	bh=yu0s7f/31s9nHObDzHBAAC3CAFDeW5WunjVX3QGCCIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/ltHEWQVBPZFtY1nSjLe555ciGJAKDoZzVE5U0wTPdBMgXsCFhde8r6IZKvCQIPVTKf/8HMAlB9g6Fj+goE+LaQ6Yt81VI2l+/2NF9AtiDV4MihOKQf/odfHDyRD8Bgk9Yoikis4bdMOEGemQsESATMRWnH5N+D/j/gu7k+pSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rBJF8ekD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723072840; x=1754608840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yu0s7f/31s9nHObDzHBAAC3CAFDeW5WunjVX3QGCCIY=;
  b=rBJF8ekDFMQNi1U9aTUVjHLbMXEkAgyJcfvZX9hZ84CeBX1NHj+WKMzv
   A6HgzsTpziMQqXXrtalzJQdVj8AehZERuxRVyU8hQmr3IOJGizCm+arT/
   6OaQPfpmVi5cZ3cTB30a1rhUmVKQ6N8JVkN3J2fWElc7khVdj1VAqJeKC
   REGKoGjkkuE0JpkPf0jJrMyOEyp4eVIxC6j46MEb3fiAWllCMks2wxVuO
   3kln8a0G8eswwtfOrEjVTMOqtMDryQfpF1q4A3O1JHOX0BRQSZTt2WUEA
   xYPBWQBLPsUS73j6UuMJwObXSP2kgNW1l4S2iu/lEeFUiWUvj0AS7xziC
   w==;
X-CSE-ConnectionGUID: 6+Ttp1hWQ4GNKoiN1h/CJw==
X-CSE-MsgGUID: z+MXDIH7QOmtfYzaois+0Q==
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="197649397"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2024 16:20:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Aug 2024 16:20:15 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 7 Aug 2024 16:20:15 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Wed, 7 Aug 2024 16:20:21 -0700
Message-ID: <20240807232023.1373779-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

This series of patches is to add KSZ8895/KSZ8864 switch support to the
KSZ DSA driver.

Tristram Ha (2):
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
  dt-bindings: net: dsa: Add KSZ8895/KSZ8864 switch support

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c        | 130 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  20 ++-
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-
 include/linux/platform_data/microchip-ksz.h   |   2 +
 6 files changed, 172 insertions(+), 13 deletions(-)

-- 
2.34.1


