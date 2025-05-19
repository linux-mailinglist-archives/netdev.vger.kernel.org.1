Return-Path: <netdev+bounces-191388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B1ABB609
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AF818945B6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58162580E2;
	Mon, 19 May 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gsb3TWj/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C623FC52;
	Mon, 19 May 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639239; cv=none; b=Ah6bQ7kJ54i4/21MNy77MpYV+HQikXu7sm0roYdsE/eIsoCG+d13aaG4DhvIaFW5LkJpVRtQxhw9GkFvQMEUyiAWWEU6ibAacGUPalGtF2ReyA9BvfMFuc823O3FleQBQdqoygEoDRbSts5LE0teCIyZH4TecNoK/5hpC0pPEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639239; c=relaxed/simple;
	bh=Y+C59h/qCKqtCEBhRtM+dfq6uWu6DUbfGTucGvd/FNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WN0lckdoiytUVOyjZysL0YGW+MdH/5kqohxRKbzQ8/Bs7gKoDoFKeCLA457N13Ls20dHugtB3eAfcgwhoCkHKTRZ3uRluyZmCVdwb8W7NdyGSLfkQLoNQZti+iJLEn+VAq3Xj5mpYPSCpMSQp5f89JKInBgdYgyk6bqzfg42+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gsb3TWj/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639238; x=1779175238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y+C59h/qCKqtCEBhRtM+dfq6uWu6DUbfGTucGvd/FNA=;
  b=Gsb3TWj/1q8wyF9haA6I+WU6fzs8np1GRtUnNGLTm0DNp5K5I5DLkb3Z
   X2Dpy38xMiLkxjTjlddQGLQFmYcrHohd4DKhc35vc4noi02Le/0vzWCQZ
   18xKgkSOL45FhjkSKjtodEb8tU3SENnXJcK0AYNWGP8suRphKTY2mxPI+
   sBIypJDi661F6grmrX/6Ks0WKZz/5v5SmdorEkO9fegg4xxAxtNc0BmyE
   EcHoWxZZncL5auTjubccG2KBiPFycaW2Iut4f2Im04Zw4aKfjJwxhD8kA
   QYVELmQO8/vX7mGooXAHtFMHNoK/mbzhxw6M22PM9OZmKNCINBTNTzZOc
   w==;
X-CSE-ConnectionGUID: q4oOD9CoRvaI+9g/rfa++Q==
X-CSE-MsgGUID: h7FH46yASCOO7goIbrsVXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030685"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:20:37 -0700
X-CSE-ConnectionGUID: YyPRf72qRi2gzLQRKklzKA==
X-CSE-MsgGUID: mvKcYUVhR9WuQj+iar3zTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798719"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:20:34 -0700
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v3 0/7] igc: harmonize queue priority and add preemptible queue support
Date: Mon, 19 May 2025 03:19:04 -0400
Message-Id: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

MAC Merge support for frame preemption was previously added for igc:
https://patchwork.kernel.org/project/netdevbpf/patch/20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com/

This series builds on that work and adds support for:
- Harmonizing taprio and mqprio queue priority behavior, based on past
  discussions and suggestions:
  https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
- Enabling preemptible queue support for both taprio and mqprio, with
  priority harmonization as a prerequisite.

Patch organization:
- Patches 1–3: Preparation work for patches 6 and 7
- Patches 4–5: Queue priority harmonization
- Patches 6–7: Add preemptible queue support

v3 changes:
- v2: https://patchwork.kernel.org/project/netdevbpf/cover/20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com/
- Patch 8 fixes a HW limitation and should precede preemption support. Merged into patch 6. (Simon)
- Add Reviewed-by tag from Simon for patch 1-5

v2 changes:
- v1: https://patchwork.kernel.org/project/netdevbpf/cover/20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com/
- Move RXDCTL macros for consistency with TXDCTL (Ruinskiy, Dima)
- Rename RX descriptor control macros with RXDCTL prefix (Ruinskiy, Dima)
- Add FPE acronym explanation in commit description (Loktionov, Aleksandr)
- Add Reviewed-by tag from Aleksandr for patch 6

Faizal Rahim (7):
  igc: move TXDCTL and RXDCTL related macros
  igc: add DCTL prefix to related macros
  igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
  igc: assign highest TX queue number as highest priority in mqprio
  igc: add private flag to reverse TX queue priority in TSN mode
  igc: add preemptible queue support in taprio
  igc: add preemptible queue support in mqprio

 drivers/net/ethernet/intel/igc/igc.h         |  33 +++++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   8 --
 drivers/net/ethernet/intel/igc/igc_defines.h |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  12 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  56 ++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 116 ++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   5 +
 7 files changed, 188 insertions(+), 43 deletions(-)

--
2.34.1


