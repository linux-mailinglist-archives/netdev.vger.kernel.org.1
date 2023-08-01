Return-Path: <netdev+bounces-23438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15B76BF8F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0017F281A74
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9E26B96;
	Tue,  1 Aug 2023 21:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6F214E9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:54:18 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BD1BE3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:54:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d11f35a0d5cso6886887276.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690926857; x=1691531657;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNBQc9Z2ynA80islAIOJ/+S6GEzr7AKoM7LT/aWT1Ls=;
        b=vD7yzpEX0z0Lpuq4DpMYMphM1UppWInPPb4bYNowQHGHGeiTRegS/BFx43zZ7oEuUP
         UPnKCHDFNQcokncWY76FyHDkOXakpljGfB7224eJVbKXLSZeNg+TV647XfhxrFqWehJM
         lVz3Hz6OvZZNaN3wM72E4/T7npq2gkAXSvNroyyW92d5ggVIsBPVLTxI9IELLKMywzCs
         75/03WMb1KgdzYEB1GAunVe8NY4G8I2C+BBmM/zTByl/87nufSGJXChXusSQ+42yMjPb
         PQGoQixfyoB+bcM85z4S9TprqvG0qt6QlWm5Wg60z310wQKJIDRqY3pgKyo0sHx/7pXV
         /T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926857; x=1691531657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNBQc9Z2ynA80islAIOJ/+S6GEzr7AKoM7LT/aWT1Ls=;
        b=GYet5WTaTO/8V6Vv51ClI/ZZ70a/uQN+eZHEWQAIU1SQyD/FcwHBZfHSHQzOTLq9Rv
         sIbbB9SGO4kKF1nhCIJUjqi25dhHdK+hchb91zChd9TpGXNFZzptm9iwMQ5ssUzMfnG6
         NFfM2t7jQWQcVWbiFnA/lxV7t+W1ro/Kg6m/sb9h1WoeIT0s4IkgF/o1WAzodxzKxTLn
         wJZwFprF8hqZtanb0Bnnp3lGN1p8CT4Y4QY53sI+twn2C98KpfUYU0EPXAgG5SwthQHg
         oI6B+YL5ZLU5dyrBFY8mrMfLujJ1TynmD2PLn9t1kV84i+7b3MWwnmqYH5O1J1HIBfo8
         Kj3Q==
X-Gm-Message-State: ABy/qLal0ijyuwKN2U2nFH/cS8jvnWo9g7U5F+R4kb9vd1zZLV2A8nD1
	A+ypAzKNaAUHKpGjGZKNYm6EM3z+j7o1MOvMuf7YyyPUO8/HzNkxhOCZUTzgOuCxULm/eIoS6ab
	vT1bcjG2kZfiMP+Vh9/qQkrOTo3Xre9JsHE64ICN/xaOIW4k4kAAGXQlPYWzurNNa
X-Google-Smtp-Source: APBJJlFsOOljJaxhafOqjOYzbyHUqfN7t1caCz7DlKgaBUfej5996xSjNky4Ldey0To0vgMWirOcXLtXNPrU
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a25:b28b:0:b0:d0c:e37:b749 with SMTP id
 k11-20020a25b28b000000b00d0c0e37b749mr93420ybj.10.1690926856922; Tue, 01 Aug
 2023 14:54:16 -0700 (PDT)
Date: Tue,  1 Aug 2023 21:54:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801215405.2192259-1-rushilg@google.com>
Subject: [PATCH net-next 0/4] Add QPL mode for DQO descriptor format
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GVE supports QPL ("queue-page-list") mode where
all data is communicated through a set of pre-registered
pages. Adding this mode to DQO.

Rushil Gupta (4):
  gve: Control path for DQO-QPL
  gve: Tx path for QPL
  gve: RX path for DQO-QPL
  gve: update gve.rst

 .../device_drivers/ethernet/google/gve.rst    |   9 +
 drivers/net/ethernet/google/gve/gve.h         | 112 ++++-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  93 +++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  10 +
 drivers/net/ethernet/google/gve/gve_main.c    |  20 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 126 +++++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 404 ++++++++++++++----
 7 files changed, 653 insertions(+), 121 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog


