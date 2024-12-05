Return-Path: <netdev+bounces-149204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD89E4BC5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3516AC89
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDD188CCA;
	Thu,  5 Dec 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHprejA2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF81714CF
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361788; cv=none; b=jRvYbimlLByFWE6uSQpSpFeJPwSE1lMzPlB/5rZ6/LULZpV6hDCYPfe/7dHlZtrMn7NifJLWeZ+eiuIjXUrI2fZRDyqzU0z1Adswxjo1kn1zQCy1i/l9OWO60cw4+PvLmgSIfDpv8GmG5/0QxKV+1tCJalzfRtNKxQnS0uQlnDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361788; c=relaxed/simple;
	bh=skVQJEQjh8PC596WXX1gHp2HG9BJ5E3hayeoU1RTyeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhmartwjH/kicVP2XrFvz3uZN0OpPI4FGW4FFHqNZoYQKEfk0nhKweRGogUsu55HS5GppDr3Bv5qPLQ6/BrDd9aW1PKZ3hFiE+WQ4+e/Znw7UNzuAM9kwHDmsvrsYz6OYNc7c9yrrhRnFr78uaiP5xsSy0guw6DTVDrXvAbaTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHprejA2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733361787; x=1764897787;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=skVQJEQjh8PC596WXX1gHp2HG9BJ5E3hayeoU1RTyeQ=;
  b=bHprejA2eQc4r4XW6zmGK8c30W0QRIe/L8b0xZo4BMf7SZgqvH5ZM8eR
   qbNymANsIIyDyLTvbnHPPtaImn9fiSmOFuO4yyFubrlcbkKJwTVuUCF6u
   zlsUQdFy52pYhEMW3inFGgk7ELAnEC689TIB9BHaWLbA0VklsH3x5EQWy
   REbEqeyI+mNHCG9PkpDHg8IhBRQbTCHGDJ7Tjf8RMvlYfIZ/iGYN8tLg5
   eJKBnR6cSuuZq//u6TNNapvoDeANmVV2v2y0LbyQ4xkFl3Z/qJV365E+H
   QUmX9GzcAQM+FtJyySxizSMnd7QWLjVg5X61kDPs888cjv8Hot5wLrmUB
   A==;
X-CSE-ConnectionGUID: uvO0keOBSFCddPSVHHRutA==
X-CSE-MsgGUID: Fx3YX8VXQ0a7P9/VC9w4mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32993877"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32993877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:01 -0800
X-CSE-ConnectionGUID: 5IiLIo98SLyA3tzCdPSzXA==
X-CSE-MsgGUID: 6wMtXQikTJugHOpouseTSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98905964"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 04 Dec 2024 17:22:48 -0800
Subject: [PATCH net-next v9 02/10] lib: packing: demote truncation error in
 pack() to a warning in __pack()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-packing-pack-fields-and-ice-implementation-v9-2-81c8f2bd7323@intel.com>
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

Most of the sanity checks in pack() and unpack() can be covered at
compile time. There is only one exception, and that is truncation of the
uval during a pack() operation.

We'd like the error-less __pack() to catch that condition as well. But
at the same time, it is currently the responsibility of consumer drivers
(currently just sja1105) to print anything at all when this error
occurs, and then discard the return code.

We can just print a loud warning in the library code and continue with
the truncated __pack() operation. In practice, having the warning is
very important, see commit 24deec6b9e4a ("net: dsa: sja1105: disallow
C45 transactions on the BASE-TX MDIO bus") where the bug was caught
exactly by noticing this print.

Add the first print to the packing library, and at the same time remove
the print for the same condition from the sja1105 driver, to avoid
double printing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/dsa/sja1105/sja1105_static_config.c |  8 ++------
 lib/packing.c                                   | 26 ++++++++++---------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index baba204ad62f6b507a6ccf3337248dd02b777249..3d790f8c6f4dab3640ede014345ef469fefb7085 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -26,12 +26,8 @@ void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len)
 		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
 		       start, end);
 	} else if (rc == -ERANGE) {
-		if ((start - end + 1) > 64)
-			pr_err("Field %d-%d too large for 64 bits!\n",
-			       start, end);
-		else
-			pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
-			       *val, start, end);
+		pr_err("Field %d-%d too large for 64 bits!\n",
+		       start, end);
 	}
 	dump_stack();
 }
diff --git a/lib/packing.c b/lib/packing.c
index f237b8af99f5fa8e839c38126769c50b2bfe6361..09a2d195b9433b61c86f3b63ff019ab319c83e97 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -59,8 +59,17 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 	 */
 	int plogical_first_u8 = startbit / BITS_PER_BYTE;
 	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int value_width = startbit - endbit + 1;
 	int box;
 
+	/* Check if "uval" fits in "value_width" bits.
+	 * The test only works for value_width < 64, but in the latter case,
+	 * any 64-bit uval will surely fit.
+	 */
+	WARN(value_width < 64 && uval >= (1ull << value_width),
+	     "Cannot store 0x%llx inside bits %zu-%zu - will truncate\n",
+	     uval, startbit, endbit);
+
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
@@ -143,9 +152,6 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	 u8 quirks)
 {
-	/* width of the field to access in the pbuf */
-	u64 value_width;
-
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
@@ -153,19 +159,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		/* Invalid function call */
 		return -EINVAL;
 
-	value_width = startbit - endbit + 1;
-	if (unlikely(value_width > 64))
-		return -ERANGE;
-
-	/* Check if "uval" fits in "value_width" bits.
-	 * If value_width is 64, the check will fail, but any
-	 * 64-bit uval will surely fit.
-	 */
-	if (value_width < 64 && uval >= (1ull << value_width))
-		/* Cannot store "uval" inside "value_width" bits.
-		 * Truncating "uval" is most certainly not desirable,
-		 * so simply erroring out is appropriate.
-		 */
+	if (unlikely(startbit - endbit >= 64))
 		return -ERANGE;
 
 	__pack(pbuf, uval, startbit, endbit, pbuflen, quirks);

-- 
2.47.0.265.g4ca455297942


