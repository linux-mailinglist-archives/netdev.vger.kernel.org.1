Return-Path: <netdev+bounces-30587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2F7882AB
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0322817E8
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C0A94A;
	Fri, 25 Aug 2023 08:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789681C06
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:28 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C91BCD
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c65820134so520320f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953604; x=1693558404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZcv41f6N+Y3whwcGh6kmDJx06nuexMNGd8bbQSwXJ0=;
        b=01xj73Da9OIwr78McNXwqXBZfkTcV8avDJTZGTg6Rj1rRMgz0oxpT4IIJ0Fos/MDyQ
         kU1t7u2C44lnb28slT807g/6gXGEyfF7IYQUyYadeVV1oYmpImdpREHSrP6LsiLQfuRD
         Gj3fSqMIMxJGQw+BrdmD6L6MN37GpEWmRjwa7CtIvtcsUihvAlpVhzdyxdTx/un4xbb5
         ZSUm2dFQZVL+G3pFhcg2dW2ZeksbFnlKLjJe11ILGwbYR02mYc70pPzQhGdJDC7Q+zsW
         Qzl59EspuLUEe/RRfPazHSXDzHZrL1ho0eN8xXBULKFCice02D/+uElVTdnR7/g0GC+5
         bkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953604; x=1693558404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZcv41f6N+Y3whwcGh6kmDJx06nuexMNGd8bbQSwXJ0=;
        b=k9n1mCJ7a6qGS/MDXs6Gcxv2SboqeqwhP4xH6cgPPYSXr7CxTPC+wiQUoNVEFiMj8u
         11CZAr51vcf2yQgEWoGWx92kRg5/AtD0FiTCcpyy/ApxZnE5TV5ERZlIKsI5phKs/w+l
         LOz5dIfDHl3GbAIr8GCPZhHeaz7ebWYzIYWvOjDYjaO0Jfkyj3LgzO1/3F5hX9TqAdxr
         Y6+pNg7z633ftyEWbA9SFBfEJy5G7rel7NuDFVT6BBkSArLguxFSmzwTolpXtQz6E9bh
         fGSiXmOqad4ClQffvmWd8Phb9rcV2C01XgyauUm+jGMjnUZOGWa1jrjBrUd+WYzey6qe
         eZqw==
X-Gm-Message-State: AOJu0YxSFjTPYjMVrfKQdzMNHe0F7h21xpELyhtuD+7k71mGXhw+9svk
	8k5s12al0msavZlx8vl5jsWRHyR4+KdaP04h1DJvxk9D
X-Google-Smtp-Source: AGHT+IECfo5nDZ3XLUOrotc1r/pwLLarsvrsXE7QfjrRLQkX7o2+etONQyPjKXaWoqwmbED7RMc4FQ==
X-Received: by 2002:adf:d4c2:0:b0:316:f25c:d0c0 with SMTP id w2-20020adfd4c2000000b00316f25cd0c0mr12265782wrk.16.1692953603614;
        Fri, 25 Aug 2023 01:53:23 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s16-20020adfea90000000b003198a9d758dsm1586670wrm.78.2023.08.25.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 00/15] devlink: finish file split and get retire leftover.c
Date: Fri, 25 Aug 2023 10:53:06 +0200
Message-ID: <20230825085321.178134-1-jiri@resnulli.us>
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
 net/devlink/leftover.c      | 9427 -----------------------------------
 net/devlink/linecard.c      |  606 +++
 net/devlink/netlink.c       |  266 +
 net/devlink/param.c         |  865 ++++
 net/devlink/port.c          | 1411 ++++++
 net/devlink/rate.c          |  722 +++
 net/devlink/region.c        | 1260 +++++
 net/devlink/resource.c      |  579 +++
 net/devlink/sb.c            |  996 ++++
 net/devlink/trap.c          | 1861 +++++++
 15 files changed, 9606 insertions(+), 9436 deletions(-)
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


