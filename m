Return-Path: <netdev+bounces-143252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0599C1A43
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC271C22D6C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058C1E2303;
	Fri,  8 Nov 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFNAmN90"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673F1E22F8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060867; cv=none; b=PHMppDrMPJbvVHlZDElKsa0tWEHKOm+plfU663d70fMvndvEpbWXMfmYTgP0rNa20qNF168pMG+jVWGWnkol4hfTy5Xi0at8/24k2siZuGhKnTsZf+2/o/jlPUJHGP9ovXC64N6QdEY0EAIGvN/+QCsqLX2AvubLe/BpQJj3e54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060867; c=relaxed/simple;
	bh=KRVHB01OEq83mExTpA4ZzpE7Xo88aH3410IvN5uxHWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nLC4aWeZ2X/mGhMAHG6MK6yRrMn7VgmLGKEh6JR0xktfLJbANTjSPpeHfPY3OjHWwCQyp1p/ETNH2MXT3hqsarKH6Dhtpu6DUL01zls1iQQdEbnWq/SPQzn0XrXDDvcKf4vaILV8UXyuYSFaFHifZevv25V6KsycLdNyMgY4sPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFNAmN90; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731060866; x=1762596866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KRVHB01OEq83mExTpA4ZzpE7Xo88aH3410IvN5uxHWk=;
  b=jFNAmN905TUU1lontrzGONogzpYur48rqfUTI2+F1Q/7/TtQpNnlqTo/
   8wKuYKSJKuWwVR+GC3SpXsD9fhmyUMUG4nAcdExtA1S44X463sYtQHvhS
   tJhJJKpJQeamoFUTXkf1hwuIJfK39DLQjv+8Wz6yLO4VYb5FcpsSA83lo
   wcqt8JbnkivFP4qaWzDj4HvCcLyuGtNG8hv6CwnzNi+zXFFlhn68g2HGH
   EesAb+Eueav+UvoukvT1SJwtuixSN5mwYmmkXuO3GCUFBHSTDhhAOGpS7
   INljbk54Kohw4EhqkYuTGU001qPxyTk+idQNj7OGgL9LpSGTBuB1XMR/d
   Q==;
X-CSE-ConnectionGUID: AUbDmGYsTFSk3x8MbXu6+g==
X-CSE-MsgGUID: Kt6bvH4CTk2yYbf9dwHM5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42325333"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="42325333"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:14:26 -0800
X-CSE-ConnectionGUID: jXuftAS4TxG03mCX4Ey3rQ==
X-CSE-MsgGUID: HrTigdLPRmSy8m+J1iuT3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="86296723"
Received: from pae-dbg-r750-02-263.igk.intel.com ([172.28.191.215])
  by orviesa008.jf.intel.com with ESMTP; 08 Nov 2024 02:14:25 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: fix PHY timestamp extraction for ETH56G
Date: Fri,  8 Nov 2024 11:14:19 +0100
Message-Id: <20241108101419.66920-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix incorrect PHY timestamp extraction for ETH56G.
It's better to use FIELD_PREP() than manual shift.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ec8db830ac73..3816e45b6ab4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1495,7 +1495,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
+	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) |
+		  FIELD_PREP(TS_PHY_LOW_M, lo);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6cedc1a906af..4c8b84571344 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -663,9 +663,8 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define TS_HIGH_M			0xFF
 #define TS_HIGH_S			32
 
-#define TS_PHY_LOW_M			0xFF
-#define TS_PHY_HIGH_M			0xFFFFFFFF
-#define TS_PHY_HIGH_S			8
+#define TS_PHY_LOW_M			GENMASK(7, 0)
+#define TS_PHY_HIGH_M			GENMASK_ULL(39, 8)
 
 #define BYTES_PER_IDX_ADDR_L_U		8
 #define BYTES_PER_IDX_ADDR_L		4

base-commit: 333b8b2188c495a2a1431b5e0d51826383271aad
-- 
2.31.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


