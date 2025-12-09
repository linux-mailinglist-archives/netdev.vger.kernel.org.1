Return-Path: <netdev+bounces-244095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A556CAF8A0
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5B4530101D5
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05824325711;
	Tue,  9 Dec 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="vP5z3pHL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0A324B19;
	Tue,  9 Dec 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274635; cv=none; b=okVszCBiH+yStg4q/mywGITVz8+4l+L9IE6xo0Yz+ANKH3JPw27PAFyNhxtGv/qiwpnMOAUGrvO1qJoR+F9PYRgYrcAcySLJ1I+qyC6qHzH4LYP+5a4MrdiKmQDqlhXV5vOLXBjDYX3C+FX9DUxkYI563dpnqYI0vtMFvSnI9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274635; c=relaxed/simple;
	bh=fXGZ2M7xxYHgmTpQmtTDzEYbKvZXrYIjTdOkA45M/Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8915odni4zA8RK2p2Phym+/2NjsiessmhLj06i67eoRIt5XTCvaTlUoRPATnmkPPiyc3DN/mivZ+/4Zxbu4mHb2cXvaWxf4upPfYxamPLOqnC18DokOnxnVsJpAJr89n8GMW/S7r8kdGDGnS141HHoWl/TZ9T2l4N8oRzr1eEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=vP5z3pHL; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZP-00HDAJ-Bp; Tue, 09 Dec 2025 11:03:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=pDzfAzksr2ZkqPsHEML95dRnTX61DmWnWyNEXtTl4FY=; b=vP5z3pHLMaiwh958rxwLVuNQE1
	Y9JGtD4u9c0ZZ8jAWOjpGBDpHzeRyANB3cPxsDjTSmHxQq2h3rocfjqASw9EHxdNXGuxd9JDAIiVV
	PpV1Y/K3or9uf7KS0Eo1B6Eig+tw0IeEKpCT7DRGqy70gIggLa9BkfdkxnS7gPgWltZNxcr/tORSE
	2uj0k8brqG0KNhWspzqC5tD2Cg6PRnWg8s4HnMA0XzoJT6UiM34zoe9LH4VWzLSLsoFUt644+Pt5Q
	XTLtzpCQybAauBzRIjQ13UI5SXHdittYtIKn+VCFHGR2gxVMiEJdFVRwEB3keoNiRUjAGifEBCnFh
	nW4K1ZmA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZO-00075d-UF; Tue, 09 Dec 2025 11:03:47 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ9-00CND9-Ca; Tue, 09 Dec 2025 11:03:31 +0100
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
Subject: [PATCH 8/9] bitfield: Add comment block for the host/fixed endian functions
Date: Tue,  9 Dec 2025 10:03:12 +0000
Message-Id: <20251209100313.2867-9-david.laight.linux@gmail.com>
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

Copied almost verbatim from the commit message that added the functions.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index bfd80ebd25b1..9feb489a8da3 100644
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


