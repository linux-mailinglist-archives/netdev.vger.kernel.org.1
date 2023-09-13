Return-Path: <netdev+bounces-33451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EE79E086
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583CE281C88
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7218026;
	Wed, 13 Sep 2023 07:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E7156C5
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:48 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6A1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31f915c3c42so3944947f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589166; x=1695193966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhA7D+NexyxGAn+74XDsdY1YOun0EK987erpU9uumqk=;
        b=J4GrUx2RVunHt3RsESCnKnJghKwZ6ZOR1rHsqr9TqMzp51PyCD2a9FO1KbAy8pr2U1
         SDmj3wE/TZp0p1YEMWXTEGktBHsVYVIaBJScQHqXPRUz3OKaB0mAPJLBoq8n9XsOzDjs
         nEAw3l3mHBlRRbIZMKEHX426NB5undidvZ2ZVXexAWeijOdUIYCNencJJyi+a5AOwKh8
         6MRY2vNwpDByAL6MRnx4pf/WTYdHqlmCGNr8deduN78cCzOMckbtYUmIB4iqquEyKfdf
         BsKSxgB08E6tx2PV1El8fz7eBZnDTgJ5Cr/fQPTMNZbLiniJz17oWrUuqUfU2NxQFekW
         vELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589166; x=1695193966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhA7D+NexyxGAn+74XDsdY1YOun0EK987erpU9uumqk=;
        b=wwMloidezqyGFsFonf9Ng2Ebky3oqxvf4Rj3HP8idWDa5tzqmsWCDKM70pw0oe41fe
         pIjR5Y4N/c90U02mf7kDEP4xm6zmBa5hL2yRHS0TO4Efqj17EE4zfHNQYlb72fQs4glz
         3wQpMCPJ8AWnzL6V5gBn1NySR+9XHdRTwjaGD1H8uQZ2NVm2V/0jOZmA9fYKZwH0UZo0
         deP8vC9ps53NzEzhclW05N7/gVn2rVHBPesfepQvrhGrmrpw3WJnB9kmSeaiowb9Li76
         zjwDj9UbnoFiQ+09aCcH17zkkceqUYrzgwZa217Q4QvxeO5tzc/6VI1sZ9/Yeuim4wkw
         R2uQ==
X-Gm-Message-State: AOJu0YyIaqm1H5Vn2jhfK92yG3KIIBLFjJA4LiA+qlCYtzS8XXsn1Fwa
	2nhnoRlAS1SroSWSq0ShAqdUo1dJfY1gdDoJfhU=
X-Google-Smtp-Source: AGHT+IHv9uqzLGJKVxcS+Rk2e0oQTfVXWBG+UkLo+6F8v+kqpkkTg16iSvMIpnO/VPqd9w/8WtVgZQ==
X-Received: by 2002:adf:a387:0:b0:31f:c8a0:1134 with SMTP id l7-20020adfa387000000b0031fc8a01134mr466280wrb.32.1694589165979;
        Wed, 13 Sep 2023 00:12:45 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b00319779ee691sm14480910wro.28.2023.09.13.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:45 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 00/12] expose devlink instances relationships
Date: Wed, 13 Sep 2023 09:12:31 +0200
Message-ID: <20230913071243.930265-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, the user can instantiate new SF using "devlink port add"
command. That creates an E-switch representor devlink port.

When user activates this SF, there is an auxiliary device created and
probed for it which leads to SF devlink instance creation.

There is 1:1 relationship between E-switch representor devlink port and
the SF auxiliary device devlink instance.

Also, for example in mlx5, one devlink instance is created for
PCI device and one is created for an auxiliary device that represents
the uplink port. The relation between these is invisible to the user.

Patches #1-#3 and #5 are small preparations.

Patch #4 adds netnsid attribute for nested devlink if that in a
different namespace.

Patch #5 is the main one in this set, introduces the relationship
tracking infrastructure later on used to track SFs, linecards and
devlink instance relationships with nested devlink instances.

Expose the relation to the user by introducing new netlink attribute
DEVLINK_PORT_FN_ATTR_DEVLINK which contains the devlink instance related
to devlink port function. This is done by patch #8.
Patch #9 implements this in mlx5 driver.

Patch #10 converts the linecard nested devlink handling to the newly
introduced rel infrastructure.

Patch #11 benefits from the rel infra and introduces possiblitily to
have relation between devlink instances.
Patch #12 implements this in mlx5 driver.

Examples:
$ devlink dev
pci/0000:08:00.0: nested_devlink auxiliary/mlx5_core.eth.0
pci/0000:08:00.1: nested_devlink auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.0

$ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 106
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
$ devlink port function set pci/0000:08:00.0/32768 state active
$ devlink port show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable nested_devlink auxiliary/mlx5_core.sf.2

# devlink dev reload auxiliary/mlx5_core.sf.2 netns ns1
$ devlink port show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768: type eth netdev eth4 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable nested_devlink auxiliary/mlx5_core.sf.2 nested_devlink_netns ns1

Jiri Pirko (12):
  devlink: move linecard struct into linecard.c
  net/mlx5: Disable eswitch as the first thing in mlx5_unload()
  net/mlx5: Lift reload limitation when SFs are present
  devlink: put netnsid to nested handle
  devlink: move devlink_nl_put_nested_handle() into netlink.c
  devlink: extend devlink_nl_put_nested_handle() with attrtype arg
  devlink: introduce object and nested devlink relationship infra
  devlink: expose peer SF devlink instance
  net/mlx5: SF, Implement peer devlink set for SF representor devlink
    port
  devlink: convert linecard nested devlink to new rel infrastructure
  devlink: introduce possibility to expose info about nested devlinks
  net/mlx5e: Set en auxiliary devlink instance as nested

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  11 -
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |   8 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.h  |   6 +
 .../mellanox/mlx5/core/sf/dev/driver.c        |  26 +++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  34 +++
 .../mellanox/mlxsw/core_linecard_dev.c        |   9 +-
 include/linux/mlx5/device.h                   |   1 +
 include/net/devlink.h                         |   9 +-
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/core.c                            | 217 ++++++++++++++++++
 net/devlink/dev.c                             |  50 ++++
 net/devlink/devl_internal.h                   |  34 +--
 net/devlink/linecard.c                        |  80 ++++---
 net/devlink/netlink.c                         |  26 +++
 net/devlink/port.c                            |  55 ++++-
 16 files changed, 509 insertions(+), 60 deletions(-)

-- 
2.41.0


