Return-Path: <netdev+bounces-244542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA1CB9A8E
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B6030DAEDB
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4030DD1C;
	Fri, 12 Dec 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="QplppzQp"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141730BF70
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568299; cv=none; b=Eh1jZJekLotzqHWhjauHVn+hTaqKi2wY2K3Y2fY1erkkKGzp0cbkwmTqdNsMqONhjS3Lb0Pn5OzApchXs6CPf+Y6nr3sXpn9hHoYPt8T12YaZJjfmiTi0bpWF6bvTvuQaWQBIt523OIVS9eOzzB7dHzXCKv7NCbSg09Ne+g3y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568299; c=relaxed/simple;
	bh=mdnK2kiWxTdEx/+91SA8fwSY8LOjWRmnEoBNvu4GgTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUiHxNZFYSZxa0g3soR01TJ8D2LDRfyuKdbObCE5B3X9rMtxu8zT2dZyw3CoQi0xCfHMo4fbLMNSRjfECInJc7stukotv6CCFHAhNANV2TUFuVzwIPmAx9nTTHLzYRUVyfEJbekRlTZ/Upr3pjsh2DisVL9rSPWz4yg6GgYE2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=QplppzQp; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xy-0087gG-BE; Fri, 12 Dec 2025 20:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=EpuO6aktcY35Crl1/oH5q0fVnrQzqVc0Xwk2TPe0MdA=; b=QplppzQpA8/Dxc7Uq6VAJ/ILsl
	3yaEZTvZmj+KOmEU79gZ1jjhPdXH7ySjnjbkltgHhR/LVwislitHw3/29Wap7FSEU/FaoTwfdrtbD
	SUh484Q1LnHqXXAz3i/IYKf4ccA7j8yJEaNYkfmRWGBYcSe72xarh/TRjiOGUIG09rYqNmXUNnqrl
	7B2XIgWDVD/jZ53Zjwjw6TWhkkdUrcIjKmMv77t9IYoj4ojVDEXr//wySm2gvKkqsHq0y+b4br8CB
	f8cJB2Ljl5ctXZhCyp/UM0mhUGbRl5ElZ+YyKwXAReEg77cXtGMCIeNaU79f6VTLMOotWhWCFPtls
	Bojl+3/w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xx-0003AW-Oq; Fri, 12 Dec 2025 20:38:13 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xd-0030pR-Pb; Fri, 12 Dec 2025 20:37:53 +0100
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 05/16] bitfield: Merge __field_prep/get() into field_prep/get()
Date: Fri, 12 Dec 2025 19:37:10 +0000
Message-Id: <20251212193721.740055-6-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212193721.740055-1-david.laight.linux@gmail.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

field_prep() calls __FIELD_PREP() which really wants the parameters
copied to 'locals' - but this is done later in __field_prep().

Move the 'auto_type' lines to the outer function.
This only leaves the shift calculation and final expression inside
__field_prep(), move the shift calculation to a new define __BF_SHIFT()
and just inline the final expression into  field_prep().
Use a common #define for the shift expression.

Do the same for field_get().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 42 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3800744281c7..c30120535680 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -251,23 +251,9 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
-#define __field_prep(mask, val)						\
-	({								\
-		__auto_type __mask = (mask);				\
-		typeof(__mask) __val = (val);				\
-		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
-				       __ffs(__mask) : __ffs64(__mask);	\
-		(__val << __shift) & __mask;				\
-	})
-
-#define __field_get(mask, reg)						\
-	({								\
-		__auto_type __mask = (mask);				\
-		typeof(__mask) __reg =  (reg);				\
-		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
-				       __ffs(__mask) : __ffs64(__mask);	\
-		(__reg & __mask) >> __shift;				\
-	})
+/* As __bf_shf() but for non-zero variables */
+#define __BF_SHIFT(mask) \
+	(BITS_PER_TYPE(mask) <= 32 ? __ffs(mask) : __ffs64(mask))
 
 /**
  * field_prep() - prepare a bitfield element
@@ -285,9 +271,14 @@ __MAKE_OP(64)
  * If you want to ensure that @mask is a compile-time constant, please use
  * FIELD_PREP() directly instead.
  */
-#define field_prep(mask, val)						\
-	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
-				    : __field_prep(mask, val))
+#define field_prep(mask, val)					\
+({								\
+	__auto_type _mask = mask;				\
+	__auto_type _val = 1 ? (val) : _mask;			\
+	__builtin_constant_p(_mask) ?				\
+		__FIELD_PREP(_mask, _val, "field_prep: ") :	\
+		(_val << __BF_SHIFT(_mask)) & _mask;		\
+})
 
 /**
  * field_get() - extract a bitfield element
@@ -305,8 +296,13 @@ __MAKE_OP(64)
  * If you want to ensure that @mask is a compile-time constant, please use
  * FIELD_GET() directly instead.
  */
-#define field_get(mask, reg)						\
-	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
-				    : __field_get(mask, reg))
+#define field_get(mask, reg)					\
+({								\
+	__auto_type _mask = mask;				\
+	__auto_type _reg = reg;					\
+	__builtin_constant_p(_mask) ?				\
+		__FIELD_GET(_mask, _reg, "field_get: ") :	\
+		(_reg & _mask) >> __BF_SHIFT(_mask);		\
+})
 
 #endif
-- 
2.39.5


