Return-Path: <netdev+bounces-42932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC47D0B75
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B056B21557
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0D12E49;
	Fri, 20 Oct 2023 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CIxy19Vq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6413111A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:40 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F68172B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso843765a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793680; x=1698398480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1X+52Y5oUhK1fQFQby198lehlQRntvjeZZ8cOQwMFw=;
        b=CIxy19VqfkKDElUENUg8zdlYxzfkV/HhYNpOkdHJfoqJfu0+IgaqWTNVnvLu9MWAR0
         DILUKXcnpJZpxp/+xMxGdrlOVeGS+84RbPT98dXFK2hKQpjVIGIhXeCf30dlfH3lh0jn
         OJpGrEKFYm+V1n0bKJBIKslHcd/j9+yZdG7/HaNIIntyYuk+GJn9iWIHFBJMJB60hsEG
         /gUryG5ONH3TJpUGJsfP0UPDOAVdnkPQCtoo15SHBB4VmAATI/dpWOlpcjQ7BWNoYXcj
         9bf9vqoz0WtzDwpKPtKFZk/526jdt0cavMm3A3DGCEAIeFWJ+lcFX9SsAe0nhtUEIJlN
         jHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793680; x=1698398480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1X+52Y5oUhK1fQFQby198lehlQRntvjeZZ8cOQwMFw=;
        b=Ssm+Mg6gr3Mde+q/FbfTMIV8jHm+RUAXNDlUEyWXDv+dVARflVZl3hz/ZhnjUW5QWl
         6sgB0yibD1kIl4q90lNH1bXVcJkLsb6mGqhU8ZEJXw0HcMhc7VqDI6bHYBwP+QhNc6mj
         wS15q5ZucLD76F1fYatbvgG5h5+Mq5gJAOPNrqgE8Y6p/APRJ49hssZQqZnkMa4w3RA2
         SE0qyK7/B2ZKrK9JzNcZbuq2u5QwkvYt4i0CMu4zHgEOSM2M2jDNMs56vK8rEvfN3qPb
         F4Hg8XFw5IC2FOVQjZ3LuWJt8zavJjwBR/qpIbbmzZsEsK29uL1+Pp3gLBoVK2fvaTQq
         M+Gg==
X-Gm-Message-State: AOJu0Yw/pqDc6LAqjgytHzxFxHvbBxj2IrPqCpZK+/g3t14yjhJo2ekn
	h+SkYgTJY5BpM7cmRZqO+2pb+WTE7fO3spxCN4c=
X-Google-Smtp-Source: AGHT+IG9Ae5/UiVZwK0rk+OwJPyVgrxOgWxduu+ajpjAQmCfaTw4WZvDWwvAcKA7feS7mkbMKSWS6w==
X-Received: by 2002:a05:6402:42cb:b0:53f:9d8a:414c with SMTP id i11-20020a05640242cb00b0053f9d8a414cmr1137864edc.37.1697793679595;
        Fri, 20 Oct 2023 02:21:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f30-20020a50a6de000000b0053dec545c8fsm1103383edc.3.2023.10.20.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 00/10] devlink: finish conversion to generated split_ops
Date: Fri, 20 Oct 2023 11:21:07 +0200
Message-ID: <20231020092117.622431-1-jiri@resnulli.us>
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

 Documentation/netlink/genetlink-legacy.yaml   |    4 +-
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
 26 files changed, 10645 insertions(+), 1661 deletions(-)

-- 
2.41.0


