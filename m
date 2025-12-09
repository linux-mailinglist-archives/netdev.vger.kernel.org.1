Return-Path: <netdev+bounces-244088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE2CAF97E
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2516E310E3C2
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8B320CAF;
	Tue,  9 Dec 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="S3lbH9Q/"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C62FC86B
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274618; cv=none; b=oIy/zcWQnDSlQ42xrsNb9LSPZPLa/60gwlc1DIM2h3y4ZVheNeBomVAEUIbnmpEoFti7zUju+S5tkDw6/66jkO6Ka5w8NAOuIKcMl8b/RZ/11iTX3eiJMNA2KZVUTjTrWY+FfVUe5aiSeR9VU7rtXgiZVpRtxCeY2qpyR+gU4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274618; c=relaxed/simple;
	bh=r0JyqLB5s8BUcwpuoP7IpOoZ4xhcyEvbalDSYeF1rWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYSFF+O47yAvWS1Gy9hAWGbIY+HaX87+AcfMGCKjYGrWfRRFM9T8uiR5lhzF7lpDzve1gpR7gkqGMRjN0EnTtwZExteJEW0EebLT20G2bkMsR1dM5Nvb4AWXMzeY3rY4CwWaQpH0NT9ty/nO233qYCnQlJGdqb8MAVDTQa6Wd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=S3lbH9Q/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-00Gyzi-VO; Tue, 09 Dec 2025 11:03:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=KikFFrDxLsLsfdxtpsUWRZaSixAcB7BcUoyENyDfy4k=; b=S3lbH9Q/Yl+VFXGmEwPyKtPYEz
	77WjtnVzjVmxMyudQgjI4elVjnc5hHMLe5PAB0Z2/jDfXid7Db6ytvRIQew2bJymKwQZScV8OdgtT
	AF3Rqm2dMKEhDVxFnqq4+eKWMn+6WBNa3raHvqITS0kdq6SGqgOMTvfvB4Glfsbi7dnzBVjOZpMIS
	afZ4CaJngiCWsxSX5gkKmgcuP/JN3SX+92z2ifHFj7+UxPOn8CIviP6UJ7zkMXSJ55FtAizxJ3ChO
	EHFgkS5dg6LHc+TbFGn4K6QtAX9P+zt7Vs+ka7eZEg+7qR68sf/V34gYafO6cnGVOkBBMXzACccmC
	wAXN02ZQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-0000E4-5L; Tue, 09 Dec 2025 11:03:29 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ5-00CND9-TL; Tue, 09 Dec 2025 11:03:28 +0100
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
Subject: [PATCH 5/9] bitfield: FIELD_MODIFY: Only do a single read/write on the target
Date: Tue,  9 Dec 2025 10:03:09 +0000
Message-Id: <20251209100313.2867-6-david.laight.linux@gmail.com>
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

Replace the:
        *reg &= ~mask; *reg |= new_value;
with a single assignment.
While the compiler will usually optimise the extra access away
it isn't guaranteed.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3e013da9ea12..3e0e8533bb66 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -200,8 +200,7 @@
 		__auto_type _val = 1 ? (val) : _mask;					\
 		typecheck_pointer(_reg_p);						\
 		__BF_FIELD_CHECK(_mask, *_reg_p, _val, "FIELD_MODIFY: ");		\
-		*_reg_p &= ~_mask;							\
-		*_reg_p |= ((_val << __bf_shf(_mask)) & _mask);				\
+		*_reg_p = (*_reg_p & ~_mask) | ((_val << __bf_shf(_mask)) & _mask);	\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.39.5


