Return-Path: <netdev+bounces-192945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D30AC1C98
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF89D502940
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6522258C;
	Fri, 23 May 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uqwcqXph"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B518DB2A;
	Fri, 23 May 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979300; cv=none; b=V71cuzg1fVVGFeOFCANJe7d/ILeWhtKllIzEw5MmsCZZdsszIOWQZ/DpcF/kln67D7p4UOr8gl4WQZTNScYU8zj2WFrdZ0WiRsqgAmEnbBiSwfZt2i21kPQOu91hE2U8W7Fil4zqxwE70Bn/2YlnsboNXCmnCmUKS7skjxh1iTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979300; c=relaxed/simple;
	bh=NceQnpdfOZIJqIWys4LasG+/ticwXG/CxHFKsfXd1GA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJLhSKQwzGOXY9nAIaoxJxWMGLV/sZWRMyvWXqES5K6Nh65dl6ij/++JlWS9SNM6wmLkqH2z/LksrrShKKDYJmcWuIj51A0egdfZqUnbpWf/onRJhGr5wn/KDJDJqCU+qkm3L/gqefUjSGVN6t3LXzBGHUFfk1+t0b+jB4MF3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uqwcqXph; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747979298; x=1779515298;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NceQnpdfOZIJqIWys4LasG+/ticwXG/CxHFKsfXd1GA=;
  b=uqwcqXphXT0Npgxut/XXyzJGLJiDHR9hParVCdWRKc25w2lPJ40dCw27
   xIk+jp2XJ87+fM7U/28oLTFp01ns7rfFYka1oJ20spEhWLVXCVWQcCSWv
   CDOgyeL1a6wMkVM34rZ9Y6K3X10kKBlz2L6TRZUdvcfP0J7TB+TxbXWTS
   SeMZ5drk62rziqh9AWuLi+1omPlRbFe1NRvoMM4WyWJoV2ejvnwoXwjfa
   tpsTvRRlQWPJ2BDjGiH+jzQR7tsaxFnObhD2jHIQI6YsCsEyXJHqtz5zU
   31LPJZVNPyzzmHzB9HXG01J0+VvSdTF1zG82P1HSTD0GXlZ4Mxdz4fTuw
   w==;
X-CSE-ConnectionGUID: LGngJwnIRy2YdRhcTVLYQw==
X-CSE-MsgGUID: cq7XLtY0RG2ElDPixosByQ==
X-IronPort-AV: E=Sophos;i="6.15,308,1739862000"; 
   d="scan'208";a="209485738"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 22:48:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 22:47:41 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 22:47:38 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net 0/2] Refactor PHY reset handling and
Date: Fri, 23 May 2025 11:13:23 +0530
Message-ID: <20250523054325.88863-1-thangaraj.s@microchip.com>
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

Thangaraj Samynathan (2):
  net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
  net: lan743x: Fix PHY reset handling during initialization and WOL

 drivers/net/ethernet/microchip/lan743x_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.25.1


