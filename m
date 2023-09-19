Return-Path: <netdev+bounces-35055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3E7A6B67
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610471C208EB
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1A28E1E;
	Tue, 19 Sep 2023 19:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3E8BE2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:20:03 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7006BE1
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-770ef96aa01so393866085a.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151200; x=1695756000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyh1KouBtG7Iy09LS9HXsGpQo6L9jAzzmaZyqdFSGZk=;
        b=wQENy8GFdhsQiOt1ngnbQNxDbaIvyzEL3MhCXzSgkxo8VSm8JBj0XvGQgZ6EeLg2JM
         pAkeAhs8lmfnrLsVHWU4hZ2scje9lZqNPE2AJQGrg4EKW6Ejb2pDBMLiVnNchmi+liZT
         fcki+wUn7UgMXKfyorjFedsRdkb2q9jLdD70fB9mi2LmmivvirXcWaqgdNvVOFA1O/jJ
         TrTYe4kcbHl39qG0IxKX7imiKZmmRhdzKN/NygsEkoOCgmFR40adnYgKlILoRuty0LOj
         x0rt5G5TCj8l75QR0DTMBkCmFsku6emjqF8RQanOckUYGith1YA1KNO6TIaUWemmR9PT
         wWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151200; x=1695756000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyh1KouBtG7Iy09LS9HXsGpQo6L9jAzzmaZyqdFSGZk=;
        b=Y77Vxqn2inMc6McIXmmZM7Rb1hQ2ZLrUe9Yg15limcLVesSM/8+u1XcQpGek2oe8Su
         +NsUeAPRejLEByJ2ByUGZfzzxoYoW0iYClzvcWwZqRvGsBJ8MQV1UGm3fPAHpBfBDdef
         6YySYX2NO0QRJBJrKsBH6uBvzlZtK+rgcmNNmib2UXl3GVbXLWoyrKlX2GxbzkkenrKa
         wNqZ5eo6R9o/aoNGK56Vuer/fG1XN+E1Mi3XzZeaHpVNRFbh25L7k+UMCHtGMbWUj9xr
         rLuxp+W3IlmE41/0PLGXjzLz6AZ2ljfIRcsuL4WU4mhxqvnM2grd1sEuuijo7Kf3fu5t
         dj8Q==
X-Gm-Message-State: AOJu0YxIA1R3dmRvhxA73AEqRgUXF+sIzV8GWRaORS3qbVdJ5S9Bx+el
	2h+Vn7yeroz3D5/Nb4XIu12QJg==
X-Google-Smtp-Source: AGHT+IFIzlQgbfEYm0jO/4QPXVzoFCq4BxIA1q1xLtcSRQPlfowW+Ybgvv+50FIj+ScdvLKfPVI38A==
X-Received: by 2002:a05:620a:ec7:b0:76e:fea0:3f40 with SMTP id x7-20020a05620a0ec700b0076efea03f40mr562362qkm.8.1695151200597;
        Tue, 19 Sep 2023 12:20:00 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:00 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christophe Roullier <christophe.roullier@st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/2] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date: Tue, 19 Sep 2023 12:45:34 -0400
Message-ID: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On STM32 MCUs, Ethernet fails to come up after resume and the following
errors appear in dmesg:

[   17.451148] stm32-dwmac 40028000.ethernet: Failed to reset the dma
[   17.451266] stm32-dwmac 40028000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed

This occurs because clk_rx is never re-enabled during resume. On the
STM32MP1, clk_rx is left running during suspend, and therefore doesn't
need to be enabled during resume, but this code was mistakenly applied
to the STM32 MCUs as well.

The first patch in this series applies a minimal fix for the bug, while
the second refactors the clock configuration to make it easier to spot
such bugs in the future.

I have tested that this series allows Ethernet to come back up correctly
after resuming from s2idle on an STM32F746. I don't have STM32MP1
hardware to test.

Ben Wolsieffer (2):
  net: stmmac: dwmac-stm32: fix resume on STM32 MCU
  net: stmmac: dwmac-stm32: refactor clock config

 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 116 ++++++++----------
 1 file changed, 48 insertions(+), 68 deletions(-)

-- 
2.42.0


