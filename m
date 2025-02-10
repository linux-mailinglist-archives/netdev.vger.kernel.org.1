Return-Path: <netdev+bounces-164762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685FA2EF72
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6701886CDD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A845235C08;
	Mon, 10 Feb 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuX4KIsS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3360235C04
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196896; cv=none; b=iPfhqXx7l8LWgFmt7yOlsVPabX3lunhq494ikj91hRgTm9rxXy+zIqve/QIFmiKDceaueV/TrdMpUlmCiT4ubObLcj2bPJBfWp+XnOUHYcjf5JeJgz3jddRe+kNGh0K3d/0acbjqzpu+lXBz8QS+6lVfWJF2IrEX/zmzz1pIHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196896; c=relaxed/simple;
	bh=eaVXXxlaM72F4eilC1sCE6YtTDVewjhTEDKE45VE+AU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swmXOB/1w9q8PGJifdCMygBT2peTraUpMqLH7GZ6XoGuEBr0XDJ9XHGt58AsBh+dkzu/NYNrEAwi6VYdEWdoSPmWdyIbvzYyzG7NLtcFe1PE+cEFNfto1CWUkg8ixYGTVhwjRyjpo2ct9SahzRX8QnMq1ftMUm74/0vN+QRHJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuX4KIsS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196895; x=1770732895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eaVXXxlaM72F4eilC1sCE6YtTDVewjhTEDKE45VE+AU=;
  b=iuX4KIsSXDPrdYEfTzdcQ9p+f5jhyckM9c6aw/drX1xOmcrU0P4LaKQN
   XE1kYq7YW1ZZJYYYPQNZMtatEx3nk1OVuua3aDoexS6fut2rrZmCia1uZ
   6C89b2+imbxb4NTtSO/7pbCdwGTftLu1iAZX5M0xvZgSVnIB1Z0N0wup+
   b0PgSdnfhz05M5/MLxxvOecPL/pSI+STs95v6okjmTmMRTmAVlqPLjTh0
   SkVtir9XRJjWfdL0sWL/oWlF9PI9EIDqdlmUZDRue88SK6/1zNNjNzdC+
   9b9lew6K+JMsiNMmevLAPL9AF+NBIeMSdVAi/x3+GMS0CTHjozhBAm+Mj
   A==;
X-CSE-ConnectionGUID: FSHN6JgDT5CS+AochwOQMw==
X-CSE-MsgGUID: eu5NOgqWRomkJSNAaDF1Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39927449"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39927449"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:14:54 -0800
X-CSE-ConnectionGUID: Xu8AkrUUSfK/1qUGHnqHQw==
X-CSE-MsgGUID: k01/QOPeSNKBZq0fE126fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117420999"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 10 Feb 2025 06:14:52 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 0/3] E825C PTP cleanup
Date: Mon, 10 Feb 2025 15:11:09 +0100
Message-Id: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series simplifies PTP code related to E825C products by
simplifying PHY register info definition.
Cleanup the code by removing unused register definitions.

v1->v2:
* remove sync delay adding from the series (patch 1/3). To be submitted as
  separate patch.
* fix kdoc (patch 2/3) in ice_phy_reg_info_eth56g struct

Karol Kolacinski (3):
  ice: rename ice_ptp_init_phc_eth56g function
  ice: Refactor E825C PHY registers info struct
  ice: E825C PHY register cleanup

 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 19 +++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 35 ++++-----
 3 files changed, 40 insertions(+), 89 deletions(-)


base-commit: 820e145d30facd90981914efefddb82c9786c963
-- 
2.39.3


