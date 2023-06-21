Return-Path: <netdev+bounces-12505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB6E737EDC
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4836028155A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E0D2E2;
	Wed, 21 Jun 2023 09:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D06C8D9
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:17 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7319AB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-311099fac92so6620456f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339436; x=1689931436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhbmVt/bR7PxLH5MDA0JQvpls/C44+Igd7TpWMy2Ddg=;
        b=E9519/hup4CMAG38i+j/WCtV5DI1Kh5Z2SC19XjwuKZvTXNn0+2iqh7XEWTEQrhH1c
         VUkySYLxCcuzudOK5wkZnpBjwTN2NtQ1P/XGst7w3gw777jYCTu4ct31uEQfkm4h6cbx
         r4Q3NKdB7EyXoWfzLfrJJTglVgmxbwgmWYC+JgZhExD1DIBU0l7QDfYubFjjT+mEadJ7
         cD9YHjU81kcR04Oy2M/NrR3plx/1i22ssTKsiUCzWEN6yXEOow5RdtKWN9y0/yO1STEB
         4qHtjQiieQ0gBfcm+73qQOmkRtiv/uLLw1qfofJxkVBg6VpJX9WHuccF6GN2UArE0/Mu
         6bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339436; x=1689931436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhbmVt/bR7PxLH5MDA0JQvpls/C44+Igd7TpWMy2Ddg=;
        b=BPh3XxRc8nn7BfQVDjNGElMEkYvbQEwrR6QRhOOiNr86JQMHM2rviSvtUunudc7rDZ
         IdSwKszxfbO0AgOi5Gcaj+qNz780cjXGfo1qPt7SzvQ0wHopDvz+dtqYPslu/DkoeD3Z
         gcCZ7EyTApvqlzwV4N6JNEnQch4KIMim0PfvM3fM0f/b1OoU22t/YmEMoJvwkxq27mfM
         sNo4ySVZJIjV1qSMktu5Lj64Cvd/za3nPhO+lTfAdw2pBjG5aFiuPJUehhoOuedwtX+g
         RHcph/XGynVRsReSrKb874YxhvdjVhCcJU3aqcRlvXX24dizuNyyhwLfQsOAEulnN8FH
         mofg==
X-Gm-Message-State: AC+VfDwCnMuWTW6/7mhgMa1lmblu89S/er/MviN+ElTP9g3kiA1KYXIr
	gUqt1H1jbLpnSpl3P1So14FKFA==
X-Google-Smtp-Source: ACHHUZ64i4VroYQxlvRXhJe9FYH5d+yXc5wuFWWIfL3KpYkieBJG4/VRQB6oiFSVmTJi7H0hCivanw==
X-Received: by 2002:a5d:6643:0:b0:311:1711:d897 with SMTP id f3-20020a5d6643000000b003111711d897mr13892428wrw.17.1687339435867;
        Wed, 21 Jun 2023 02:23:55 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:55 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 00/12] can: m_can: Optimizations for m_can/tcan part 2
Date: Wed, 21 Jun 2023 11:23:38 +0200
Message-Id: <20230621092350.3130866-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Marc, Simon and everyone,

thanks again for taking the time for review.

This version has the fixes for the issues you pointed out in v3.
It is tested on tcan455x but I don't have hardware with mcan on the SoC
myself so any testing is appreciated.

The series implements many small and bigger throughput improvements and
adds rx/tx coalescing at the end.

Based on v6.4-rc1. Also available at
https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.4?ref_type=heads

Best,
Markus

Changes in v4:
- Create and use struct m_can_fifo_element in m_can_tx_handler
- Fix memcpy_and_pad to copy the full buffer
- Fixed a few checkpatch warnings
- Change putidx to be unsigned
- Print hard_xmit error only once when TX FIFO is full

Changes in v3:
- Remove parenthesis in error messages
- Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
  header and data in one transaction'.
- Replace spin_lock with spin_lock_irqsave. I got a report of a
  interrupt that was calling start_xmit just after the netqueue was
  woken up before the locked region was exited. spin_lock_irqsave should
  fix this. I attached the full stack at the end of the mail if someone
  wants to know.
- Rebased to v6.3-rc1.
- Removed tcan4x5x patches from this series.

Changes in v2:
- Rebased on v6.2-rc5
- Fixed missing/broken accounting for non peripheral m_can devices.

previous versions:
v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/

Markus Schneider-Pargmann (12):
  can: m_can: Write transmit header and data in one transaction
  can: m_can: Implement receive coalescing
  can: m_can: Implement transmit coalescing
  can: m_can: Add rx coalescing ethtool support
  can: m_can: Add tx coalescing ethtool support
  can: m_can: Use u32 for putidx
  can: m_can: Cache tx putidx
  can: m_can: Use the workqueue as queue
  can: m_can: Introduce a tx_fifo_in_flight counter
  can: m_can: Use tx_fifo_in_flight for netif_queue control
  can: m_can: Implement BQL
  can: m_can: Implement transmit submission coalescing

 drivers/net/can/m_can/m_can.c | 516 +++++++++++++++++++++++++---------
 drivers/net/can/m_can/m_can.h |  35 ++-
 2 files changed, 418 insertions(+), 133 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1


