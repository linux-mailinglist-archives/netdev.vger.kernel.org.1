Return-Path: <netdev+bounces-20968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A7762051
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0391C20F3C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA125914;
	Tue, 25 Jul 2023 17:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAD25140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:37:36 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CDA1FCF;
	Tue, 25 Jul 2023 10:37:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686be28e1a8so57972b3a.0;
        Tue, 25 Jul 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690306655; x=1690911455;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnTumbdoXA7kD4l0sgFMoj5lddIfZfyLgk/Pn05/htE=;
        b=O6fh574qQ2nGINq2T31huCYSAL0r6voZnPFKravwzEZ8hYSssxDLcKp4qt6v5Jp76G
         g+0RXK4Cgo+sS2aoFe8APnzagkw+UD23/mQpS9nSAqCIbxhErxSYkL4106NNHjZzT+RF
         lTIJgDfg9r+nbSxqQLcsejgUhrGiymCxRqK6VDp5KAPLz0HvbHwW3+Z7diF7+Kx8aUsH
         uf6UpU+ITmF2UXF3e4bsnOZBZKTpHG7e4ngtwMqJ+yLoHTfkSsvI0KJQwG9AyPaBolXA
         519wH9e3liCq1fi7qxI98xi3iTgrLUMnriEADmiUnz5BgQsXiIp4nTvz38KOEvjDZuzc
         AulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306655; x=1690911455;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnTumbdoXA7kD4l0sgFMoj5lddIfZfyLgk/Pn05/htE=;
        b=R/tFQtP2nH/1xSv7V9huStJF7WwGLBSQk3CSWW3F+AIFI50qyA+QYwyd5R2h2tZkgr
         JDFRoq/vs3O7ihWJtf7ApOT1bqGzB765N4K47FPpBMXpMPDuMW/fCCUyVT/1YyfiFoP0
         IwfCDZUZdMrpxvF8U86shLxZQT0XSvr4PPulfVdjwp0ZiyPtzLTHl2zA70CUQPYmBqRV
         7BP6WNTKQ//I+ZvjXeqQePpkn5wHQ8vMySuLFJLBinUl0FkkSnqHzj5iFBsM6I9G944z
         nPIX6VxX41SvJXGyugF2q3F9m9x9AR/Z4FuoKXan+xStjaJXtIR2XgYPCZ4Iz06tx2Ji
         /3MQ==
X-Gm-Message-State: ABy/qLaBgeiZ/MPfLH36XwNa/PdUYiiNMpFk1gewhQjv6iwbE6SXLkWD
	HBtFph4z9OMMrIAxJsDqTok=
X-Google-Smtp-Source: APBJJlFM3Aa14VXpHuV0rtSBjneVPfgDeOZeusNwsl0Rw0ZzY4nuc1/0bx36X+Jp0nCH1r7poiYFiA==
X-Received: by 2002:a05:6a20:7d9f:b0:123:828f:68c with SMTP id v31-20020a056a207d9f00b00123828f068cmr12790754pzj.50.1690306655077;
        Tue, 25 Jul 2023 10:37:35 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b0064d57ecaa1dsm9906645pfi.28.2023.07.25.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:37:34 -0700 (PDT)
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
Subject: [PATCH] mISDN: hfcpci: Fix potential deadlock on &hc->lock
Date: Tue, 25 Jul 2023 17:37:28 +0000
Message-Id: <20230725173728.13816-1-dg573847474@gmail.com>
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

But the patch could be not enough since between the lock critical section
inside the timer, tx_birq() is called in which a lot of stuff is executed
such as dev_kfree_skb(). I am not sure what's the best way to solve this
potential deadlock problem.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index c0331b268010..ca77f259fd93 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
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


