Return-Path: <netdev+bounces-251322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7AD3BAFD
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CFA830390D5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE52550D5;
	Mon, 19 Jan 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh+EueMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA441DFD96
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862504; cv=none; b=Yu96/lwc9gyuvUp8GcoypkP8c1UbKqPiXlnHCxCEwIpOk99piTQOU8Xkj96J4HGafkydoJdNSWEE/pBwM8dRw5s6S4cAGD4ijTJTs+/EFlSSHnMvPreU4vOct5R80CpwvnQse8Hh1jlVaTsERPSYl54AZzvmG3w9x1iiwikPEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862504; c=relaxed/simple;
	bh=Xp0nTaYImIHU7q01+FUxAEI56j/ksRq5ORpNv8+ku0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7hqdx3NQhlDatZTUUzzVmk7N0xnWSpcMvP65vXzKdpidT6lFFgs17oa9VL9XM2YfFdjGtK0ffjAAK5Z+Dk5hUTF0woT8EbBCE7tIEy68Adm7Wkg6p/T4w8JlOKzbOJRkSlJYs5X369SLH5mgJxhtzizB4EnIqp2UORPrfXYx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh+EueMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21F4C116C6;
	Mon, 19 Jan 2026 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768862504;
	bh=Xp0nTaYImIHU7q01+FUxAEI56j/ksRq5ORpNv8+ku0w=;
	h=From:To:Cc:Subject:Date:From;
	b=Nh+EueMk7vUBD5ooZyDsaLITyUTZr31jwpyj42D6NrL0qnvJUle+aw+cn29FecfXb
	 1/RPYVnaDs6zDSl2h8xORL2HWUWqYVR164VfhmalnNyP7emuEKc6mUDwx4nFUffnM0
	 FT7x1hbpRMtC8lB50PYhEZ/q3x7s6/tBeLO9u1+/SKJK/VffHfHKXuDxRCDysY9VQq
	 1qnjTjx6YlnpyRsEJe9TeTRq/BxOCmDu8IUJ1C4hFowDgn5YgYX5Ydi+QZEu2o3i7R
	 qr8q6rwWXnSdaw+mYkv0TDPGVIAWTHAsH4Af9ahYxDTim2WceJgaWLpgnrtbpsx4vL
	 qIcXGv45JAhmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	kernelxing@tencent.com
Subject: [PATCH net-next] net: add kdoc for napi_consume_skb()
Date: Mon, 19 Jan 2026 14:41:40 -0800
Message-ID: <20260119224140.1362729-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like AI reviewers miss that napi_consume_skb() must have
a real budget passed to it. Let's see if adding a real kdoc will
help them figure this out.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kernelxing@tencent.com
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c29677f7857c..3fa01cc90613 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1499,9 +1499,20 @@ void napi_skb_free_stolen_head(struct sk_buff *skb)
 	napi_skb_cache_put(skb);
 }
 
+/**
+ * napi_consume_skb() - consume skb in NAPI context, try to feed skb cache
+ * @skb: buffer to free
+ * @budget: NAPI budget
+ *
+ * Non-zero @budget must come from the @budget argument passed by the core
+ * to a NAPI poll function. Note that core may pass budget of 0 to NAPI poll
+ * for example when polling for netpoll / netconsole.
+ *
+ * Passing @budget of 0 is safe from any context, it turns this function
+ * into dev_consume_skb_any().
+ */
 void napi_consume_skb(struct sk_buff *skb, int budget)
 {
-	/* Zero budget indicate non-NAPI context called us, like netpoll */
 	if (unlikely(!budget || !skb)) {
 		dev_consume_skb_any(skb);
 		return;
-- 
2.52.0


