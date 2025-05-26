Return-Path: <netdev+bounces-193347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59215AC3955
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0CD7AA1D9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919571D6193;
	Mon, 26 May 2025 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GCWfh3BW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A01C5F39;
	Mon, 26 May 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237771; cv=none; b=ebVJpvl899VORTWDHm1pohUyRYH4e6abcgHK1AFlleAtBYvyT9NfsQYm/YvNxONZEYTO6vXGm9IzraGdJwsGGjB5MUPuiN9bJ4MSc/JCMg3h1C0zdyQ5jpOXHRPGCsCitA1A8z9mF4+FYQ8LoKY4WGgVBxXFHdCjyE9cABwq4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237771; c=relaxed/simple;
	bh=CDTIkRHRF1Q6zB+nRvd/gYo0v1esb9c+9rfC7MY0OJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QuxfNdS3+3jlDYZKGAkzMgc4+PkJfzOZFqosSTvqglrpPV61OYqTBZqf+giqZ1fNUUxIv7eiMno3huQbgp6AFGRkko4eOV85ZPonR6dTc9DqegvM3ykOUxQk67hw5pDgSUte+u1bkxMVeCbxPHbPq+2S1+NkqJUjMc+xTTrtrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GCWfh3BW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748237769; x=1779773769;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CDTIkRHRF1Q6zB+nRvd/gYo0v1esb9c+9rfC7MY0OJg=;
  b=GCWfh3BWtAFAlidYEKQHsCUDlz4lwwbyi42LfABkCZw+XQySgj332y53
   6+1kmoOswWTEsL+ZYQ+616osJhl7z7s/0jwYAOlZtO7cgVG4AUYHgFeKq
   UdPlnLBbOd33E9uey/8ybXr1BPhEECXOSknMVJcVZudwKBo8eGEZcOOFq
   LadCw/eYb5Fw8z+1hsxdDl/4U2+KBiTWI4oklY1t1ST/QdQ7Yr2aA3Nx9
   d/bcAYm/yTlgd3oY9qB/nvYrqf7HnKR3pKWZJzCMEHiUTCjnAWA1lSkJ/
   ZEs8VJUSArWooTCnmKZJ+c8v/bOcjGHgwVZ08ilK9wCvG1oNqDqftwbwc
   w==;
X-CSE-ConnectionGUID: JL4228CNQcalNKv+RnWdOg==
X-CSE-MsgGUID: 3vgrOgbRRZq7bE0130ew0w==
X-IronPort-AV: E=Sophos;i="6.15,315,1739862000"; 
   d="scan'208";a="209556938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2025 22:35:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 25 May 2025 22:34:52 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 25 May 2025 22:34:49 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 0/2] Refactor PHY reset handling and
Date: Mon, 26 May 2025 11:00:46 +0530
Message-ID: <20250526053048.287095-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series refines the PHY reset and initialization logic in the
lan743x driver. It includes the following changes

Rename lan743x_reset_phy to lan743x_hw_reset_phy 
Clarifies the functions purpose as performing a hardware-level PHY
reset, improving naming consistency and readability.

Remove lan743x_phy_init and Call lan743x_hw_reset_phy in probe only
This function only performed a PHY reset and did not contribute to
complete initialization. It has been removed to simplify the
initialization sequence. The PHY reset is now performed during probe
and removed from the resume path. Resetting the PHY during resume
was clearing Wake-on-LAN (WOL) registers, leading to wake-up failures.
This change ensures proper PHY setup without interfering with WOL
functionality.

These changes enhance the robustness of the driver initialization
process and prevent WOL-related issues during suspend/resume cycles.

v1
-Initial Submission

v2
-Corrcted Typo in commit message

Thangaraj Samynathan (2):
  net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
  net: lan743x: Fix PHY reset handling during initialization and WOL

 drivers/net/ethernet/microchip/lan743x_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.25.1


