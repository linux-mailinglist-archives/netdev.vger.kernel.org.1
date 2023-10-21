Return-Path: <netdev+bounces-43223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6E7D1CCD
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7141F2824CF
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0DFDF61;
	Sat, 21 Oct 2023 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UDmHyZ9W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9FD534
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:20 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C031A3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2499661a12.2
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887633; x=1698492433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpk0k0ogme2d1cv2E0/I1viGOjA7QZt5vgfeWptNu8M=;
        b=UDmHyZ9WGw+9XwbL74iEDCDlhLpA2gncQYwylRRKmdCeELIjHICP1KhKEEzR42aHot
         y4x62aBKend52HuB8jxOtW5sWWSNTHBY3Jkj6Xq5q2+XEikMeKOtZXQIRIPe7m1O7W10
         QPAXxu582N5/H+4AzPbPe2bSFHaTmgHbJDzqhAR9GE924i9ZYTbtDlNLdbEddZ2pZ/D6
         8oeDD7hyHNxKPYgd1I9x9m1RcMTvu91WhYia6ccwEy9WkX/z12cp4wphvE8CFZGpvkGS
         j/TwRbXTLBTJa3ECx8tEa1wzfFZnPekpyy9e0U3sfbuvVo9OHPhpKvor84MKwWnvuWJm
         qWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887633; x=1698492433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpk0k0ogme2d1cv2E0/I1viGOjA7QZt5vgfeWptNu8M=;
        b=pQ7JtQInDZyZ2SJPM08CFPaF3p+e4JsvcQDfTOSBoTSNAS/OMWkL/YlySRF/zcqVXU
         OiHuDyYIl1Kpcx9mH7x8REcaR1lI+jydmGWtXP067yFghs5ALVylZu9hQ8Tw4Oy8Tctz
         D/sNzk1V0hD8MvQVFLaoD0EhUMi7aHrewd5AzQUYsCMSyVyMAnXTMQswSkz3ukMIQC6W
         lVobMj2E4Im3o380hhaLcfvF01/f4eQRxtSuG0A3ySl8TAk1o5GJiGtpqxFhCsElO2ve
         D/m8KpI96TONPJwboSZqXi7owVTfz9EC7Uc7N9bbJY1FBATl7ohOI6tJWyL22i0LG+Oc
         rE2g==
X-Gm-Message-State: AOJu0YyY+o5xfTAdUTmrMgYmTmWbm7r+t8Kut1px9us+0mVCsQQN+piU
	X42B/ePttX4SILjtKnhpBAoOiLc2ETPZ0PxhQbU=
X-Google-Smtp-Source: AGHT+IHcufC2yMRxfTtyLYa2Z6OE2pPCuy0UGyTSITevGeYHuZzOoZf9G/JBOdhwbrNjg5gh2ucr3g==
X-Received: by 2002:a17:906:73ca:b0:9ae:7081:402e with SMTP id n10-20020a17090673ca00b009ae7081402emr2476521ejl.64.1697887632974;
        Sat, 21 Oct 2023 04:27:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id do6-20020a170906c10600b009ad7fc17b2asm3452858ejc.224.2023.10.21.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 00/10] devlink: finish conversion to generated split_ops
Date: Sat, 21 Oct 2023 13:27:01 +0200
Message-ID: <20231021112711.660606-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchset converts the remaining genetlink commands to generated
split_ops and removes the existing small_ops arrays entirely
alongside with shared netlink attribute policy.

Patches #1-#6 are just small preparations and small fixes on multiple
              places. Note that couple of patches contain the "Fixes"
              tag but no need to put them into -net tree.
Patch #7 is a simple rename preparation
Patch #8 is the main one in this set and adds actual definitions of cmds
         in to yaml file.
Patches #9-#10 finalize the change removing bits that are no longer in
               use.

---
v2->v3:
- just small fix and rebase in patch #2
v1->v2:
- see individual patches for changelog
- patch #3 is new
- patch "netlink: specs: devlink: fix reply command values" was removed
  from the set and sent separately to -net

Jiri Pirko (10):
  genetlink: don't merge dumpit split op for different cmds into single
    iter
  tools: ynl-gen: introduce support for bitfield32 attribute type
  tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
  netlink: specs: devlink: remove reload-action from devlink-get cmd
    reply
  netlink: specs: devlink: make dont-validate single line
  devlink: make devlink_flash_overwrite enum named one
  devlink: rename netlink callback to be aligned with the generated ones
  netlink: specs: devlink: add the remaining command to generate
    complete split_ops
  devlink: remove duplicated netlink callback prototypes
  devlink: remove netlink small_ops

 Documentation/netlink/genetlink-legacy.yaml   |    2 +-
 Documentation/netlink/specs/devlink.yaml      | 1604 +++++-
 .../netlink/genetlink-legacy.rst              |    2 +-
 include/uapi/linux/devlink.h                  |    2 +-
 net/devlink/dev.c                             |   10 +-
 net/devlink/devl_internal.h                   |   64 -
 net/devlink/dpipe.c                           |   14 +-
 net/devlink/health.c                          |   24 +-
 net/devlink/linecard.c                        |    3 +-
 net/devlink/netlink.c                         |  328 +-
 net/devlink/netlink_gen.c                     |  757 ++-
 net/devlink/netlink_gen.h                     |   64 +-
 net/devlink/param.c                           |   14 +-
 net/devlink/port.c                            |   11 +-
 net/devlink/rate.c                            |    6 +-
 net/devlink/region.c                          |    8 +-
 net/devlink/resource.c                        |    4 +-
 net/devlink/sb.c                              |   17 +-
 net/devlink/trap.c                            |    9 +-
 net/netlink/genetlink.c                       |    3 +-
 tools/net/ynl/generated/devlink-user.c        | 5075 +++++++++++++++--
 tools/net/ynl/generated/devlink-user.h        | 4213 ++++++++++++--
 tools/net/ynl/lib/ynl.c                       |    6 +
 tools/net/ynl/lib/ynl.h                       |    1 +
 tools/net/ynl/lib/ynl.py                      |   13 +-
 tools/net/ynl/ynl-gen-c.py                    |   50 +-
 26 files changed, 10644 insertions(+), 1660 deletions(-)

-- 
2.41.0


