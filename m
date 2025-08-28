Return-Path: <netdev+bounces-217687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198EB398EB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C9B7A7649
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD702F39B0;
	Thu, 28 Aug 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWatUvqH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEC25BF1B;
	Thu, 28 Aug 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375075; cv=none; b=q7m3s+ylTS3XS+/+bOLDDoBEyYcuLy7gbnsFUZibYuiCrNBZGRgNcMAD/AvMD5jZUEO10oNFyWbMMDLzmwwh/lK9jmGBm8EoRFXwerE1f8yGhd99Vwlto9bf+iBazoZj9WHWAtofRxFg/C2qy1rkjtld6s2HC4WzBmWcv0+8Oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375075; c=relaxed/simple;
	bh=nRvwG+odou1fbYjqtnskkPLA/86Ybt0X0xVNM2I0jVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FbIkF88VotMNaTPRXcTQeMiW7CttVWhKbui7dzjCzElvRblQdRaXOLTUbBjazmueBEh7B5u8McjMgCFzzvfejXOBT3RKBx0c7iGZn+LMpgWWS/FTwSROgW7Ypz2dTC22MhAE44gKnvYv4PeC/mURnGW/S0VuHKQLyEDA0a9LaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWatUvqH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375074; x=1787911074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nRvwG+odou1fbYjqtnskkPLA/86Ybt0X0xVNM2I0jVA=;
  b=dWatUvqHTE0Dg3kc5uq0KEZcRDaFCuiQcfqc8K+Qmhn4mq6LMkU3HVTF
   0etNE9QHFyKMUOlo7WD/NLalppjkdqr7fnuWRNLlIl7U23XkltxEpge86
   PCUKt/SsxW1iOIZdOFR4qRXWuugDB1elGGnm9WrL18n9MOJX1TgqUSAx5
   TGvsgAKMDnbAqAX3rrlpQoObaJHz2XtQpGdo1fD+4M2bm73VFJDc8CO7h
   MrQh8Rwy8Xg7+aXjrwlzGIuZ6Usr//P3eZcIpSE3QSmdc0YnWzBGColmr
   wlBLLqdnXI19ZFCPBa2TECVa1W3s4RlCXGpXmEfn78nSlT6SfkJv46deC
   g==;
X-CSE-ConnectionGUID: mag7TtdFS7aULt9f5JZtIA==
X-CSE-MsgGUID: yL+WXGRxRbm+exQqr0UnxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69735019"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69735019"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:57:53 -0700
X-CSE-ConnectionGUID: oneQcFmBS46dkSGLvpGKIg==
X-CSE-MsgGUID: q+SwU6BeRB6Nevonyk2H+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170467385"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 02:57:50 -0700
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
Subject: [PATCH net 0/3] net: stmmac: misc fixes
Date: Thu, 28 Aug 2025 12:02:34 +0200
Message-Id: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds three fixes addressing KASAN panic on ethtool usage,
Enhanced Descriptor printing and flow stop on TC block setup when
interface down.

Patchset has been created as a result of discussion at [1].

[1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/

v1 -> v2:
- add missing Fixes lines
- add missing SoB lines
- removed all non-fix patches. These will be sent in a separate series

Karol Jurczenia (1):
  net: stmmac: check if interface is running before TC block setup

Konrad Leszczynski (1):
  net: stmmac: replace memcpy with strscpy in ethtool

Piotr Warpechowski (1):
  net: stmmac: correct Tx descriptors debugfs prints

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.34.1


