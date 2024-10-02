Return-Path: <netdev+bounces-131372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77598E58A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B3A28557C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F11199391;
	Wed,  2 Oct 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfQkftGi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAE198E79
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905923; cv=none; b=OvKI9C9dXDKZTx4usTxB5/FXmGI9efr9JFJQ2N+uxM9/Mf1MRcMwrbaJuWm246rDNhzw5O8tr1FQafj7UP2gYVqCh/KHxcVO7CILafXsP1QPZ6hRrx3nmDwww91S8R83UwCYkh2icIgCWLwrq1/CmHo7tCG40aTCsTB4KFZr738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905923; c=relaxed/simple;
	bh=b6uU8eCUInNrw0CnTqbBHlU+yvIKjqkkR5Sq/ldmmXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHNm2PhZJwLHNNxWpGYQP2WU5wvadhccFbZNts24D9AaeQwz7m1SICw+QB6jh4ZX0fsfeHPS5JmfkS3LfU84ZU5/18WpEINgzmk8CjzXI7Ece0xnkED/k5T7TWYI3MG/DbFruHCZgclG9cn12JLiA5eGPMZIfaawmEqNNJFB7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfQkftGi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905922; x=1759441922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b6uU8eCUInNrw0CnTqbBHlU+yvIKjqkkR5Sq/ldmmXA=;
  b=TfQkftGi7zyOKUuU3DLQ9iJSt8WoG7TgPPvQ/ioCtttb53VlODGZCLR+
   /CAkkMU7KzZiPp8EOhtDbgN04ZFdb+wYyKxfD4rpzA+UJIhl+XeZS5ehv
   mNBPG2ClfN+iymHW1Bg7k/bjrLBAjzYRqU9oI3h8pcSWE/2npcZqWLka2
   JQaW3+grMI0r9i7BIvlQBrTQNe//43jojv2iGu/nEUz9L/xyRKFICKcc0
   yEnvv98nI2Qfyp1XXsotNlr4/2MlofUcxVLXvGCfxskaPNQYyL3dXV6Xj
   mN3ZnIvieNE2QjgT9tML4RW3bX5yX7U/43bMzAYyC8qZCVWqFFm4J8+70
   A==;
X-CSE-ConnectionGUID: Fal8xDS8SCm1YgK5IJjD7A==
X-CSE-MsgGUID: pmY1GACMSSOcnRjuPDVJrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262017"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
X-CSE-ConnectionGUID: 590R+yZJQUiaRm/0maLdow==
X-CSE-MsgGUID: ciSEYAaRSQ+72YngUk40vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673885"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:51 -0700
Subject: [PATCH net-next v2 02/10] lib: packing: adjust definitions and
 implementation for arbitrary buffer lengths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-2-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Jacob Keller has a use case for packing() in the intel/ice networking
driver, but it cannot be used as-is.

Simply put, the API quirks for LSW32_IS_FIRST and LITTLE_ENDIAN are
naively implemented with the undocumented assumption that the buffer
length must be a multiple of 4. All calculations of group offsets and
offsets of bytes within groups assume that this is the case. But in the
ice case, this does not hold true. For example, packing into a buffer
of 22 bytes would yield wrong results, but pretending it was a 24 byte
buffer would work.

Rather than requiring such hacks, and leaving a big question mark when
it comes to discontinuities in the accessible bit fields of such buffer,
we should extend the packing API to support this use case.

It turns out that we can keep the design in terms of groups of 4 bytes,
but also make it work if the total length is not a multiple of 4.
Just like before, imagine the buffer as a big number, and its most
significant bytes (the ones that would make up to a multiple of 4) are
missing. Thus, with a big endian (no quirks) interpretation of the
buffer, those most significant bytes would be absent from the beginning
of the buffer, and with a LSW32_IS_FIRST interpretation, they would be
absent from the end of the buffer. The LITTLE_ENDIAN quirk, in the
packing() API world, only affects byte ordering within groups of 4.
Thus, it does not change which bytes are missing. Only the significance
of the remaining bytes within the (smaller) group.

No change intended for buffer sizes which are multiples of 4. Tested
with the sja1105 driver and with downstream unit tests.

Link: https://lore.kernel.org/netdev/a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing.c                      | 70 ++++++++++++++++++++++---------------
 Documentation/core-api/packing.rst | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 439125286d2b..435236a914fe 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -9,27 +9,6 @@
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
-static int get_le_offset(int offset)
-{
-	int closest_multiple_of_4;
-
-	closest_multiple_of_4 = (offset / 4) * 4;
-	offset -= closest_multiple_of_4;
-	return closest_multiple_of_4 + (3 - offset);
-}
-
-static int get_reverse_lsw32_offset(int offset, size_t len)
-{
-	int closest_multiple_of_4;
-	int word_index;
-
-	word_index = offset / 4;
-	closest_multiple_of_4 = word_index * 4;
-	offset -= closest_multiple_of_4;
-	word_index = (len / 4) - word_index - 1;
-	return word_index * 4 + offset;
-}
-
 static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
 				       int *box_end_bit, u8 *box_mask)
 {
@@ -47,6 +26,48 @@ static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
 	*box_end_bit   = new_box_end_bit;
 }
 
+/**
+ * calculate_box_addr - Determine physical location of byte in buffer
+ * @box: Index of byte within buffer seen as a logical big-endian big number
+ * @len: Size of buffer in bytes
+ * @quirks: mask of QUIRK_LSW32_IS_FIRST and QUIRK_LITTLE_ENDIAN
+ *
+ * Function interprets the buffer as a @len byte sized big number, and returns
+ * the physical offset of the @box logical octet within it. Internally, it
+ * treats the big number as groups of 4 bytes. If @len is not a multiple of 4,
+ * the last group may be shorter.
+ *
+ * @QUIRK_LSW32_IS_FIRST gives the ordering of groups of 4 octets relative to
+ * each other. If set, the most significant group of 4 octets is last in the
+ * buffer (and may be truncated if @len is not a multiple of 4).
+ *
+ * @QUIRK_LITTLE_ENDIAN gives the ordering of bytes within each group of 4.
+ * If set, the most significant byte is last in the group. If @len takes the
+ * form of 4k+3, the last group will only be able to represent 24 bits, and its
+ * most significant octet is byte 2.
+ *
+ * Return: the physical offset into the buffer corresponding to the logical box.
+ */
+static int calculate_box_addr(int box, size_t len, u8 quirks)
+{
+	size_t offset_of_group, offset_in_group, this_group = box / 4;
+	size_t group_size;
+
+	if (quirks & QUIRK_LSW32_IS_FIRST)
+		offset_of_group = this_group * 4;
+	else
+		offset_of_group = len - ((this_group + 1) * 4);
+
+	group_size = min(4, len - offset_of_group);
+
+	if (quirks & QUIRK_LITTLE_ENDIAN)
+		offset_in_group = box - this_group * 4;
+	else
+		offset_in_group = group_size - (box - this_group * 4) - 1;
+
+	return offset_of_group + offset_in_group;
+}
+
 /**
  * packing - Convert numbers (currently u64) between a packed and an unpacked
  *	     format. Unpacked means laid out in memory in the CPU's native
@@ -157,12 +178,7 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 		 * effective addressing inside the pbuf (so it's not
 		 * logical any longer).
 		 */
-		box_addr = pbuflen - box - 1;
-		if (quirks & QUIRK_LITTLE_ENDIAN)
-			box_addr = get_le_offset(box_addr);
-		if (quirks & QUIRK_LSW32_IS_FIRST)
-			box_addr = get_reverse_lsw32_offset(box_addr,
-							    pbuflen);
+		box_addr = calculate_box_addr(box, pbuflen, quirks);
 
 		if (op == UNPACK) {
 			u64 pval;
diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 3ed13bc9a195..821691f23c54 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -151,6 +151,77 @@ the more significant 4-byte word.
 We always think of our offsets as if there were no quirk, and we translate
 them afterwards, before accessing the memory region.
 
+Note on buffer lengths not multiple of 4
+----------------------------------------
+
+To deal with memory layout quirks where groups of 4 bytes are laid out "little
+endian" relative to each other, but "big endian" within the group itself, the
+concept of groups of 4 bytes is intrinsic to the packing API (not to be
+confused with the memory access, which is performed byte by byte, though).
+
+With buffer lengths not multiple of 4, this means one group will be incomplete.
+Depending on the quirks, this may lead to discontinuities in the bit fields
+accessible through the buffer. The packing API assumes discontinuities were not
+the intention of the memory layout, so it avoids them by effectively logically
+shortening the most significant group of 4 octets to the number of octets
+actually available.
+
+Example with a 31 byte sized buffer given below. Physical buffer offsets are
+implicit, and increase from left to right within a group, and from top to
+bottom within a column.
+
+No quirks:
+
+::
+
+            31         29         28        |   Group 7 (most significant)
+ 27         26         25         24        |   Group 6
+ 23         22         21         20        |   Group 5
+ 19         18         17         16        |   Group 4
+ 15         14         13         12        |   Group 3
+ 11         10          9          8        |   Group 2
+  7          6          5          4        |   Group 1
+  3          2          1          0        |   Group 0 (least significant)
+
+QUIRK_LSW32_IS_FIRST:
+
+::
+
+  3          2          1          0        |   Group 0 (least significant)
+  7          6          5          4        |   Group 1
+ 11         10          9          8        |   Group 2
+ 15         14         13         12        |   Group 3
+ 19         18         17         16        |   Group 4
+ 23         22         21         20        |   Group 5
+ 27         26         25         24        |   Group 6
+ 30         29         28                   |   Group 7 (most significant)
+
+QUIRK_LITTLE_ENDIAN:
+
+::
+
+            30         28         29        |   Group 7 (most significant)
+ 24         25         26         27        |   Group 6
+ 20         21         22         23        |   Group 5
+ 16         17         18         19        |   Group 4
+ 12         13         14         15        |   Group 3
+  8          9         10         11        |   Group 2
+  4          5          6          7        |   Group 1
+  0          1          2          3        |   Group 0 (least significant)
+
+QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST:
+
+::
+
+  0          1          2          3        |   Group 0 (least significant)
+  4          5          6          7        |   Group 1
+  8          9         10         11        |   Group 2
+ 12         13         14         15        |   Group 3
+ 16         17         18         19        |   Group 4
+ 20         21         22         23        |   Group 5
+ 24         25         26         27        |   Group 6
+ 28         29         30                   |   Group 7 (most significant)
+
 Intended use
 ------------
 

-- 
2.46.2.828.g9e56e24342b6


