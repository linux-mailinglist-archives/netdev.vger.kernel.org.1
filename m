Return-Path: <netdev+bounces-149807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19709E7910
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8518835FF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12B21B1AC;
	Fri,  6 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4nFRWSg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134421B18F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513749; cv=none; b=J/gFsvks+ugcA2URrC8A6EVYmjmhScJZApkRFLtSo4M68uzQTMWTRoPMYKAY/Xx4T9Z77Sm/XlkJ2X6xfSME5ANsZtDKC0QCCQWfcI9Fa25+Ow71OQ00QvN01MVUmVF9pgnMMM7MHTUmUtKuvxAV2p9/hPQHypoXGDwDMzSIWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513749; c=relaxed/simple;
	bh=gR1sxg1cn0Qokyxc/hiM02MD2O09PQ+A65RYC7cjSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSvdzIXz17+5GJ5oR3w6nUllIZIv/0jET4Dg4h8g+CIClGTu2j+bA/ixKb6geX920fiXPX6KRqDXvXM5NswmXUFJRPa5zuq/YzSPNMSWtQGKwRa1IjhxCP98DUQ2gF528bCbRTFl1Q/eIm776S0P2F1ZsnnpDrnXeuUG7gUZN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4nFRWSg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513747; x=1765049747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gR1sxg1cn0Qokyxc/hiM02MD2O09PQ+A65RYC7cjSn4=;
  b=L4nFRWSg2TUkZF0un7O12zWJFN0hjVuOVvbf2+7I8pSgfO/2HKSPH/Gs
   rOZcodP15ln0813SY+J7pXaiZUxL/F9o/SQOwjx+MAH43mVoOetTFe0ur
   i+nsUAR29Jw3GfEU4A4v3sFaaeniOWzrl2hGsY69bbh4IgKcIGSQdZhE5
   NJ0927kkAw+hXOiFuAWGXrA8Jox1F/6BQAa2i0JJsBibX9GXasMoQ06i3
   fuDv1VLwDY2Ek84l8m9fVRceglxw6uCQNkip2rILCaILvVlwHcaPHBzAT
   wS/ABukne8KKZLxFdWWK5fVd02uTiskhbvuO7gHeie9XG3zDfa0Og6rEh
   Q==;
X-CSE-ConnectionGUID: W+zY7wWUQT+rJSw4wHLWnA==
X-CSE-MsgGUID: cLhwrdXsRt6NC8hhvKOEKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33226553"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33226553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:35:46 -0800
X-CSE-ConnectionGUID: spIm76GgQPyBxP0mY7oTVA==
X-CSE-MsgGUID: Vq4jMdeRSxW7omgJfgxXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94301395"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 06 Dec 2024 11:35:46 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	grzegorz.nitka@intel.com,
	richardcochran@gmail.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net 0/4][pull request] Fix E825 initialization
Date: Fri,  6 Dec 2024 11:35:37 -0800
Message-ID: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Grzegorz Nitka says:

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking
the PHY revision only for current PHY and adding proper destination
device when reading port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as
a primary PHY lane number, which is incorrect.
---
IWL: https://lore.kernel.org/intel-wired-lan/20241105122916.1824568-1-grzegorz.nitka@intel.com/

The following are changes since commit 11776cff0b563c8b8a4fa76cab620bfb633a8cb8:
  net/mlx5: DR, prevent potential error pointer dereference
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  45 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 270 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 9 files changed, 207 insertions(+), 147 deletions(-)

-- 
2.42.0


