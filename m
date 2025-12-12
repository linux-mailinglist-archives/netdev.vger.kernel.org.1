Return-Path: <netdev+bounces-244541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CADCB9A76
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94DA43029F76
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429130CDB7;
	Fri, 12 Dec 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ecTP+qUr"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130130BF6B
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568298; cv=none; b=JmTkmwpKGtSFOxxYrAdeP3o9VP2dzdDJj3HbG2Et8MnDCrRb6K8YXIRo/iCEMawyQ2OztOFMs3Oi/C60dGwPNwAq36FcnYEiFMjTRAZnNCPayy1Vs2zXhfIGrrOWwyEof0ZeZ9hDj2LB1o9X/xDEEOujHMwKwD4CkQAs6+h6l5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568298; c=relaxed/simple;
	bh=28J+8dq1JwHHdPRLjgx9Ss18YMj9ZMQlOdRW9yK1NrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyTPscKQ+9FQ1KUc93ip8nnNtzAna0i8iNnHglKzy94O/iy1IRC+1Dfgpj4r0472KNYCL5gleX6qF5yeWI5SOUQqUf2oQgay62FwpehACnx6dkzIQTpuK5YdgGPpqEubZBON9b29+D7zKRtxvp5GiAzS+fn5BxyqmGvQpHY4YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ecTP+qUr; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xs-0087al-JL; Fri, 12 Dec 2025 20:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=6U3T9tjd/hVxKlBQ0Q6ToH9Df4rvaTpY6G/EvE5x9HY=; b=ecTP+qUrIFB7nUlZrQifCzIq+n
	UKiolkrWT5d3gGeSpYi/PeVGFMp0uTGd3Bmmt5ic+m6Pyutg3SOfNJJFWZkwD2T/oTasjzwVEpf/B
	v7Onb8w/CEmif23SAVNc/T5so81RbyAM58ORTSFcIJIK7QQACPH2BVzT3mplgqxMng3gDpcgHEzyQ
	5O2njuu5uNBsjmZGteluX0uhTMdgXKqA8C64uC57gsm1ux771BkGZ/uC0QeyM/Gk932w+fA1zbyyc
	cHab4Xb959FgaleyYwDNUo1vuCfACcBsHXLiedmguLJiAG8/6XUl6g7ps59u+Sk+oo3cHjha+Huib
	bUPbL6xQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xs-00039g-8N; Fri, 12 Dec 2025 20:38:08 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xj-0030pR-0B; Fri, 12 Dec 2025 20:37:59 +0100
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
Subject: [PATCH v2 10/16] bitfield: Split the 'val' check out of __BF_FIELD_CHECK_MASK()
Date: Fri, 12 Dec 2025 19:37:15 +0000
Message-Id: <20251212193721.740055-11-david.laight.linux@gmail.com>
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

Three of the five calls to __BF_FIELD_CHECK_MASK() don't have a 'value'
to check, separate out as was done to __BF_FIELD_CHECK_REG().

Since __BF_FIELD_CHECK_MASK() doesn't return a value, use
do { ... } while (0) rather than ({ ... }).

There is no point checking a 'val' of zero or a 'reg' of 0ULL (both
are placeholders) - remove/change the calls.

There should be a check of __BF_FIELD_CHECK_REG() when __BF_FIELD_GET()
is called from field_get().
Move the check from FIELD_GET() into __BF_FIELD_GET().

Delete the now-unused __BF_FIELD_CHECK().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ed5735c13a64..138f4c14786d 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -45,39 +45,36 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
-#define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
-	({								\
+#define __BF_FIELD_CHECK_MASK(_mask, _pfx)				\
+	do {								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
 		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
-		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) &	\
-					(0 + (_val)) : 0,		\
-				 _pfx "value too large for the field"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
-	})
+	} while (0)
+
+#define __BF_FIELD_CHECK_VAL(mask, val, pfx)			\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(val) &&		\
+			 ~((mask) >> __bf_shf(mask)) & (val),	\
+			 pfx "value too large for the field")
 
 #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
 	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
 			 ~0ULL >> (64 - 8 * sizeof (reg)),		\
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
 
@@ -91,7 +88,7 @@
 #define FIELD_MAX(mask)							\
 	({								\
 		__auto_type _mask = mask;				\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_MAX: ");		\
 		(_mask >> __bf_shf(_mask));				\
 	})
 
@@ -106,7 +103,7 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_FIT: ");		\
 		!((_val << __bf_shf(_mask)) & ~_mask);			\
 	})
 
@@ -122,7 +119,6 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
-		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
 		__BF_FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
 
@@ -164,7 +160,6 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__auto_type _reg = reg;					\
-		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
 		__BF_FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
@@ -182,8 +177,9 @@
 		__auto_type _mask = mask;						\
 		__auto_type _reg_p = reg_p;						\
 		__auto_type _val = 1 ? (val) : _mask;					\
-		typecheck_pointer(_reg_p);						\
-		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
+		__BF_FIELD_CHECK_MASK(_mask, "FIELD_MODIFY: ");				\
+		__BF_FIELD_CHECK_VAL(_mask, _val, "FIELD_MODIFY: ");			\
+		__BF_FIELD_CHECK_REG(_mask, *_reg_p, "FIELD_MODIFY: ");			\
 		*_reg_p = (*_reg_p & ~_mask) | ((_val << __bf_shf(_mask)) & _mask);	\
 	})
 
-- 
2.39.5


