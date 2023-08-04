Return-Path: <netdev+bounces-24583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B5770B0C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B45C1C21526
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F61F92A;
	Fri,  4 Aug 2023 21:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575119891
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:34:49 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3710E2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:34:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56438e966baso1702261a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691184887; x=1691789687;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBL8NikCgIrVBzLpRB5a5oHEpwB3eha8bDhNyxoWivc=;
        b=4nsKcQCjeAsiLZ0iNyZn5S0w8lJY2cS3+KWkkUMPZOrmXrdSJM8vdrb6Wo3/eni56F
         6p0GOjeNXY6Qm4MbPij7cevf/t76u0J4cgYCze1To0r325Dtq9+4HNLg0gaOyNu2FnDs
         wCzUaLeXa37B1CEDn94+N37773uCTT+waiz71xg4VzH59YP+7i5c5JNAqMcvkt/4GeXy
         wwujSaxAPCdB6OCUAtsrOL0XdfqRgOKFfE/9WdFG+xvadZjhSjGCddk4qHm8+CT/fUm8
         0yS+QSQOq0UZwXp0MNKWEGbX6+6NjpJsrSk0dR7/LMJxj8DVj2aARcCWQB3h7+Pchccw
         lfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184887; x=1691789687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBL8NikCgIrVBzLpRB5a5oHEpwB3eha8bDhNyxoWivc=;
        b=j10ciV2iCzcaIbXOD4kecP+ZMuGeqvxkuYy0qsPGSpJ8PVu1n13OWKuwh+WxkKk3yx
         KGPixiad6H+zg4Nfrh1QUqmy45QQj0/HUu6MMsQ9tUNlqDB8D625/3lwhVI5vKc2nUEv
         wswEQ4bmv/33ULWMt/R28op/Z0KKgw/mfJ/aSgYyZ4h2UUpeu59kic79t42mU5hkdE3b
         izd1m8ZEfaOpGfLTv2pbU7z1X0a80Y8Djy3e0ILVMVKb2NGSAVYoVA6V5ZY1K/kXbyym
         35kRsnIZatl8VLLpl+WI3LXOOxTUI8wVsBotRRZXibQWckPnrFYiocLTlrTW9T5/1799
         FbGA==
X-Gm-Message-State: AOJu0YxqucKnd+Sq62vvj8hIlaDXR1RtgV0iH8aoPGEWjd9qtPJjdYEW
	tuWozsG9XupIuX31B5rFWprhmFefO4JUTcmZ4b0JJgxNYODFikoUSErKTKJ79/NxyH0nM86zIht
	D4kElxCZ/8PFdsb+AHswmEtuFSaZ2OgDt9HBu/6cftteBPqLotfOYLfG5hvGCPLjs
X-Google-Smtp-Source: AGHT+IFIzQPjMOPK9r/DcerB/0bkkEHuo9OuRxxPSIuerZUwd999Yt4T/qD1c6c1bLjAG/WOr7zD/hDawzcA
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a63:b512:0:b0:564:9785:75c with SMTP id
 y18-20020a63b512000000b005649785075cmr119pge.10.1691184886957; Fri, 04 Aug
 2023 14:34:46 -0700 (PDT)
Date: Fri,  4 Aug 2023 21:34:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804213444.2792473-1-rushilg@google.com>
Subject: [PATCH net-next v2 0/4] Add QPL mode for DQO descriptor format
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GVE supports QPL ("queue-page-list") mode where
all data is communicated through a set of pre-registered
pages. Adding this mode to DQO.

Rushil Gupta (4):
  gve: Control path for DQO-QPL
  gve: Tx path for DQO-QPL
  gve: RX path for DQO-QPL
  gve: update gve.rst

 .../device_drivers/ethernet/google/gve.rst    |   9 +
 drivers/net/ethernet/google/gve/gve.h         | 112 ++++-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  89 +++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  10 +
 drivers/net/ethernet/google/gve/gve_main.c    |  20 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 126 +++++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 404 ++++++++++++++----
 7 files changed, 649 insertions(+), 121 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog


