Return-Path: <netdev+bounces-139271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C79B13BC
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570D01F21736
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8467646434;
	Sat, 26 Oct 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1v2v8aM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D21DDD1;
	Sat, 26 Oct 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901164; cv=none; b=BMQLJ2G5syy2oET7PqKDwlvhcIOA4xYkK3poVQMOxQiG/fKeb1i07V+y+put9Kxgv+A92Hw8rDpCqbC23n/r1LLlOMUobCpYDaOTrxi7DL+xZ3mtvC4IuDgFpsIBpsxkDLjAp6/KCIkOKa4LP3Lvmn6B6uD6X3yYDrM0TdV/6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901164; c=relaxed/simple;
	bh=jLNdgYJmfcj2P/E79Y9btX2AUpOXIadutMqL5tW2b1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYCaygWIWW0YlAoCN05RO0tJlvWuoHD2/CRxPrmJVBmWBMUz+PQvDRAMFa8Jbg2+Hyh3/yJsxuyuC5WpVJvw0Tsa4nXEiPT6XJbcLzBjNoxG120y8k/MLESIAp6HRK41p3xSCQ1rzqCYWrOacYwwmu7FssQlyXQ1xptLEN0nP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1v2v8aM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901160; x=1761437160;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jLNdgYJmfcj2P/E79Y9btX2AUpOXIadutMqL5tW2b1k=;
  b=X1v2v8aMkHudlso+ld7W3x7FAhLSsp6VKjN6HkTRkSnPs+hPwWHobogu
   yf7R0ETLhS/BdaeuGDFGEQnzKbvQoZRVJXqRHssStIf1vpHwIHBuCp17C
   048dhj4dZ/v5OkwR2PU4NtBPl/5RwVU0xDN78FTXXmVaGR3wdcR35hc4i
   vfAj0jfKIVN6ouxSfk+WEl+gEI4I4ck212nA1PGFv6jJjy2uvkDCrt6Oy
   OXrPBHm2hBT4Uz8rnKNLSmnuXKVAZbCj9BcRj61FyLPW9OxfLZUUNRPsy
   qZnh8sZ+cdqOlPO9Gqh+McD2lwj+vZpK1ouo0eJ/WMX1me87/RVqZdycg
   Q==;
X-CSE-ConnectionGUID: YZLkNoY9QjmxoNNm2KW0PQ==
X-CSE-MsgGUID: mQzhkgqmS4yxPeXDadLg7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959129"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:53 -0700
X-CSE-ConnectionGUID: 02uGlIdzRnmFuqIY9s8wqQ==
X-CSE-MsgGUID: /I70yoAATU2NEL8WjU03Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386845"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2024 17:04:55 -0700
Subject: [PATCH net-next v2 3/9] lib: packing: add pack_fields() and
 unpack_fields()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-3-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
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
  by the developer and thus are not a problem. To limit the amount of code
  generated, limit each CHECK_PACKED_FIELDS* macro to a separate config
  option which the driver must select. This avoids generating thousands of
  unused lines of macro.

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
 include/linux/packing.h  |  73 ++++++++++
 lib/gen_packing_checks.c | 193 +++++++++++++++++++++++++
 lib/packing.c            | 149 ++++++++++++++++++-
 Kbuild                   | 168 +++++++++++++++++++++-
 lib/Kconfig              | 361 ++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 940 insertions(+), 4 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 5d36dcd06f60..31afee8344a5 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -26,4 +26,77 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
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
+#if IS_ENABLED(CONFIG_PACKING_CHECK_FIELDS)
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
+#endif
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
index 000000000000..5ff346a190c0
--- /dev/null
+++ b/lib/gen_packing_checks.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <stdio.h>
+
+static bool generate_checks[51];
+
+static void parse_defines(void)
+{
+#ifdef PACKING_CHECK_FIELDS_1
+	generate_checks[1] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_2
+	generate_checks[2] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_3
+	generate_checks[3] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_4
+	generate_checks[4] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_5
+	generate_checks[5] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_6
+	generate_checks[6] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_7
+	generate_checks[7] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_8
+	generate_checks[8] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_9
+	generate_checks[9] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_10
+	generate_checks[10] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_11
+	generate_checks[11] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_12
+	generate_checks[12] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_13
+	generate_checks[13] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_14
+	generate_checks[14] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_15
+	generate_checks[15] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_16
+	generate_checks[16] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_17
+	generate_checks[17] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_18
+	generate_checks[18] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_19
+	generate_checks[19] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_20
+	generate_checks[20] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_21
+	generate_checks[21] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_22
+	generate_checks[22] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_23
+	generate_checks[23] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_24
+	generate_checks[24] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_25
+	generate_checks[25] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_26
+	generate_checks[26] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_27
+	generate_checks[27] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_28
+	generate_checks[28] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_29
+	generate_checks[29] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_30
+	generate_checks[30] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_31
+	generate_checks[31] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_32
+	generate_checks[32] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_33
+	generate_checks[33] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_34
+	generate_checks[34] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_35
+	generate_checks[35] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_36
+	generate_checks[36] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_37
+	generate_checks[37] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_38
+	generate_checks[38] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_39
+	generate_checks[39] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_40
+	generate_checks[40] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_41
+	generate_checks[41] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_42
+	generate_checks[42] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_43
+	generate_checks[43] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_44
+	generate_checks[44] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_45
+	generate_checks[45] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_46
+	generate_checks[46] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_47
+	generate_checks[47] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_48
+	generate_checks[48] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_49
+	generate_checks[49] = true;
+#endif
+#ifdef PACKING_CHECK_FIELDS_50
+	generate_checks[50] = true;
+#endif
+}
+
+int main(int argc, char **argv)
+{
+	parse_defines();
+
+	printf("/* Automatically generated - do not edit */\n\n");
+	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
+	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
+
+	for (int i = 1; i <= 50; i++) {
+		if (!generate_checks[i])
+			continue;
+
+		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
+		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
+		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
+		for (int j = 0; j < i; j++) {
+			bool final = (i == 1);
+
+			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
+			       j, final ? " })\n" : " \\");
+		}
+		for (int j = 1; j < i; j++) {
+			for (int k = 0; k < j; k++) {
+				bool final = (j == i - 1) && (k == j - 1);
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
index 464b34a08f51..1a4d31b3eb6c 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,6 +34,172 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
+ifdef CONFIG_PACKING_CHECK_FIELDS
+
+# Generate packing-checks.h
+
+ifdef CONFIG_PACKING_CHECK_FIELDS_1
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_1
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_2
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_2
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_3
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_3
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_4
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_4
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_5
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_5
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_6
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_6
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_7
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_7
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_8
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_8
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_9
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_9
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_10
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_10
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_11
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_11
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_12
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_12
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_13
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_13
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_14
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_14
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_15
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_15
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_16
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_16
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_17
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_17
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_18
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_18
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_19
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_19
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_20
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_20
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_21
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_21
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_22
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_22
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_23
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_23
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_24
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_24
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_25
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_25
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_26
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_26
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_27
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_27
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_28
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_28
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_29
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_29
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_30
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_30
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_31
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_31
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_32
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_32
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_33
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_33
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_34
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_34
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_35
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_35
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_36
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_36
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_37
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_37
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_38
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_38
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_39
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_39
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_40
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_40
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_41
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_41
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_42
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_42
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_43
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_43
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_44
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_44
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_45
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_45
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_46
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_46
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_47
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_47
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_48
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_48
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_49
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_49
+endif
+ifdef CONFIG_PACKING_CHECK_FIELDS_50
+HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_50
+endif
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
+endif
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
@@ -70,7 +236,7 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
 # A phony target that depends on all the preparation targets
 
 PHONY += prepare
-prepare: $(offsets-file) missing-syscalls $(atomic-checks)
+prepare: $(offsets-file) missing-syscalls $(atomic-checks) $(packing-checks)
 	@:
 
 # Ordinary directory descending
diff --git a/lib/Kconfig b/lib/Kconfig
index 50d85f38b569..68b440d622f6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -40,9 +40,11 @@ config PACKING
 
 	  When in doubt, say N.
 
+if PACKING
+
 config PACKING_KUNIT_TEST
 	tristate "KUnit tests for packing library" if !KUNIT_ALL_TESTS
-	depends on PACKING && KUNIT
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  This builds KUnit tests for the packing library.
@@ -52,6 +54,363 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config PACKING_CHECK_FIELDS
+	bool
+	help
+	  This option generates the <include/generated/packing-checks.h> file.
+
+config PACKING_CHECK_FIELDS_1
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 1 element.
+
+config PACKING_CHECK_FIELDS_2
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 2 elements.
+
+config PACKING_CHECK_FIELDS_3
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 3 elements.
+
+config PACKING_CHECK_FIELDS_4
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 4 elements.
+
+config PACKING_CHECK_FIELDS_5
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 5 elements.
+
+config PACKING_CHECK_FIELDS_6
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 6 elements.
+
+config PACKING_CHECK_FIELDS_7
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 7 elements.
+
+config PACKING_CHECK_FIELDS_8
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 8 elements.
+
+config PACKING_CHECK_FIELDS_9
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 9 elements.
+
+config PACKING_CHECK_FIELDS_10
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 10 elements.
+
+config PACKING_CHECK_FIELDS_11
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 11 elements.
+
+config PACKING_CHECK_FIELDS_12
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 12 elements.
+
+config PACKING_CHECK_FIELDS_13
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 13 elements.
+
+config PACKING_CHECK_FIELDS_14
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 14 elements.
+
+config PACKING_CHECK_FIELDS_15
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 15 elements.
+
+config PACKING_CHECK_FIELDS_16
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 16 elements.
+
+config PACKING_CHECK_FIELDS_17
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 17 elements.
+
+config PACKING_CHECK_FIELDS_18
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 18 elements.
+
+config PACKING_CHECK_FIELDS_19
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 19 elements.
+
+config PACKING_CHECK_FIELDS_20
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 20 elements.
+
+config PACKING_CHECK_FIELDS_21
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 21 elements.
+
+config PACKING_CHECK_FIELDS_22
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 22 elements.
+
+config PACKING_CHECK_FIELDS_23
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 23 elements.
+
+config PACKING_CHECK_FIELDS_24
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 24 elements.
+
+config PACKING_CHECK_FIELDS_25
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 25 elements.
+
+config PACKING_CHECK_FIELDS_26
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 26 elements.
+
+config PACKING_CHECK_FIELDS_27
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 27 elements.
+
+config PACKING_CHECK_FIELDS_28
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 28 elements.
+
+config PACKING_CHECK_FIELDS_29
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 29 elements.
+
+config PACKING_CHECK_FIELDS_30
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 30 elements.
+
+config PACKING_CHECK_FIELDS_31
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 31 elements.
+
+config PACKING_CHECK_FIELDS_32
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 32 elements.
+
+config PACKING_CHECK_FIELDS_33
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 33 elements.
+
+config PACKING_CHECK_FIELDS_34
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 34 elements.
+
+config PACKING_CHECK_FIELDS_35
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 35 elements.
+
+config PACKING_CHECK_FIELDS_36
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 36 elements.
+
+config PACKING_CHECK_FIELDS_37
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 37 elements.
+
+config PACKING_CHECK_FIELDS_38
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 38 elements.
+
+config PACKING_CHECK_FIELDS_39
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 39 elements.
+
+config PACKING_CHECK_FIELDS_40
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 40 elements.
+
+config PACKING_CHECK_FIELDS_41
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 41 elements.
+
+config PACKING_CHECK_FIELDS_42
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 42 elements.
+
+config PACKING_CHECK_FIELDS_43
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 43 elements.
+
+config PACKING_CHECK_FIELDS_44
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 44 elements.
+
+config PACKING_CHECK_FIELDS_45
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 45 elements.
+
+config PACKING_CHECK_FIELDS_46
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 46 elements.
+
+config PACKING_CHECK_FIELDS_47
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 47 elements.
+
+config PACKING_CHECK_FIELDS_48
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 48 elements.
+
+config PACKING_CHECK_FIELDS_49
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 49 elements.
+
+config PACKING_CHECK_FIELDS_50
+	bool
+	select PACKING_CHECK_FIELDS
+	help
+	  This option generates compile-time checks for struct packed_field
+	  arrays of 50 elements.
+
+endif # PACKING
+
 config BITREVERSE
 	tristate
 

-- 
2.47.0.265.g4ca455297942


