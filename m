Return-Path: <netdev+bounces-244545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2FCCB9A9A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DB53045F22
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FAE30F52D;
	Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hCMdKtXY"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B830BB9E;
	Fri, 12 Dec 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568301; cv=none; b=MwXdrXj0+DjAs5k7Wi3gy4c590KX7g8XjfcpqJZsiHi1Y607Dk7+ptZtmB2yCWazNLhvCGes/Tii1qS7UxSLzskR3Yw5GQ+nU+OJZ+/Q+YQ1cLao2H/COOx52+2paYRl07swGjVQYKA+1zydMauhRq0mML8+8ASv3403KbKuVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568301; c=relaxed/simple;
	bh=sTX7hhMNXYX8IeOtAcpdooALbpE0W1i7Hg2nYaiqdfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNlrDFrU8ze4mnnoctWsLM5hOV+kOZlHo6ykAFokhVLeFE/b5OnntG6Ywygq0DtVg7hRHmqJK9UtGysJw7BdNB/HtD6Sv2+bawPrGZVFPgrag31Ro4wiIsHkB1oilKROQzk8T7fJNaUccqal4y8a5VpP1K1qFbKWSpizKdq7gpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hCMdKtXY; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xx-007Tbu-LG; Fri, 12 Dec 2025 20:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=FIpjYJfctt+TZ2YlO2ye1wdnb5GL7Nb/xCC/LOcVI7s=; b=hCMdKtXYW1Q79tiHOUteeVtWBN
	AS/aVRLklJFhSlCBTAmV8gMKXbz/14zqPqeMlTMqkDPFT9ZDnmX8elzlhxfxva/GDZgMiGx1gZMHT
	ghUVUuaS0w2Tx9S/UW1NLcP0Kjm5jJIfCJxorvs3tqA8sBL1jcRrvTYRR4UA9LtbDl4G96IoZ6XR4
	kOJ8ViPg5hTrV3PTbfMhYt7o10WPJ15LOXmd1s3ma4opnFVkCW0bJMJGuxPgEX8Ff0EEET1mB5hfg
	3dhau67k1okv0H/KsDuM8X/tI7mwR5WPIwj1ADW4xU4wKudDTN/TDEZx5VxDCB6H8kIW6NPiLXfu1
	wfqeiKBg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xx-0003AQ-Aq; Fri, 12 Dec 2025 20:38:13 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xc-0030pR-Nf; Fri, 12 Dec 2025 20:37:52 +0100
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
Subject: [PATCH v2 04/16] bitfield: Copy #define parameters to locals
Date: Fri, 12 Dec 2025 19:37:09 +0000
Message-Id: <20251212193721.740055-5-david.laight.linux@gmail.com>
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

Use __auto_type to take copies of parameters to both ensure they are
evaluated only once and to avoid bloating the pre-processor output.
In particular 'mask' is likely to be GENMASK() and the expension
of FIELD_GET() is then about 18KB.

The 'val' parameter is sometimes a bitfield (so _auto_type cannot be
used), the type of _val also needs to be large enough to hold the
shifted value, using '__auto_type _val = 1 ? (val) : _mask;' solves
both problems.

Update kerneldoc to match the renamed (no leading _) formal parameters.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 52 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 126dc5b380af..3800744281c7 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -99,40 +99,45 @@
 
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
- * @_mask: shifted mask defining the field's length and position
+ * @mask: shifted mask defining the field's length and position
  *
  * FIELD_MAX() returns the maximum value that can be held in the field
- * specified by @_mask.
+ * specified by @mask.
  */
-#define FIELD_MAX(_mask)						\
+#define FIELD_MAX(mask)							\
 	({								\
+		__auto_type _mask = mask;				\
 		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
 		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
 	})
 
 /**
  * FIELD_FIT() - check if value fits in the field
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to test against the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to test against the field
  *
- * Return: true if @_val can fit inside @_mask, false if @_val is too big.
+ * Return: true if @val can fit inside @mask, false if @val is too big.
  */
-#define FIELD_FIT(_mask, _val)						\
+#define FIELD_FIT(mask, val)						\
 	({								\
+		__auto_type _mask = mask;				\
+		__auto_type _val = 1 ? (val) : _mask;			\
 		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
 		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
 	})
 
 /**
  * FIELD_PREP() - prepare a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
  */
-#define FIELD_PREP(_mask, _val)						\
+#define FIELD_PREP(mask, val)						\
 	({								\
+		__auto_type _mask = mask;				\
+		__auto_type _val = 1 ? (val) : _mask;			\
 		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
 		__FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
@@ -165,29 +170,34 @@
 
 /**
  * FIELD_GET() - extract a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_reg:  value of entire bitfield
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
  *
- * FIELD_GET() extracts the field specified by @_mask from the
- * bitfield passed in as @_reg by masking and shifting it down.
+ * FIELD_GET() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
  */
-#define FIELD_GET(_mask, _reg)						\
+#define FIELD_GET(mask, reg)						\
 	({								\
+		__auto_type _mask = mask;				\
+		__auto_type _reg = reg;					\
 		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
 		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
 /**
  * FIELD_MODIFY() - modify a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_reg_p: pointer to the memory that should be updated
- * @_val: value to store in the bitfield
+ * @mask: shifted mask defining the field's length and position
+ * @reg_p: pointer to the memory that should be updated
+ * @val: value to store in the bitfield
  *
- * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
- * by replacing them with the bitfield value passed in as @_val.
+ * FIELD_MODIFY() modifies the set of bits in @reg_p specified by @mask,
+ * by replacing them with the bitfield value passed in as @val.
  */
-#define FIELD_MODIFY(_mask, _reg_p, _val)						\
+#define FIELD_MODIFY(mask, reg_p, val)							\
 	({										\
+		__auto_type _mask = mask;						\
+		__auto_type _reg_p = reg_p;						\
+		__auto_type _val = 1 ? (val) : _mask;					\
 		typecheck_pointer(_reg_p);						\
 		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
 		*(_reg_p) &= ~(_mask);							\
-- 
2.39.5


