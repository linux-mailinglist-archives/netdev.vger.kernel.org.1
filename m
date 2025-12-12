Return-Path: <netdev+bounces-244546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EEECB9AA6
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59DA305C855
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC230FC37;
	Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="DpNsL337"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADD30DD25;
	Fri, 12 Dec 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568301; cv=none; b=GpwbjJSE9shvWLXMFLXuTavjAGuWyWRc0RH65lGAjblyyTurHmvYLtEid6jppI2f4y42mwPtY5X0cVGzDedmVEN5juTS7kV1rS+yb1AiBprrXmgvXkg0XfM1jbS3FzUXqj3PUB0BmK0QDOP2Fovctl9n8ikb7bnKHBW+ZKBtlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568301; c=relaxed/simple;
	bh=6xLPwuKCmyiv7sNodFTlJg7EJpoafX0uNY4awsxdL/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZP156BzpN5IdBb675s83zEnkcPWDZFjTqbVFajwzvrIU+CBQ6jLDTXz7Macap7vPQRpcEhmePCd/8zq36/nfwOC+NfaHh7UyGXoHE8MWXZZWi/Wf4UWeZgR6NFKxHjq3g2ZUfYrDbRgBxZ+UnTWxssntV9AubHW/bpCYzbmEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=DpNsL337; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xz-0087hJ-DV; Fri, 12 Dec 2025 20:38:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=E7Grad49ePF15z6adZbwiVMT+Xs15fuNWU87DPOvLXg=; b=DpNsL337rQB0wyWs99J0dgkPR3
	7jlIvmFa55BFvmBMGaRY9DdyilTfooTtMMnUgK9NjdAoKyXUpmLKTXe3FOkSl+WIR1ATELCWotoXJ
	O9sOUBxv8zYmXpIPzyPAxNsqrO75HJrV6z7izv5DBffDnJBHwxrHkX5WM9TkpCADJl//Ylyhhozhl
	DphIR9dNxvu68eaV+UIfLQGLku7DdZiixpiqflCoueSWJbno4r9X+67cZpsJ7akSR+pziNW1+ChNC
	IUniIw0Hf6P5uwbtP4R0Tn2K5HWUYInYfaM74gARjC7ryjUvix+BgXoKB/DLGWqg6Pd9FQSe5pzXy
	8JRMdV3g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xz-0003Ai-24; Fri, 12 Dec 2025 20:38:15 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xb-0030pR-Kt; Fri, 12 Dec 2025 20:37:51 +0100
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
Subject: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
Date: Fri, 12 Dec 2025 19:37:08 +0000
Message-Id: <20251212193721.740055-4-david.laight.linux@gmail.com>
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

Instead of directly expanding __BF_FIELD_CHECK() (which really ought
not be used outside bitfield) and open-coding the generation of the
masked value, just call FIELD_PREP() and add an extra check for
the mask being at most 16 bits.
The extra check is added after calling FIELD_PREP() to get a sane
error message if 'mask' isn't constant.

Remove the leading _ from the formal parameter names.
Prefix the local variables with _wm16_ to hopefully make them
unique.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v2:
- Update kerneldoc to match changed formal parameter names.
- Change local variables to not collide with those in FIELD_PREP().

Most of the examples are constants and get optimised away.

 include/linux/hw_bitfield.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
index df202e167ce4..0bd1040a5f93 100644
--- a/include/linux/hw_bitfield.h
+++ b/include/linux/hw_bitfield.h
@@ -12,8 +12,8 @@
 
 /**
  * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
  * result with the mask shifted up by 16.
@@ -23,15 +23,14 @@
  * register, a bit in the lower half is only updated if the corresponding bit
  * in the upper half is high.
  */
-#define FIELD_PREP_WM16(_mask, _val)					     \
-	({								     \
-		typeof(_val) __val = _val;				     \
-		typeof(_mask) __mask = _mask;				     \
-		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
-				 "HWORD_UPDATE: ");			     \
-		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
-		((__mask) << 16);					     \
-	})
+#define FIELD_PREP_WM16(mask, val)				\
+({								\
+	__auto_type _wm16_mask = mask;				\
+	u32 _wm16_val = FIELD_PREP(_wm16_mask, val);		\
+	BUILD_BUG_ON_MSG(_wm16_mask > 0xffffu,			\
+			 "FIELD_PREP_WM16: mask too large");	\
+	_wm16_val | (_wm16_mask << 16);				\
+})
 
 /**
  * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
-- 
2.39.5


