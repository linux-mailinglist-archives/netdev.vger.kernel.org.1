Return-Path: <netdev+bounces-60416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67381F209
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C991C22456
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972547F78;
	Wed, 27 Dec 2023 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="if5XSPO5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2C47F71
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703710852; x=1735246852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QSZHQHZthHODb1jnLPWdSD1pge1N16nzqpaQuYRMaGo=;
  b=if5XSPO5Eb1SDz698V4Me6EsOXYJEG2tUpqfdSZx98+EIXOTV5EKqxii
   g83EHLu65HLXu0foZzyeqvu3+e1wmVoLuPjgeeEeix6DuZB8Exivkz+hh
   i/VzfST5wXrDfIp5hVIl7vkwghzRdFriv4oybR25V+/+S0tnkRNTLXYWq
   AZT4csi9whtr4NanQVsbwSij/ZzNEVXYADIxkQ+o3pCYzXdczAf4Xzx+t
   0uGJwEyV26742ynEKRNTiDSWiTKMoIUJNMgId2OAuk4DJWGx9iyNRRMz/
   vIoGGCOUX5N1X1ywj1xFCl4L57nGMZC0lG7YQ0P0+R3+NVyPIC0/fy4ZQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427655621"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="427655621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 13:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="844258748"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="844258748"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2023 13:00:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-12-27 (igc)
Date: Wed, 27 Dec 2023 13:00:37 -0800
Message-ID: <20231227210041.3035055-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to igc driver only.

Kurt Kanzenbach resolves issues around VLAN ntuple rules; correctly
reporting back added rules and checking for valid values.

The following are changes since commit 49fcf34ac908784f97bc0f98dc5460239cc53798:
  Merge tag 'wireless-2023-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Kurt Kanzenbach (3):
  igc: Report VLAN EtherType matching back to user
  igc: Check VLAN TCI mask
  igc: Check VLAN EtherType mask

 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 42 ++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.41.0


