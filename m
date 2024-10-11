Return-Path: <netdev+bounces-134672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2199AB93
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040DB1C21957
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4F1D1505;
	Fri, 11 Oct 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMaLv6Ra"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3C1D0E19;
	Fri, 11 Oct 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672615; cv=none; b=EuEjQ+M/ItAfruW0COUHUZ2VwaJq+NWCSxP4gG7F7N6Yl1NufwCpbLdslehMKixyPEW+m2jz5NcFhIL8/MAnIo10oQ97Vlbq7F+Kh4cQXMLOydIqPon2/phvPHFWliTGy5PqD+a6uVuh3WOKZ3T2M6BDhNOyzIE1rdrJDRqW+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672615; c=relaxed/simple;
	bh=CoWQv1r3+a71JRhFsmZYLZzuRcuyheIhOcBK7o0dF5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX5XWSYq4Y25IDi7MpeDaQRbizeOuxbYrfhtkt8xNnjOygRpK7e+Ld/la3Kr5k3/JL9OfJd0W9qNtXrzpDBK1zV1lvicCY4EL4ns5PH3hnRRJfB22HlNIOYcwFcVTYTLR+970/s0iG+o6CORX8ug1JJoba5XnzLn2/SHOJs6Gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMaLv6Ra; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728672613; x=1760208613;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CoWQv1r3+a71JRhFsmZYLZzuRcuyheIhOcBK7o0dF5Y=;
  b=iMaLv6RakHM97gXQ/wjv7cvTWfHRZE2XP4A53Li6EtERHCY6BsRvjX1G
   G3Yv39e/m884JGjLS0MUvMRdHWArN4eTIhr72HG/da8/zLHLnbWCMf2wp
   oOOWaTXBPKi9e4c1bPlgt6gtNITgQHNAabXeCESvswp+TUJQUf0EqiNMv
   o9GhAIYpsbL26KlNXM3HstW6dMKJh+wveFQEAr8SUhq6Kchqy52yaEDe8
   VKsFihRI4+/y9TJTFj75O/tAPhhJf9tjwIqBMiFjzoZgIluPEB7sF+/mi
   bUF5p15cII6hfTLLoI9HPZowlt6A8IjclKkklDN5TZ7P0f3AI4dt4cOBq
   Q==;
X-CSE-ConnectionGUID: zjoE8W9bRAK89xMtgVdQiw==
X-CSE-MsgGUID: VxjAlu3yTs61nDB8Vv8WcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50626207"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50626207"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:07 -0700
X-CSE-ConnectionGUID: vlUYbifyRX6PGVx9mjxQ/Q==
X-CSE-MsgGUID: 7D8DfJLtTZKXa/nHOlakPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77804153"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Oct 2024 11:48:31 -0700
Subject: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is new API which caters to the following requirements:

- Pack or unpack a large number of fields to/from a buffer with a small
  code footprint. The current alternative is to open-code a large number
  of calls to pack() and unpack(), or to use packing() to reduce that
  number to half. But packing() is not const-correct.

- Use unpacked numbers stored in variables smaller than u64. This
  reduces the rodata footprint of the stored field arrays.

- Perform error checking at compile time, rather than at runtime, and
  return void from the API functions. To that end, we introduce
  CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
  fields. Note: the C preprocessor can't generate variable-length code
  (loops),  as would be required for array-style definitions of struct
  packed_field arrays. So the sanity checks use code generation at
  compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
  There are explicit macros for sanity-checking arrays of 1 packed
  field, 2 packed fields, 3 packed fields, ..., all the way to 50 packed
  fields. In practice, the sja1105 driver will actually need the variant
  with 40 fields. This isn't as bad as it seems: feeding a 39 entry
  sized array into the CHECK_PACKED_FIELDS_40() macro will actually
  generate a compilation error, so mistakes are very likely to be caught
  by the developer and thus are not a problem.

- Reduced rodata footprint for the storage of the packed field arrays.
  To that end, we have struct packed_field_s (small) and packed_field_m
  (medium). More can be added as needed (unlikely for now). On these
  types, the same generic pack_fields() and unpack_fields() API can be
  used, thanks to the new C11 _Generic() selection feature, which can
  call pack_fields_s() or pack_fields_m(), depending on the type of the
  "fields" array - a simplistic form of polymorphism. It is evaluated at
  compile time which function will actually be called.

Over time, packing() is expected to be completely replaced either with
pack() or with pack_fields().

Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/packing.h  |  69 ++++++++++++++++++++++
 lib/gen_packing_checks.c |  31 ++++++++++
 lib/packing.c            | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
 Kbuild                   |  13 ++++-
 4 files changed, 259 insertions(+), 3 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 5d36dcd06f60..eeb23d90e5e0 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -26,4 +26,73 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	   size_t pbuflen, u8 quirks);
 
+#define GEN_PACKED_FIELD_MEMBERS(__type) \
+	__type startbit; \
+	__type endbit; \
+	__type offset; \
+	__type size;
+
+/* Small packed field. Use with bit offsets < 256, buffers < 32B and
+ * unpacked structures < 256B.
+ */
+struct packed_field_s {
+	GEN_PACKED_FIELD_MEMBERS(u8);
+};
+
+/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
+ * unpacked structures < 64KB.
+ */
+struct packed_field_m {
+	GEN_PACKED_FIELD_MEMBERS(u16);
+};
+
+#define PACKED_FIELD(start, end, struct_name, struct_field) \
+	{ \
+		(start), \
+		(end), \
+		offsetof(struct_name, struct_field), \
+		sizeof_field(struct_name, struct_field), \
+	}
+
+#define CHECK_PACKED_FIELD(field, pbuflen) \
+	({ typeof(field) __f = (field); typeof(pbuflen) __len = (pbuflen); \
+	BUILD_BUG_ON(__f.startbit < __f.endbit); \
+	BUILD_BUG_ON(__f.startbit >= BITS_PER_BYTE * __len); \
+	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
+	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && __f.size != 4 && __f.size != 8); })
+
+#define CHECK_PACKED_FIELD_OVERLAP(field1, field2) \
+	({ typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
+	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <=  min(_f1.startbit, _f2.startbit)); })
+
+#include <generated/packing-checks.h>
+
+void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_s *fields, size_t num_fields,
+		   u8 quirks);
+
+void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_m *fields, size_t num_fields,
+		   u8 quirks);
+
+void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_s *fields, size_t num_fields,
+		     u8 quirks);
+
+void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
+		      const struct packed_field_m *fields, size_t num_fields,
+		      u8 quirks);
+
+#define pack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	_Generic((fields), \
+		 const struct packed_field_s * : pack_fields_s, \
+		 const struct packed_field_m * : pack_fields_m \
+		)(pbuf, pbuflen, ustruct, fields, ARRAY_SIZE(fields), quirks)
+
+#define unpack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	_Generic((fields), \
+		 const struct packed_field_s * : unpack_fields_s, \
+		 const struct packed_field_m * : unpack_fields_m \
+		)(pbuf, pbuflen, ustruct, fields, ARRAY_SIZE(fields), quirks)
+
 #endif
diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
new file mode 100644
index 000000000000..3213c858c2fe
--- /dev/null
+++ b/lib/gen_packing_checks.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+
+int main(int argc, char **argv)
+{
+	printf("/* Automatically generated - do not edit */\n\n");
+	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
+	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
+
+	for (int i = 1; i <= 50; i++) {
+		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
+		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
+		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
+		for (int j = 0; j < i; j++) {
+			int final = (i == 1);
+
+			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
+			       j, final ? " })\n" : " \\");
+		}
+		for (int j = 1; j < i; j++) {
+			for (int k = 0; k < j; k++) {
+				int final = (j == i - 1) && (k == j - 1);
+
+				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d], _f[%d]);%s\n",
+				       k, j, final ? " })\n" : " \\");
+			}
+		}
+	}
+
+	printf("#endif /* GENERATED_PACKING_CHECKS_H */\n");
+}
diff --git a/lib/packing.c b/lib/packing.c
index 2bf81951dfc8..b7ca55269d0f 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -5,10 +5,37 @@
 #include <linux/packing.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
+#define __pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
+	({									\
+		for (size_t i = 0; i < (num_fields); i++) {			\
+			typeof(&(fields)[0]) field = &(fields)[i];		\
+			u64 uval;						\
+										\
+			uval = ustruct_field_to_u64(ustruct, field->offset, field->size); \
+										\
+			__pack(pbuf, uval, field->startbit, field->endbit,	\
+			       pbuflen, quirks);				\
+		}								\
+	})
+
+#define __unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
+	({									\
+		for (size_t i = 0; i < (num_fields); i++) {			\
+			typeof(&(fields)[0]) field = &fields[i];		\
+			u64 uval;						\
+										\
+			__unpack(pbuf, &uval, field->startbit, field->endbit,	\
+				 pbuflen, quirks);				\
+										\
+			u64_to_ustruct_field(ustruct, field->offset, field->size, uval); \
+		}								\
+	})
+
 /**
  * calculate_box_addr - Determine physical location of byte in buffer
  * @box: Index of byte within buffer seen as a logical big-endian big number
@@ -168,8 +195,8 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 }
 EXPORT_SYMBOL(pack);
 
-static void __unpack(const void *pbuf, u64 *uval, size_t startbit,
-		     size_t endbit, size_t pbuflen, u8 quirks)
+static void __unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
+		     size_t pbuflen, u8 quirks)
 {
 	/* Logical byte indices corresponding to the
 	 * start and end of the field.
@@ -322,4 +349,122 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 }
 EXPORT_SYMBOL(packing);
 
+static u64 ustruct_field_to_u64(const void *ustruct, size_t field_offset,
+				size_t field_size)
+{
+	switch (field_size) {
+	case 1:
+		return *((u8 *)(ustruct + field_offset));
+	case 2:
+		return *((u16 *)(ustruct + field_offset));
+	case 4:
+		return *((u32 *)(ustruct + field_offset));
+	default:
+		return *((u64 *)(ustruct + field_offset));
+	}
+}
+
+static void u64_to_ustruct_field(void *ustruct, size_t field_offset,
+				 size_t field_size, u64 uval)
+{
+	switch (field_size) {
+	case 1:
+		*((u8 *)(ustruct + field_offset)) = uval;
+		break;
+	case 2:
+		*((u16 *)(ustruct + field_offset)) = uval;
+		break;
+	case 4:
+		*((u32 *)(ustruct + field_offset)) = uval;
+		break;
+	default:
+		*((u64 *)(ustruct + field_offset)) = uval;
+		break;
+	}
+}
+
+/**
+ * pack_fields_s - Pack array of small fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of small packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_s *fields, size_t num_fields,
+		   u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_s);
+
+/**
+ * pack_fields_m - Pack array of medium fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of medium packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
+		    const struct packed_field_m *fields, size_t num_fields,
+		    u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_m);
+
+/**
+ * unpack_fields_s - Unpack array of small fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of small packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_s *fields, size_t num_fields,
+		     u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_s);
+
+/**
+ * unpack_fields_m - Unpack array of medium fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of medium packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
+		      const struct packed_field_m *fields, size_t num_fields,
+		      u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_m);
+
 MODULE_DESCRIPTION("Generic bitfield packing and unpacking");
diff --git a/Kbuild b/Kbuild
index 464b34a08f51..35a8b78b72d9 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,6 +34,17 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
+# Generate packing-checks.h
+
+hostprogs += lib/gen_packing_checks
+
+packing-checks := include/generated/packing-checks.h
+
+filechk_gen_packing_checks = lib/gen_packing_checks
+
+$(packing-checks): lib/gen_packing_checks FORCE
+	$(call filechk,gen_packing_checks)
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
@@ -70,7 +81,7 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
 # A phony target that depends on all the preparation targets
 
 PHONY += prepare
-prepare: $(offsets-file) missing-syscalls $(atomic-checks)
+prepare: $(offsets-file) missing-syscalls $(atomic-checks) $(packing-checks)
 	@:
 
 # Ordinary directory descending

-- 
2.47.0.265.g4ca455297942


