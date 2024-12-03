Return-Path: <netdev+bounces-148723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC59E301F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A6D166FC1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390820ADC6;
	Tue,  3 Dec 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAK1nqzX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC497189F56
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270112; cv=none; b=pVYCy7C9t5MXU2Jj8/wPWOsgqFfnvavrwuRm/4HSkr5g8eWLioSDAsYu7Ohc4oBk/N0BqUkhbWNQKU3YfEb3zpQ8W2x4OC4vVJxTobcgiDZ0rb1hnVEmcJiGRXWGdvw5N0jb0MWrZ5yZhFLKrFW2+kspAcVxNV2u0cLhnClipWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270112; c=relaxed/simple;
	bh=OFbXpW4cjMBtIrq5zqseCgEcuoy9/ENqEaEUl+wYd48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQlfE+WedNEWsNstgDJS4hLWwgNPBqP5CbUl2jCOuogN4IRzMSstSHdEi8U9NwZkyo9dByfKvB23lqTFa0XNKAOrXYJiiVNwORHw4NxLWwg1kTmSTKsSlH2nPiAfz8yXgVQD9Kr1kIOIyuXGO/ceCa1lzzyAzQ7deybmBUaUMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAK1nqzX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733270111; x=1764806111;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OFbXpW4cjMBtIrq5zqseCgEcuoy9/ENqEaEUl+wYd48=;
  b=NAK1nqzXH+KlyHld8I5TUT0rgIbJ+6bRxtc8dARNPKhiHlCSePVqSIMh
   myJhcYgV47AU56dSxRas9kHdZVPqmRXdZSW4f8bM8TCoVm5nxObd/2yC0
   /IQHZAOUxYzbwaj7qlU5Wun6jZUKq9Sji1wIgB3Qb7DIWnYwo/cU5soAq
   krSY/2qmvlBHfjv/ce2xH3hOV8WBtYS7V9C+hwEuDqAF9YOo18+zZd7Qk
   iOGePMlrnUPJeuJNEqR6uGGQtqnu3PuPdpRVwJbLzRvs2upvqGwzT0pRZ
   oFwfyY5gOo8YY/qpM0KeSssb+GLuuMj8hBXlYTO03ArPq/bwFp0pO4nbD
   A==;
X-CSE-ConnectionGUID: 5fEWQPrMSMeDVQoxbqBiAQ==
X-CSE-MsgGUID: Td7eAutVQROJrFozMQMgfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58918422"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58918422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
X-CSE-ConnectionGUID: KlsojjvRS4+hqVbLZwux5w==
X-CSE-MsgGUID: c4gauc8QROWQNrWdR3AO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93679042"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 03 Dec 2024 15:53:50 -0800
Subject: [PATCH net-next v8 04/10] lib: packing: document recently added
 APIs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

Extend the documentation for the packing library, covering the intended use
for the recently added APIs. This includes the pack() and unpack() macros,
as well as the pack_fields() and unpack_fields() macros.

Add a note that the packing() API is now deprecated in favor of pack() and
unpack().

For the pack_fields() and unpack_fields() APIs, explain the rationale for
when a driver may want to select this API. Provide an example which shows
how to define the fields and call the pack_fields() and unpack_fields()
macros.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/core-api/packing.rst | 118 +++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 821691f23c541cee27995bb1d77e23ff04f82433..30fc2328f789920e27a1bcf3945a6793894ef1d4 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -227,11 +227,119 @@ Intended use
 
 Drivers that opt to use this API first need to identify which of the above 3
 quirk combinations (for a total of 8) match what the hardware documentation
-describes. Then they should wrap the packing() function, creating a new
-xxx_packing() that calls it using the proper QUIRK_* one-hot bits set.
+describes.
+
+There are 3 supported usage patterns, detailed below.
+
+packing()
+^^^^^^^^^
+
+This API function is deprecated.
 
 The packing() function returns an int-encoded error code, which protects the
 programmer against incorrect API use.  The errors are not expected to occur
-during runtime, therefore it is reasonable for xxx_packing() to return void
-and simply swallow those errors. Optionally it can dump stack or print the
-error description.
+during runtime, therefore it is reasonable to wrap packing() into a custom
+function which returns void and simply swallow those errors. Optionally it can
+dump stack or print the error description.
+
+.. code-block:: c
+
+  void my_packing(void *buf, u64 *val, int startbit, int endbit,
+                  size_t len, enum packing_op op)
+  {
+          int err;
+
+          /* Adjust quirks accordingly */
+          err = packing(buf, val, startbit, endbit, len, op, QUIRK_LSW32_IS_FIRST);
+          if (likely(!err))
+                  return;
+
+          if (err == -EINVAL) {
+                  pr_err("Start bit (%d) expected to be larger than end (%d)\n",
+                         startbit, endbit);
+          } else if (err == -ERANGE) {
+                  if ((startbit - endbit + 1) > 64)
+                          pr_err("Field %d-%d too large for 64 bits!\n",
+                                 startbit, endbit);
+                  else
+                          pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
+                                 *val, startbit, endbit);
+          }
+          dump_stack();
+  }
+
+pack() and unpack()
+^^^^^^^^^^^^^^^^^^^
+
+These are const-correct variants of packing(), and eliminate the last "enum
+packing_op op" argument.
+
+Calling pack(...) is equivalent, and preferred, to calling packing(..., PACK).
+
+Calling unpack(...) is equivalent, and preferred, to calling packing(..., UNPACK).
+
+pack_fields() and unpack_fields()
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The library exposes optimized functions for the scenario where there are many
+fields represented in a buffer, and it encourages consumer drivers to avoid
+repetitive calls to pack() and unpack() for each field, but instead use
+pack_fields() and unpack_fields(), which reduces the code footprint.
+
+These APIs use field definitions in arrays of ``struct packed_field_s`` (small)
+or ``struct packed_field_m`` (medium), allowing consumer drivers to minimize
+the size of these arrays according to their custom requirements.
+
+The pack_fields() and unpack_fields() API functions are actually macros which
+automatically select the appropriate function at compile time, based on the
+type of the fields array passed in.
+
+An additional benefit over pack() and unpack() is that sanity checks on the
+field definitions are handled at compile time with ``BUILD_BUG_ON`` rather
+than only when the offending code is executed. These functions return void and
+wrapping them to handle unexpected errors is not necessary.
+
+It is recommended, but not required, that you wrap your packed buffer into a
+structured type with a fixed size. This generally makes it easier for the
+compiler to enforce that the correct size buffer is used.
+
+Here is an example of how to use the fields APIs:
+
+.. code-block:: c
+
+   /* Ordering inside the unpacked structure is flexible and can be different
+    * from the packed buffer. Here, it is optimized to reduce padding.
+    */
+   struct data {
+        u64 field3;
+        u32 field4;
+        u16 field1;
+        u8 field2;
+   };
+
+   #define SIZE 13
+
+   typdef struct __packed { u8 buf[SIZE]; } packed_buf_t;
+
+   static const struct packed_field_s fields[] = {
+           PACKED_FIELD(100, 90, struct data, field1),
+           PACKED_FIELD(90, 87, struct data, field2),
+           PACKED_FIELD(86, 30, struct data, field3),
+           PACKED_FIELD(29, 0, struct data, field4),
+   };
+
+   void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
+   {
+           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+
+           unpack_fields(buf, sizeof(*buf), unpacked, fields,
+                         QUIRK_LITTLE_ENDIAN);
+   }
+
+   void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
+   {
+           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+
+           pack_fields(buf, sizeof(*buf), unpacked, fields,
+                       QUIRK_LITTLE_ENDIAN);
+   }

-- 
2.47.0.265.g4ca455297942


