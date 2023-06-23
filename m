Return-Path: <netdev+bounces-13628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFD73C4CC
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 01:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA76E1C21391
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 23:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC7C6FB7;
	Fri, 23 Jun 2023 23:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76A23108
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 23:30:01 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD5D3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:29:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564fb1018bcso15371927b3.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687562999; x=1690154999;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmM4/Q4YBdn7CpXPNusqWQQ1ir3JZBh3uVjpPVIGTX4=;
        b=oQAb6PmzIbZirw/ADw1BbbgKWrKnVqiC3CQc9Oxpx4XLjSnTwBi5zmTaCZyMUHb1Rl
         FrRwxNfI8UV/7WeFWh939HTEOK2RTNH+FuzZRChBJApGlRldpwzxf+RZ+H8gOWretz5S
         u+0sBVKGtJ/wOkMHZ6dEKZcZsyWm3oVAG6uScmRjRo9Nzk9x4OprCwxaCb4weFkq0WWB
         hEjJBjAPxO5+yV8JTqqUeZgDb6BEIx81wKLRUP74kdXfAm+OWe3YDO7lg3HtQayg66Eo
         cJfeBtmaZ6e6aiSgscxxQcwpM/C0bONdiwLbiWhpJIt+NU/WrgWsz8QgQSNLMYhlqwUd
         neGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562999; x=1690154999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmM4/Q4YBdn7CpXPNusqWQQ1ir3JZBh3uVjpPVIGTX4=;
        b=Swfv+DpNBR7HN1Wg7UyrnHV8Dv16nG3cIUtaFP7jWs4Z49oOvbTf1V+q7Uioi5eEv0
         vWNyUGg0hTNhQnhjgPuC9o11etESUBI6HDJMf8KxHCZ8rGEHQKOBpGfX31XXbw2PtbLr
         P1ePQsnTxSYZYx3x7xPE4i4Tt1F1t78iDyvFdYpEkT3ZdVbCwzlEHi5cgWvAfYCksSNd
         YIJTZKlY2/3d1fDHCV46+dG/qUyJItmYyFnRyhHY5iO8CLcU7xn0v8uqH3yMbBFLqSRa
         n/VZ39OHESBmruuj87AC6Ihw4JdCqpjKx3yH6Mdhy5lmoA2zkBxLzs94cPV39oCSI7gy
         sZoA==
X-Gm-Message-State: AC+VfDxcpJT3n0nhOLW1aHFrva+CCHVXJeVyjfSGR7zqgLPrvA1IXOTB
	sRh17e7AKcY9EmCccvTcLlBjxImz9gfsrXfQdpbGVokTBJxn4pFgi14hyLVRKm3qKnbnFOyBXjt
	FpmBYkfqRZeaSl+VPZei1i/4giF8OWgTsUex+BOVGcBwoQNjU3kKp5R24WOHJHTQJ
X-Google-Smtp-Source: ACHHUZ6gdRrLYszz0KiOXtCQRgHLmvUE4c2nfj11uts2alGcWvTpcST0uqkbs/kyWlL9dDN5Q9fDoRAH3/iJ
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a81:b54a:0:b0:576:750a:7094 with SMTP id
 c10-20020a81b54a000000b00576750a7094mr1485564ywk.7.1687562998512; Fri, 23 Jun
 2023 16:29:58 -0700 (PDT)
Date: Fri, 23 Jun 2023 23:29:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623232949.743733-1-moritzf@google.com>
Subject: [PATCH] net: lan743x: Don't sleep in atomic context
From: Moritz Fischer <moritzf@google.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, bryan.whitehead@microchip.com, 
	UNGLinuxDriver@microchip.com, mdf@kernel.org, 
	Moritz Fischer <moritzf@google.com>, Marshall Rawson <rawsonm@google.com>
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

Tested-by: Marshall Rawson <rawsonm@google.com>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f1bded993edc..10512f725b57 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -144,6 +144,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
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
+					 target_value == ((data & bit_mask) ? 1 : 0),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -736,8 +748,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -748,8 +760,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
-- 
2.41.0.178.g377b9f9a00-goog


