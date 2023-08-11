Return-Path: <netdev+bounces-26852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE3779391
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB11E282227
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099F2AB50;
	Fri, 11 Aug 2023 15:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1065692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:57:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA94270F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so19183095e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691769436; x=1692374236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6ude95TTG8bPb51iCiKbHfIBzK+PtXWCvCjnwGJf2E=;
        b=P4rNfgBIc+6qiD5ouwSzJy1jD++wmSlcQwGMq7UFtbQLAU2e86MsIG+LjLjbq2pA1U
         H3gd/McXFB5r00n16oWtaPZU3yq/k/UhA9ZWHb3QfHjiFurekv6vtZabfVUm+1IvdKdE
         jZJ9JkAAFxBGccGhYga1LD+nMHyWMyg02mZQTzN6ypaMfwzr4HHrWf5aw6okNmRwQSUN
         LHXv2hBI+i1DgmEp+EvQGSKSXl7QZ6iR26UglUpwlGPqBnD/N5ab6h/2rd98Mvxw3Yue
         TcKsvRyX3zKAgP2jr6K7gwb4LLCWCnahsFLGMMEQZj2N1OPVkGGMME59fsc0Vtdmf+o9
         SY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769436; x=1692374236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6ude95TTG8bPb51iCiKbHfIBzK+PtXWCvCjnwGJf2E=;
        b=fgtWg5LXJfvJHcrMYeVvnyDseTz2godREtLkp0RDn3i6qCsxxFiGQYikiTW5Hkg8SQ
         v50dwUlB6MDukKKN65LgjNLjgMn7zoNCF1X1ceoteLBzn357tzA22nS7IkHOek/8oUFM
         AgnLbz8EQwMlYUM30Alb/6mjn76RHlIxUcG7HiAuT9HrKH0U6kNaC7suRHdC5N9eXAc3
         MO5EOM5MCVSe95qrx7B6JQcL3AdKIeDKfAw5klKxtOK1yT+22iB/zj/RM/MICmSDgBqF
         LEhckECk3obJn8PNgfepCX4KPkQwImgPftXF5HmzREZQVwDX0BXGGC0T3tHgtQyzkCK0
         Itgg==
X-Gm-Message-State: AOJu0YwxNpEGVgf49oF5Rnfoe7EvTtOLPQBfH4WWrm0CCEc8RvVJV0Tw
	mdT5geLfaO5PjJQF+2EMY9oSOBoX1mv6frvg1zXZqw==
X-Google-Smtp-Source: AGHT+IFbO8kRNv8EoX3QJpO5qY2FNjgdLTS3VgsiqhHYLTJ8l02o+oqg74lUfWj+dVZiR/leIaHiXA==
X-Received: by 2002:a7b:cd97:0:b0:3fe:4900:db95 with SMTP id y23-20020a7bcd97000000b003fe4900db95mr2019892wmj.37.1691769436443;
        Fri, 11 Aug 2023 08:57:16 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5546000000b003142e438e8csm5833461wrw.26.2023.08.11.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:57:15 -0700 (PDT)
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
Subject: [patch net-next v4 00/13] devlink: introduce selective dumps
Date: Fri, 11 Aug 2023 17:57:01 +0200
Message-ID: <20230811155714.1736405-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Motivation:

For SFs, one devlink instance per SF is created. There might be
thousands of these on a single host. When a user needs to know port
handle for specific SF, he needs to dump all devlink ports on the host
which does not scale good.

Solution:

Allow user to pass devlink handle (and possibly other attributes)
alongside the dump command and dump only objects which are matching
the selection.

Use split ops to generate policies for dump callbacks acccording to
the attributes used for selection.

The userspace can use ctrl genetlink GET_POLICY command to find out if
the selective dumps are supported by kernel for particular command.

Example:
$ devlink port show
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

$ devlink port show auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false

$ devlink port show auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false

Extension:

patches #12 and #13 extends selection attributes by port index
for health reporter dumping.

---
v3->v4:
- fixed NLM_F_DUMP_FILTERED flag handling
v2->v3:
- redid the whole thing using generated split ops and removed nested
  selector attribute as suggested by Jakub. More in individual patches.
v1->v2:
- the original single patch (patch #10) was extended to a patchset

Jiri Pirko (13):
  devlink: parse linecard attr in doit() callbacks
  devlink: parse rate attrs in doit() callbacks
  devlink: introduce devlink_nl_pre_doit_port*() helper functions
  devlink: rename doit callbacks for per-instance dump commands
  devlink: introduce dumpit callbacks for split ops
  devlink: pass flags as an arg of dump_one() callback
  netlink: specs: devlink: add commands that do per-instance dump
  devlink: remove duplicate temporary netlink callback prototypes
  devlink: remove converted commands from small ops
  devlink: allow user to narrow per-instance dumps by passing handle
    attrs
  netlink: specs: devlink: extend per-instance dump commands to accept
    instance attributes
  devlink: extend health reporter dump selector by port index
  netlink: specs: devlink: extend health reporter dump attributes by
    port index

 Documentation/netlink/specs/devlink.yaml |  457 +++-
 net/devlink/dev.c                        |   29 +-
 net/devlink/devl_internal.h              |   44 +-
 net/devlink/health.c                     |   40 +-
 net/devlink/leftover.c                   |  419 ++--
 net/devlink/netlink.c                    |  110 +-
 net/devlink/netlink_gen.c                |  424 +++-
 net/devlink/netlink_gen.h                |   52 +-
 tools/net/ynl/generated/devlink-user.c   | 2434 +++++++++++++++++++++-
 tools/net/ynl/generated/devlink-user.h   | 1824 +++++++++++++++-
 10 files changed, 5327 insertions(+), 506 deletions(-)

-- 
2.41.0


