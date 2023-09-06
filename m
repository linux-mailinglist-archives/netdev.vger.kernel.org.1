Return-Path: <netdev+bounces-32233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEC793AC8
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156791C209EC
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA6612D;
	Wed,  6 Sep 2023 11:11:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8D7E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:20 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812FCF1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso34121305e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998676; x=1694603476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8v6NLHc+RJR56Vu/uh49WWy6P9wbU6EVAWK7qSgcCs=;
        b=mzMIvz/C9nZuyz4sflzaCYYVkn0SbrwDHJFs/5x9HjZAe0HITS7cDCq/i1mh71S75o
         F6oyKwjsssoarGnKrM5x0GyAK08A1apnuafPglIZbkmT7DpJ9eQfy5j2gIHZgx8x8Ix3
         M8tNNwW37Fkn7fMaD8uNww22bQH1wIHEZTmYdfyRXLCNjM9T3s69FNv98QqXcVXRCbXR
         blqV4U3ocXeDwcyIAdIEP1LWgUP4s66Lrj9bgPGC6fYOSTvkLn8rLTCKnjuFehG2BCdQ
         oPuyv/tyyL7z3Ndpa9GC1W8KDKRCyIFI8rwpqgNuQpGoglbnZIxFbpxuwycIDsIqIYe9
         AT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998676; x=1694603476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8v6NLHc+RJR56Vu/uh49WWy6P9wbU6EVAWK7qSgcCs=;
        b=F1JIfhcTKcMapArQ1nwwbIeMlQ4qy8NGtqDnsc1MrFQCTA/kA6ATNdou41A0oRTkOq
         uZfyzXP/YPt6pOcu4oFCcRaAgYSO+QLVTTZvHqNAtolV2EePx9haPDAYugiZfXAGROfm
         kxhOSs5voik6Wpbctiq2myu0Ki/UV/LyudqM0Tu04PVFnXbxX/vbOVlsoU4dTKewUJb6
         eiLKAKvgKGPOyeaxlTe4UnXy80664+cRacGlQjv4hBBiTktYrLzt0xrlZE7rOAO/VG6E
         SfLZ5V8eCdOmhlDLFa/P8gnJB6CUt/OJJH1Kr6Q7l/xhqYTo7/ZfefhewbjEkWOi3Xq5
         DIjQ==
X-Gm-Message-State: AOJu0YxRwexLWX8I+1/ettNvOgesK4Pn7Ous6TqJtWbIEHSPECm9jhY4
	jTxDiBZw10GjrDbaXyhzalWrr/lLxXJ8FVuSIG4=
X-Google-Smtp-Source: AGHT+IGBt9mk/8FkZXVusji25w/1w7cafLAmN8iZfL9JY+ZDL8aSeTfutv29W3nfgfU+iUWRvCuwXQ==
X-Received: by 2002:a05:600c:21cd:b0:3fe:22a9:910 with SMTP id x13-20020a05600c21cd00b003fe22a90910mr2030991wmj.14.1693998675817;
        Wed, 06 Sep 2023 04:11:15 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gw8-20020a05600c850800b003fe15ac0934sm789482wmb.1.2023.09.06.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 0/6] devlink: implement dump selector for devlink objects show commands
Date: Wed,  6 Sep 2023 13:11:07 +0200
Message-ID: <20230906111113.690815-1-jiri@resnulli.us>
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

First 5 patches are preparations for the last one.

Motivation:

For SFs, one devlink instance per SF is created. There might be
thousands of these on a single host. When a user needs to know port
handle for specific SF, he needs to dump all devlink ports on the host
which does not scale good.

Solution:

Allow user to pass devlink handle (and possibly other attributes)
alongside the dump command and dump only objects which are matching
the selection.

Example:
$ devlink port show
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

$ devlink port show auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false

$ devlink port show auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

Jiri Pirko (6):
  devlink: move DL_OPT_SB into required options
  devlink: make parsing of handle non-destructive to argv
  devlink: implement command line args dry parsing
  devlink: return -ENOENT if argument is missing
  mnl_utils: introduce a helper to check if dump policy exists for
    command
  devlink: implement dump selector for devlink objects show commands

 devlink/devlink.c   | 382 ++++++++++++++++++++++++++------------------
 include/mnl_utils.h |   1 +
 lib/mnl_utils.c     | 121 +++++++++++++-
 3 files changed, 345 insertions(+), 159 deletions(-)

-- 
2.41.0


