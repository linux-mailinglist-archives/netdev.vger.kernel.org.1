Return-Path: <netdev+bounces-244094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A37CAF8D0
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C0330CBE4F
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C02324B3C;
	Tue,  9 Dec 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=runbox.com header.i=@runbox.com header.b="sl+fWZA1"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B603242D7;
	Tue,  9 Dec 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274633; cv=none; b=NllL/TycQBFiLdqJ0JxtGkWXNBSK39fgbdaxRyea+baV2JvlIvPhk0R7SjnuoOskArj2ycZ6ihEaSENLDBj3963x1Dp56gtsSGzU8zt5xKxXgZhEvJFL6cvJlGlT+tUxk5rCDQFT9rz4TXsAMEpRE5J/w/6Jft0A0DkNS/gFj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274633; c=relaxed/simple;
	bh=E4cqdyWnTy6bAeX8CvB1yK9sMkTu2li1KwGCMYFsl7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5xVBc8u973wiJT2afY9fRFI7JRtwPg32Yn2MpRmNq71s6lUIkiq3gtQunvMQXUwExVaummZ51kd+CmkX9UUwYgONoLAN7wEJg7+bMZf+gPohvvody7knvN3n/8/F/hsMsHJKSgrje7PSy+WrfQetLVj46E07HPboXhgYllXLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=fail (0-bit key) header.d=runbox.com header.i=@runbox.com header.b=sl+fWZA1 reason="key not found in DNS"; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZQ-00Gz5h-TL; Tue, 09 Dec 2025 11:03:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=bsZokk41/Z+0gE+q67wcjT3/DTqcuPp1ab0Znae2e7U=; b=sl+fWZA1KrHVQlduXXfJhykvKr
	2WT2lPOU5hY2jlC0JNcG2BE3iNunIRBT0f3+1bIYNlrQJvuzjrxaxTHN15TPPpzNV+qDs5dmaMbK+
	MHt/Gt7XoasFhPX1JZrdUrjkI619HjFJTraQsVEYOY12Dz/m4dsyBOuSfC19rapOWADhGGWP895XD
	b8tf/mX9lvoeFelTnhdGSmHecg3XLel1Aeh7hDUCnT7+NJzu3+l+cS0esOZDzUCXG2eA//9lTCaqo
	A8MDyhhAoXUfTPxlGx26wW0G1YQ5Aw6Ly3FsjH7R499v52fR4oWfOw/imEMzOSYJn6yd76ufDaT3o
	e8TDWTYA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZQ-0000Ib-Hl; Tue, 09 Dec 2025 11:03:48 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZA-00CND9-G9; Tue, 09 Dec 2025 11:03:32 +0100
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
Subject: [PATCH 9/9] bitfield: Update comments for le/be functions
Date: Tue,  9 Dec 2025 10:03:13 +0000
Message-Id: <20251209100313.2867-10-david.laight.linux@gmail.com>
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

Make it clear the the values are converted to host order before
being acted on.
Order the explantions with the simple functions first.

These still need converting to kerneldoc format.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 9feb489a8da3..dcc4809b4706 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -184,24 +184,24 @@ do {								\
 /*
  * Primitives for manipulating bitfields both in host- and fixed-endian.
  *
- * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
- *   bitfield specified by @field in little-endian 32bit object @val and
- *   converts it to host-endian.
  *
- * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
- *   the contents of the bitfield specified by @field in little-endian
- *   32bit object pointed to by @p with the value of @v.  New value is
- *   given in host-endian and stored as little-endian.
+ * * u32 le32_get_bits(__le32 val, u32 field) converts the little-endian 32bit
+ *   object @val to host-endian then extracts the contents of the bitfield
+ *   specified by @field.
+ *
+ * * __le32 le32_encode_bits(u32 v, u32 field) encodes the value of @v into
+ *   the bitfield specified by @field then converts the value to little-endian.
+ *   All the bits outside that bitfield being zero.
  *
- * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) is equivalent to
- *   ({__le32 tmp = old; le32p_replace_bits(&tmp, v, field); tmp;})
- *   In other words, instead of modifying an object in memory, it takes
- *   the initial value and returns the modified one.
+ * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) converts the
+ *   little-endian 32bit object @old to host order, replaces the contents
+ *   of the bitfield specified by @field with @v, then returns the value
+ *   converted back to little-endian.
  *
- * * __le32 le32_encode_bits(u32 v, u32 field) is equivalent to
- *   le32_replace_bits(0, v, field).  In other words, it returns a little-endian
- *   32bit object with the bitfield specified by @field containing the
- *   value of @v and all bits outside that bitfield being zero.
+ * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
+ *   the contents of the bitfield specified by @field in little-endian
+ *   32bit object pointed to by @p with the value of @v.
+ *   Equivalent to *p = le32_replace_bits(*p, v, field).
  *
  * Such set of helpers is defined for each of little-, big- and host-endian
  * types; e.g. u64_get_bits(val, field) will return the contents of the bitfield
@@ -210,15 +210,13 @@ do {								\
  *
  * Fields to access are specified as GENMASK() values - an N-bit field
  * starting at bit #M is encoded as GENMASK(M + N - 1, M).  Note that
- * bit numbers refer to endianness of the object we are working with -
+ * bit numbers refer to the value after being converted to host order -
  * e.g. GENMASK(11, 0) in __be16 refers to the second byte and the lower
  * 4 bits of the first byte.  In __le16 it would refer to the first byte
  * and the lower 4 bits of the second byte, etc.
  *
- * Field specification must be a constant; __builtin_constant_p() doesn't
- * have to be true for it, but compiler must be able to evaluate it at
- * build time.  If it cannot or if the value does not encode any bitfield,
- * the build will fail.
+ * Field specification must be a non-zero constant, otherwise the build
+ * will fail.
  *
  * If the value being stored in a bitfield is a constant that does not fit
  * into that bitfield, a warning will be generated at compile time.
-- 
2.39.5


