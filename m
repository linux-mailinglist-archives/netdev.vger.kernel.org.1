Return-Path: <netdev+bounces-85914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E189CD33
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37741F23217
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC11474A4;
	Mon,  8 Apr 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTQHAi37"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36111433BD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610541; cv=none; b=kqyQLGlhZwCZZE+AE1RwRBXClMcB7JoNHiJjaiOeSmyAHvYw5xJ2t+WAfm0owstpaGnZfdWGHdKLXQMdcqZYeI0a1bJsDXim4vS73WSkQc7gn4CNiCy7kmT6Jry0OuIc9q5I+DgYIYtK7jyxEzdIbRdJxKKnqJeAP3bZHj/WrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610541; c=relaxed/simple;
	bh=gWKiIBmkuT8B2nmwlgXqx2LLHQ7aNAZ1aw5NhJY2xTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/6qSBmufjT46vfzcEEoyMylN4bekaZo6rt14gKdFwrmpXKNczpMMKJ/y5UO5rPB1AQV4PAA5Mk+t80Fog34L/I2h8VX/2YwXaWZUXvqXqzIlybdVu2hY++HHFK2Z9iuEEOlWTLLrhzQfbnjyykgaJ/xNLDWyxrUlkRu8UKrsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTQHAi37; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712610540; x=1744146540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gWKiIBmkuT8B2nmwlgXqx2LLHQ7aNAZ1aw5NhJY2xTc=;
  b=iTQHAi37NwWFndwXcSCsNKrR2klBrpeVCm3qiMUoenW7Tswl+ron9gP/
   krMsxAPthmzjbEhrUtojv0EHozSd0y5giBOMj0Pn8WPxLwXwfW3vS+82W
   rNYSA/+Xx9kEqNQT9Y1tAqJhhlRZ/wX5Dc3fzI/t2o+8TDV554o1+r1p0
   BL6rqDSBC0bO6Q4T3+jhG1runhjnArEo6UybW1HkWCDDGiKgsZ8fBP9qk
   r+5waJ8kKf2K9/xUcgx2HW+Gi0aKcazN4elEkGSoM4DgqdDEKgIFls8w9
   Nct2TcTmXn3oGS8Da9BPLIvlyIVDOhBaDPNL0kgbBO/HVP1bcphz6HNsd
   Q==;
X-CSE-ConnectionGUID: L6xn6EU1TxiLxZUeG3H8oQ==
X-CSE-MsgGUID: rHpS8ht0RqWKrXsH/y0fsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7764060"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7764060"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:08:59 -0700
X-CSE-ConnectionGUID: MfiOPe2sQtiMrAIFRChDMg==
X-CSE-MsgGUID: PkYFF04/TIS26jlTaZLGlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20128188"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2024 14:08:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	bhelgaas@google.com
Subject: [PATCH net-next 0/3][pull request] net/e1000e, igb, igc: Remove redundant runtime resume
Date: Mon,  8 Apr 2024 14:08:45 -0700
Message-ID: <20240408210849.3641172-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bjorn Helgaas says:

e1000e, igb, and igc all have code to runtime resume the device during
ethtool operations.

Since f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool
ioctl ops"), dev_ethtool() does this for us, so remove it from the
individual drivers.

The following are changes since commit 39f59c72ad3a1eaab9a60f0671bc94d2bc826d21:
  r8169: add support for RTL8168M
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Bjorn Helgaas (3):
  e1000e: Remove redundant runtime resume for ethtool_ops
  igb: Remove redundant runtime resume for ethtool_ops
  igc: Remove redundant runtime resume for ethtool ops

 drivers/net/ethernet/intel/e1000e/ethtool.c  | 62 ++------------------
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 -----
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 ------
 3 files changed, 6 insertions(+), 88 deletions(-)

-- 
2.41.0


