Return-Path: <netdev+bounces-212764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EFB21C48
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A7E2A87AC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B222E0B6D;
	Tue, 12 Aug 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDISj7LS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51D2E4247
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974041; cv=none; b=LQlcxe8la07fC6Muc9ARQTHO/tJ5Nt2zprUfpvxC3mCAxLba4ScnAqCxdJLiSEeJ/Xj3K6T5Hb89ZJTCm1ci9qcBRyUcrFfm1d0QUukho1YDbkp3KZTnE4r1QxS4/J6x9NFlLF21EVNYfZDtP2pBSCTMrtnwBge28WcTIpRSKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974041; c=relaxed/simple;
	bh=UaUPbdCMu84U9XA3Acq479SpwOPQHptEGSZ2V1MPSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBEC2CaOCDOTjUmtA2tIRBchFKUS3IN6m/adWY+mX1xtYluISm4Y2fenAHC0NGrlqNKYTUj1HblF+OIdmsmABw5ZOu/cHTKs14VdYiC9+6fB0TcUBi5LEqiYs8g93dIPWr/VDo+d3Bl6ovl6w3aozzzE1On4EbuZr7err8FS8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDISj7LS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974040; x=1786510040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaUPbdCMu84U9XA3Acq479SpwOPQHptEGSZ2V1MPSHk=;
  b=QDISj7LS6CVNGJ7XDOJtgCqVBCewabKNTpmOWMwiI07yo3lWAFN7hOUK
   aO+iqaKq/S67bRbu8XZA1Ef5QvHCsuDgLXBLGrfGtQ6fMs0DMyOigLL5J
   7tNhxgwVYne1BkmAKKS8GS59CJOYmL0YFcvcrxbTAY8Ok75Gkt3k7MqtU
   JHhs0GzkgcD115/iepPpHwH/z0oLTqvaBZcsXhXO5cWlfypGwqArJv1Li
   fej3bv0Oy9hoPKOp1N2xoRQY4dif4WNybrk0nVUMj4uixib8rt2HMUwBA
   t7nxnoG1MzQG0ZMNEM8/hI3HAYVSb1tR8+VzuIL7M/Y51R+G5eXRCuVKP
   g==;
X-CSE-ConnectionGUID: 1oxgm/mNTImt5+AyH+yILg==
X-CSE-MsgGUID: s+Z+HbZOQ3i3GhF01utYcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612774"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:20 -0700
X-CSE-ConnectionGUID: XGjQe3imQru8YrS1AcNfOQ==
X-CSE-MsgGUID: 7W2vNavqRxecXpUdX065uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327922"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:19 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 13/15] ice: reregister fwlog after driver reinit
Date: Tue, 12 Aug 2025 06:23:34 +0200
Message-ID: <20250812042337.1356907-14-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap libie_fwlog_register() by libie_fwlog_reregister(), which checks
first if the registration is needed. This simplifies the code and makes
the former function static.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 11 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 775581163e04..e76397ade68b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -290,7 +290,7 @@ static int libie_aq_fwlog_register(struct libie_fwlog *fwlog, bool reg)
  * After this call the PF will start to receive firmware logging based on the
  * configuration set in libie_fwlog_set.
  */
-int libie_fwlog_register(struct libie_fwlog *fwlog)
+static int libie_fwlog_register(struct libie_fwlog *fwlog)
 {
 	int status;
 
@@ -1096,3 +1096,12 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+
+void libie_fwlog_reregister(struct libie_fwlog *fwlog)
+{
+	if (!(fwlog->cfg.options & LIBIE_FWLOG_OPTION_IS_REGISTERED))
+		return;
+
+	if (libie_fwlog_register(fwlog))
+		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 3698759c8ebb..e534205a2d04 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -79,6 +79,6 @@ struct libie_fwlog {
 
 int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api);
 void libie_fwlog_deinit(struct libie_fwlog *fwlog);
-int libie_fwlog_register(struct libie_fwlog *fwlog);
+void libie_fwlog_reregister(struct libie_fwlog *fwlog);
 void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _LIBIE_FWLOG_H_ */
-- 
2.49.0


