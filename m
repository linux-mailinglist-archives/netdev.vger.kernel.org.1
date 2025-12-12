Return-Path: <netdev+bounces-244548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C8CB9B21
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB30631272CE
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98031AAA4;
	Fri, 12 Dec 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Wpdx0hNl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA630BF67;
	Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568303; cv=none; b=JZ4rFog8fkGikSrRJcp/qxS6b/tmtDLKFL00lWTClr+uPff9z0nvfUEStmIM5CUdzojAhjQ4zg7lXJAh/nYWfWhlmOo0n2pPCCCrnA7MXcx6vsdLSS02/DonQ5Bl5+ovWZynHF8VfdGttyewZHxl2bZMKoM89VuomGVn5ufty3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568303; c=relaxed/simple;
	bh=iX4bCRJMjNTc89J6Hb3IJZ8DlWuZIDZYYAn/N65O7DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pn2EHHOSZNLVxgOkeCeYF1vXTnthIREcba80O0YzHcP48Xa+KK7xcwWDOTje5QQOY3AIgHW350F90bDu68dydgDGkmA9I2/cOQiqSZMT+jC3p0E/fj3pZKu3T7edRMYwS9j9EFBLcq0aum12GnD0tv4RNc0CCLksd2to4AZFsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Wpdx0hNl; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xy-007TcM-Hl; Fri, 12 Dec 2025 20:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=XGNNIc7IKcGdjBNdCWUpuNKT8BFgCw2QYiU5srDt8fQ=; b=Wpdx0hNlbtmydznicg6yGTxTE9
	i+/7jgy7Yx8lPlzp4IottmUUrwCU1IO7VJPIaV+S9mAKgvv5A8OZ3sRJBJbMw5RvKwBcsmpFlxc+I
	gzPgX7iZw8yehHsqpHvCxT3blsWtG/ALesGkD3NxDxHZ7cGFURST/OO+qataDwXcEFCiS1JupodY9
	+MJJYHxeE0swVBQr14URnBmXccDVKX1SEBxCHqXTuUhlNvgRbkAF8ct2aAHTv/o27QYRLND27O5qf
	E0srSaYNv34Z1fdRPpFGr6JG0/YHKacRjGcdcEooNVFmtY8cK7xF4PZt3+zWC5XbwGzqjSppGv8FK
	GvGn8jWQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xy-0003Ac-6G; Fri, 12 Dec 2025 20:38:14 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xn-0030pR-5E; Fri, 12 Dec 2025 20:38:03 +0100
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
Subject: [PATCH v2 14/16] bitfield: Add comment block for the host/fixed endian functions
Date: Fri, 12 Dec 2025 19:37:19 +0000
Message-Id: <20251212193721.740055-15-david.laight.linux@gmail.com>
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

Copied almost verbatim from the commit message that added the functions.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 03206be4ab54..3bf82121a282 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -181,6 +181,49 @@ do {								\
 	*_reg_p = (*_reg_p & ~_mask) | ((_val << __bf_shf(_mask)) & _mask);	\
 })
 
+/*
+ * Primitives for manipulating bitfields both in host- and fixed-endian.
+ *
+ * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
+ *   bitfield specified by @field in little-endian 32bit object @val and
+ *   converts it to host-endian.
+ *
+ * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
+ *   the contents of the bitfield specified by @field in little-endian
+ *   32bit object pointed to by @p with the value of @v.  New value is
+ *   given in host-endian and stored as little-endian.
+ *
+ * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) is equivalent to
+ *   ({__le32 tmp = old; le32p_replace_bits(&tmp, v, field); tmp;})
+ *   In other words, instead of modifying an object in memory, it takes
+ *   the initial value and returns the modified one.
+ *
+ * * __le32 le32_encode_bits(u32 v, u32 field) is equivalent to
+ *   le32_replace_bits(0, v, field).  In other words, it returns a little-endian
+ *   32bit object with the bitfield specified by @field containing the
+ *   value of @v and all bits outside that bitfield being zero.
+ *
+ * Such set of helpers is defined for each of little-, big- and host-endian
+ * types; e.g. u64_get_bits(val, field) will return the contents of the bitfield
+ * specified by @field in host-endian 64bit object @val, etc.  Of course, for
+ * host-endian no conversion is involved.
+ *
+ * Fields to access are specified as GENMASK() values - an N-bit field
+ * starting at bit #M is encoded as GENMASK(M + N - 1, M).  Note that
+ * bit numbers refer to endianness of the object we are working with -
+ * e.g. GENMASK(11, 0) in __be16 refers to the second byte and the lower
+ * 4 bits of the first byte.  In __le16 it would refer to the first byte
+ * and the lower 4 bits of the second byte, etc.
+ *
+ * Field specification must be a constant; __builtin_constant_p() doesn't
+ * have to be true for it, but compiler must be able to evaluate it at
+ * build time.  If it cannot or if the value does not encode any bitfield,
+ * the build will fail.
+ *
+ * If the value being stored in a bitfield is a constant that does not fit
+ * into that bitfield, a warning will be generated at compile time.
+ */
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
-- 
2.39.5


