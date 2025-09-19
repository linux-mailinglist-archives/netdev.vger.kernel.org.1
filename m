Return-Path: <netdev+bounces-224653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BCB877F1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0756503E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A276246327;
	Fri, 19 Sep 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNhZO+GP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD31E5B63;
	Fri, 19 Sep 2025 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242061; cv=none; b=DDgRGghwuaBBZ9kcMCk3ys0mrjBxHFbykKAbBgc1WDijpEYWF3jMFUc8Gsr/gyaXxobHiWnut/uIsKZTSniGsrMnRRH1BOrN+kNmBBwu2Xk7iSGt7vFBTmPOqfNc7PuaY4oR8JzUcG8/9McZLIIKsZvgicRh61VVEI1jD2SsUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242061; c=relaxed/simple;
	bh=HX7DsyxBGaMFL1ZTU9HD2GcaEcXEcL5erdg7R3pOBHA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gWov1zPOvzEx4W58SGNywsEcPR2BQDphbqcAgRtrsZE4Mvwy++gC1Vo1gUUIQSsqa59dkoKfVeS3uORzh/+Suc5xyxzItBVKKg6KEyRWNztLPw7g8u/3Hx/sx4OwMYQ0XbUClyY5fZVb7yo3hTwEowe9KZ1+S4hsIU80Y8X5E84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNhZO+GP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758242059; x=1789778059;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HX7DsyxBGaMFL1ZTU9HD2GcaEcXEcL5erdg7R3pOBHA=;
  b=QNhZO+GPfp19N8y0hFXEzyIwyNm1T9RfE++aoXEiHMi8Z72UjrRELpv1
   QWAgmrLdZDeBF1N/UPogBIOVujczXP/Ly9XZMhPmhYGSOHZGk5AEAQIse
   hU7R8ZQdf8fBF826epOLwwL/1fYv5a0e/Z9zzFqAo597pPdXhcefCPyp7
   sh2zJ3l0qC2nK0qRUkj5Adki3bHm3Bz9fIiU1WZglHL5cvf09rkRuo6Jj
   b2uCIdo3VQGmyD8p42G9Y2WiuNU49pUSGtwoRLIq4PjjFo1tmGJ/GCNjk
   xC+1unTNm59gRbROpGe4SZKY/doIUfUrruPtJAAoQhedUsS3kdcqYNEO4
   A==;
X-CSE-ConnectionGUID: WrqNRzsuTley5L4lHkfvxg==
X-CSE-MsgGUID: 0i45RCJTQ16GWfjmZwRy6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60517624"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60517624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:18 -0700
X-CSE-ConnectionGUID: ikanVsL1SMW3I66cSsFLqw==
X-CSE-MsgGUID: xHoTpK5cTAGKLaleYZn0TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="180119985"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/3] broadcom: report the supported flags for ancillary
 features
Date: Thu, 18 Sep 2025 17:33:15 -0700
Message-Id: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMykzGgC/x2NywqDMBAAf0X23IUotRp/pfRg3Y2ujxiyKi3iv
 zf0ODDMnKAchRWa7ITIh6isPkF+y6AbWt8zCiWGwhSlsXmN44ROPvjuFgzDF3UPYY0bE7q57RV
 NZR9E5Cpb3iFFQuSk/wdP8LzB67p+ZagF0HUAAAA=
X-Change-ID: 20250918-jk-fix-bcm-phy-supported-flags-0796dddf7954
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=HX7DsyxBGaMFL1ZTU9HD2GcaEcXEcL5erdg7R3pOBHA=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGjMpQShhk66SBlyQFxzNLyw6cIN2+gwNdFlAIN64Pn1kagVW
 oh1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmjMpQQACgkQapZdPm8PKOhf7QEA72SG
 R3mwTliaNgT/zeGwho0x2BH1lXd8S25jMdTHeCEA/R1Q5QCD/uI6eEaP6dG+3BmKioxxYCXRta3
 khLQz4xAF
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

James Clark reported off list that the broadcom PHY PTP driver was
incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
the conversion to the .supported_*_flags fields. This series fixes the
driver to correctly report its flags through the .supported_perout_flags
and .supported_extts_flags fields. It also contains an update to comment
the behavior of the PTP_STRICT_FLAGS being always enabled for
PTP_EXTTS_REQUEST2.

I plan to follow up this series with some improvements to the PTP
documentation better explaining each flag and the expectation of the driver
APIs.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (3):
      broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
      broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: document behavior of PTP_STRICT_FLAGS

 include/uapi/linux/ptp_clock.h | 3 +++
 drivers/net/phy/bcm-phy-ptp.c  | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: cbf658dd09419f1ef9de11b9604e950bdd5c170b
change-id: 20250918-jk-fix-bcm-phy-supported-flags-0796dddf7954

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


