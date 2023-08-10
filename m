Return-Path: <netdev+bounces-26344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E7777957
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BCD1C2151B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A761E1C8;
	Thu, 10 Aug 2023 13:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CB1FA3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:45 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0489810E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317f1c480eeso856019f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673341; x=1692278141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIG6MGuNTAT0hdnnoX4sqX3imK+uc7mN5pSAJJ8HDco=;
        b=5ZmzQNAr6Sv9BYhCgP2PtS9t2QJrXSE+XzmvtWjKuOPKecLtFLZ5Td3jStc5ltRoIt
         cdymUzgJ1DmhYPqal6Hr+HOycGwqkEA4de/qZ9tf3ijqPie6HZCFeKyQlYIDxp7uuvPb
         IjXK38hDWmWq+kQ0rDRB0BC6SlxV84GbwT3W9AOYgHrKTnL73uHPzh7CH63EfgF2kGvY
         +ZnSqKV0iuUA8I3K3RdbfapWkyJr5zLjtFTOO2KhGXTrOhTzSm3rkt8NYL/XHnPwM92D
         MrxOgWVenq5JscKGXdmKjIbWL/M/pfEjpD9cd2MnpdgFt9ZYOuZmkZmnbaH/u6RqN0Jq
         jh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673341; x=1692278141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIG6MGuNTAT0hdnnoX4sqX3imK+uc7mN5pSAJJ8HDco=;
        b=H5oZfHhKjOGOJDmuo5c+CCVb39pMLAJ80KIkgJKJ9lFvL093R94KNmdhIGfj0+ZBCs
         72tmjUL0pFSbfusj1vvxjtB/gp7XFwZCwY4rfbivbXp8+SqOUj13pDePYLmMhvFrk/V0
         xHKKohCllQSJieIEh1pO5RqYbIiet9oF28EHbaPatI7wQtEGhC1QFz3lOlMeqEpWTBBB
         eFUTkhtac4njhxn/5Mp2uS8SM9RLgmOQudbNY1hb6jAPz+jlP7M9ADyE4P2hdYyyjD20
         QUGXpc42/DGA5MeUN55/02Hpum2QHfFgSgTYkAIPQt4TYlkw/sPqQMEF+t2dyjpDmtra
         WIZQ==
X-Gm-Message-State: AOJu0YxQk+j5Z4kfijfCG5FKsKand4eUgBa07C8gMP9GzQ+hDqOu771E
	uJGwUs0yS9ABUa4HZsyx+3FrYHyLxA8EmTSnhUmupQ==
X-Google-Smtp-Source: AGHT+IEZzky3028dsVEejuyeG9l9vSD2/ZAJE+QGZyRtCVp+NvzAQ5cuUdR5DDm9E+0uzhqehScCkQ==
X-Received: by 2002:a5d:6512:0:b0:317:60a8:f3a7 with SMTP id x18-20020a5d6512000000b0031760a8f3a7mr2163650wru.10.1691673341381;
        Thu, 10 Aug 2023 06:15:41 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0031801aa34e2sm2204587wrv.9.2023.08.10.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:40 -0700 (PDT)
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
Subject: [patch net-next v3 00/13] devlink: introduce selective dumps
Date: Thu, 10 Aug 2023 15:15:26 +0200
Message-ID: <20230810131539.1602299-1-jiri@resnulli.us>
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
 net/devlink/health.c                     |   39 +-
 net/devlink/leftover.c                   |  419 ++--
 net/devlink/netlink.c                    |  112 +-
 net/devlink/netlink_gen.c                |  424 +++-
 net/devlink/netlink_gen.h                |   52 +-
 tools/net/ynl/generated/devlink-user.c   | 2434 +++++++++++++++++++++-
 tools/net/ynl/generated/devlink-user.h   | 1824 +++++++++++++++-
 10 files changed, 5328 insertions(+), 506 deletions(-)

-- 
2.41.0


