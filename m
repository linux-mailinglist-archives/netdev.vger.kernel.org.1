Return-Path: <netdev+bounces-19484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B575AE28
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF271C213CD
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA651800D;
	Thu, 20 Jul 2023 12:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0918000
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:18:35 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85092106
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so5588315e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689855511; x=1690460311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A07ibyfLvXpWUJ9yLyQc28373rV8mXUUeIoEVcXIec8=;
        b=ceT+gKj+JuK/UQpDtfQaXTZBJxi0SGYxQPx8c5qjeZXwP3sLrk6bs2zTLobdOfB89j
         mdzL5NUe1Ns3ksu2zvi7FqcPKQkpefYa1a4qqtGCQke2hsh24SE9VgwlGQK8Nf6Vs1/a
         lfhmRvmAjr8DLrVg8/s24hkwhZoLc2FTDnufWQaMCEo9OGh3h0iWxl5mC4SPopkfNFlI
         IGk9SEclcnpAz5RDEj7Zhyj7XIrsHcXRHNV/gPZAFhHL27ZLhZ53yJrvaviW6VpJphwP
         6phu/3vOSk7dvP1xsZ/Dsac5Sn3/wMXCx0uDetLvdE21YzX6za/alEgHC6GRdN2Oc7ND
         QR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855511; x=1690460311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A07ibyfLvXpWUJ9yLyQc28373rV8mXUUeIoEVcXIec8=;
        b=D5IU5/Yb+H0dqdJ1kwKlvM8idNadWjuF0wmYfCs2C3v50eBl5CZnfnwBEiBBxWqXKp
         iALAuh5ZnCOtAYRC1H0io3PzupQ6xuv4J2aX2q2fwgqQqirheK7+fZLY64qdlG2xU+yQ
         3L06P8vpyjf6xSizxGlz8PqiJxq0DNpju3FouRG+iOecwG1UbT6q9aQVj3c0bjwFv0L3
         quHO6iWCmorwgK7uuHmFDY1mTPtQ+wMqzRgOtppTZItbUYHSqOWcFJ2s/znZin9LP/Fa
         xb4YOU9jBmwPxC0ydSqiWS/mDAAvkbbR0qf5GW2oQ6tHHA7PyvXkvNW9fSCtevgSEgvd
         Zt5w==
X-Gm-Message-State: ABy/qLZyaFh+tUgjBvXmO3F4dRzW6DfCswdHLCYprSJskjjijICD0QR1
	aVV+VhzIiPFP6+gPXGAJAO+nuEVuWx92HUECbn0=
X-Google-Smtp-Source: APBJJlHNIhS51jpsfuJEqwwMBfwrs0t+JzHsx305V8iQfcVFu1F8AwgBQh7mM0gZ2PnpIo0WSvBAtA==
X-Received: by 2002:a7b:cb8e:0:b0:3fc:4e0:caf8 with SMTP id m14-20020a7bcb8e000000b003fc04e0caf8mr1578592wmi.34.1689855511074;
        Thu, 20 Jul 2023 05:18:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b003fbc681c8d1sm3806587wmi.36.2023.07.20.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:18:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 00/11] devlink: introduce dump selector attr and use it for per-instance dumps
Date: Thu, 20 Jul 2023 14:18:18 +0200
Message-ID: <20230720121829.566974-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Motivation:

For SFs, one devlink instance per SF is created. There might be
thousands of these on a single host. When a user needs to know port
handle for specific SF, he needs to dump all devlink ports on the host
which does not scale good.

Solution:

Allow user to pass devlink handle alongside the dump command
and dump only objects which are under selected devlink instance.

Introduce new attr DEVLINK_ATTR_DUMP_SELECTOR to nest the selection
attributes. This way the userspace can use maxattr to tell if dump
selector is supported by kernel or not.

Assemble netlink policy for selector attribute. If user passes attr
unknown to kernel, netlink validation errors out.

Example:
$ devlink port show
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

$ devlink port show auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false

$ devlink port show auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

This is done in patch #10

Dependency:

The DEVLINK_ATTR_DUMP_SELECTOR parsing is very suitable to be done
once at the beginning of the dumping. Unfortunatelly, it is not possible
to define start() and done() callbacks for netlink small ops.
So all commands that use instance iterator for dumpit are converted to
split ops. This is done in patch #1-9

Extension:

patch #11 extends the selector by port index for health reporter
dumping.

v1->v2:
- the original single patch (patch #10) was extended to a patchset

Jiri Pirko (11):
  devlink: parse linecard attr in doit() callbacks
  devlink: parse rate attrs in doit() callbacks
  devlink: introduce __devlink_nl_pre_doit() with internal flags as
    function arg
  devlink: convert port get command to split ops
  devlink: convert health reporter get command to split ops
  devlink: convert param get command to split ops
  devlink: convert trap get command to split ops
  devlink: introduce set of macros and use it for split ops definitions
  devlink: convert rest of the iterator dumpit commands to split ops
  devlink: introduce dump selector attr and use it for per-instance
    dumps
  devlink: extend health reporter dump selector by port index

 include/uapi/linux/devlink.h |   2 +
 net/devlink/devl_internal.h  |  42 +++---
 net/devlink/health.c         |  21 ++-
 net/devlink/leftover.c       | 211 ++++++++--------------------
 net/devlink/netlink.c        | 263 ++++++++++++++++++++++++++++++-----
 5 files changed, 333 insertions(+), 206 deletions(-)

-- 
2.41.0


