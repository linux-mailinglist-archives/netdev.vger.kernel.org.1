Return-Path: <netdev+bounces-13836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A573D2F4
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498581C20918
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E579D3;
	Sun, 25 Jun 2023 18:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1EEA4
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 18:23:30 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B0137
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:23:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so34403787b3.2
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687717409; x=1690309409;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nStssVR9ZPW4NaCc49D+wnFGC4O65SkKwiCmf2V2d0Y=;
        b=msXNNXJxzAyQGjjB0NoqLtN+QrxX5gUMXibVtxbYU4OFi2MaeNYA8Z0RxZomf9AvqT
         45QQi5o1fd3X3xW05GRj7pOGYbxiS+VnYVxP5Uwz7Jfy3hf4kqWymowFyUt7fOZHMYfg
         OYK5YGQFVXjCzmyXCoYwmNCk+XZJcndt/tIMpTkJftF4/h1YK5PNukTFrndt7p9zMk5U
         w7P3+OwUQV8iHptnP76wsiypbn9KOncOHMBLX264SqzoCh1RcXHz2jwFvzYvULLnaqE8
         4+gshS6uN4MYXzH32kVH0NshI/xjnQnvSnogBOTSGJto2W9LUlK0YhNuzYfKmFtWaF6O
         LrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687717409; x=1690309409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nStssVR9ZPW4NaCc49D+wnFGC4O65SkKwiCmf2V2d0Y=;
        b=SXggotXxRLAAZFqfsuG+P/uQQWvQLOKPnP4wYQP76VaFOF6l5jzaROMxk2PJXWCJyi
         ze7MXzZQ5cM0NAohJVb1LYMwm09d8kKwNXxOEHXfZD8rDY37OSU8UCY6FOSq/9RTM35i
         oqnEUBEmPhjkown/8YQhFd2/vmXCvAsgY/QlirrvFNg8UA4Wv3Xze0NhlisLuUJdEqsx
         eZYHPX19QYkDi86fbiKHgU/0on1lmYR6Mz7iuXUSBE1TjhFotI4xr3o1vpoB7HDjNzec
         3+p4yLBzIUSxCufltaF7I9ON4GJlyAMJnZTDToY+PVnGsTniQS9NxrfdQ/BoObYZPRQ3
         y9iQ==
X-Gm-Message-State: AC+VfDxpChONFptc3TtQG54N8bk3o4kq/RFP1j8kt13EuPp5H3CmcoyH
	tz/xLcv9M2HdQGfWTGX4PZyJKq1/3dU/PZM5VsNqW9y0kxOMckZb/wQ5+8BAT+rROITXAuh3k5T
	E8fwJ4KSVxOyTK5Ld4QY3xR4TOyyGvR8I3Udj/oeov4eSDqrNR6fvBWHJRLb22kHN
X-Google-Smtp-Source: ACHHUZ5pLQBE9Bj0k4hxQUKMJX9VqCllGLV7fdkhVoYhQ/SyjUzIfPuFw6u6b8pvXi3nVVXfdnlZ5cnMmaYL
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:fc06:0:b0:bad:23f:87bd with SMTP id
 v6-20020a25fc06000000b00bad023f87bdmr5166246ybd.9.1687717408883; Sun, 25 Jun
 2023 11:23:28 -0700 (PDT)
Date: Sun, 25 Jun 2023 18:23:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230625182327.984115-1-moritzf@google.com>
Subject: [PATCH net-next v2] net: lan743x: Don't sleep in atomic context
From: Moritz Fischer <moritzf@google.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, bryan.whitehead@microchip.com, 
	UNGLinuxDriver@microchip.com, mdf@kernel.org, 
	Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
proceeds subsequently to go to sleep using readx_poll_timeout().

Introduce a helper wrapping the readx_poll_timeout_atomic() function
and use it to replace the calls to readx_polL_timeout().

Signed-off-by: Moritz Fischer <moritzf@google.com>
---

Changes from v1:
- Added line-breaks
- Changed subject to target net-next
- Removed Tested-by: tag

---
 drivers/net/ethernet/microchip/lan743x_main.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f1bded993edc..4f277ffff1dc 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -144,6 +144,19 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == ((data & bit_mask) ?
+					 1 : 0), udelay_max,
+					 udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -736,8 +749,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -748,8 +761,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
-- 
2.41.0.178.g377b9f9a00-goog


