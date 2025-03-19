Return-Path: <netdev+bounces-176078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B075A68A68
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA019C6F90
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAA25486F;
	Wed, 19 Mar 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROnndb5T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C32AEED;
	Wed, 19 Mar 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381902; cv=none; b=MRHofMd9G7ILfvH2s4qX3AR7gTua+kE0Wv+0PtFOUX3EgYFofmY9VkNyoREmm69peGo5R7j9thkv6u5d+m3GedHjV1tkq7wnaLCB1sIvw4AZPQlPF/H9N+99YAtxTuPlfgh5FOOghfvzjjCEt/fZcHDO4E7G2cpaev8NkpqRsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381902; c=relaxed/simple;
	bh=sKvwfjsRTfkQXantG3ih0cTasoHqjKHbz3D9lnpMmmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzv0zW+zOAGZrkS6La16F6w04P2A47CyT0s1PvTxTDWhZH5uulV+/1BVLsuvi6fJpFKDhTFbID+Yf/2AWQtBiG3uSqCpwKd1lHK3rIj/5iKHtU5j1oPJuiAGiPgirgHIIym2n8KL2+qNS+hdde6AGVlNtGpkHk6nL77uxuK8sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROnndb5T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381900; x=1773917900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKvwfjsRTfkQXantG3ih0cTasoHqjKHbz3D9lnpMmmo=;
  b=ROnndb5Tqye900eaAvAwaIaP9t9Yj7Dh/eqQ8TpQLgXAL+TzKxciIyZm
   16oKmTqHsMeVZ+yWS4yXlFRxfgVNq2dssjJskgS5/78ULdM/IITLmfkxn
   I8RSngcv6jOF2GgZtqPDlDZUPpBiqxlcIorh33l7Z06pRM6z6ck2TmYDn
   h8z4l4qfigK4GxcrgmSTt8nxtIaUzWU+PrawdnOlKuTRkx+YSAvxdr28T
   cLjmF5JHXvYiXCbCHzlofjdjiqAlUnwzOC67uY0hAnHR/HqhWx9CdTnTG
   3ilORPGr+BhkCXydJoogbBabz+Zi9jeeH7YbwSDioZlurDUHitDiPvSCK
   A==;
X-CSE-ConnectionGUID: p+Mnm5arRsmFIPzyPdkMMg==
X-CSE-MsgGUID: /mQ/nF6aSSme4xXjypZ+eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="31144445"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31144445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:58:19 -0700
X-CSE-ConnectionGUID: H0FQVJToRXqAoBBKVP/mxQ==
X-CSE-MsgGUID: ubkkE9CaQ2Ouj7CVbTC+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127639596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 19 Mar 2025 03:58:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 97A1014B; Wed, 19 Mar 2025 12:58:15 +0200 (EET)
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
Subject: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid potential string cuts
Date: Wed, 19 Mar 2025 12:54:33 +0200
Message-ID: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PHY_ID_FMT is defined with '%02x' which is _minumum_ digits
to be printed. This, in particular, may trigger GCC warning, when
the parameter for the above mentioned specifier is bigger than
a byte. Avoid this, by limiting the amount of digits to be printed
to two. This is okay as the PHY maximum address is 31 and it fits.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..3b18c241f33e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -309,7 +309,7 @@ static inline long rgmii_clock(int speed)
 #define PHY_MAX_ADDR	32
 
 /* Used when trying to connect to a specific phy (mii bus id:phy device id) */
-#define PHY_ID_FMT "%s:%02x"
+#define PHY_ID_FMT "%s:%02hhx"
 
 #define MII_BUS_ID_SIZE	61
 
-- 
2.47.2


