Return-Path: <netdev+bounces-18193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B9755BAE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ED128145A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0A8466;
	Mon, 17 Jul 2023 06:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F26D19
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:29:24 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D8410F8
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 23:29:03 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R4BxJ6tYvzBHXgp
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:28:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689575332; x=1692167333; bh=gYfLRyY+eBS7ELomGMNo4u0qwZ+
	q7EitNu0BbhLxNN0=; b=kuit9gHhjoxniS43GPa4tZuiKakP7Pbe/PQB4Z4dKie
	TtgWMsRgG5pJlUZ2ISKvXL8yIKDvak3srA0jzE9G2ZF/cd7IiG19IheQTbFmGn9Z
	tuQ49ralXs/NzpjvG6ruopqt0u7Ebc05HwSHvsLE9KkaMkpFqGbZ9nVd8TTDFAMz
	gM1SJCdSFaYifovW7KOJGCeVE5uDOCO0zMc6bndU1BcFa8rzuxSgw1/4y8CFgYzA
	tpqOli+VPgsmNQGPSYALw+tuBcF6/3+EbAE3j5NX3zM9Dn9RZUgKxpMU4uWOaY+v
	SQwK/N+nLmIG5UQgh7zB2rxW5u+ZGCka3zxau2Ede4A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 28aD7KA-lMoV for <netdev@vger.kernel.org>;
	Mon, 17 Jul 2023 14:28:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R4BxJ45dGzBHXgf;
	Mon, 17 Jul 2023 14:28:52 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jul 2023 14:28:52 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net: space required after that ','
In-Reply-To: <tencent_42BF9168164914C9431B82386C853B9EE609@qq.com>
References: <tencent_42BF9168164914C9431B82386C853B9EE609@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <e0580876db3dbe6f9fedd2eb210bfe07@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fixes the following checkpatch errors:

./drivers/net/ethernet/realtek/8139cp.c:1141: ERROR: space required 
after that ',' (ctx:VxV)
./drivers/net/ethernet/realtek/8139cp.c:1152: ERROR: space required 
after that ',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/realtek/8139cp.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c 
b/drivers/net/ethernet/realtek/8139cp.c
index f5786d7..6c828b4 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1138,7 +1138,7 @@ static void cp_clean_rings (struct cp_private *cp)
      for (i = 0; i < CP_RX_RING_SIZE; i++) {
          if (cp->rx_skb[i]) {
              desc = cp->rx_ring + i;
-            dma_unmap_single(&cp->pdev->dev,le64_to_cpu(desc->addr),
+            dma_unmap_single(&cp->pdev->dev, le64_to_cpu(desc->addr),
                       cp->rx_buf_sz, DMA_FROM_DEVICE);
              dev_kfree_skb_any(cp->rx_skb[i]);
          }
@@ -1149,7 +1149,7 @@ static void cp_clean_rings (struct cp_private *cp)
              struct sk_buff *skb = cp->tx_skb[i];

              desc = cp->tx_ring + i;
-            dma_unmap_single(&cp->pdev->dev,le64_to_cpu(desc->addr),
+            dma_unmap_single(&cp->pdev->dev, le64_to_cpu(desc->addr),
                       le32_to_cpu(desc->opts1) & 0xffff,
                       DMA_TO_DEVICE);
              if (le32_to_cpu(desc->opts1) & LastFrag)

