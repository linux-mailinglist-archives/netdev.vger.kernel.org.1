Return-Path: <netdev+bounces-246897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F11CF231E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D769F303B198
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0392630FC17;
	Mon,  5 Jan 2026 07:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653530E852
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597310; cv=none; b=hc7H9gmDh/jIRC7d8otaGHk1BRk5jWT6NtKrU7lq4wpitD6NVR+ummL0scuN140lxMCY2JxouA6QKIbkCVXdZVy3MLszR0Y/CC2rREM5embDBzhi4lxLwJbM2rZU2Q0XkMtsSSiva1w2oy4HtBgaIMnW2iFjOFg6RV6fa0kMbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597310; c=relaxed/simple;
	bh=gCfSmzE8N37Gd5xFMblng6G/nOVfqWpmhnp1zSx5wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWvud6dpJi8faF6/epJjeujKnrFleMgUH2uj0erDyWwRN+4mMPQsLjve5Z6bFpC/xXzbsFgrfpA5OimPhnfeeoTzNuLKSwvdMiGvdO9Jhy8xb2YGJ+B95BtgFai9JV3xSSmvFbW2535ILByEW0zh6/tDLZk/zhilDqm/sFM8AaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz6t1767597125tf9cefe64
X-QQ-Originating-IP: OA766dtSJrhY8+OcpdO1rFFIuislcNcfMRK5ms7eeT8=
Received: from w-MS-7E16.trustnetic.com ( [122.231.228.237])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Jan 2026 15:12:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7769706624817966411
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: libwx: remove unused rx_buffer_pgcnt
Date: Mon,  5 Jan 2026 15:11:58 +0800
Message-ID: <F0907C8394B2D4A8+20260105071158.49929-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NmNdn36/F4yvJsyMqe3TgkBV/HSt8RzPzOUWk6N4UdQIddUlcjG6dG19
	g+PqIt3bond2PV9EbANpoNbLn5TQ1UEDcVth0bWETqmHit8WeNIkXbRqfQgwSxa/qkIcA8y
	mFD0iYib8hhmOS074Iy9BHY4yB6unyhXv97XEoRSZcVYla5iWRUZLxwhftN0JMe6Z7SF6l4
	i8TFphelKb/R6fNd1FCZQCwKVyAOYFix4govr6Yhwe7LOyZFrx/njU9jl1Mg6/9tzj2opnt
	UWQt+EBaNgABMIef+zKnw6E5zTWW2F4x4wrBysk+UmSiPflIYKHxThOauBauJBEypOiaCNb
	voW6ftPLcI7VH9npSOA2Hfw6l+6HkBcnkaS0efLeHmBY4rsdHVAbacQI7hhJ51z1dSY0bIy
	5gJw0zxLYplPqo16avMKvo1lqK/bxTWE++sn2Oz0uzp2FNz6m/Yt2K9ecH9M7PQjtQwI57q
	NZb/fT/9xxBLuyS+L0OA6EPD/ExlqigIWaEWgCOpnfpj7gWR3vkJORY45aHClwhD7vnJM81
	+tJycx70nbPXly20MM/Otzq5ZN24hElTDLGfgj+9fuLNaflA68T+j9TXZPFt5v3L6NtkqyI
	4PFvPCTAF/ddbrZdRK9oUapIam5pNryFKDbn6UNpsBlNSS7oxQJsbsPq9wfSDcvxG1Nij4y
	oz6lWyOAnubxgyTVajXOsJzYnHqbx3gO1I4w4HUtB72KAZnB83v/qRf1VnzoZNJsNufwJ1O
	pqNl9NMG8OWggt18B6KfLwnJUjQklNeIKX3KW45ThQhZqypoauDfBPy7Kc489L2uZ1ay3Uj
	OI7guwj4geoMnAbcogTll4D/X7LQHppSVYxAh4BxCpjNixw9WLbmMDAPoG4OC8mLyTR4F6R
	pLUVesMqDv5LNRa4ouBEAVVpVSgFOYs17Y31iTTCF0/Gk6tFjs0AimH+0t8+uqgeFi34BqH
	gb6l+CtjOVjTu9oUbFosY6nb7wz9KPZ8SqF5IDuCA/iHhY8X9aoVOQmyP9x0pFJCor1Mdfd
	U9/AyB9uq93Kir+kPNnBw4HsdeJJKmONxHF0lwDMIhQTjMzNXBM3hQxbiAjjA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The variable rx_buffer_pgcnt is redundant, just remove it.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 32cadafa4b3b..b31b48d26575 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -179,8 +179,7 @@ static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 
 static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 					     union wx_rx_desc *rx_desc,
-					     struct sk_buff **skb,
-					     int *rx_buffer_pgcnt)
+					     struct sk_buff **skb)
 {
 	struct wx_rx_buffer *rx_buffer;
 	unsigned int size;
@@ -188,12 +187,6 @@ static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
 	size = le16_to_cpu(rx_desc->wb.upper.length);
 
-#if (PAGE_SIZE < 8192)
-	*rx_buffer_pgcnt = page_count(rx_buffer->page);
-#else
-	*rx_buffer_pgcnt = 0;
-#endif
-
 	prefetchw(rx_buffer->page);
 	*skb = rx_buffer->skb;
 
@@ -221,8 +214,7 @@ static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 
 static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			     struct wx_rx_buffer *rx_buffer,
-			     struct sk_buff *skb,
-			     int rx_buffer_pgcnt)
+			     struct sk_buff *skb)
 {
 	/* clear contents of rx_buffer */
 	rx_buffer->page = NULL;
@@ -685,7 +677,6 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 		struct wx_rx_buffer *rx_buffer;
 		union wx_rx_desc *rx_desc;
 		struct sk_buff *skb;
-		int rx_buffer_pgcnt;
 
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= WX_RX_BUFFER_WRITE) {
@@ -703,7 +694,7 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 		 */
 		dma_rmb();
 
-		rx_buffer = wx_get_rx_buffer(rx_ring, rx_desc, &skb, &rx_buffer_pgcnt);
+		rx_buffer = wx_get_rx_buffer(rx_ring, rx_desc, &skb);
 
 		/* retrieve a buffer from the ring */
 		skb = wx_build_skb(rx_ring, rx_buffer, rx_desc);
@@ -714,7 +705,7 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 			break;
 		}
 
-		wx_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
+		wx_put_rx_buffer(rx_ring, rx_buffer, skb);
 		cleaned_count++;
 
 		/* place incomplete frames back on ring for completion */
-- 
2.48.1


