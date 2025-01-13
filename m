Return-Path: <netdev+bounces-157837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C9A0BFCB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21A43A69F8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1561C4A13;
	Mon, 13 Jan 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkSa/y+f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F71C3C18
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792941; cv=none; b=t92avIly/v0OYA01uN2YlQUSLbEzzxHIyFXlX4NiUzKSyfzapeMyfKQkAbGlCAy3AX49ZmFk1K68anDflRxvL7iOxrP9pxC7S5fJkelCbUDq58Z6OWVkcKzZ2ScDcdaa0awUAc2Qd1igu3/FmHIf9ZoNRhNwV/Yo25DfpoXHTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792941; c=relaxed/simple;
	bh=Qh0fZGmkTOgzL2OQ9J60mHfdRasaOQ11fbFpbdsVE7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFIz2h+VCp6/vF93Ws0yY7fegcPZSc4xQpVVJcar9/cVEA7mZtNFC4Mqu+sgEb3PwNyNZUrkzAOtifJt/Ttlm5TOKiarOmZTz9WGGgrK1qy9kbvOWSSVqu2QMxNndd2MTmcPdNr620/oJSE2/60Jwj5CUWvDmYsUoeRa0Fmc9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkSa/y+f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736792940; x=1768328940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qh0fZGmkTOgzL2OQ9J60mHfdRasaOQ11fbFpbdsVE7U=;
  b=UkSa/y+fX8ieo5VhWExHRP/JanCp5vQl1ABuk8exdc2NE5Vy77QNv1Iq
   /O32YsUuP0AEdw2q7wvZsjlty24diwx+9XT/VzMY6XjMQOzcouZexWE7n
   L/5Rs8KzFNk42WkxNsYpRdSQzvWUNroiMyashgophuIZeQELKEEmax23q
   FfvucmiSkXpnOOdX79Tti3Ki7g+dPteW2LwemJXiWeGL3hlzlgejPnXnz
   FXn6dxKYed5HgdFIZsi2qfyuojuoi1DwJX+FbXbo2XDhvgXhJTnGFkAz4
   jfLnCghhX50xjsAW7HtBSjIy5BmDomV3Y5894xus7+JRyZboMUdCdi8wE
   g==;
X-CSE-ConnectionGUID: ZjM98yttRTuqiCsd8XBc6g==
X-CSE-MsgGUID: 1vwLoMAlRxi0S01e2Pyweg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48483093"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48483093"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:28:56 -0800
X-CSE-ConnectionGUID: AC2XRy0ZS4iaLzCGSEw2Vw==
X-CSE-MsgGUID: T8yBdX9QSvOGj/rGt2X6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104333262"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 13 Jan 2025 10:28:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net v2 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Mon, 13 Jan 2025 10:28:35 -0800
Message-ID: <20250113182840.3564250-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
References: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index d75f0eddd631..a8e57cf05a9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -131,7 +131,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.47.1


