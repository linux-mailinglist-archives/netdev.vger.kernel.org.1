Return-Path: <netdev+bounces-57083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC192812133
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A86B20EAB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573A87FBD2;
	Wed, 13 Dec 2023 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nN7QwRHW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB6A3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702505312; x=1734041312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RMfvwaiF/sCzNRU5t+U++Tg5AMpwHvXf6SWBBAHgZ7k=;
  b=nN7QwRHWGTVjkYM9P0MrHcCAhNFMmp7xdlAHO3+mXtwd74PcUo2yQ1bV
   +vLEalADpPdZ/j7Nkoe2uQYR2VNM78P3bBzPVZQst4RWnGGnQrHA4Z6vY
   Vnl5orFU6GoPaY0UJiV7KfhQzXsyJ4tLLT/b1TmkbnPJVhY+Ubii8/mcf
   khs7ADUbi+G9q/EzI4Ry8IHlBiaH3v+7OaKbtz0sS3lE7Gz1+WsDGFZyO
   0/NIs+cSdmzNkxhFe4C7+aZGH+87EfOaH/8t/kMobJEdpYTEjpCy2724p
   AVWTWwuT24DuzmPytmNYX4vpXZgAzf9O3i3AFhSNaf7+sYidw5yOirDo2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392209628"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="392209628"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803034126"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803034126"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 14:08:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-12-13 (ice, i40e)
Date: Wed, 13 Dec 2023 14:08:24 -0800
Message-ID: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice and i40e drivers.

Michal Schmidt prevents possible out-of-bounds access for ice.

Ivan Vecera corrects value for MDIO clause 45 on i40e.

The following are changes since commit 810c38a369a0a0ce625b5c12169abce1dd9ccd53:
  net/rose: Fix Use-After-Free in rose_ioctl
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Ivan Vecera (1):
  i40e: Fix ST code value for Clause 45

Michal Schmidt (1):
  ice: fix theoretical out-of-bounds access in ethtool link modes

 drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0


