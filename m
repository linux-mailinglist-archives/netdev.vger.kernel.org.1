Return-Path: <netdev+bounces-34944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463C7A61CD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F01C20BEE
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00E15BE;
	Tue, 19 Sep 2023 11:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18E3FD4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:56:51 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840AE3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso5369941f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124607; x=1695729407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYcsoKmuAOYH1Dousqvl+I00OLRj+UXR05BdfP8aYI4=;
        b=jTWmVKCderPAW7wkhzXvNU2nBFw6ezwiOCMm7FozgF60n1wCKPrWpHBJP91wHGgD2e
         JXHHvH8Hi59zQ6idgAJ60pnp2iDW5LF/BONZIvw0mxOLHgQrb9l8V47B9ZAr02EmNWUh
         gKVFGaSVGut33R91FhmOzBz3s+Yz9Xea32ZF1+sITMwfjPf11cV1XUslArzirQJuj2GA
         CZfqChOj+m1/NT0g3c5z4zxi++5PxZYKqV+3qRazKy7ePL9fVX0/KItnMwQw9hSfjmfi
         fnOBizYnxOJUMvuMF+yXhPm+u9EQSyIyBhvWeyopFspIilGawhAYqN+0jHmSgu+S6BZE
         7eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124607; x=1695729407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYcsoKmuAOYH1Dousqvl+I00OLRj+UXR05BdfP8aYI4=;
        b=pFXJAHTuaqua/62ezq6SUDj57xCq4bee0cuDCBE0li9Ijhy0b/K3tmwDLHC802kNyU
         WZ3+OnV5dP/IUDoYskY9IsWuO75mrWeowX0srbq4G0wrlp9o+XTD0xaKBEr2t9jvMXM9
         +BC2FvXpzXFZwQw3gmAjDKBmq+NS9fDM0Dpn+z5HuSRC5zFvre4D/961XgnZnOF6nS7t
         h8hpDkv+rV50ONSANqeslV3ntOcisl1I50cqLbtapQq1srqsOl7OCtrOp1TiPHKMPHkH
         A0KJ4iKGSyOM5ef+Cxuo3BzEyWL+O+WyRUKNkwdNDjgXXiHCRnIGBQmnnTTywyuyM6h3
         A/+g==
X-Gm-Message-State: AOJu0YzPdhdQE9Qnsm4lnJXgLIivnmJcM1ObbbF4ACfR89QpSt5R1nkL
	3/UJe13fo5YuMNiGxF7j5uS96goL5LJTAoN17SA=
X-Google-Smtp-Source: AGHT+IEAtyhcoD4Ivx8mXsIUCg5Dqj3uwlgWiLFtWA8hjkl4Y7Ffj8hnGQq6ioutqm3uR5p8ynCHiA==
X-Received: by 2002:adf:fbd0:0:b0:31f:afeb:4e7e with SMTP id d16-20020adffbd0000000b0031fafeb4e7emr9530855wrs.37.1695124606937;
        Tue, 19 Sep 2023 04:56:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b0031c5ce91ad6sm15362943wrr.97.2023.09.19.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:46 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 0/5] expose devlink instances relationships
Date: Tue, 19 Sep 2023 13:56:39 +0200
Message-ID: <20230919115644.1157890-1-jiri@resnulli.us>
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

Print out recently added attributes that expose relationships between
devlink instances. This patchset extends the outputs by
"nested_devlink" and "nested_devlink_netns" attributes.

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

---
v1->v2:
- patch #2 was added
- patch #3 uses new helper added by patch #2, typo is fixed

Jiri Pirko (5):
  devlink: update headers
  ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
  devlink: introduce support for netns id for nested handle
  devlink: print nested handle for port function
  devlink: print nested devlink handle for devlink dev

 devlink/devlink.c            | 108 +++++++++++++++++++++++++++++++++--
 include/namespace.h          |   4 ++
 include/uapi/linux/devlink.h |   1 +
 ip/ipnetns.c                 |  45 +--------------
 lib/namespace.c              |  49 ++++++++++++++++
 5 files changed, 159 insertions(+), 48 deletions(-)

-- 
2.41.0


