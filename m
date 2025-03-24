Return-Path: <netdev+bounces-177096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78794A6DD5A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83EA16E219
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E847261384;
	Mon, 24 Mar 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBA/+gp5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8E25F963;
	Mon, 24 Mar 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827681; cv=none; b=rnOpKqHZbexVWYBE8DwdbpaTgCW7CnYUZR+uqF2QXvA/X6N6iDltjfJKPH+7NiJgZ0jA37IBQB60MXEyaL+nDzpz15bYiYLso0dZ5sJkSUkcUHvQaw/HcsNBYP3PqIYj1mZQWZx+SGim9TXcruZGgmGlqs5by8H362xjSoSF1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827681; c=relaxed/simple;
	bh=3Zof91lWD3nLZ3P7usuHkGaIG+jzELNo83GIF4XRpBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btFMM1EnJlr4KE1HLx47rTof69YhYC1dllNQI2NPh/4qzY+MEwYBCariFMa6PLiCziEsDIZyYzZNRkMK9l89NpKbU0r/ouoeetdu1UWMMnDWq+qw7i1Iy3A9/FvR5p4Jon+CaG3RbrhQL+2KCDq9RRrifzuhn4j5Zn9mlqE1cVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBA/+gp5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742827680; x=1774363680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Zof91lWD3nLZ3P7usuHkGaIG+jzELNo83GIF4XRpBs=;
  b=VBA/+gp5jO1vX/gfGFG893cDAoqBV3yrQpNi0nzN2gqOGYysIfWuJO9v
   bDWvSrEiBRx+HT0WlBoLa+tjSbeOOzHAHJ+0eUXlLonz/4XPXucKup4iM
   qVDys1cdyGdfjWThh1petWbBna7UtB/qicFeNMg3v66h+vS/17JzUlc+b
   B9w8Hi9Tc/Vis58C848puYiERXgyVVOpyhwW5pOqwjTEg87WEet0Zi/SI
   8Qv0ydgy8OWnRSG1R7bKMUnMFohUzh6buJlaNlZuu2DpFOZdx686vMhVw
   WWKuQl4hl3/1H83d2+drtFFoJ186nRhtzvZBy0YC9QwsZQ3jfX/R0ZHGL
   w==;
X-CSE-ConnectionGUID: TVrqICFMS4C6RGbLiKXk8A==
X-CSE-MsgGUID: pMIeBOWZRoCcArxmDGVAsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43192116"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43192116"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:47:57 -0700
X-CSE-ConnectionGUID: KA0XWa67QaWd+yHu7NrpSg==
X-CSE-MsgGUID: UGSEefHOT7GjJT8snXp6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124022003"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2025 07:47:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E65C912C; Mon, 24 Mar 2025 16:47:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v3 1/2] =?UTF-8?q?net:=20phy:=20Introduce=20PHY=5FID?= =?UTF-8?q?=5FSIZE=20=E2=80=94=20minimum=20size=20for=20PHY=20ID=20string?=
Date: Mon, 24 Mar 2025 16:39:29 +0200
Message-ID: <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PHY_ID_FMT defines the format specifier "%s:%02x" to form
the PHY ID string, where the maximum of the first part is defined
in MII_BUS_ID_SIZE, including NUL terminator, and the second part
is implied to be 3 as the maximum address is limited to 32, meaning
that 2 hex digits is more than enough, plus ':' (colon) delimiter.
However, some drivers, which are using PHY_ID_FMT, customise buffer
size and do that incorrectly. Introduce a new constant PHY_ID_SIZE
that makes the minimum required size explicit, so drivers are
encouraged to use it.

Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..5bb8dfb3d15c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -310,6 +310,7 @@ static inline long rgmii_clock(int speed)
 
 /* Used when trying to connect to a specific phy (mii bus id:phy device id) */
 #define PHY_ID_FMT "%s:%02x"
+#define PHY_ID_SIZE	(MII_BUS_ID_SIZE + 3)
 
 #define MII_BUS_ID_SIZE	61
 
-- 
2.47.2


