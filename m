Return-Path: <netdev+bounces-219692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700ABB42AD2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292171888F56
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C12EBBA3;
	Wed,  3 Sep 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0hsYwYf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98322DFA21
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931144; cv=none; b=t3oQPU+V5Eve7inuCxQbFO5eGEqrY76QWu8lWSxqsm+GQLeW32n3O5KOXHSRpXLWvP1lpr9yFS4fMPSjcItPuc0lZDY2cpY2dbO8tZ3SvB9N37iLaDzXxW8UhQSmNfB2DPSbH3KWw4CUBHMax+Ze041BfLFc++mZmsg54CIcbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931144; c=relaxed/simple;
	bh=StH6HD0OQlUQNU/1HL5rbnzsCoYvwwEHu9AP0+9x+VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfmbMB6aagA+cAB8SikEPGf/9FYlmKMvcqlfj4+k9x/M28p0R8r9SGd4DHAe7XfkbjKACpjy0ERb6W6oCaaWxL1tMnZ/DnWUifcPFCPGlcqc113OgyM8Wz/258snf9o4IHHATNMuMJq1WIIROCehA3b2XqDWyADPhUJaFsSmkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0hsYwYf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931143; x=1788467143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StH6HD0OQlUQNU/1HL5rbnzsCoYvwwEHu9AP0+9x+VY=;
  b=D0hsYwYf/NjnG0uhzcURVR0Ph8/C75S25DsJa5tupmCGK5D1YEIf4uMf
   AH0gEim1vRC6Iy8n4ORKlM2bDM6iG53ISxc2k17OImgRSm5u9TBObp9rr
   SVvrY9Kyt5SAlZUsQiMdd0JSwiWB6D8oUpHUX+UaZBpQRGP/L07LDWieX
   3qWj6e74sDWoSmWHZ/1a7Z6ZVV0XVuaS6mI4ACwowqWidNsdYJI2SWUKi
   ObYYYbq66hMcKAC4hRvjv/UPv5HYAJ6SU8f6ykRiAhf55gfqEEMzm0O4g
   qs/B7jGfP6L0mXghyGWklW5eUPCYqg40UWvlEzdiLOXHnst02l3kFGXbJ
   g==;
X-CSE-ConnectionGUID: vWCr3ZVsTqmC8wzxHLE1cA==
X-CSE-MsgGUID: R2J3+QeOTmGWmhtdpRi+fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173012"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:40 -0700
X-CSE-ConnectionGUID: qH01oQwmTlKtf4d/M482MQ==
X-CSE-MsgGUID: PpfhvU08TCepkNaIsAcIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823445"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/9] ixgbe: reduce number of reads when getting OROM data
Date: Wed,  3 Sep 2025 13:25:28 -0700
Message-ID: <20250903202536.3696620-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Currently, during locating the CIVD section, the ixgbe driver loops
over the OROM area and at each iteration reads only OROM-datastruct-size
amount of data. This results in many small reads and is inefficient.

Optimize this by reading the entire OROM bank into memory once before
entering the loop. This significantly reduces the probing time.

Without this patch probing time may exceed over 25s, whereas with this
patch applied average time of probe is not greater than 5s.

without the patch:
[14:12:22] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[14:12:25] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[14:12:25] ixgbe 0000:21:00.0: 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link)
[14:12:26] ixgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001
[14:12:26] ixgbe 0000:21:00.0: 20:3a:43:09:3a:12
[14:12:26] ixgbe 0000:21:00.0: Intel(R) 10 Gigabit Network Connection
[14:12:50] ixgbe 0000:21:00.0 ens2f0np0: renamed from eth0

with the patch:
[14:18:18] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[14:18:19] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[14:18:19] ixgbe 0000:21:00.0: 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link)
[14:18:19] ixgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001
[14:18:19] ixgbe 0000:21:00.0: 20:3a:43:09:3a:12
[14:18:19] ixgbe 0000:21:00.0: Intel(R) 10 Gigabit Network Connection
[14:18:22] ixgbe 0000:21:00.0 ens2f0np0: renamed from eth0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 59 +++++++++++++------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 7d4f12b69ee2..c5ca7b392b0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2997,50 +2997,71 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
  * Searches through the Option ROM flash contents to locate the CIVD data for
  * the image.
  *
- * Return: the exit code of the operation.
+ * Return: -ENOMEM when cannot allocate memory, -EDOM for checksum violation,
+ *	   -ENODATA when cannot find proper data, -EIO for faulty read or
+ *	   0 on success.
+ *
+ *	   On success @civd stores collected data.
  */
 static int
 ixgbe_get_orom_civd_data(struct ixgbe_hw *hw, enum ixgbe_bank_select bank,
 			 struct ixgbe_orom_civd_info *civd)
 {
-	struct ixgbe_orom_civd_info tmp;
+	u32 orom_size = hw->flash.banks.orom_size;
+	u8 *orom_data;
 	u32 offset;
 	int err;
 
+	orom_data = kzalloc(orom_size, GFP_KERNEL);
+	if (!orom_data)
+		return -ENOMEM;
+
+	err = ixgbe_read_flash_module(hw, bank,
+				      IXGBE_E610_SR_1ST_OROM_BANK_PTR, 0,
+				      orom_data, orom_size);
+	if (err) {
+		err = -EIO;
+		goto cleanup;
+	}
+
 	/* The CIVD section is located in the Option ROM aligned to 512 bytes.
 	 * The first 4 bytes must contain the ASCII characters "$CIV".
 	 * A simple modulo 256 sum of all of the bytes of the structure must
 	 * equal 0.
 	 */
-	for (offset = 0; (offset + SZ_512) <= hw->flash.banks.orom_size;
-	     offset += SZ_512) {
+	for (offset = 0; offset + SZ_512 <= orom_size; offset += SZ_512) {
+		struct ixgbe_orom_civd_info *tmp;
 		u8 sum = 0;
 		u32 i;
 
-		err = ixgbe_read_flash_module(hw, bank,
-					      IXGBE_E610_SR_1ST_OROM_BANK_PTR,
-					      offset,
-					      (u8 *)&tmp, sizeof(tmp));
-		if (err)
-			return err;
+		BUILD_BUG_ON(sizeof(*tmp) > SZ_512);
+
+		tmp = (struct ixgbe_orom_civd_info *)&orom_data[offset];
 
 		/* Skip forward until we find a matching signature */
-		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp.signature,
-			   sizeof(tmp.signature)))
+		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp->signature,
+			   sizeof(tmp->signature)))
 			continue;
 
 		/* Verify that the simple checksum is zero */
-		for (i = 0; i < sizeof(tmp); i++)
-			sum += ((u8 *)&tmp)[i];
+		for (i = 0; i < sizeof(*tmp); i++)
+			sum += ((u8 *)tmp)[i];
+
+		if (sum) {
+			err = -EDOM;
+			goto cleanup;
+		}
 
-		if (sum)
-			return -EDOM;
+		*civd = *tmp;
+		err = 0;
 
-		*civd = tmp;
-		return 0;
+		goto cleanup;
 	}
 
-	return -ENODATA;
+	err = -ENODATA;
+cleanup:
+	kfree(orom_data);
+	return err;
 }
 
 /**
-- 
2.47.1


