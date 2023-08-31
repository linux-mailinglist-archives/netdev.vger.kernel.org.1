Return-Path: <netdev+bounces-31578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3B78EE75
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CB9281580
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0711719;
	Thu, 31 Aug 2023 13:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C437481
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:35 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D3CEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so7484435e9.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488152; x=1694092952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7INKZZajCRPr5cTXh/nUGkhu0LeE9esjkNG2LqXI4Nk=;
        b=xjGcPoHghBFJr/q+LF4yn9ZQDDRPLRR4kFOIgJAnEZ6CUfZScjaSl4aRkLzLUkvUwp
         OitINcNWuoQYdMBHaXaa9zGdM62RwZ1TSmCuMPDHUStTZQH31z8mSAGd6t3Y07sLx0/c
         544vHPoL0y8GV98DupfKJQj7iBqLDm8cOsTO72+xrIr0/z2N/jU/hwOvPkFKOeRRXv6o
         oPq7osfKk5aCnUV9BSl0RJLWMbIQC8jy1vAAqdWTXfcSx/a94miT5WRxo9dgBT4ZmTNx
         Zss7x8xj2H9CDErVUKU1QvdbBXUuOXupRvHShNex7gIFmKdMXv9Q8G8d7BhUM0a+sxL+
         8ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488152; x=1694092952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7INKZZajCRPr5cTXh/nUGkhu0LeE9esjkNG2LqXI4Nk=;
        b=HUO21NRgnjtIQyZZFxZKs9ZNGNNffCYOsdMI444KEUrOV7QMU0Chf9YhxWCutzv+4X
         cihyOQH1GCGlh2xhCelKcWzEqAfhGrKiARrLsM5lVUghZHwVDjIzqqKfYWsdylN6keDV
         7s+hDCkxpxaXXSb01hwLaXKBYonpu33ClxHagWhejdW4Xq2bRZHU4cW39XagdKdlebuC
         /MMhNf5EPuRVHSu5HHjArOkksPlJp5tbjcIr4b4dT3xifWhGJjsRrUnMtp0bIH2qQJDH
         I6cJ8qRgUFIjfHIbuU9Owm5OAaVEUTTyusSVhMO2WIiaquIPWljkQqFccpVGBY0nTES3
         xpjQ==
X-Gm-Message-State: AOJu0Yxm/unuEMY07Fh6k3aGwLNsCb/LYxE+9zHzQPe0/bx8dYOjLKEP
	5WlMSvrC3Z5ZsV45aGN5W7KsUDFh/ylMQXGGY3w=
X-Google-Smtp-Source: AGHT+IHfz6tzF4sPPdFQPL/4ugkIDSsaVv12JYzB4GdAT2mrYknGW3dWZAx1GaBgAnuf/53+bdwAgg==
X-Received: by 2002:a7b:cd0a:0:b0:3fe:dd91:b5b6 with SMTP id f10-20020a7bcd0a000000b003fedd91b5b6mr4309029wmj.25.1693488151867;
        Thu, 31 Aug 2023 06:22:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c225600b003fefcbe7fa8sm1981002wmm.28.2023.08.31.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 0/6] devlink: implement dump selector for devlink objects show commands
Date: Thu, 31 Aug 2023 15:22:23 +0200
Message-ID: <20230831132229.471693-1-jiri@resnulli.us>
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

 devlink/devlink.c   | 376 ++++++++++++++++++++++++++------------------
 include/mnl_utils.h |   1 +
 lib/mnl_utils.c     | 121 +++++++++++++-
 3 files changed, 342 insertions(+), 156 deletions(-)

-- 
2.41.0


