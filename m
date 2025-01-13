Return-Path: <netdev+bounces-157834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DFA0BFC9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1673E3A6672
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C201BFE03;
	Mon, 13 Jan 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiE6668J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08B1BB6B3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792938; cv=none; b=XMSEaBU/j6e/fHeGzw/j6q6usd7FzZ3NHQnwlzBCP89SRoMU5naKmTL18i5aPWw2DUVH7SsS0vwmSe0DjYxCKM8kCZeYpzLMeHMp1D8CGwZzbYpXBp22o9M65kJ/pWUMQ1KC8Wk8pM/I+rBHpxj6gxq8D+YFkEtk0sqMTrTu/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792938; c=relaxed/simple;
	bh=GDPiGoQgnGaPPC1tJpRXyisjbFYIlNR0wc1ZOJjvWco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jggIUsrb6anwkfeTq/+XhGmjPAFYmbRRTF+Y8EsAAFZI1ZTDd+ap+NSEicdB5zvCaZz2d5lROJcLyi6V11QZega4VevHgp0zpyair8ctOYYD/meTDYDm91zN8QEP/PCPFzbPeFkvm+Xh+nVz+PURKr10OQsPJY1Rcp+iy821O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiE6668J; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736792936; x=1768328936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GDPiGoQgnGaPPC1tJpRXyisjbFYIlNR0wc1ZOJjvWco=;
  b=QiE6668JL30Jq6SD06lecPFW0awLr2PSqLCAXm9oh9KJ90WmUJnhONaq
   onUX+yn379Ydws+LrNvMMEERZ3Dq5srIWkOCfWcRj1RwxMj38pa0f+MJ6
   pKabwdhvFa/EbVAdlvNrVvaMze27MIdL2z1pp7jl08tYOJrmj5+/snINk
   5MArbYXSLTxAYlqvhjuO+rAVSpeqGdROy3qZJ89htY+8U4ppSzanfu8yI
   /FxE7ZRYPRVBs50IAPJLx3foAyHjBYlXdL5sZsq4zDoK7YwDY+WOfc5yU
   SbWwxufchGXhAmwR5JVx9Zkd7/vMQxM2xwzkFkO5Ic4bfCiTWEEFBZwnU
   A==;
X-CSE-ConnectionGUID: OGKZnT+QSTCqj/VgX7N4uw==
X-CSE-MsgGUID: iTRvsfzgSoCyg9lG1kUTRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48483072"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48483072"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:28:55 -0800
X-CSE-ConnectionGUID: 2biffFL3S42cy3RmWEBG5w==
X-CSE-MsgGUID: TUTRkt2vQhCt61tco8Q4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104333250"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 13 Jan 2025 10:28:56 -0800
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
Subject: [PATCH net v2 0/4][pull request] Fix E825 initialization
Date: Mon, 13 Jan 2025 10:28:32 -0800
Message-ID: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
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
v1: https://lore.kernel.org/netdev/20241206193542.4121545-1-anthony.l.nguyen@intel.com/
- Remove a few cosmetic changes (Patch 2)
- Remove use of __kfree() (Patch 4)

IWL: https://lore.kernel.org/intel-wired-lan/20241105122916.1824568-1-grzegorz.nitka@intel.com/

The following are changes since commit 76201b5979768500bca362871db66d77cb4c225e:
  pktgen: Avoid out-of-bounds access in get_imix_entries
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  51 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 263 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 9 files changed, 209 insertions(+), 144 deletions(-)

-- 
2.47.1


