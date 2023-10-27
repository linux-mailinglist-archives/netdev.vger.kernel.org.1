Return-Path: <netdev+bounces-44704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB47D94E6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F81C20FDC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FF917993;
	Fri, 27 Oct 2023 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bLwougTJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9471775B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:11 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A9D7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6255621a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401646; x=1699006446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcDx244Mqsz+a9Tv2vFWjuWGcT3cu8POivc0EJyaqdI=;
        b=bLwougTJeZ/BwyR4rd+AGu6oNYHm032+eYhMDGjrRtYvKdK+8Xy/3OZ6MoZocXNotR
         ryyilUhGo4Vg7E5NySHSjPactXNmtQFiAhP4eFnRXcEi6lmAd8+ck3z5ZS4hSLvFjXwA
         ARvYr6BaJYSU47UObgacjeVttwq+jkYLdxviYvhksI0T4RQ2LS/8BL1rwpIouvJ8FsYB
         unPC1n3JIVTWYH/1myFmIPu7Z7htgLyVb+niUuzN3G9jdasGH6g1q2EvGHSy0d40uaaO
         adUzi8xJXszyASqo0BIWNGDtffTuyzlAAXIbjwk745xnt78Um5FrN/7J6IBogzUYixMM
         RFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401646; x=1699006446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcDx244Mqsz+a9Tv2vFWjuWGcT3cu8POivc0EJyaqdI=;
        b=NFH0c5kjhtK2Va0jtJknuVWBaME5+Kg/kKoakeLz90JUuRdjmJ9/TuPl/bY+7wTUrH
         X1tpytzhlnBHTxohVaKfGJzJpzVQn4EIiq+UtY2tC5As80spZYznKg+UI4/f9YeOrv7q
         dHtFTyW7vojmLnZhPhPIJNcaBw6Uat/XyK45R0mUdx1lde58NQ9qKDXIsJeW7lLpwDSL
         eYc32PnwHPb+d1ggJjfkQuAvOn/O9xKJdPwK9ecgbjOwFkgUFnbWCnV6SyBywJU4iT6a
         +M0Xp2Q0kxCjvLJanhrQgS+nbSuCxmcx8QrGxQdw6PSBPBcKy69RYrzisvWG8EUpWRUD
         uxQg==
X-Gm-Message-State: AOJu0YzW3r4nToQ/jFR+3wSkFVcalZuL+6y98Lah44+82w6JiIOUqXI0
	pfkX3JxoVZ1zNNTKURkw16YpgPquCYwlLHleHe4RSw==
X-Google-Smtp-Source: AGHT+IGxWuBhbyA7uWWqjbYEchnseX8ezjW04XzmJwX14BUtnYrzZpNWZ+vwCgUzcV5w5148MJDDQQ==
X-Received: by 2002:a17:906:6a0e:b0:9a5:7dec:fab9 with SMTP id qw14-20020a1709066a0e00b009a57decfab9mr5352876ejc.9.1698401645805;
        Fri, 27 Oct 2023 03:14:05 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709065acf00b0099bcf9c2ec6sm964887ejs.75.2023.10.27.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 0/7] expose devlink instances relationships
Date: Fri, 27 Oct 2023 12:13:56 +0200
Message-ID: <20231027101403.958745-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Print out recently added attributes that expose relationships between
devlink instances. This patchset extends the outputs by
"nested_devlink" attributes.

Examples:
$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

$ devlink dev -j -p
{
    "dev": {
        "pci/0000:08:00.0": {
            "nested_devlink": {
                "auxiliary/mlx5_core.eth.0": {}
            }
        },
        "auxiliary/mlx5_core.eth.0": {},
        "pci/0000:08:00.1": {
            "nested_devlink": {
                "auxiliary/mlx5_core.eth.1": {}
            }
        },
        "auxiliary/mlx5_core.eth.1": {}
    }
}

$ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 106
pci/0000:08:00.0/32768: type eth netdev eth2 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
$ devlink port function set pci/0000:08:00.0/32768 state active
$ devlink port show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768: type eth netdev eth2 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable
      nested_devlink:
        auxiliary/mlx5_core.sf.2
$ devlink port show pci/0000:08:00.0/32768 -j -p
{
    "port": {
        "pci/0000:08:00.0/32768": {
            "type": "eth",
            "netdev": "eth2",
            "flavour": "pcisf",
            "controller": 0,
            "pfnum": 0,
            "sfnum": 106,
            "splittable": false,
            "function": {
                "hw_addr": "00:00:00:00:00:00",
                "state": "active",
                "opstate": "attached",
                "roce": "enable",
                "nested_devlink": {
                    "auxiliary/mlx5_core.sf.2": {}
                }
            }
        }
    }
}

$ devlink dev reload auxiliary/mlx5_core.sf.2 netns ns1
$ devlink port show pci/0000:08:00.0/32768
pci/0000:08:00.0/32768: type eth netdev eth2 flavour pcisf controller 0 pfnum 0 sfnum 106 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state active opstate attached roce enable
      nested_devlink:
        auxiliary/mlx5_core.sf.2: netns ns1
$ devlink port show pci/0000:08:00.0/32768 -j -p
{
    "port": {
        "pci/0000:08:00.0/32768": {
            "type": "eth",
            "netdev": "eth2",
            "flavour": "pcisf",
            "controller": 0,
            "pfnum": 0,
            "sfnum": 106,
            "splittable": false,
            "function": {
                "hw_addr": "00:00:00:00:00:00",
                "state": "active",
                "opstate": "attached",
                "roce": "enable",
                "nested_devlink": {
                    "auxiliary/mlx5_core.sf.2": {
                        "netns": "ns1"
                    }
                }
            }
        }
    }
}

---
v3->v4
- removed namespace.h include from patch #1
- added patch #2
v2->v3:
- the output format is changed to treat the nested handle in a similar
  way as the dev_handle/port_handle allowing to contain attrs, like
  netns. See examples
- couple of details
- see individual patches for more details
v1->v2:
- patch #2 was added
- patch #3 uses new helper added by patch #2, typo is fixed

Jiri Pirko (7):
  ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
  devlink: use snprintf instead of sprintf
  devlink: do conditional new line print in pr_out_port_handle_end()
  devlink: extend pr_out_nested_handle() to print object
  devlink: introduce support for netns id for nested handle
  devlink: print nested handle for port function
  devlink: print nested devlink handle for devlink dev

 devlink/devlink.c   | 140 ++++++++++++++++++++++++++++++++++----------
 include/namespace.h |   3 +
 ip/ipnetns.c        |  45 +-------------
 lib/namespace.c     |  83 ++++++++++++++++++++++++++
 4 files changed, 196 insertions(+), 75 deletions(-)

-- 
2.41.0


