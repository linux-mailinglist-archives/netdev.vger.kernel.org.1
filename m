Return-Path: <netdev+bounces-243494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A301CA2541
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 05:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBB2305F674
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895242FF151;
	Thu,  4 Dec 2025 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNCmO7oB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5019E968;
	Thu,  4 Dec 2025 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823292; cv=none; b=X4HNuWoEL7QL+jy7TRJD7ADTz3cyEH9YBF3CtF4k5DLKbMYFBV78m07EIPua+otA7wVYnEUteKazpKgw2C5iMpKsIfLNLUL58Cd3puufUShNCqBlHW+rd78luD7BXdSB3FzRply+KvspZ7wVzZJc2n+CG9vWnayDpgtEJt7zOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823292; c=relaxed/simple;
	bh=wj1zTlmxZ6w8p5WL1TQZ0TATfR58M5u70uppx+bZhRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjDxHemycYNSvh8Un0JYrOAuZbq5JJ+wML7BNwps5jRrAUqvQXs3UFVlmrlq32sfaKSLXNXpfC93BTHJuN8loZY6TOmNpJIk1vdfhQPD7+Pe4ry5O2Ltrs7sytC2G1dm/mnu4gtPXL8b7aY0WHpy8s6m4AXXyrcdL95fK2iQiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNCmO7oB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764823291; x=1796359291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wj1zTlmxZ6w8p5WL1TQZ0TATfR58M5u70uppx+bZhRs=;
  b=RNCmO7oBJmmH+sWasDhbtsM+gJJ8J6GjXlrXTTJf2DNyclugXuvU8YUX
   pkzDtWUooXMV92VDsCDBupKhY4gIutPe4S1mbuAkRO7mQnFNeHBP/JWEX
   mMMd5iffw/kwTBNYKIwM3gOYaLy2IT1tkY62h3wIcm7sbuIsPxb8I8r8a
   NkvRS10ULq87nHRgLs2JK4pazHMYQKN5b5V1HQh9kQWPyTlabo6TYA/Ar
   Dj8gAsOdpRtyATp9nNM2Ac9Wu2Sc0vK8k5Tgb6ncbrCj+WBefXQZbxrLI
   /0k6Fp6oTGBz6g+zj76MPXdnWj0KYMCcEQwJmItmtWBKV30+Zk6CVb2S+
   Q==;
X-CSE-ConnectionGUID: Qd6++P+IRyW+KXnBhS6V/w==
X-CSE-MsgGUID: NsA5iNaIQ9ySnh3Rg+BYcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65830529"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="65830529"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 20:41:30 -0800
X-CSE-ConnectionGUID: tY188lS6TIWhEgQ7hypAlA==
X-CSE-MsgGUID: VNU1mn/lQXiGpuqnF1h2ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="194703060"
Received: from p2dy149cchoong.png.intel.com ([10.107.243.50])
  by orviesa009.jf.intel.com with ESMTP; 03 Dec 2025 20:41:26 -0800
From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zdenek Bouska <zdenek.bouska@siemens.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue
Date: Thu,  4 Dec 2025 20:21:50 +0800
Message-ID: <20251204122150.23853-1-chwee.lin.choong@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous 7 KB per queue caused TX unit hangs under heavy
timestamping load. Reducing to 5 KB avoids these hangs and matches
the TSN recommendation in I225/I226 SW User Manual Section 7.5.4.

The 8 KB “freed” by this change is currently unused. This reduction
is not expected to impact throughput, as the i226 is PCIe-limited
for small TSN packets rather than TX-buffer-limited.

Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for TSN mode")
Reported-by: Zdenek Bouska <zdenek.bouska@siemens.com>
Closes: https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
---
v1: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250918183811.31270-1-chwee.lin.choong@intel.com/

changelog:
v1 -> v2 
- Elaborated commit message
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 498ba1522ca4..9482ab11f050 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -443,9 +443,10 @@
 #define IGC_TXPBSIZE_DEFAULT ( \
 	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
 	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
+/* TSN value following I225/I226 SW User Manual Section 7.5.4 */
 #define IGC_TXPBSIZE_TSN ( \
-	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
-	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
+	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
+	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.43.0


