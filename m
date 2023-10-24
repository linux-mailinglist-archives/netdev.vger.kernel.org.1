Return-Path: <netdev+bounces-43795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2D7D4D36
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4880281884
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA60250EF;
	Tue, 24 Oct 2023 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ctovw/gG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4D250E5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:10 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD287DA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so6515748a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141845; x=1698746645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGRSD6BcL5oJCeCaFAyrgZoQEodhyBl5We6cHijxQzU=;
        b=Ctovw/gGIjCaOB06CR92e2ZlagQowULF9v3NcLktrIpQq6d2lxfc85jiOyBnbzhXyW
         RRnenmSZ58LpkucstewkY7UWKcSifSAdwJnemZnBsY+JZhQhOXsnIDcp0a6IrO0/OONt
         DfYngGIYqUzo51am7+QrJ1mSsKPgspe4U03ouy5I7UZf1BndxU+vjwc/AeVj2CO6tMrG
         nSIy/gvPIStpkMI3++JKGr4ISPWVYnhC0B+JaJntUPAuVn4bJ21Y+0fMT4f+T2Cr5Drj
         YnPdtzzHWtcQ3FfhrECSJMQNersdoqtClWZY9QrHFnGKsfmNvFyFb4uekARJkKd839LG
         yFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141845; x=1698746645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGRSD6BcL5oJCeCaFAyrgZoQEodhyBl5We6cHijxQzU=;
        b=Zb74qBNmkGArH9u74xIkxcxZofz9bLvS0kQcWIaEWo5OKvzdVMGyFh62/AGCpI9QXz
         EMiKiaE1Sx8Umcq7ktOdb+r8E46Dut6kKG9bTSeE4m0nUeVDja0NpGJeuJpBSB2ONKY9
         1oRjZA5gOM+h7a8dJg8WMxgRkJxD1qoEQOlGlHwWbS3RIi/gXT3TwtGIrzWLwJA/vqWk
         Ihpd1dzzFs5j1srlbytJ8wFA038bkqTaWqyCzoc9PZVtmhZyqry2T/7ypMA16atBBxjf
         B8OVEI3OGosuSH9oHM8XuiK3+1Q82TmjRn0IdT/FfS00EKXBYrb9I5DKtDo88Et7SrPh
         Qbwg==
X-Gm-Message-State: AOJu0Yxk9/Z2Ojb0WJfhheMIuzyXdqpLbsN+ZUbZhUQldOgUtuXtHDhM
	BCSfCImSFj3A9x2NeePqBZ7O+gZp7nfn/OQGEYpPRA==
X-Google-Smtp-Source: AGHT+IHSguQhRLOklYPeyqhodXzK9AFP+Gb/eA3udZT8KWMOAxPj6Ila+3LS0h6uEXSf1ReQhvehEA==
X-Received: by 2002:a17:907:97c2:b0:9c5:45f8:c529 with SMTP id js2-20020a17090797c200b009c545f8c529mr8200645ejc.20.1698141845077;
        Tue, 24 Oct 2023 03:04:05 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906110e00b009cc1227f443sm908244eja.104.2023.10.24.03.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 0/6] expose devlink instances relationships
Date: Tue, 24 Oct 2023 12:03:57 +0200
Message-ID: <20231024100403.762862-1-jiri@resnulli.us>
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
v2->v3:
- the output format is changed to treat the nested handle in a similar
  way as the dev_handle/port_handle allowing to contain attrs, like
  netns. See examples
- couple of details
- see individual patches for more details
v1->v2:
- patch #2 was added
- patch #3 uses new helper added by patch #2, typo is fixed

Jiri Pirko (6):
  ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
  devlink: do conditional new line print in pr_out_port_handle_end()
  devlink: extend pr_out_nested_handle() to print object
  devlink: introduce support for netns id for nested handle
  devlink: print nested handle for port function
  devlink: print nested devlink handle for devlink dev

 devlink/devlink.c   | 124 +++++++++++++++++++++++++++++++++++---------
 include/namespace.h |   5 ++
 ip/ipnetns.c        |  45 +---------------
 lib/namespace.c     |  83 +++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 68 deletions(-)

-- 
2.41.0


