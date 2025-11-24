Return-Path: <netdev+bounces-241115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B61C7F6B8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EA2B340F2E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F42F068E;
	Mon, 24 Nov 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lt7PFREb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C852EF660;
	Mon, 24 Nov 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974104; cv=none; b=eCCn/ck9Druwd0yeyTK4wDLtcdXkZKzZs4vvlxlhnT7vRtq5/H1HiFNY9zxmc8eYDPB5hXYbY+VxzITZkgVbdOuOac7XVSa4dHvpbeEv0ybFbNVbnBhOq1ue45zSFQepGSjVHnVHWDzHHP6+cZuI2RnIeVWwbEW3FtTPlUZgTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974104; c=relaxed/simple;
	bh=CNYaofuYooeUvgz36F0ZuFirOsBHUvJbvAhxrpcfTjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8t8YHJYGEAb91NAmjYJGyUXo8yVJUFKGisJiPxYx4XQLRc6NlAsKS9oz9uCfeycpNupgBNYFDQuvfNDpHySCykKzLMM/nTFzJzoZo8wDy5N4K/D+1GAltiO05aGf0IEvd35ourxdz68L7nlX4ie6FJItU5IYhAFT9lhJyHagOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lt7PFREb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763974102; x=1795510102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CNYaofuYooeUvgz36F0ZuFirOsBHUvJbvAhxrpcfTjo=;
  b=lt7PFREbyfBkPpkdlQF3qFTnIaAIK7zbMP7AjaWHrMY5Fj9CWdE2Z0vE
   Y+R5exOpc/fNkjWyWQcsYeilGzgUT2PRWIJPWlZlylQRn44PA/5hFegkm
   VcK1HpVDiWf1QkL4qJsjsNjU6tyVjhLJ4KwWuD3HY5A63USEw2Up2oYYT
   YXr4JUlMF2c+AmmTEq/G18EWy+pR3NCk8ivBD50eaGwD0rg/Cw6teCUvU
   WRb08dLPwxSwcJfR6W224Zwh3PqNfQPYXHGUPeZpcC992X1+9YSqRqDT+
   DJ+gbS6qFzG9owuVVQR78avuiPTLQoPnFGP/Xh7EmtGl+4Nw+9BnqMG6w
   A==;
X-CSE-ConnectionGUID: yjJc+AahRnqcPsXsKFCsXA==
X-CSE-MsgGUID: tJHTFbypTgy97IdNvrVN4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65918440"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65918440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:48:21 -0800
X-CSE-ConnectionGUID: icS278v8RHGBUSwXuWdx+w==
X-CSE-MsgGUID: nldcpaOzTQ+8/xYJFpA0HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196729230"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 24 Nov 2025 00:48:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CC5216D; Mon, 24 Nov 2025 09:48:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 0/4] ptp: ocp: A fix and refactoring
Date: Mon, 24 Nov 2025 09:45:44 +0100
Message-ID: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the fix for incorrect use of %ptT with the associated
refactoring and additional cleanups.

Note, %ptS, which is introduced in another series that is already
applied to PRINTK tree, doesn't fit here, that's why this fix
is separated from that series.

Changelog v2:
- dropped patches under discussion (Vadim)
- collected tags (Vadim)

v1: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>

Andy Shevchenko (4):
  ptp: ocp: Refactor signal_show() and fix %ptT misuse
  ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
  ptp: ocp: Apply standard pattern for cleaning up loop
  ptp: ocp: Reuse META's PCI vendor ID

 drivers/ptp/ptp_ocp.c | 46 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

-- 
2.50.1


