Return-Path: <netdev+bounces-189623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEEAB2D57
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D147F7A4C47
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8791A9B23;
	Mon, 12 May 2025 02:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D102D528
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747015499; cv=none; b=tTvWXFiLZlLzZsFL8p/yq7m9e27P/kE8z8tqKJm/PHmRMi9DalOaJF6hMkR7QCescH5B3zvWDLwJT970X3OM4nfkJ931/4SeB0RbGnDXnxF8AFkMUqkle4aMx5IfysZd7vhE1jycenclYaE0fEW6QAx0vQLFOapkcluZVO2BbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747015499; c=relaxed/simple;
	bh=izapFTJCHdLeuwWPRSW9ZcQXdJNd5TcaCM9/h6FftkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaRW1uSO3WOUyysTeNCKBwX2vzh9rhfBghiWeAP3cnmbOygOPhlI+OT9Y5U2kNZKK6AKiFox2dCjOQSplbQb9VvZgZVABRE34A4AnS8eVWhxgGhhcyHiBC3BvVMsRFMj7te1g5AgVCdeRpOz47lxenk+i0xPIQbcPHr3g8TFJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1747015428t1986902e
X-QQ-Originating-IP: ib4xLXH9YUwSgoeSM52/g/GWGoqr/pAetUtHUlsVwSw=
Received: from w-MS-7E16.trustnetic.com ( [122.233.173.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 10:03:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8647933736990949819
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: wangxun: Correct clerical errors in comments
Date: Mon, 12 May 2025 10:03:33 +0800
Message-ID: <06CD515316BD5489+20250512020333.43433-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NaIjp9H05hjftyww/luSYCULzBT5RT7/gFZAwzYdLGaYyaXufLJDg28k
	pF7EvUVq+vRLqBwvqHSNqAHrgMTz75E5c+5c3fiovxMJuQR/HCNiEF+dIrsuBPALJDjeByJ
	A8s/HE7SujHHsTHgpk+ZZTIMvms4H8FxTEJsp4eLNRhNv/rkmpQ8qwTmn/DXkkTNFWQtfjJ
	AVxwdi8pb6GSN+sfVQgdx1O1SEUep4O80LzAXxXjzy71pTPd6+w+OSVqwPyfM44qds5ysH3
	cd7FLkKUQMZzLhndyi7awrxvYwNdXo5KmYrJZcHNivZusl0b32fpQPLly1T4QB9id+RTQme
	9R478fMtLN/6aFpo/pVDF49or6dnm4TyXakTg2STvcG4mun0BIZSfv2G/ZrtrXBj5HS73Us
	Vnd+jHqP00o6+WyfOx32gZIDIsc3sE3OxwVZzEqRJlWzIVe6djxWHCXXY8Jh5NOWVL5qXKz
	V64cTYHqo6sY/+7PIE+zVA8FWlL9hB4uFz/Umk6lGzKJRpU3gaAZyRTudQGy8AzIfR9kvsF
	13A0BeXdfVF+PlyjKBaS/VGutDDZmsR3SD6zsm+BWI5vI6DBnZG6xS7Vscjv6WqGF786zvx
	hohl51a3Qo3GzDCMvGIMrhVdrCMkVZCISt3+OCgd7vGcDP570m2hPv8RXKvgxJQI4/KO7Tb
	S754zK8gyZuk4yHbd2ObpLF3VQY8haQTcR6Xt6DGVb8uBgHAn1g9C1MB0IjL3D0FXOE9KDw
	O7QjItPC4G3r2Jjq0m9SbfJ+mHBNB563he/vUqJBp9yZCJ+pSDzTzA8EeU9BLo4GJJvSAq0
	um3SvymUjPNZBjuja5rrug/EtgG+T+kYO9Lh1VrP35j4+hv+zCbTaIkPSbjbuc+eEtlTNsz
	b+LeZsq9XSMlNOUMDaA8fUGhPGp9aP/1yD8bz5jy0csblozwODkIUVKken/AMBWssfuH9MT
	oexpg0Iyc8r33mTS1wsyz5f+eRKr8T1bjjDkoYuL39Aem9hlAewznn84Hfxzg7chd1BeGxf
	7LEJ//bA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

There are wrong "#endif" comments in .h files need to be corrected.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.h    | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index 919f49999308..49f8bde36ddb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -39,4 +39,4 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
 
-#endif /* _NGBE_LIB_H_ */
+#endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 3938985355ed..a32b19d71ea2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -8,4 +8,4 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
 
-#endif /* _TXGBE_NODE_H_ */
+#endif /* _TXGBE_PHY_H_ */
-- 
2.48.1


