Return-Path: <netdev+bounces-18485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD27575DC
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC3281254
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803AD8828;
	Tue, 18 Jul 2023 07:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD77477
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:57:38 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71033173B
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so8784730e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667032; x=1690271832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw8S8ohFAjJvqm8HRm1Ib4h2RNi+dhnA4IaPY526ysM=;
        b=xuotYMKhWom8XlUQzbv1lWFQHoApOVmGWqonV/mG0O2JornO3adaNKalFzJSwG3xe9
         HKBn/TVVQB2sZaQ9D9v48G7eGqizLOZcxgPyMPr7+fjzudxg+UXKbRK3Y87vD+k0tTfq
         0FWaaou+5SFObSYd9wmn+4YCqHYt1m8bCMXzNxX60Xmm/R+T6ZL/NgEHNxGgqiSchNKI
         RzYLGXllSWwxyPhLzS7SMA5wp9EpH7kJA1RNoCNdR3hxgpa5Lzi4I81ak1A9DqWuAitA
         RhTVTBrzPBBYNaq7xK2ETPUWGIpaLQCHK4kD8DB911JpPi+iQxnsGIl3EwLv1gZp3rvc
         52+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667032; x=1690271832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw8S8ohFAjJvqm8HRm1Ib4h2RNi+dhnA4IaPY526ysM=;
        b=C5hbfrR9yRdGLqNduSVOLu4RchiaN1PlGkJstmAFVn8z2AcBe0+xTvQNaNXBLb+zSg
         GzqCVjoIxrBN02FCJe9+oQa1fIpiGG858CYGzggGBzFSYq4ZtkiKxmaRgVtvMfUHEb2h
         ogRXcwPP6ddNo5CsvrUmQr3uJ0lqfwZw0VgorSXE8TI+CsHINlEDYaV0kZ5JsH36YvtL
         Fr3vNxjuVHTO6VkzFvDNXXtPsxVS8D73S2w2YkP7rc09MCYxLtqXi/bpBOVNDVkMg8xb
         TKpKBg5UcsMwLfc36gJOEU8vSYJL85hgzOCJTZMm3UPqw2pJ5Ym4/BDDl/1lHiG40UKM
         1i2Q==
X-Gm-Message-State: ABy/qLbxd3cIoLyb9Io+7vinHe4EpZ9vA6KMvyiKbfFLNjhp3BTt+bU9
	V3LU77nbiJ/104C2+sRh0OcP7w==
X-Google-Smtp-Source: APBJJlHx6i25vRWw7/xD22QR+8rmUVx4iZRBYki5dchLFjO6eC9KSAqrqs3yPRIxKY1p0z1dv1+OZQ==
X-Received: by 2002:ac2:4a87:0:b0:4f9:547c:a3cc with SMTP id l7-20020ac24a87000000b004f9547ca3ccmr8551001lfp.14.1689667032251;
        Tue, 18 Jul 2023 00:57:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:11 -0700 (PDT)
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
Subject: [PATCH v5 00/12] can: m_can: Optimizations for m_can/tcan part 2
Date: Tue, 18 Jul 2023 09:56:56 +0200
Message-Id: <20230718075708.958094-1-msp@baylibre.com>
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

v5 got a rebase on v6.5 with some small style fixes as pointed out in v4.

It is tested on tcan455x but I don't have hardware with mcan on the SoC
myself so any testing is appreciated.

The series implements many small and bigger throughput improvements and
adds rx/tx coalescing at the end.

Based on v6.5-rc1. Also available at
https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.5?ref_type=heads

Best,
Markus

Changes in v5:
- Add back parenthesis in m_can_set_coalesce(). This will make
  checkpatch unhappy but gcc happy.
- Remove unused fifo_header variable in m_can_tx_handler().
- Rebased to v6.5-rc1

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
v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/

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

 drivers/net/can/m_can/m_can.c | 517 +++++++++++++++++++++++++---------
 drivers/net/can/m_can/m_can.h |  35 ++-
 2 files changed, 418 insertions(+), 134 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.1


