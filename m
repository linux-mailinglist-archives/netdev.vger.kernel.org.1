Return-Path: <netdev+bounces-48016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189157EC4ED
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493E21C20328
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262628DC1;
	Wed, 15 Nov 2023 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vfemBHDM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF141F958
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:31 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A411C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso10627069a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057847; x=1700662647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMMpjF6NOTQPUzKEPgJQ7kLRRjHqNnZRDBI5qtChAGU=;
        b=vfemBHDMeyLLrob/T/DpD57R//HpVMtkP06MtAIVMnljoOYU45gMq3HuGkFt5pynpz
         RnmclCY1A8nrexswHFnTTFOKyQV7UXQe5mLFZMZbrxuh8Hsxd0fFQG5Y/X4+pnLrvG2d
         gg5jttp1ZGVS15o9juqYAMgLGAcpJ33kX5LKQkxfWWNt1qBYx/DUWzLPlr6cC/RzZW+R
         Wjy8/82wJHorTJkKM3hLGHdODKAmK5duVOfqfNGAYkupST4JR1Qd6/l2BYSeFvDeDkdR
         5dU4hnFJGnPBHNMx5dnrb7WJlGkHJXyXET8naQR3BbvXZCjleS+8S8uyt1YjBQENnCHj
         wCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057847; x=1700662647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMMpjF6NOTQPUzKEPgJQ7kLRRjHqNnZRDBI5qtChAGU=;
        b=gvwwLjQzn1SOYtxeIRbXwtiknZLmD7K1BJ6b4S4Gz3EzT5j63nI1HAkieXumWL9L81
         CGLheVXjRYHzDNgzVC+/cK4gctFBlmECnbltJo49l8YSGaZQSY4mKPqmpkQJYVgd3lEN
         BMGAV+DluHvL+HzkI63uiebnX2qm1je7usF/6318DvY3umTRPTZNQFBp0UiR91K61lek
         LmJoI7IYiQCRKfHihfIdv2GVn/7K7Tz25BPpASozQkDOqaWoRlhv+HSEL8evkXhWn2Wr
         5tlNHvVrD0Le/xnXBGOPCjCN7AC4BM9gTWSM9Ln74gO56WTzpzMw6M6jxErzMVGDU5sa
         jjPA==
X-Gm-Message-State: AOJu0YzcLIsLodKFawQp5gRYY/hwvv5Cll6WI56Bih1Bv1Mv9iyUpNCd
	3NNSZRZ89hSrdJ7LQHM4WqYUX71yO+I19HCQxcY=
X-Google-Smtp-Source: AGHT+IEYz78BVV5xGSUQfPk00J/DNZNp2kCAAut6QRnAiEgVfThwx95zvdW7L1OszNNbIB+1SSY8Aw==
X-Received: by 2002:a17:906:fb8b:b0:9cf:f762:1911 with SMTP id lr11-20020a170906fb8b00b009cff7621911mr9635002ejb.66.1700057846913;
        Wed, 15 Nov 2023 06:17:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906414c00b009adc5802d08sm7081934ejk.190.2023.11.15.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:26 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com
Subject: [patch net-next 0/8] devlink: introduce notifications filtering
Date: Wed, 15 Nov 2023 15:17:16 +0100
Message-ID: <20231115141724.411507-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the user listening on a socket for devlink notifications
gets always all messages for all existing devlink instances and objects,
even if he is interested only in one of those. That may cause
unnecessary overhead on setups with thousands of instances present.

User is currently able to narrow down the devlink objects replies
to dump commands by specifying select attributes.

Allow similar approach for notifications providing user a new
notify-filter-set command to select attributes with values
the notification message has to match. In that case, it is delivered
to the socket.

Note that the filtering is done per-socket, so multiple users may
specify different selection of attributes with values.

This patchset initially introduces support for following attributes:
DEVLINK_ATTR_BUS_NAME
DEVLINK_ATTR_DEV_NAME
DEVLINK_ATTR_PORT_INDEX

Patches #1 - #4 are preparations in devlink code, patch #3 is
                an optimization done on the way.
Patches #5 and #6 are preparations in netlink and generic netlink code.
Patch #7 is the main one in this set implementing of
         the notify-filter-set command and the actual
	 per-socket filtering.
Patch #8 extends the infrastructure allowing to filter according
         to a port index.

Example:
$ devlink mon port pci/0000:08:00.0/32768
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,del] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable

Jiri Pirko (8):
  devlink: use devl_is_registered() helper instead xa_get_mark()
  devlink: introduce __devl_is_registered() helper and use it instead of
    xa_get_mark()
  devlink: send notifications only if there are listeners
  devlink: introduce a helper for netlink multicast send
  genetlink: implement release callback and free sk_user_data there
  genetlink: introduce helpers to do filtered multicast
  devlink: add a command to set notification filter and use it for
    multicasts
  devlink: extend multicast filtering by port index

 Documentation/netlink/specs/devlink.yaml | 11 ++++
 include/net/genetlink.h                  | 35 +++++++++--
 include/net/netlink.h                    | 31 ++++++++--
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/dev.c                        | 13 ++--
 net/devlink/devl_internal.h              | 58 +++++++++++++++++-
 net/devlink/health.c                     | 10 ++-
 net/devlink/linecard.c                   |  5 +-
 net/devlink/netlink.c                    | 77 ++++++++++++++++++++++++
 net/devlink/netlink_gen.c                | 16 ++++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/param.c                      |  5 +-
 net/devlink/port.c                       |  8 ++-
 net/devlink/rate.c                       |  5 +-
 net/devlink/region.c                     |  6 +-
 net/devlink/trap.c                       | 18 +++---
 net/netlink/genetlink.c                  |  6 ++
 tools/net/ynl/generated/devlink-user.c   | 33 ++++++++++
 tools/net/ynl/generated/devlink-user.h   | 56 +++++++++++++++++
 19 files changed, 356 insertions(+), 43 deletions(-)

-- 
2.41.0


