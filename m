Return-Path: <netdev+bounces-149196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07239E4BBF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FE216AAB3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC834126C01;
	Thu,  5 Dec 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbd3on98"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAA54782
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361783; cv=none; b=rqy/g1ocnr86JOXdDjxoP2m6dqTk4+BMv1OkGGS1HlxXeR4yyuARpp9TkPf2C1P1PPVrVLK+dg3fj36ZM+eAHCSXO+Z+30t4wojwh6QMmytHiWcC+nEblU7uEXZ1v1Xr3WHNCQ6kPY7xmOPGt0m9v1FwfgtxskC9AOUHkxpjY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361783; c=relaxed/simple;
	bh=Lrzl8oBksoU1XuUsfABgiY37KSgVd82RiMW0vKdqKcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcElsnWHQqTHXFpPsNw0htDrU9zKiHRlyFtTD5171sXYIu6JZMFZ8vxhZbWiXO1mQJetR8lgxXTUOaE6hM0F6WS5zrcpUbAnQm6uPIVEBSVGFRUlryf4ckMQoU6f4TPPOSLCtGhDfoIWp5W5vRrshdorZ7rbcC+FgSf79zB7iWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbd3on98; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733361782; x=1764897782;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Lrzl8oBksoU1XuUsfABgiY37KSgVd82RiMW0vKdqKcA=;
  b=jbd3on98sVvElPRGuaNZTLr7MabYemDYCepCuN8cqQTD+PEdpqdaWjAT
   480T+spf3MARqItTWdcRrmm0dXXPqiYxVQrzbmAYgAfGRmBUgLSv3lVKU
   73ObzO4Ej7S4QASRZ/WJh1Rs/6w0NdxlWnryl2vkPEMxItrScwpHIzhFt
   j2KmOQ714vr9tC3Z46Hh0+urjR080/kC/4Jwjl0ByQ5v5JBDWXFYmfkE4
   uDWQVWgm4qHTESQrRLocbI99K2afmRen/n01hz6lDetB4mapObGT1sM79
   ouaJeg2zytgbR1SZvOnOFskE4yaFMV3F381UvvTcIEkmHTMi3anH3+CvZ
   A==;
X-CSE-ConnectionGUID: sJvtBT9eSqir+8y/9Y5pAg==
X-CSE-MsgGUID: mp5rek42QomlwB+Lx3PwBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32993835"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32993835"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
X-CSE-ConnectionGUID: YFrHbKkqTvWv0MapntOkwg==
X-CSE-MsgGUID: /QvBLS98TF6F4/AJ3NM44g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98905971"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 04 Dec 2024 17:22:50 -0800
Subject: [PATCH net-next v9 04/10] lib: packing: document recently added
 APIs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-packing-pack-fields-and-ice-implementation-v9-4-81c8f2bd7323@intel.com>
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

Extend the documentation for the packing library, covering the intended use
for the recently added APIs. This includes the pack() and unpack() macros,
as well as the pack_fields() and unpack_fields() macros.

Add a note that the packing() API is now deprecated in favor of pack() and
unpack().

For the pack_fields() and unpack_fields() APIs, explain the rationale for
when a driver may want to select this API. Provide an example which shows
how to define the fields and call the pack_fields() and unpack_fields()
macros.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/core-api/packing.rst | 118 +++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 821691f23c541cee27995bb1d77e23ff04f82433..a0c2d90a44861042263e8da1ea329245681e2a82 100644
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
+function which returns void and swallows those errors. Optionally it can
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


