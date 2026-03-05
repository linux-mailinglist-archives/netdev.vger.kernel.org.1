Return-Path: <netdev+bounces-264197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGZQFz8qqWkF2wAAu9opvQ
	(envelope-from <netdev+bounces-264197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:01:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71F20C10D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6456B303AB56
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2062314D36;
	Thu,  5 Mar 2026 07:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156814EC73;
	Thu,  5 Mar 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694045; cv=none; b=jqKM9rt8ycBMdlr/KJGsARirjXPZxs3iAv0w84Q/NUtIg54UFNV/V5mIVS5s9jigILrHyEv+xibhuOvnTeYa9YUFxUI4MjOTfAnDUfjpM6thfHYf8nYddDkQTlyC+20LxaGbBn5bo4iwczW0SqokVU05ZAO8oLQ6C5JkClccSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694045; c=relaxed/simple;
	bh=SGPg643gglqJv+UshT/T2/TXtVzvxYdKr5gxNyEmiXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k2vOOU7NaDV9u8MqqmEOODGPaDvoMw6KIW4hoTB9Lblrayk7iMe3sBt3SPOSBR3rkxw4ZrHvsMvbu419+iC3X38dlGL425eQP2EqXAxnvfjFd6nRntU3mCk7+Jxuz/95ZCOS6DhugaJNax3omObsYN1Qt37d5U4FQkAPrHsb5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAXrA8RKqlpDu+uCQ--.18491S2;
	Thu, 05 Mar 2026 15:00:34 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 05 Mar 2026 15:00:29 +0800
Subject: [PATCH net-next] net: spacemit: Remove unused buff_addr fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-k1-ethernet-cleanup-buff_addr-v1-1-e978ef119231@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAwqqWkC/y2N2w6CMBBEf4Xss2sKIhh+xaApZZBGLbgthITw7
 9bL4+TMnFnJQyw8VclKgtl6O7gY0l1CptfuBrZtzJSprFAHdeR7ygg9xCGweUC7aeRm6rqrblt
 hXeb5qUAsoqDoGAWdXb7+M30mDkug+kcErykehj9utAeb4fm0oUrmcq9YTHpZN6q37Q2b0W8Nq
 AAAAA==
X-Change-ID: 20260305-k1-ethernet-cleanup-buff_addr-a74486e305e6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@kernel.org>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowAAXrA8RKqlpDu+uCQ--.18491S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GF1fZrW5GFyUGF4rCw1kuFg_yoW8JrWfp3
	yDZas2grW3JF4YgwsrZw4xZw45Ca4rtryrua4ayw4Fvwn0y3WjgF95tF43Gr45ArWxGFWS
	vrWUAw4rAF1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj_b15UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Queue-Id: 5C71F20C10D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264197-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Action: no action

These were never used. Just remove them.

No functional change intended.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Cleanup patch split out from:

  https://lore.kernel.org/r/20260303-k1-ethernet-more-fixes-v1-1-0ab0122fdd14@iscas.ac.cn/
---
 drivers/net/ethernet/spacemit/k1_emac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 338a2637b1da..af58eae6fcd8 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -57,7 +57,6 @@
 
 struct desc_buf {
 	u64 dma_addr;
-	void *buff_addr;
 	u16 dma_len;
 	u8 map_as_page;
 };
@@ -70,7 +69,6 @@ struct emac_tx_desc_buffer {
 struct emac_rx_desc_buffer {
 	struct sk_buff *skb;
 	u64 dma_addr;
-	void *buff_addr;
 	u16 dma_len;
 	u8 map_as_page;
 };
@@ -340,7 +338,6 @@ static void emac_free_tx_buf(struct emac_priv *priv, int i)
 
 		buf->dma_addr = 0;
 		buf->map_as_page = false;
-		buf->buff_addr = NULL;
 	}
 
 	if (tx_buf->skb) {

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260305-k1-ethernet-cleanup-buff_addr-a74486e305e6

Best regards,
-- 
Vivian "dramforever" Wang


