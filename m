Return-Path: <netdev+bounces-224656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F69B87800
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB761CC19AF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C625744D;
	Fri, 19 Sep 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="advuets0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5290248F6F;
	Fri, 19 Sep 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242063; cv=none; b=CgD26nGwou+2Fam+wVse01ZUDBdMETJsIy93E9ORraCYBEJKBPOITxqbMsb3mYwk1GxrZldu07sa8NKL2s9RWpId/GjOjcxNgY6y+gBM6vpJBW+nsX1H0/FX0QdArfrs11DfzP/VlQd823XUB7lRL7lMTnfinLzd9RkQCG2MqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242063; c=relaxed/simple;
	bh=fM1oYtxAmTvcto6ypPmRdybLInTXWVbH9+IH/w812qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIIKpGUMvU3xOgnpwUG12tmwpLQiJzZqgHKjoqLgGaeSNUsCQui6Iz8p8HP+Oz46AqQtaBRZC2jS8rql67IKZt4vkju+gCsoKH+1Bi54rLriacpLt4acnx/eo/603NiCx3/SHmsC8cXCCMS6crNxoj4CRRBTrHV/tkoFnz0NW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=advuets0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758242062; x=1789778062;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fM1oYtxAmTvcto6ypPmRdybLInTXWVbH9+IH/w812qo=;
  b=advuets0XEFMQ1vYKBlekwXnN7p4+hWqJVxaZ/t/nW5kYKMC2Qq10JLR
   aTShBWdqTrbn6xWiCvsMLN3rVPzWgNDamXdTH5Su+JqEdLnc+UFPManB1
   greGxzYwR1778cqjQ1WmA1yfBGEW2Jf4y1X8BBUbdtROTHa847R7Ahklg
   5EUMyalPnk7d9OvWN14grDIxTHPFKPju1S6p2rctYZbIGgK5Ls8Kw+mCr
   cOT2twXJweM/VPLmhfMvh4z0o9BrgquxawNGg6N2hX20avZK/QQK56pRO
   d7zbwmgwXzM+jgHkGGJQ0gcCtN1soTA8XiC5/bviHB4dIwJ9nhuhlvvAJ
   A==;
X-CSE-ConnectionGUID: 7Au1tvgCQQ2QRDSutVqrUw==
X-CSE-MsgGUID: hvSN6gBOTtOFcRVWAJ/kYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60517658"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60517658"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:19 -0700
X-CSE-ConnectionGUID: nboOvlkuT9S0SY2qExoYpg==
X-CSE-MsgGUID: +sbYk6ONReyxqj0g+/ecvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="180119996"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 18 Sep 2025 17:33:18 -0700
Subject: [PATCH net 3/3] ptp: document behavior of PTP_STRICT_FLAGS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-jk-fix-bcm-phy-supported-flags-v1-3-747b60407c9c@intel.com>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>, 
 Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=fM1oYtxAmTvcto6ypPmRdybLInTXWVbH9+IH/w812qo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowzSzlVngdYNx84XJO9Xqj40NmsvS5O/Q3r7GKnvRJNu
 MwjFHe5o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIkElzP8FXs2+9XMwuSL7OGn
 ttrZXLl0nj3tlt5J17/RJcz7J2Ydm8HIcCDs+X4tdt/q/pR84/MvtPdX7PCvTEkxXnWxnm37n4n
 zOAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Commit 6138e687c7b6 ("ptp: Introduce strict checking of external time stamp
options.") added the PTP_STRICT_FLAGS to the set of flags supported for the
external timestamp request ioctl.

It is only supported by PTP_EXTTS_REQUEST2, as it was introduced the
introduction of the new ioctls. Further, the kernel has always set this
flag for PTP_EXTTS_REQUEST2 regardless of whether or not the user requested
the behavior.

This effectively means that the flag is not useful for userspace. If the
user issues a PTP_EXTTS_REQUEST ioctl, the flag is ignored due to not being
supported on the old ioctl. If the user issues a PTP_EXTTS_REQUEST2 ioctl,
the flag will be set by the kernel regardless of whether the user set the
flag in their structure.

Add a comment documenting this behavior in the uAPI header file.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/uapi/linux/ptp_clock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 18eefa6d93d6..2c3346e91dbe 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -37,6 +37,9 @@
 
 /*
  * flag fields valid for the new PTP_EXTTS_REQUEST2 ioctl.
+ *
+ * Note: PTP_STRICT_FLAGS is always enabled by the kernel for
+ * PTP_EXTTS_REQUEST2 regardless of whether it is set by userspace.
  */
 #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
 				 PTP_RISING_EDGE |	\

-- 
2.51.0.rc1.197.g6d975e95c9d7


