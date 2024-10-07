Return-Path: <netdev+bounces-132864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA899397D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122651C2155B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A418C351;
	Mon,  7 Oct 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Syq8Pbjt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5C18C03A;
	Mon,  7 Oct 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337461; cv=none; b=OuKBNO+CMkx+5+g5qIeX6CtcWgqbH137z0rpZvEsqRife5bkCI0GyuBFmFlqHDGsX3s2etzhV03QVjXhiM6rjPYvSq5rigPt9THaLCHeQgP0N1hhuiyw9shbap40PobvD8lvB5PP+rC8/mfzunuSB4/vt95c6BUlF9pGJUsjr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337461; c=relaxed/simple;
	bh=SSGYF4xheaCEM3eFQW6XDhQ+RluuReYD8rH3Q6Rs114=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orIh+tNgfg+zckgrrZqSVSoun4VzGHPDpPcqYnHnP6BIMFvcQ3YIq0LowohQj+rPr907WNIqq9j7mjcqk8NwedlBpou5Xggxqlq3e1rst5YtiaHYbo8C5eZWj/BkiBPyxMjhJKD59gf+tcOe3Rn8nVYUlu91LlewTUw2plaV4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Syq8Pbjt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728337456; x=1759873456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SSGYF4xheaCEM3eFQW6XDhQ+RluuReYD8rH3Q6Rs114=;
  b=Syq8Pbjtg5CRl92x333aL5pTv/PYoYwEjJ+EbsqFS1shZVPMjLyoIcum
   1nr3GuD9AAJMdijHGN2zY3wbRqSTw3nIzUX2pDgybW82droim7roseP0U
   NMU+OW6R5jvXvD+UYBmjw5mGmu4dxq1ndsZ8BGi8ZF6Niip96DJWuK/DU
   jN+G1wjByq0HtDGsMN3nbxYBWay1Y+IbKbPDFySzt5Q/rxM8Q4XVb6fak
   B9GnLvl0ovg3x42CuTuOfDmX+YqxECP4IExevSdsze5KDhp7G5RWTJQKv
   sfanIfQoShVkLRxPUOWMVoclZ4nVd30yHUkEcbyguE507MUDIysbwcVAZ
   Q==;
X-CSE-ConnectionGUID: +hgdsMTpTiu4UnF2UBjE1w==
X-CSE-MsgGUID: CJeZfg/gTB6tBXhvvLdiaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27675551"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27675551"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 14:44:16 -0700
X-CSE-ConnectionGUID: WCqZG9RUT22pMpTPiWMZ9Q==
X-CSE-MsgGUID: ODrwzj+6QFuEGQHRgKUb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75449453"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 07 Oct 2024 14:44:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH iwl-next] ice: Unbind the workqueue
Date: Mon,  7 Oct 2024 14:44:07 -0700
Message-ID: <20241007214408.501013-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The ice workqueue doesn't seem to rely on any CPU locality and should
therefore be able to run on any CPU. In practice this is already
happening through the unbound ice_service_timer that may fire anywhere
and queue the workqueue accordingly to any CPU.

Make this official so that the ice workqueue is only ever queued to
housekeeping CPUs on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
Resend of: https://lore.kernel.org/all/20240922222420.18009-1-frederic@kernel.org/
- Added IWL and netdev lists

 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 179631921611..b819e7f9d97d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5904,7 +5904,7 @@ static int __init ice_module_init(void)
 
 	ice_adv_lnk_speed_maps_init();
 
-	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
+	ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
 		return status;
-- 
2.42.0


