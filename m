Return-Path: <netdev+bounces-244554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1850CB9BC0
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DA0D30065AD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18530CD92;
	Fri, 12 Dec 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="BFFCouyy"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3130C60B
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570334; cv=none; b=ObX+iVXipqFV6dlMVJ1jQruQaBOA2rrp+QTr+2mrkDXM8Smel3T1LidzpimQlSp3AAsqsnLDk57cn35lZ+nXYmQo77OEmqKfl6D+tQG4zD5qdLlJNXvOjBkQKgyVZZUapwzOaSJ6vPSofSrg1S/Fjv4l+WKdn304hzl1rC6UmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570334; c=relaxed/simple;
	bh=CSJsxa9xyu7aDhk6yxlncz4abHbJ8KPOGVhQs3YLKhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IopZaFGcg9ZBO2u4PYSGIoaB220gycCC6KLrEfcBD+Y57jbfYf8/2fdKShQhONG2PC9/+5PNjUIm6NvXOuEYstbtjw8KvwHw7WdN6S7PAtztv4+i7IJPgpAZb04zU/0zBz4nGXRGiqbosXXqDg1sOhJ2Ui+Wz/FQah/KzDFcock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=BFFCouyy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xu-0087bU-Hc; Fri, 12 Dec 2025 20:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=6aqv+V5GEVFjOVOl0hKZO1gtT1BRvvjcLF837XqfAaE=; b=BFFCouyyaTIes4oFGBd+WEFrmd
	B9AuCUlRMZtZuBdy0f0RHN5KOA2O43c7D8uV74I8jpNC2PJ5Dd0GKr7Oe0ipnYK1NHajfEu7ALt+I
	WvgIZ9v/cnhuptTmRIykKv9ODiSw8G1eNzXO5IAHxSyCiYWLuIMhqa/O27JMIbYEd3Mu/LcSbnFU7
	Lk79jjsaexlTPu2vmYiRzjx2SZSBnGF0U/lixe4pvAU2zboG8h4NqjrOZB3S6WnQheZdlRpTj/OVT
	CsHjZI4VvclE/6BS+6JrEHS/AxZZCi/jRfDui6RgmaZ5siMbQHdZikUKDCyJ4UL95gew5Gzg9c7nb
	G5mi7idw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xu-00039x-5D; Fri, 12 Dec 2025 20:38:10 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xl-0030pR-3T; Fri, 12 Dec 2025 20:38:01 +0100
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
Subject: [PATCH v2 12/16] bitfield: Remove leading _ from #define formal parameter names
Date: Fri, 12 Dec 2025 19:37:17 +0000
Message-Id: <20251212193721.740055-13-david.laight.linux@gmail.com>
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

There is no need to 'protect' formal parameter names from anything
outside the #define body itself.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6f454ef43d24..753032285754 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -48,12 +48,12 @@
 #define __BF_VALIDATE_MASK(mask) \
 	(!(mask) || ((mask) & ((mask) + ((mask) & -(mask)))))
 
-#define __BF_FIELD_CHECK_MASK(_mask, _pfx)				\
+#define __BF_FIELD_CHECK_MASK(mask, pfx)				\
 	do {								\
-		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
-				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG(__BF_VALIDATE_MASK(_mask),		\
-				 _pfx "mask is zero or not contiguous");	\
+		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
+				 pfx "mask is not constant");		\
+		BUILD_BUG_ON_MSG(__BF_VALIDATE_MASK(mask),		\
+				 pfx "mask is zero or not contiguous");	\
 	} while (0)
 
 #define __BF_FIELD_CHECK_VAL(mask, val, pfx)			\
@@ -126,8 +126,8 @@
 
 /**
  * FIELD_PREP_CONST() - prepare a constant bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP_CONST() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
@@ -136,14 +136,14 @@
  * be used in initializers. Error checking is less comfortable for this
  * version, and non-constant masks cannot be used.
  */
-#define FIELD_PREP_CONST(_mask, _val)					\
+#define FIELD_PREP_CONST(mask, val)					\
 	(								\
 		/* mask must be non-zero and contiguous */		\
-		BUILD_BUG_ON_ZERO(__BF_VALIDATE_MASK(_mask)) +		\
+		BUILD_BUG_ON_ZERO(__BF_VALIDATE_MASK(mask)) +		\
 		/* check if value fits */				\
-		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		BUILD_BUG_ON_ZERO(~((mask) >> __bf_shf(mask)) & (val)) + \
 		/* and create the value */				\
-		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+		(((typeof(mask))(val) << __bf_shf(mask)) & (mask))	\
 	)
 
 /**
-- 
2.39.5


