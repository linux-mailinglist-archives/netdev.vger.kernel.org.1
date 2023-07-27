Return-Path: <netdev+bounces-21821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28611764E53
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6464281FF5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE75DDD8;
	Thu, 27 Jul 2023 08:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E840C2C2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:56:38 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB56A5B;
	Thu, 27 Jul 2023 01:56:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56334abe325so382310a12.3;
        Thu, 27 Jul 2023 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690448194; x=1691052994;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCyF5MJPNKz1i/3b0k6mf+/OQb0Y/PT2v0GJZTYQPmM=;
        b=TxF6jH7ajiW9fjO04OD6DDD2NOP9c0aWDnjWg7b7J+xEIxwsL0zzdM6afMUyCVn9W8
         g47gpOYLYIRVkcnDwtMf3Saa0GjU3hh6nttE022pylKZaPGrgfkuUDAtKm0pjWJaHRWE
         8elKLRxDMzP2Ozh5IlBwll8o/Hc/xD2FqU90TrjuqTGYQ2AGS8ONR1FbwCp7LIxzO7Cx
         OLOSX9sQSO4HB7Dq0OWS9RSPmiq7LXxzwE3mUxEu1zF0oQontJAqMxuqAgsiYPJBT2rN
         FBPLpUwQCdwYcHZq0ewFRej1V1IKu+1XWok0lUqvR4GICqeHfkxWV2RpNW1uP31U5cHI
         4lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448194; x=1691052994;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCyF5MJPNKz1i/3b0k6mf+/OQb0Y/PT2v0GJZTYQPmM=;
        b=PbvDlJew3yDjCuZrs1pPkyvGliweK+aLO9GRI5P3O1TVqk/bOwoWNvOb/dmHOEpj2E
         CDnxp4H3R3dsaliU1v0jSeeFt3uT10XIPjsAAWhdnJnuy/yX3Q+PpO7e6H1E6PuxlQdt
         133yedcm5emKmP3+HuPNd4njXhsuZJnVEQhoS6cJWvwN5pHGfsCWz7GOL/HcnvMgEjy7
         geblgfj2VXFWlqV1O7dtgxx6HYMSUX0PAd1nzskYEoYPrbfM37UhUBOaGH9HT8RZHviF
         1lEPcyIZiyqW4rBtBvy//hY6wbUkKJ0vEWP5qlEysBQTAW+suUnhA48eq0Rfmdvu5L3T
         IisA==
X-Gm-Message-State: ABy/qLY7STjIzusbDUX5P/b/n4LmOTTVjHanzSuz1VoQtEEO2Nm9wG4J
	L6p3Sltm/kt7XmlfMSey2gGONB6u4VtHnw==
X-Google-Smtp-Source: APBJJlE8JkK/V03dRWFZ4CRI8tCdHpATyyK6phYvyqQtBpE2DoBdBi5KPBnFY4gwiRudcI4XygVPhA==
X-Received: by 2002:a05:6a20:841f:b0:12f:fcbb:3e53 with SMTP id c31-20020a056a20841f00b0012ffcbb3e53mr4704146pzd.28.1690448194279;
        Thu, 27 Jul 2023 01:56:34 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id a23-20020a637057000000b0054ff36967f7sm921961pgn.54.2023.07.27.01.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:56:33 -0700 (PDT)
From: Chengfeng Ye <dg573847474@gmail.com>
To: isdn@linux-pingi.de,
	alexanderduyck@fb.com,
	duoming@zju.edu.cn,
	yangyingliang@huawei.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] mISDN: hfcpci: Fix potential deadlock on &hc->lock
Date: Thu, 27 Jul 2023 08:56:19 +0000
Message-Id: <20230727085619.7419-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
hfcpci_int(), the timer should disable irq before lock acquisition
otherwise deadlock could happen if the timmer is preemtped by the hadr irq.

Possible deadlock scenario:
hfcpci_softirq() (timer)
    -> _hfcpci_softirq()
    -> spin_lock(&hc->lock);
        <irq interruption>
        -> hfcpci_int()
        -> spin_lock(&hc->lock); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_irq()
in timer.

Fixes: b36b654a7e82 ("mISDN: Create /sys/class/mISDN")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Changes in v2
- change dev_kfree_skb() to dev_kfree_skb_any() inside spin_lock_irq()
  critical region
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index c0331b268010..fe391de1aba3 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -839,7 +839,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 		*z1t = cpu_to_le16(new_z1);	/* now send data */
 		if (bch->tx_idx < bch->tx_skb->len)
 			return;
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			goto next_t_frame;
 		return;
@@ -895,7 +895,7 @@ hfcpci_fill_fifo(struct bchannel *bch)
 	}
 	bz->za[new_f1].z1 = cpu_to_le16(new_z1);	/* for next buffer */
 	bz->f1 = new_f1;	/* next frame */
-	dev_kfree_skb(bch->tx_skb);
+	dev_kfree_skb_any(bch->tx_skb);
 	get_next_bframe(bch);
 }
 
@@ -1119,7 +1119,7 @@ tx_birq(struct bchannel *bch)
 	if (bch->tx_skb && bch->tx_idx < bch->tx_skb->len)
 		hfcpci_fill_fifo(bch);
 	else {
-		dev_kfree_skb(bch->tx_skb);
+		dev_kfree_skb_any(bch->tx_skb);
 		if (get_next_bframe(bch))
 			hfcpci_fill_fifo(bch);
 	}
@@ -2277,7 +2277,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 		return 0;
 
 	if (hc->hw.int_m2 & HFCPCI_IRQ_ENABLE) {
-		spin_lock(&hc->lock);
+		spin_lock_irq(&hc->lock);
 		bch = Sel_BCS(hc, hc->hw.bswapped ? 2 : 1);
 		if (bch && bch->state == ISDN_P_B_RAW) { /* B1 rx&tx */
 			main_rec_hfcpci(bch);
@@ -2288,7 +2288,7 @@ _hfcpci_softirq(struct device *dev, void *unused)
 			main_rec_hfcpci(bch);
 			tx_birq(bch);
 		}
-		spin_unlock(&hc->lock);
+		spin_unlock_irq(&hc->lock);
 	}
 	return 0;
 }
-- 
2.17.1


