Return-Path: <netdev+bounces-46369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A57E364D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFBFB20E85
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39518DF5B;
	Tue,  7 Nov 2023 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N22+v+1X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD20D306
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:13 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7CFD
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso8986113a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344369; x=1699949169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLBVKdL1CxGWV7zx7UfnDA1WtRwChb9AevQmSHi4FTU=;
        b=N22+v+1XXJJwCgTlh88f7sFR3xij9rzSLiOzZta8B4vEhjE350Vf0UA5YaC4sgisH4
         Y9fqJG176xycrvle3vn7b00zQv1XJKL5ZC9nCBVq0gO4xxvyDMzrqcq5ceLy+H71yT9o
         02nMBQg30mRkXdB8GGmdbSgd4bqj8Df6SRA8mOWs3kg07iiuvjadOkqKCQQMNWlQgqdx
         mdjn7bDF/+3SGp/hEZGpMLU+7H6tF8ukcnel5jP3A8LD8Rq0NzhwZuPnYU3NhjhAFKRm
         B7zxlsQWgitJiJFLNLsH8aMopwzGx7N2lZ2KuUFNz6OAmcO2PVlib7bpj1ChpwHrPiZK
         AzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344369; x=1699949169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLBVKdL1CxGWV7zx7UfnDA1WtRwChb9AevQmSHi4FTU=;
        b=KFyMLqgNFBPX9dsz71JBY6aTMwxzUfJu6S9jqiuZrMT4vGzlOK5tfsNqFC/FywoEbo
         CrHdxHHZU6PP8luwk2l3UqKQNPV5Jn5usNQNyFKc5THYRF1j6fgPeAxc9qF+JKDJQfRn
         rTvTHdRemLu3hrwaA6mEJllqiiEd4WZnPxglb4RbYMtY0LyLyaHtXxLrftaYU6aNWKkJ
         0QsnOYgorWwXSHszaDWdU/TSA1Tqjnlvdz0tahR66/y1BPJRiIlFyoLmgzh4wy6jGC90
         +iwkfw2QkVHbIafJL6jJMO0oKQDjckla65EHvY6uyLhUfCmPQmjyOVUuSSfUvNgzhiPo
         gPgA==
X-Gm-Message-State: AOJu0YxuzbaUTX/ZABHmWCJqFEgTZ9w1rN4qjy9h6YbkkgnfI3F08iOj
	rLMZS3uwY+inTnZTjMT5G97xouLbDKbpVXvueAQ=
X-Google-Smtp-Source: AGHT+IGPfWsFepDoljLUNTpzlMCFk3MmmOjRNmMNxFWMZiTk7wExVAvCO5hyvagH6lKhw7F0zOxijg==
X-Received: by 2002:a17:907:c085:b0:9d0:2e6b:f47f with SMTP id st5-20020a170907c08500b009d02e6bf47fmr16284449ejc.36.1699344368526;
        Tue, 07 Nov 2023 00:06:08 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id gh10-20020a170906e08a00b009c6a4a5ac80sm724528ejb.169.2023.11.07.00.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:08 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 0/7] expose devlink instances relationships
Date: Tue,  7 Nov 2023 09:06:00 +0100
Message-ID: <20231107080607.190414-1-jiri@resnulli.us>
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
v4->v5:
- fixed dcb compile warn cause by missing header include
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
 include/namespace.h |   4 ++
 ip/ipnetns.c        |  45 +-------------
 lib/namespace.c     |  83 ++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 75 deletions(-)

-- 
2.41.0


