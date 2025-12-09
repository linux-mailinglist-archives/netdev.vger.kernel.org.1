Return-Path: <netdev+bounces-244096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951DCAF8DF
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B988C30DC3BE
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C384326941;
	Tue,  9 Dec 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="q+8ONBud"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23D325715
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274638; cv=none; b=pZLhJ3Pbsb+KkDv95RM7psP4KU/Dh5tXq6rEzIKYoYMCRJ6ETNNCYbeeNccR9q/gqlbkIWKCzW00mebvhsmYnVHA7RkVeyxIx/jUuntGsO5reVd08JFjO5V1zV5KinrfUtuRK2wN28A3iPM0NgmExSdXgSzZuGyzPAIvQr0A/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274638; c=relaxed/simple;
	bh=tSCid1sPM0NX+JcS8589gqV/qYOqQ9nwuLmgYPNoSTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEsNL1l2QBoUIyUYH4vn5Ee563o/iFKytPda2csW4RomBs02Oa1yU9c1463ta5ajne9ivdaGOHd6705w59atW2CcSw7dGiBtulOH5HWpy4LabWE0/VVmbR7ihtRT9owfPTJ4xsnAzsAL9bqGCjAqCJbFdqS5KS45XrMq+TozgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=q+8ONBud; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZR-00HDB2-Ez; Tue, 09 Dec 2025 11:03:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=OPG7fOtrkSC18N/RtHW1QBQqlawki4Y6k2/a0XZqajk=; b=q+8ONBud9kB/D38Wv1XtzGNYgz
	1Q1ZbG9xuiuKUQp4/4kM2uKX9UDSELqnfSRW/ilOx+zsdHIpa4T4KI7RztYAW7WMHybSeYJukmfyl
	L+sY6AmQu1RLKTApX9zviUrpEWDFwcPWFX1oe2QexB51kPP0EHDIaFioBtEbxHOyCQlyFhaE+Z19X
	hADKVYgueALMBFeik/FUuxqcSlt4wUZTp/LO8J/sGVmBemyLeglQc8MdgbjpWrSnzrvskKaGsOW23
	UOdVagj3D1KSBlhjSjHVRn2mUeXqsl2PeQheSxERdN1iQXLtG94fO6255X7YjuLOGllEqfh4gYcsS
	DkOeS7pQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZQ-00075o-VA; Tue, 09 Dec 2025 11:03:49 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ7-00CND9-0p; Tue, 09 Dec 2025 11:03:29 +0100
From: david.laight.linux@gmail.com
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 6/9] bitfield: Update sanity checks
Date: Tue,  9 Dec 2025 10:03:10 +0000
Message-Id: <20251209100313.2867-7-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251209100313.2867-1-david.laight.linux@gmail.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Simplify the check for 'reg' being large enough to hold 'mask' using
sizeof (reg) rather than a convoluted scheme to generate an unsigned
type the same size as 'reg'.

There are three places where the mask is checked for being non-zero
and contiguous. Add a simple expression that checks it and use in
all three places.

Three of the five calls to __BF_FIELD_CHECK_MASK() don't have a 'value'
to check, separate out as was done to __BF_FIELD_CHECK_REG().

There is no point checking a 'val' of zero or a 'reg' of 0ULL (both
are placeholders) - remove/change the calls.

There should be a check of __BF_FIELD_CHECK_REG() when __BF_FIELD_GET()
is called from field_get().
Move the check from FIELD_GET() into __BF_FIELD_GET().

Delete the now-unused __BF_FIELD_CHECK().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 74 ++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3e0e8533bb66..7e8d436b6571 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -45,55 +45,38 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
-#define __scalar_type_to_unsigned_cases(type)				\
-		unsigned type:	(unsigned type)0,			\
-		signed type:	(unsigned type)0
+#define __BF_VALIDATE_MASK(mask) \
+	(!(mask) || ((mask) & ((mask) + ((mask) & -(mask)))))
 
-#define __unsigned_scalar_typeof(x) typeof(				\
-		_Generic((x),						\
-			char:	(unsigned char)0,			\
-			__scalar_type_to_unsigned_cases(char),		\
-			__scalar_type_to_unsigned_cases(short),		\
-			__scalar_type_to_unsigned_cases(int),		\
-			__scalar_type_to_unsigned_cases(long),		\
-			__scalar_type_to_unsigned_cases(long long),	\
-			default: (x)))
-
-#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
-
-#define __BF_FIELD_CHECK_MASK(mask, val, pfx)				\
-	({								\
+#define __BF_FIELD_CHECK_MASK(mask, pfx)				\
+	do {								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
 				 pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG((mask) == 0, _pfx "mask is zero");	\
-		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
-				 ~((mask) >> __bf_shf(mask)) &		\
-					(0 + (val)) : 0,		\
-				 pfx "value too large for the field");	\
-		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
-					      (1ULL << __bf_shf(mask))); \
-	})
+		BUILD_BUG_ON_MSG(__BF_VALIDATE_MASK(mask),		\
+				 pfx "mask is zero or not contiguous");	\
+	} while (0)
+
+#define __BF_FIELD_CHECK_VAL(mask, val, pfx)			\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(val) &&		\
+			 ~((mask) >> __bf_shf(mask)) & (val),	\
+			 pfx "value too large for the field")
 
 #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
-	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
-			 __bf_cast_unsigned(reg, ~0ull),		\
+	BUILD_BUG_ON_MSG(mask + 0U + 0UL + 0ULL >			\
+			 ~0ULL >> (64 - 8 * sizeof (reg)),		\
 			 pfx "type of reg too small for mask")
 
-#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
-	({								\
-		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
-		__BF_FIELD_CHECK_REG(mask, reg, pfx);			\
-	})
-
 #define __BF_FIELD_PREP(mask, val, pfx)					\
 	({								\
-		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
+		__BF_FIELD_CHECK_MASK(mask, pfx);			\
+		__BF_FIELD_CHECK_VAL(mask, val, pfx);			\
 		((val) << __bf_shf(mask)) & (mask);			\
 	})
 
 #define __BF_FIELD_GET(mask, reg, pfx)					\
 	({								\
-		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
+		__BF_FIELD_CHECK_MASK(mask, pfx);			\
+		__BF_FIELD_CHECK_REG(mask, reg, pfx);			\
 		((reg) & (mask)) >> __bf_shf(mask);			\
 	})
 
@@ -107,7 +90,7 @@
 #define FIELD_MAX(mask)							\
 	({								\
 		__auto_type _mask = mask;				\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_MAX: ");		\
 		(_mask >> __bf_shf(_mask));				\
 	})
 
@@ -122,7 +105,7 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_FIT: ");		\
 		!((_val << __bf_shf(_mask)) & ~_mask); 			\
 	})
 
@@ -138,12 +121,9 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
-		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
 		__BF_FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
 
-#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
-
 /**
  * FIELD_PREP_CONST() - prepare a constant bitfield element
  * @mask: shifted mask defining the field's length and position
@@ -158,12 +138,10 @@
  */
 #define FIELD_PREP_CONST(mask, val)					\
 	(								\
-		/* mask must be non-zero */				\
-		BUILD_BUG_ON_ZERO((mask) == 0) +			\
+		/* mask must be non-zero and contiguous */		\
+		BUILD_BUG_ON_ZERO(__BF_VALIDATE_MASK(mask)) +		\
 		/* check if value fits */				\
 		BUILD_BUG_ON_ZERO(~((mask) >> __bf_shf(mask)) & (val)) + \
-		/* check if mask is contiguous */			\
-		__BF_CHECK_POW2((mask) + (1ULL << __bf_shf(mask))) +	\
 		/* and create the value */				\
 		(((typeof(mask))(val) << __bf_shf(mask)) & (mask))	\
 	)
@@ -180,7 +158,6 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _reg = reg;					\
-		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
 		__BF_FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
@@ -198,8 +175,9 @@
 		__auto_type _mask = mask;						\
 		__auto_type _reg_p = reg_p;						\
 		__auto_type _val = 1 ? (val) : _mask;					\
-		typecheck_pointer(_reg_p);						\
-		__BF_FIELD_CHECK(_mask, *_reg_p, _val, "FIELD_MODIFY: ");		\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_MODIFY: ");				\
+		__BF_FIELD_CHECK_VAL(_mask, _val, "FIELD_MODIFY: ");			\
+		__BF_FIELD_CHECK_REG(_mask, *_reg_p, "FIELD_MODIFY: ");			\
 		*_reg_p = (*_reg_p & ~_mask) | ((_val << __bf_shf(_mask)) & _mask);	\
 	})
 
@@ -209,7 +187,7 @@ extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
 static __always_inline u64 field_multiplier(u64 field)
 {
-	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
+	if (__BF_VALIDATE_MASK(field))
 		__bad_mask();
 	return field & -field;
 }
-- 
2.39.5


