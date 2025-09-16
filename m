Return-Path: <netdev+bounces-223496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C8B595B4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7F71BC4487
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C192D24B3;
	Tue, 16 Sep 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUY3ce9a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557E2DC79E;
	Tue, 16 Sep 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024286; cv=none; b=A01yy3oaQ95P/lbVcN+JOGix4QFRFdV4jo0fEGlR4P1Uoid323A63SpEBOpakHzxzSvVqfMoZvKHDpD/P3k9/6SOxiPb/jN0kn3vx2KOblp4dPV0LBOL1TEY0eII+EDOFSyLzDql3C1xYZwgetzuqI9Lq4lR6dpGpJpI3iTOHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024286; c=relaxed/simple;
	bh=SCxMx4yEem5tSoETGmO1maR9jyrWfm8TqZNB0zt9vOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pifne5Eqy2/Q9Xgnu141Fzx4B5yizYb6kYrr45nnl8vWjWazwWdtPvpfo+Mf9X9cpPaxXkPAIfPbHOmtR+avXfRAzWRv3y6GHaXYBrjr8dL9ffhH3+gtf7QGOloDAm3LgonCkezCe2Z613LdW5eRRD+GR94abIaGiyNyuScedyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUY3ce9a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758024284; x=1789560284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SCxMx4yEem5tSoETGmO1maR9jyrWfm8TqZNB0zt9vOw=;
  b=QUY3ce9aP4da3ibNMqYG79wrOkFj/8+csWgyG1eaox9l0FPCkGoTRtOD
   VnVJwvbmHwpxrgWGi8rZ0vM8CcLNRQqxKWSNpAuY4dBANnO8uMuDcIxIx
   SFvL7/++iQaxsE0Mk8NVGsVffI5NdV18/qP50Ct/4GOIXWYT91IUHZMe4
   fLU/pyYGLrdL9J0bMQZJtaDQjOrYvhLUB35bNNoZGwcQ9gw8ahlSQdR12
   eOfhOLUuigGxQViGOp21GnN87wnorrOQEU+NHCBrTKrcxKtv5xD4A/vtC
   jfzpH0fqH4SIH62OFUsKEb2xk4wfz6YHcLMXm5xK2e7viHEhzbMfaQsPF
   w==;
X-CSE-ConnectionGUID: XkjKfuFGT8uhpJdZbls9qg==
X-CSE-MsgGUID: ni8xyfJsRAm9PV7wOj0dhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59347147"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="59347147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:04:43 -0700
X-CSE-ConnectionGUID: +tfY37zWQQeVhM7X2GtGXQ==
X-CSE-MsgGUID: jk21zKWcS7WwUSZnHEVknw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="180058260"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa005.jf.intel.com with ESMTP; 16 Sep 2025 05:04:41 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net v4 0/2] net: stmmac: misc fixes
Date: Tue, 16 Sep 2025 14:09:30 +0200
Message-Id: <20250916120932.217547-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds two fixes addressing KASAN panic on ethtool usage and
flow stop on TC block setup when interface down.

Patchset has been created as a result of discussion at [1].

v2 can be found at [2].
v3 can be found at [3].

[1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
[2] https://lore.kernel.org/netdev/20250828100237.4076570-1-konrad.leszczynski@intel.com/
[3] https://lore.kernel.org/netdev/20250916092507.216613-1-konrad.leszczynski@intel.com/

v3 -> v4:
- add missing Reviewed-by lines

v2 -> v3:
- replace strcpy with ethtool_puts per suggestion
- removed extension patch for printing enhanced descriptors

v1 -> v2:
- add missing Fixes lines
- add missing SoB lines
- removed all non-fix patches. These will be sent in separate series

Karol Jurczenia (1):
  net: stmmac: check if interface is running before TC block setup

Konrad Leszczynski (1):
  net: stmmac: replace memcpy with ethtool_puts in ethtool

 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


