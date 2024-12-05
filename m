Return-Path: <netdev+bounces-149203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E99E4BC7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D55E1881846
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EA187876;
	Thu,  5 Dec 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeFkDOr/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C315DBB3
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361787; cv=none; b=fGRhW/EdwhGMTMH5BWPriqdicPJczKxX+Msa2CBJJBCE8gUe2SDyjcG4PkLhBhiSzXXl10WdzEvsBlAZcKNfunB5dbVz4IoT973e0p5AgZ+giiXtvRRJ9UgRjTImiR548YtbBa/uOiOyWrtnu4/Lfk1KcDRGmJWMgXH0maulB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361787; c=relaxed/simple;
	bh=GKU35ZWsxf8uh/9gdvowWFQ6Kp4aMT7p4JseMmVWzRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRgqPAJiPIIZSzE27+0ArZ1T0pA/oubVbTjSgn/heEkLByEQG24q+vmVqA5t5dsJYaUPBNAgiuAQqe0VyZn6OxnUDftrHliITRZsFjRH1MpzaJHljvagKJsM+eau4qdSlcXbDcsxnbc5vKEfuzZQALqBrFwzp455qWFJElBOqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeFkDOr/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733361786; x=1764897786;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GKU35ZWsxf8uh/9gdvowWFQ6Kp4aMT7p4JseMmVWzRU=;
  b=LeFkDOr/Gg4KtdinxYbSceGvwyrhDact/ikP6ftoSlX50gyGucDQPFcs
   vU5Tc5v6cYJPrSX/S+sk6J/XqxmND60U8K3x/RDu/I7m0IeN462jcStsE
   fxlMNKI2xKaC9rQUjY9WH8ozqdQ/qbFn1Mi+lIi5pBikxmQUwOn3aIeDo
   PBN9urMRLhLByB+q+06jTNApmOvJKC0i01ctuoxqyP3wy2oZt3ydMCX4v
   vTqt2h83D3jKQnr5DayE9o5OkcXLXq965DOXA2KkxmKr5rxmnil5htXft
   lrdUsLcN3xHS90LArI9TS2c94Va/qUH+BQKEjKs4SwXk2ZmU3/2c5Ly5r
   A==;
X-CSE-ConnectionGUID: 31RKOXXuQDSI3kVti6eeig==
X-CSE-MsgGUID: ICzegyYtQXuMmW252AGyCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32993865"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32993865"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:01 -0800
X-CSE-ConnectionGUID: 6S9XApmxQyGKyYvR//qHGQ==
X-CSE-MsgGUID: PHrFNKviQz+UrTWXlrW6eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98905961"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 04 Dec 2024 17:22:47 -0800
Subject: [PATCH net-next v9 01/10] lib: packing: create __pack() and
 __unpack() variants without error checking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-packing-pack-fields-and-ice-implementation-v9-1-81c8f2bd7323@intel.com>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Vladimir Oltean <vladimir.oltean@nxp.com>

A future variant of the API, which works on arrays of packed_field
structures, will make most of these checks redundant. The idea will be
that we want to perform sanity checks at compile time, not once
for every function call.

Introduce new variants of pack() and unpack(), which elide the sanity
checks, assuming that the input was pre-sanitized.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/packing.c | 142 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 78 insertions(+), 64 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 793942745e34fde1810010e303742e6484861bc8..f237b8af99f5fa8e839c38126769c50b2bfe6361 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -51,64 +51,20 @@ static size_t calculate_box_addr(size_t box, size_t len, u8 quirks)
 	return offset_of_group + offset_in_group;
 }
 
-/**
- * pack - Pack u64 number into bitfield of buffer.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: CPU-readable unpacked value to pack.
- * @startbit: The index (in logical notation, compensated for quirks) where
- *	      the packed value starts within pbuf. Must be larger than, or
- *	      equal to, endbit.
- * @endbit: The index (in logical notation, compensated for quirks) where
- *	    the packed value ends within pbuf. Must be smaller than, or equal
- *	    to, startbit.
- * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
- * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
- *	    QUIRK_MSB_ON_THE_RIGHT.
- *
- * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded. The @pbuf memory will
- *	   be modified on success.
- */
-int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
-	 u8 quirks)
+static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
+		   size_t pbuflen, u8 quirks)
 {
 	/* Logical byte indices corresponding to the
 	 * start and end of the field.
 	 */
-	int plogical_first_u8, plogical_last_u8, box;
-	/* width of the field to access in the pbuf */
-	u64 value_width;
-
-	/* startbit is expected to be larger than endbit, and both are
-	 * expected to be within the logically addressable range of the buffer.
-	 */
-	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
-		/* Invalid function call */
-		return -EINVAL;
-
-	value_width = startbit - endbit + 1;
-	if (unlikely(value_width > 64))
-		return -ERANGE;
-
-	/* Check if "uval" fits in "value_width" bits.
-	 * If value_width is 64, the check will fail, but any
-	 * 64-bit uval will surely fit.
-	 */
-	if (unlikely(value_width < 64 && uval >= (1ull << value_width)))
-		/* Cannot store "uval" inside "value_width" bits.
-		 * Truncating "uval" is most certainly not desirable,
-		 * so simply erroring out is appropriate.
-		 */
-		return -ERANGE;
+	int plogical_first_u8 = startbit / BITS_PER_BYTE;
+	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int box;
 
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / BITS_PER_BYTE;
-	plogical_last_u8  = endbit / BITS_PER_BYTE;
-
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
 		size_t box_start_bit, box_end_bit, box_addr;
@@ -163,15 +119,13 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		((u8 *)pbuf)[box_addr] &= ~box_mask;
 		((u8 *)pbuf)[box_addr] |= pval;
 	}
-	return 0;
 }
-EXPORT_SYMBOL(pack);
 
 /**
- * unpack - Unpack u64 number from packed buffer.
+ * pack - Pack u64 number into bitfield of buffer.
  *
  * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
+ * @uval: CPU-readable unpacked value to pack.
  * @startbit: The index (in logical notation, compensated for quirks) where
  *	      the packed value starts within pbuf. Must be larger than, or
  *	      equal to, endbit.
@@ -183,16 +137,12 @@ EXPORT_SYMBOL(pack);
  *	    QUIRK_MSB_ON_THE_RIGHT.
  *
  * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded. The @uval will be
- *	   modified on success.
+ *	   correct usage, return code may be discarded. The @pbuf memory will
+ *	   be modified on success.
  */
-int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
-	   size_t pbuflen, u8 quirks)
+int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
+	 u8 quirks)
 {
-	/* Logical byte indices corresponding to the
-	 * start and end of the field.
-	 */
-	int plogical_first_u8, plogical_last_u8, box;
 	/* width of the field to access in the pbuf */
 	u64 value_width;
 
@@ -207,6 +157,33 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	if (unlikely(value_width > 64))
 		return -ERANGE;
 
+	/* Check if "uval" fits in "value_width" bits.
+	 * If value_width is 64, the check will fail, but any
+	 * 64-bit uval will surely fit.
+	 */
+	if (value_width < 64 && uval >= (1ull << value_width))
+		/* Cannot store "uval" inside "value_width" bits.
+		 * Truncating "uval" is most certainly not desirable,
+		 * so simply erroring out is appropriate.
+		 */
+		return -ERANGE;
+
+	__pack(pbuf, uval, startbit, endbit, pbuflen, quirks);
+
+	return 0;
+}
+EXPORT_SYMBOL(pack);
+
+static void __unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
+		     size_t pbuflen, u8 quirks)
+{
+	/* Logical byte indices corresponding to the
+	 * start and end of the field.
+	 */
+	int plogical_first_u8 = startbit / BITS_PER_BYTE;
+	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int box;
+
 	/* Initialize parameter */
 	*uval = 0;
 
@@ -214,9 +191,6 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / BITS_PER_BYTE;
-	plogical_last_u8  = endbit / BITS_PER_BYTE;
-
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
 		size_t box_start_bit, box_end_bit, box_addr;
@@ -271,6 +245,46 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		*uval &= ~proj_mask;
 		*uval |= pval;
 	}
+}
+
+/**
+ * unpack - Unpack u64 number from packed buffer.
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @uval: Pointer to an u64 holding the unpacked value.
+ * @startbit: The index (in logical notation, compensated for quirks) where
+ *	      the packed value starts within pbuf. Must be larger than, or
+ *	      equal to, endbit.
+ * @endbit: The index (in logical notation, compensated for quirks) where
+ *	    the packed value ends within pbuf. Must be smaller than, or equal
+ *	    to, startbit.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
+ *	   correct usage, return code may be discarded. The @uval will be
+ *	   modified on success.
+ */
+int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
+	   size_t pbuflen, u8 quirks)
+{
+	/* width of the field to access in the pbuf */
+	u64 value_width;
+
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen)
+		/* Invalid function call */
+		return -EINVAL;
+
+	value_width = startbit - endbit + 1;
+	if (value_width > 64)
+		return -ERANGE;
+
+	__unpack(pbuf, uval, startbit, endbit, pbuflen, quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL(unpack);

-- 
2.47.0.265.g4ca455297942


