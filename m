Return-Path: <netdev+bounces-150826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832C9EBAD4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2D282E86
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066422837B;
	Tue, 10 Dec 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/iPxx0e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58D226895
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862453; cv=none; b=ZnKVybPyC+7qzy2tIEaXxfMQJBK53CtGgCYflisqM12L83O3KOxIWWGIAZOcbD+AByf8izb7dRmq5MkOFgEDa6C4T/yDj/ONleSMfzvgEv7TI7LmbsAzsgjFpzBMc+lA/XuJl6BIB7p7I1ItHzVy1YVGQJlAq21nyhfNUbpqUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862453; c=relaxed/simple;
	bh=TToxpClbRzPvC69mObsv/oy/EKIMFbKE8tSga3B0Vr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ec3S2VMDMvTNARa5lasVjhn8N4dRacDfdXLPSTKYvSos6wSDA2LSlktvYxRqknMQL5WVOn122jjqg4L/0MmMCdT0nGs/X9Tl893HMqqO8L20bRVZvLIH3E3n3c+oud7Zgk0DyjOZ/AIHYQW9ZycWO4cHUcWwO9UZLdEvXOxV+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/iPxx0e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862451; x=1765398451;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TToxpClbRzPvC69mObsv/oy/EKIMFbKE8tSga3B0Vr4=;
  b=Z/iPxx0ebY4wk3MN8jBJrI76LBOe964p+ZNOOEPFxAA5HsJzhFs1Y6oC
   jrPSoH3OQM52GqtCcODQbeghFdh28iMjgqljKyEjQ3PQJFpqJOQSnKvRm
   XbsTWOpbdy2p0sHxd9UKjLF+warRAPPEK3PcNcYkhSJIAQ1l43heVpAu7
   bKYxGL9QkXRlKzEpE/VObxolPdoGaHtZ00SwU07DXr09as8Ib0ObEghE5
   2KIktnYMmpDO4TB6A2ApYIhMwHzJBGe6Tf0dS6TrIS7AnlY3WlNGwzMgc
   3VFssgX/jCOmAQqcIOx3h1k3z6wbz5rl05tEcEtCfX0xLOxl4Kex11V5G
   A==;
X-CSE-ConnectionGUID: VvqzFTTbRfy7IUJO4E++WA==
X-CSE-MsgGUID: ppcyVy4eQ6iZ9wu6Nwb4/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147289"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
X-CSE-ConnectionGUID: phtjqFKgScaktBSDfO69Ag==
X-CSE-MsgGUID: uAEqDErhRnWpNIznabrH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424086"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:27 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:12 -0800
Subject: [PATCH net-next v10 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-3-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is new API which caters to the following requirements:

- Pack or unpack a large number of fields to/from a buffer with a small
  code footprint. The current alternative is to open-code a large number
  of calls to pack() and unpack(), or to use packing() to reduce that
  number to half. But packing() is not const-correct.

- Use unpacked numbers stored in variables smaller than u64. This
  reduces the rodata footprint of the stored field arrays.

- Perform error checking at compile time, rather than runtime, and return
  void from the API functions. Because the C preprocessor can't generate
  variable length code (loops), this is a bit tricky to do with macros.

  To handle this, implement macros which sanity check the packed field
  definitions based on their size. Finally, a single macro with a chain of
  __builtin_choose_expr() is used to select the appropriate macros. We
  enforce the use of ascending or descending order to avoid O(N^2) scaling
  when checking for overlap. Note that the macros are written with care to
  ensure that the compilers can correctly evaluate the resulting code at
  compile time. In particular, care was taken with avoiding too many nested
  statement expressions. Nested statement expressions trip up some
  compilers, especially when passing down variables created in previous
  statement expressions.

  There are two key design choices intended to keep the overall macro code
  size small. First, the definition of each CHECK_PACKED_FIELDS_N macro is
  implemented recursively, by calling the N-1 macro. This avoids needing
  the code to repeat multiple times.

  Second, the CHECK_PACKED_FIELD macro enforces that the fields in the
  array are sorted in order. This allows checking for overlap only with
  neighboring fields, rather than the general overlap case where each field
  would need to be checked against other fields.

  The overlap checks use the first two fields to determine the order of the
  remaining fields, thus allowing either ascending or descending order.
  This enables drivers the flexibility to keep the fields ordered in which
  ever order most naturally fits their hardware design and its associated
  documentation.

  The CHECK_PACKED_FIELDS macro is directly called from within pack_fields
  and unpack_fields, ensuring that all drivers using the API receive the
  benefits of the compile-time checks. Users do not need to directly call
  any of the macros directly.

  The CHECK_PACKED_FIELDS and its helper macros CHECK_PACKED_FIELDS_(0..50)
  are generated using a simple C program in scripts/gen_packed_field_checks.c
  This program can be compiled on demand and executed to generate the
  macro code in include/linux/packing.h. This will aid in the event that a
  driver needs more than 50 fields. The generator can be updated with a new
  size, and used to update the packing.h header file. In practice, the ice
  driver will need to support 27 fields, and the sja1105 driver will need
  to support 0 fields. This on-demand generation avoids the need to modify
  Kbuild. We do not anticipate the maximum number of fields to grow very
  often.

- Reduced rodata footprint for the storage of the packed field arrays.
  To that end, we have struct packed_field_u8 and packed_field_u16, which
  define the fields with the associated type. More can be added as
  needed (unlikely for now). On these types, the same generic pack_fields()
  and unpack_fields() API can be used, thanks to the new C11 _Generic()
  selection feature, which can call pack_fields_u8() or pack_fields_16(),
  depending on the type of the "fields" array - a simplistic form of
  polymorphism. It is evaluated at compile time which function will actually
  be called.

Over time, packing() is expected to be completely replaced either with
pack() or with pack_fields().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Makefile                          |   4 +
 include/linux/packing.h           | 425 ++++++++++++++++++++++++++++++++++++++
 lib/packing.c                     | 153 ++++++++++++++
 lib/packing_test.c                |  61 ++++++
 scripts/gen_packed_field_checks.c |  37 ++++
 MAINTAINERS                       |   1 +
 scripts/.gitignore                |   1 +
 scripts/Makefile                  |   2 +-
 8 files changed, 683 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 93ab62cef244ff99701e271bd23ef18c5b6b30ba..9a9fd5504ae8f47cc56668d7956b4bab5b59369b 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,6 +1367,10 @@ PHONY += scripts_unifdef
 scripts_unifdef: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 
+PHONY += scripts_gen_packed_field_checks
+scripts_gen_packed_field_checks: scripts_basic
+	$(Q)$(MAKE) $(build)=scripts scripts/gen_packed_field_checks
+
 # ---------------------------------------------------------------------------
 # Install
 
diff --git a/include/linux/packing.h b/include/linux/packing.h
index 5d36dcd06f60420325473dae3a0e9ac37d03da4b..0589d70bbe0434c418f41b842f92b3300a107762 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -8,6 +8,83 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 
+#define GEN_PACKED_FIELD_STRUCT(__type) \
+	struct packed_field_ ## __type { \
+		__type startbit; \
+		__type endbit; \
+		__type offset; \
+		__type size; \
+	}
+
+/* struct packed_field_u8. Use with bit offsets < 256, buffers < 32B and
+ * unpacked structures < 256B.
+ */
+GEN_PACKED_FIELD_STRUCT(u8);
+
+/* struct packed_field_u16. Use with bit offsets < 65536, buffers < 8KB and
+ * unpacked structures < 64KB.
+ */
+GEN_PACKED_FIELD_STRUCT(u16);
+
+#define PACKED_FIELD(start, end, struct_name, struct_field) \
+{ \
+	(start), \
+	(end), \
+	offsetof(struct_name, struct_field), \
+	sizeof_field(struct_name, struct_field), \
+}
+
+#define CHECK_PACKED_FIELD_OVERLAP(fields, index1, index2) ({ \
+	typeof(&(fields)[0]) __f = (fields); \
+	typeof(__f[0]) _f1 = __f[index1]; typeof(__f[0]) _f2 = __f[index2]; \
+	const bool _ascending = __f[0].startbit < __f[1].startbit; \
+	BUILD_BUG_ON_MSG(_ascending && _f1.startbit >= _f2.startbit, \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " breaks ascending order"); \
+	BUILD_BUG_ON_MSG(!_ascending && _f1.startbit <= _f2.startbit, \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " breaks descending order"); \
+	BUILD_BUG_ON_MSG(max(_f1.endbit, _f2.endbit) <= \
+			 min(_f1.startbit, _f2.startbit), \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " overlaps with previous field"); \
+})
+
+#define CHECK_PACKED_FIELD(fields, index) ({ \
+	typeof(&(fields)[0]) _f = (fields); \
+	typeof(_f[0]) __f = _f[index]; \
+	BUILD_BUG_ON_MSG(__f.startbit < __f.endbit, \
+			 __stringify(fields) " field " __stringify(index) \
+			 " start bit must not be smaller than end bit"); \
+	BUILD_BUG_ON_MSG(__f.size != 1 && __f.size != 2 && \
+			 __f.size != 4 && __f.size != 8, \
+			 __stringify(fields) " field " __stringify(index) \
+			" has unsupported unpacked storage size"); \
+	BUILD_BUG_ON_MSG(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size, \
+			 __stringify(fields) " field " __stringify(index) \
+			 " exceeds unpacked storage size"); \
+	__builtin_choose_expr(index != 0, \
+			      CHECK_PACKED_FIELD_OVERLAP(fields, index - 1, index), \
+			      1); \
+})
+
+/* Note that the packed fields may be either in ascending or descending order.
+ * Thus, we must check that both the first and last field wit within the
+ * packed buffer size.
+ */
+#define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
+	typeof(&(fields)[0]) _f = (fields); \
+	typeof(pbuflen) _len = (pbuflen); \
+	const size_t num_fields = ARRAY_SIZE(fields); \
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(_len), \
+			 __stringify(fields) " pbuflen " __stringify(pbuflen) \
+			 " must be a compile time constant"); \
+	BUILD_BUG_ON_MSG(_f[0].startbit >= BITS_PER_BYTE * _len, \
+			 __stringify(fields) " first field exceeds packed buffer size"); \
+	BUILD_BUG_ON_MSG(_f[num_fields - 1].startbit >= BITS_PER_BYTE * _len, \
+			 __stringify(fields) " last field exceeds packed buffer size"); \
+})
+
 #define QUIRK_MSB_ON_THE_RIGHT	BIT(0)
 #define QUIRK_LITTLE_ENDIAN	BIT(1)
 #define QUIRK_LSW32_IS_FIRST	BIT(2)
@@ -26,4 +103,352 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	   size_t pbuflen, u8 quirks);
 
+void pack_fields_u8(void *pbuf, size_t pbuflen, const void *ustruct,
+		    const struct packed_field_u8 *fields, size_t num_fields,
+		    u8 quirks);
+
+void pack_fields_u16(void *pbuf, size_t pbuflen, const void *ustruct,
+		     const struct packed_field_u16 *fields, size_t num_fields,
+		     u8 quirks);
+
+void unpack_fields_u8(const void *pbuf, size_t pbuflen, void *ustruct,
+		      const struct packed_field_u8 *fields, size_t num_fields,
+		      u8 quirks);
+
+void unpack_fields_u16(const void *pbuf, size_t pbuflen, void *ustruct,
+		       const struct packed_field_u16 *fields, size_t num_fields,
+		       u8 quirks);
+
+/* Do not hand-edit the following packed field check macros!
+ *
+ * They are generated using scripts/gen_packed_field_checks.c, which may be
+ * built via "make scripts_gen_packed_field_checks". If larger macro sizes are
+ * needed in the future, please use this program to re-generate the macros and
+ * insert them here.
+ */
+
+#define CHECK_PACKED_FIELDS_1(fields) \
+	CHECK_PACKED_FIELD(fields, 0)
+
+#define CHECK_PACKED_FIELDS_2(fields) do { \
+	CHECK_PACKED_FIELDS_1(fields); \
+	CHECK_PACKED_FIELD(fields, 1); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_3(fields) do { \
+	CHECK_PACKED_FIELDS_2(fields); \
+	CHECK_PACKED_FIELD(fields, 2); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_4(fields) do { \
+	CHECK_PACKED_FIELDS_3(fields); \
+	CHECK_PACKED_FIELD(fields, 3); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_5(fields) do { \
+	CHECK_PACKED_FIELDS_4(fields); \
+	CHECK_PACKED_FIELD(fields, 4); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_6(fields) do { \
+	CHECK_PACKED_FIELDS_5(fields); \
+	CHECK_PACKED_FIELD(fields, 5); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_7(fields) do { \
+	CHECK_PACKED_FIELDS_6(fields); \
+	CHECK_PACKED_FIELD(fields, 6); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_8(fields) do { \
+	CHECK_PACKED_FIELDS_7(fields); \
+	CHECK_PACKED_FIELD(fields, 7); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_9(fields) do { \
+	CHECK_PACKED_FIELDS_8(fields); \
+	CHECK_PACKED_FIELD(fields, 8); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_10(fields) do { \
+	CHECK_PACKED_FIELDS_9(fields); \
+	CHECK_PACKED_FIELD(fields, 9); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_11(fields) do { \
+	CHECK_PACKED_FIELDS_10(fields); \
+	CHECK_PACKED_FIELD(fields, 10); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_12(fields) do { \
+	CHECK_PACKED_FIELDS_11(fields); \
+	CHECK_PACKED_FIELD(fields, 11); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_13(fields) do { \
+	CHECK_PACKED_FIELDS_12(fields); \
+	CHECK_PACKED_FIELD(fields, 12); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_14(fields) do { \
+	CHECK_PACKED_FIELDS_13(fields); \
+	CHECK_PACKED_FIELD(fields, 13); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_15(fields) do { \
+	CHECK_PACKED_FIELDS_14(fields); \
+	CHECK_PACKED_FIELD(fields, 14); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_16(fields) do { \
+	CHECK_PACKED_FIELDS_15(fields); \
+	CHECK_PACKED_FIELD(fields, 15); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_17(fields) do { \
+	CHECK_PACKED_FIELDS_16(fields); \
+	CHECK_PACKED_FIELD(fields, 16); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_18(fields) do { \
+	CHECK_PACKED_FIELDS_17(fields); \
+	CHECK_PACKED_FIELD(fields, 17); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_19(fields) do { \
+	CHECK_PACKED_FIELDS_18(fields); \
+	CHECK_PACKED_FIELD(fields, 18); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_20(fields) do { \
+	CHECK_PACKED_FIELDS_19(fields); \
+	CHECK_PACKED_FIELD(fields, 19); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_21(fields) do { \
+	CHECK_PACKED_FIELDS_20(fields); \
+	CHECK_PACKED_FIELD(fields, 20); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_22(fields) do { \
+	CHECK_PACKED_FIELDS_21(fields); \
+	CHECK_PACKED_FIELD(fields, 21); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_23(fields) do { \
+	CHECK_PACKED_FIELDS_22(fields); \
+	CHECK_PACKED_FIELD(fields, 22); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_24(fields) do { \
+	CHECK_PACKED_FIELDS_23(fields); \
+	CHECK_PACKED_FIELD(fields, 23); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_25(fields) do { \
+	CHECK_PACKED_FIELDS_24(fields); \
+	CHECK_PACKED_FIELD(fields, 24); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_26(fields) do { \
+	CHECK_PACKED_FIELDS_25(fields); \
+	CHECK_PACKED_FIELD(fields, 25); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_27(fields) do { \
+	CHECK_PACKED_FIELDS_26(fields); \
+	CHECK_PACKED_FIELD(fields, 26); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_28(fields) do { \
+	CHECK_PACKED_FIELDS_27(fields); \
+	CHECK_PACKED_FIELD(fields, 27); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_29(fields) do { \
+	CHECK_PACKED_FIELDS_28(fields); \
+	CHECK_PACKED_FIELD(fields, 28); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_30(fields) do { \
+	CHECK_PACKED_FIELDS_29(fields); \
+	CHECK_PACKED_FIELD(fields, 29); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_31(fields) do { \
+	CHECK_PACKED_FIELDS_30(fields); \
+	CHECK_PACKED_FIELD(fields, 30); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_32(fields) do { \
+	CHECK_PACKED_FIELDS_31(fields); \
+	CHECK_PACKED_FIELD(fields, 31); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_33(fields) do { \
+	CHECK_PACKED_FIELDS_32(fields); \
+	CHECK_PACKED_FIELD(fields, 32); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_34(fields) do { \
+	CHECK_PACKED_FIELDS_33(fields); \
+	CHECK_PACKED_FIELD(fields, 33); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_35(fields) do { \
+	CHECK_PACKED_FIELDS_34(fields); \
+	CHECK_PACKED_FIELD(fields, 34); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_36(fields) do { \
+	CHECK_PACKED_FIELDS_35(fields); \
+	CHECK_PACKED_FIELD(fields, 35); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_37(fields) do { \
+	CHECK_PACKED_FIELDS_36(fields); \
+	CHECK_PACKED_FIELD(fields, 36); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_38(fields) do { \
+	CHECK_PACKED_FIELDS_37(fields); \
+	CHECK_PACKED_FIELD(fields, 37); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_39(fields) do { \
+	CHECK_PACKED_FIELDS_38(fields); \
+	CHECK_PACKED_FIELD(fields, 38); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_40(fields) do { \
+	CHECK_PACKED_FIELDS_39(fields); \
+	CHECK_PACKED_FIELD(fields, 39); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_41(fields) do { \
+	CHECK_PACKED_FIELDS_40(fields); \
+	CHECK_PACKED_FIELD(fields, 40); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_42(fields) do { \
+	CHECK_PACKED_FIELDS_41(fields); \
+	CHECK_PACKED_FIELD(fields, 41); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_43(fields) do { \
+	CHECK_PACKED_FIELDS_42(fields); \
+	CHECK_PACKED_FIELD(fields, 42); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_44(fields) do { \
+	CHECK_PACKED_FIELDS_43(fields); \
+	CHECK_PACKED_FIELD(fields, 43); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_45(fields) do { \
+	CHECK_PACKED_FIELDS_44(fields); \
+	CHECK_PACKED_FIELD(fields, 44); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_46(fields) do { \
+	CHECK_PACKED_FIELDS_45(fields); \
+	CHECK_PACKED_FIELD(fields, 45); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_47(fields) do { \
+	CHECK_PACKED_FIELDS_46(fields); \
+	CHECK_PACKED_FIELD(fields, 46); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_48(fields) do { \
+	CHECK_PACKED_FIELDS_47(fields); \
+	CHECK_PACKED_FIELD(fields, 47); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_49(fields) do { \
+	CHECK_PACKED_FIELDS_48(fields); \
+	CHECK_PACKED_FIELD(fields, 48); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS_50(fields) do { \
+	CHECK_PACKED_FIELDS_49(fields); \
+	CHECK_PACKED_FIELD(fields, 49); \
+} while (0)
+
+#define CHECK_PACKED_FIELDS(fields) \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 1, ({ CHECK_PACKED_FIELDS_1(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 2, ({ CHECK_PACKED_FIELDS_2(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 3, ({ CHECK_PACKED_FIELDS_3(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 4, ({ CHECK_PACKED_FIELDS_4(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 5, ({ CHECK_PACKED_FIELDS_5(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 6, ({ CHECK_PACKED_FIELDS_6(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 7, ({ CHECK_PACKED_FIELDS_7(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 8, ({ CHECK_PACKED_FIELDS_8(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 9, ({ CHECK_PACKED_FIELDS_9(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 10, ({ CHECK_PACKED_FIELDS_10(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 11, ({ CHECK_PACKED_FIELDS_11(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 12, ({ CHECK_PACKED_FIELDS_12(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 13, ({ CHECK_PACKED_FIELDS_13(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 14, ({ CHECK_PACKED_FIELDS_14(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 15, ({ CHECK_PACKED_FIELDS_15(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 16, ({ CHECK_PACKED_FIELDS_16(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 17, ({ CHECK_PACKED_FIELDS_17(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 18, ({ CHECK_PACKED_FIELDS_18(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 19, ({ CHECK_PACKED_FIELDS_19(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 20, ({ CHECK_PACKED_FIELDS_20(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 21, ({ CHECK_PACKED_FIELDS_21(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 22, ({ CHECK_PACKED_FIELDS_22(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 23, ({ CHECK_PACKED_FIELDS_23(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 24, ({ CHECK_PACKED_FIELDS_24(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 25, ({ CHECK_PACKED_FIELDS_25(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 26, ({ CHECK_PACKED_FIELDS_26(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 27, ({ CHECK_PACKED_FIELDS_27(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 28, ({ CHECK_PACKED_FIELDS_28(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 29, ({ CHECK_PACKED_FIELDS_29(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 30, ({ CHECK_PACKED_FIELDS_30(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 31, ({ CHECK_PACKED_FIELDS_31(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 32, ({ CHECK_PACKED_FIELDS_32(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 33, ({ CHECK_PACKED_FIELDS_33(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 34, ({ CHECK_PACKED_FIELDS_34(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 35, ({ CHECK_PACKED_FIELDS_35(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 36, ({ CHECK_PACKED_FIELDS_36(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 37, ({ CHECK_PACKED_FIELDS_37(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 38, ({ CHECK_PACKED_FIELDS_38(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 39, ({ CHECK_PACKED_FIELDS_39(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 40, ({ CHECK_PACKED_FIELDS_40(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 41, ({ CHECK_PACKED_FIELDS_41(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 42, ({ CHECK_PACKED_FIELDS_42(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 43, ({ CHECK_PACKED_FIELDS_43(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 44, ({ CHECK_PACKED_FIELDS_44(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 45, ({ CHECK_PACKED_FIELDS_45(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 46, ({ CHECK_PACKED_FIELDS_46(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 47, ({ CHECK_PACKED_FIELDS_47(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 48, ({ CHECK_PACKED_FIELDS_48(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 49, ({ CHECK_PACKED_FIELDS_49(fields); }), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 50, ({ CHECK_PACKED_FIELDS_50(fields); }), \
+	({ BUILD_BUG_ON_MSG(1, "CHECK_PACKED_FIELDS() must be regenerated to support array sizes larger than 50."); }) \
+))))))))))))))))))))))))))))))))))))))))))))))))))
+
+/* End of generated content */
+
+#define pack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	({ \
+		CHECK_PACKED_FIELDS(fields); \
+		CHECK_PACKED_FIELDS_SIZE((fields), (pbuflen)); \
+		_Generic((fields), \
+			 const struct packed_field_u8 * : pack_fields_u8, \
+			 const struct packed_field_u16 * : pack_fields_u16 \
+			)((pbuf), (pbuflen), (ustruct), (fields), ARRAY_SIZE(fields), (quirks)); \
+	})
+
+#define unpack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	({ \
+		CHECK_PACKED_FIELDS(fields); \
+		CHECK_PACKED_FIELDS_SIZE((fields), (pbuflen)); \
+		_Generic((fields), \
+			 const struct packed_field_u8 * : unpack_fields_u8, \
+			 const struct packed_field_u16 * : unpack_fields_u16 \
+			)((pbuf), (pbuflen), (ustruct), (fields), ARRAY_SIZE(fields), (quirks)); \
+	})
+
 #endif
diff --git a/lib/packing.c b/lib/packing.c
index 09a2d195b9433b61c86f3b63ff019ab319c83e97..bb1643d9e64d762bc7dd226487d75dc7c879b763 100644
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
@@ -322,4 +349,130 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
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
+ * pack_fields_u8 - Pack array of fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_u8 definitions.
+ * @fields: Array of packed_field_u8 field definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Use the pack_fields() macro instead of calling this directly.
+ */
+void pack_fields_u8(void *pbuf, size_t pbuflen, const void *ustruct,
+		    const struct packed_field_u8 *fields, size_t num_fields,
+		    u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_u8);
+
+/**
+ * pack_fields_u16 - Pack array of fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_u16 definitions.
+ * @fields: Array of packed_field_u16 field definitions. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Use the pack_fields() macro instead of calling this directly.
+ */
+void pack_fields_u16(void *pbuf, size_t pbuflen, const void *ustruct,
+		     const struct packed_field_u16 *fields, size_t num_fields,
+		     u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_u16);
+
+/**
+ * unpack_fields_u8 - Unpack array of fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_u8 definitions.
+ * @fields: Array of packed_field_u8 field definitions. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Use the unpack_fields() macro instead of calling this directly.
+ */
+void unpack_fields_u8(const void *pbuf, size_t pbuflen, void *ustruct,
+		      const struct packed_field_u8 *fields, size_t num_fields,
+		      u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_u8);
+
+/**
+ * unpack_fields_u16 - Unpack array of fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_u16 definitions.
+ * @fields: Array of packed_field_u16 field definitions. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Use the unpack_fields() macro instead of calling this directly.
+ */
+void unpack_fields_u16(const void *pbuf, size_t pbuflen, void *ustruct,
+		       const struct packed_field_u16 *fields, size_t num_fields,
+		       u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_u16);
+
 MODULE_DESCRIPTION("Generic bitfield packing and unpacking");
diff --git a/lib/packing_test.c b/lib/packing_test.c
index b38ea43c03fd83639f18a6f3e2a42eae36118c45..ce3b83d33b0417a2be8172dbf59056e8d0879b46 100644
--- a/lib/packing_test.c
+++ b/lib/packing_test.c
@@ -396,9 +396,70 @@ static void packing_test_unpack(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, uval, params->uval);
 }
 
+#define PACKED_BUF_SIZE 8
+
+typedef struct __packed { u8 buf[PACKED_BUF_SIZE]; } packed_buf_t;
+
+struct test_data {
+	u32 field3;
+	u16 field2;
+	u16 field4;
+	u16 field6;
+	u8 field1;
+	u8 field5;
+};
+
+static const struct packed_field_u8 test_fields[] = {
+	PACKED_FIELD(63, 61, struct test_data, field1),
+	PACKED_FIELD(60, 52, struct test_data, field2),
+	PACKED_FIELD(51, 28, struct test_data, field3),
+	PACKED_FIELD(27, 14, struct test_data, field4),
+	PACKED_FIELD(13, 9, struct test_data, field5),
+	PACKED_FIELD(8, 0, struct test_data, field6),
+};
+
+static void packing_test_pack_fields(struct kunit *test)
+{
+	const struct test_data data = {
+		.field1 = 0x2,
+		.field2 = 0x100,
+		.field3 = 0xF00050,
+		.field4 = 0x7D3,
+		.field5 = 0x9,
+		.field6 = 0x10B,
+	};
+	packed_buf_t expect = {
+		.buf = { 0x50, 0x0F, 0x00, 0x05, 0x01, 0xF4, 0xD3, 0x0B },
+	};
+	packed_buf_t buf = {};
+
+	pack_fields(&buf, sizeof(buf), &data, test_fields, 0);
+
+	KUNIT_EXPECT_MEMEQ(test, &expect, &buf, sizeof(buf));
+}
+
+static void packing_test_unpack_fields(struct kunit *test)
+{
+	const packed_buf_t buf = {
+		.buf = { 0x17, 0x28, 0x10, 0x19, 0x3D, 0xA9, 0x07, 0x9C },
+	};
+	struct test_data data = {};
+
+	unpack_fields(&buf, sizeof(buf), &data, test_fields, 0);
+
+	KUNIT_EXPECT_EQ(test, 0, data.field1);
+	KUNIT_EXPECT_EQ(test, 0x172, data.field2);
+	KUNIT_EXPECT_EQ(test, 0x810193, data.field3);
+	KUNIT_EXPECT_EQ(test, 0x36A4, data.field4);
+	KUNIT_EXPECT_EQ(test, 0x3, data.field5);
+	KUNIT_EXPECT_EQ(test, 0x19C, data.field6);
+}
+
 static struct kunit_case packing_test_cases[] = {
 	KUNIT_CASE_PARAM(packing_test_pack, packing_gen_params),
 	KUNIT_CASE_PARAM(packing_test_unpack, packing_gen_params),
+	KUNIT_CASE(packing_test_pack_fields),
+	KUNIT_CASE(packing_test_unpack_fields),
 	{},
 };
 
diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
new file mode 100644
index 0000000000000000000000000000000000000000..60042b7616eef6f99680967908684dfb460013e1
--- /dev/null
+++ b/scripts/gen_packed_field_checks.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024, Intel Corporation
+#include <stdbool.h>
+#include <stdio.h>
+
+#define MAX_PACKED_FIELD_SIZE 50
+
+int main(int argc, char **argv)
+{
+	/* The first macro doesn't need a 'do {} while(0)' loop */
+	printf("#define CHECK_PACKED_FIELDS_1(fields) \\\n");
+	printf("\tCHECK_PACKED_FIELD(fields, 0)\n\n");
+
+	/* Remaining macros require a do/while loop, and are implemented
+	 * recursively by calling the previous iteration's macro.
+	 */
+	for (int i = 2; i <= MAX_PACKED_FIELD_SIZE; i++) {
+		printf("#define CHECK_PACKED_FIELDS_%d(fields) do { \\\n", i);
+		printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
+		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i - 1);
+		printf("} while (0)\n\n");
+	}
+
+	printf("#define CHECK_PACKED_FIELDS(fields) \\\n");
+
+	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
+		printf("\t__builtin_choose_expr(ARRAY_SIZE(fields) == %d, ({ CHECK_PACKED_FIELDS_%d(fields); }), \\\n",
+		       i, i);
+
+	printf("\t({ BUILD_BUG_ON_MSG(1, \"CHECK_PACKED_FIELDS() must be regenerated to support array sizes larger than %d.\"); }) \\\n",
+	       MAX_PACKED_FIELD_SIZE);
+
+	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
+		printf(")");
+
+	printf("\n");
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index af35519be3200af339a11d994cda60b177b091be..15cf366c0aecf3aaa7bb3d8a4f19179527593ade 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17644,6 +17644,7 @@ F:	Documentation/core-api/packing.rst
 F:	include/linux/packing.h
 F:	lib/packing.c
 F:	lib/packing_test.c
+F:	scripts/gen_packed_field_checks.c
 
 PADATA PARALLEL EXECUTION MECHANISM
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 3dbb8bb2457bcab00b1566faa6d1d07f8f1948ca..c2ef68848da5c3b1f025f9cb8ba6bf82c322decd 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
+/gen_packed_field_checks
 /generate_rust_target
 /insert-sys-cert
 /kallsyms
diff --git a/scripts/Makefile b/scripts/Makefile
index 6bcda4b9d054021b185488841cd36c6e0fb86d0c..546e8175e1c4c8209e67a7f92f7d1e795a030988 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -47,7 +47,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
 # The following programs are only built on demand
-hostprogs += unifdef
+hostprogs += unifdef gen_packed_field_checks
 
 # The module linker script is preprocessed on demand
 targets += module.lds

-- 
2.47.0.265.g4ca455297942


