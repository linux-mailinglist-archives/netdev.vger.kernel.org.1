Return-Path: <netdev+bounces-30983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FDD78A59A
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6331C20840
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260A2A57;
	Mon, 28 Aug 2023 06:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156917ED
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:31 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EC125
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c7912416bso2520825f8f.1
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203419; x=1693808219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9A2DeJRRBKQUVYij2OudJ9cs6a8Y4Tlr6qJxvftlXM=;
        b=5ozr7qerokrY3MO7/K8Rjsh/wxDGJuJIEzX/vFNwz6O9ZNWwZJmWGdkwuhMF1P98s9
         JMfR3vSpe8Oa0CZfc8b0mBg3WIDF/Syt+SbZXHlw/iJ7nO3gIewjZ9ZrlbZTM464CXs2
         IKNWLfjmJxtptuCJx0MNN+hcMjKZ65ETKWUEeKJa4pAjiBmNE2blYK6mynLXfanruaAB
         J/Q0+tH/i+SgPvFZRF1nkTI1mcDZwGju0Et+/zdHViVHPX0e93TrsRg7KD42dPBrlBu8
         LjETfzKyU9mQ66hRw+mry3ktG17flZU7p0GjLVfNPyD3oXd13dFvzwEdZmr36t9f6zqt
         0+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203419; x=1693808219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9A2DeJRRBKQUVYij2OudJ9cs6a8Y4Tlr6qJxvftlXM=;
        b=OpRmJjp/zXjF70FwrXtUalEVmp479ztwxl1kxsF0wKwvF/AL2F3xSBo56kjzKAm56J
         GyPugIgEETR5PSMf4mHrxyvHkAhfMbWhhK+cXSE68gbYwSUO/pM+b7sg7klysK5S64IM
         3FrHrtTIAGjSZK2qv0GyWz8IKwPVbjwrR1jkEKKS9SaV0+d8U8g+AAgnKyIHhrliwrS9
         P6XiNiOq/fRZqLwyFjPoc9NeOHzVoViIA3dMall8QaM4fY9mOOGmdSmX8OQlTgm0ebe4
         xPoIdgJd57tRWJ5xSD1zSKCMQuUeDZEsmhU3eXmIgnTu0BFe8BmAlf3Li/SaYv52hyDy
         jKXA==
X-Gm-Message-State: AOJu0Yxxuzv16sAzoaizgCqJZfML0WP/N/FBqe7f3g9mgI11eh1FFyyA
	j53LjnOQzLc0h35RxCo/KM8ZUYCK3TTHEso6jzFi4g==
X-Google-Smtp-Source: AGHT+IE7fLYJFwEj7gd5P3zKd2Rx822ncOCxA/MCru4fTPm9VI1nWuGvkwpA6oesZsIc6bESIHohIQ==
X-Received: by 2002:adf:d4c2:0:b0:31a:d754:2c7c with SMTP id w2-20020adfd4c2000000b0031ad7542c7cmr18616135wrk.59.1693203419081;
        Sun, 27 Aug 2023 23:16:59 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w4-20020adfde84000000b003143b14848dsm9422220wrl.102.2023.08.27.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:16:58 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 00/15] devlink: finish file split and get retire leftover.c
Date: Mon, 28 Aug 2023 08:16:42 +0200
Message-ID: <20230828061657.300667-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

This patchset finishes a move Jakub started and Moshe continued in the
past. I was planning to do this for a long time, so here it is, finally.

This patchset does not change any behaviour. It just splits leftover.c
into per-object files and do necessary changes, like declaring functions
used from other code, on the way.

The last 3 patches are pushing the rest of the code into appropriate
existing files.

---
v1->v2:
patch #2 rebased on top of recent net-next changes

Jiri Pirko (15):
  devlink: push object register/unregister notifications into separate
    helpers
  devlink: push port related code into separate file
  devlink: push shared buffer related code into separate file
  devlink: move and rename devlink_dpipe_send_and_alloc_skb() helper
  devlink: push dpipe related code into separate file
  devlink: push resource related code into separate file
  devlink: push param related code into separate file
  devlink: push region related code into separate file
  devlink: use tracepoint_enabled() helper
  devlink: push trap related code into separate file
  devlink: push rate related code into separate file
  devlink: push linecard related code into separate file
  devlink: move tracepoint definitions into core.c
  devlink: move small_ops definition into netlink.c
  devlink: move devlink_notify_register/unregister() to dev.c

 net/devlink/Makefile        |    3 +-
 net/devlink/core.c          |    6 +
 net/devlink/dev.c           |   28 +-
 net/devlink/devl_internal.h |   95 +-
 net/devlink/dpipe.c         |  917 ++++
 net/devlink/leftover.c      | 9531 -----------------------------------
 net/devlink/linecard.c      |  606 +++
 net/devlink/netlink.c       |  266 +
 net/devlink/param.c         |  865 ++++
 net/devlink/port.c          | 1515 ++++++
 net/devlink/rate.c          |  722 +++
 net/devlink/region.c        | 1260 +++++
 net/devlink/resource.c      |  579 +++
 net/devlink/sb.c            |  996 ++++
 net/devlink/trap.c          | 1861 +++++++
 15 files changed, 9710 insertions(+), 9540 deletions(-)
 create mode 100644 net/devlink/dpipe.c
 delete mode 100644 net/devlink/leftover.c
 create mode 100644 net/devlink/linecard.c
 create mode 100644 net/devlink/param.c
 create mode 100644 net/devlink/port.c
 create mode 100644 net/devlink/rate.c
 create mode 100644 net/devlink/region.c
 create mode 100644 net/devlink/resource.c
 create mode 100644 net/devlink/sb.c
 create mode 100644 net/devlink/trap.c

-- 
2.41.0


