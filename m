Return-Path: <netdev+bounces-244538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C5CB9A73
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8D130B3A22
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DB30BF6A;
	Fri, 12 Dec 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ZoPdvWPv"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E642459FD;
	Fri, 12 Dec 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568296; cv=none; b=EuenBDvG3nxQnbI22l6dUnEGAhXhesE9l95T6brCT/5ZcWe4uWC+KH4V2d1Gk1SX7zZuIx0bxDi+pprdfaidnsX7Vifd+X+a6GF7Ns/oV8ZVQAYLXvjRBug28XoZ+5ykm+74DBMj6cApcGU0YNLui07YsRj1Ss20/EnE/ig9PvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568296; c=relaxed/simple;
	bh=oKG5kkA4svUiPNmHEZ04vDi9a5SjU596V5IWn8CvoxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChNwWz9dgYDmo2I5zCe3un2sdhoQpvwZIuMN5jho0NmNl08fFHqqFnQSdNNB2Rd+P19AA+0gSEwSNJ7fGT7zLL1uhHms4zYe3K+byXQu4zLt06fxx0iClAz7AobmYGd/8Dd5UoyptphkJADsUE+BuL2Dvf4hER3yFFcZGtzj3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ZoPdvWPv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xt-007TaV-5S; Fri, 12 Dec 2025 20:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=bBARxlsMunaL3yEx7etxlOGIwGGWqNaium90kicufJs=; b=ZoPdvWPv489Cyxqx0Ipj61gmb5
	Xdqiq5q/Gjn3jYudEJUzUnzm0kjBG66DpVUIcP/SGgEzb3JwhuD0SloYDm3h4/09FIA2cev24xlSL
	5tgwTR8TeJkbKU8vKHYMvQYz0Im62AXVCyb44JA03nToi9v6JdTL4rmUiRqVkO5jihn9dL3qGL8gk
	H0u3NK0N4+6ju/XYakmWkiCy5+LUT1qBxoj/PUxm3KsASES/8Htuk2pzYvD/luLosJth9eQwEGgJ8
	gkynwuoM+ZOeG48voTOulmbESKACYndFa2TPlK5oWvCYYFa9FITg7iJ4xOVDvHjKLTy3DxntuLOtE
	zHDPk8mg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xs-0006uY-Mv; Fri, 12 Dec 2025 20:38:08 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xh-0030pR-Uh; Fri, 12 Dec 2025 20:37:58 +0100
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
Subject: [PATCH v2 09/16] bitfield: Rename __FIELD_PREP/GET() to __BF_FIELD_PREP/GET()
Date: Fri, 12 Dec 2025 19:37:14 +0000
Message-Id: <20251212193721.740055-10-david.laight.linux@gmail.com>
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

This makes the names consistent with the other internal defines
that shouldn't be used outside tis file.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 7160b762c979..ed5735c13a64 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -69,13 +69,13 @@
 		__BF_FIELD_CHECK_REG(mask, reg, pfx);			\
 	})
 
-#define __FIELD_PREP(mask, val, pfx)					\
+#define __BF_FIELD_PREP(mask, val, pfx)					\
 	({								\
 		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
 		((val) << __bf_shf(mask)) & (mask);			\
 	})
 
-#define __FIELD_GET(mask, reg, pfx)					\
+#define __BF_FIELD_GET(mask, reg, pfx)					\
 	({								\
 		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
 		((reg) & (mask)) >> __bf_shf(mask);			\
@@ -123,7 +123,7 @@
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
 		__BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");	\
-		__FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
+		__BF_FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
 
 #define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
@@ -165,7 +165,7 @@
 		__auto_type _mask = mask;				\
 		__auto_type _reg = reg;					\
 		__BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");	\
-		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
+		__BF_FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
 	})
 
 /**
@@ -259,7 +259,7 @@ __MAKE_OP(64)
 	__auto_type _mask = mask;				\
 	__auto_type _val = 1 ? (val) : _mask;			\
 	__builtin_constant_p(_mask) ?				\
-		__FIELD_PREP(_mask, _val, "field_prep: ") :	\
+		__BF_FIELD_PREP(_mask, _val, "field_prep: ") :	\
 		(_val << __BF_SHIFT(_mask)) & _mask;		\
 })
 
@@ -284,7 +284,7 @@ __MAKE_OP(64)
 	__auto_type _mask = mask;				\
 	__auto_type _reg = reg;					\
 	__builtin_constant_p(_mask) ?				\
-		__FIELD_GET(_mask, _reg, "field_get: ") :	\
+		__BF_FIELD_GET(_mask, _reg, "field_get: ") :	\
 		(_reg & _mask) >> __BF_SHIFT(_mask);		\
 })
 
-- 
2.39.5


