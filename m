Return-Path: <netdev+bounces-34530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C77A47A2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3928162E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F938FB7;
	Mon, 18 Sep 2023 10:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DB6AA4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:54:50 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DEE185
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53136a13cd4so486811a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695034458; x=1695639258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pf5wvq76rTYu610hYxA3NwqrHlYVQBRI28VDSbQ8VuQ=;
        b=n9Zn/LFDhMu0YV0xftr8Ss/mn7k8YJp+5p3OpEg+S9HZW6EpZI1vceDkCbeBUiwDFJ
         EqCy6Yp0DzyNqjht9V/6J5z3IfVCzA9/gMq1ISbwoUyPrr5ksPu95+Mk4mE0DWI423el
         CkAR15f2Yhk4rpT6IzZhpXnv+RMrC6qGKzMogGlXLhdIo0ezN2aOVx0CBeFS1P5RSiz8
         AmPCP0H9uYC8Zzpf/F9C9dUBiRPQd9WAVqgRAUd0GjDGzrJVLDR4tNvE3fxBZFLo2Oag
         2SgsGuOkY4FkEzJ1uEVmD3D+3yRbskbAbp5ecJ53qqdKzVJFRV8pHlZTtWE7XnoY3+4v
         1KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034458; x=1695639258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf5wvq76rTYu610hYxA3NwqrHlYVQBRI28VDSbQ8VuQ=;
        b=RWFgl5lbUUsUWLQfPndE85S2+yZTQSAx99dAMuTwoH2AFiPv/U85Mu4lxK3Gj1wrhM
         z7kp5axzYUJtzmmebWhf8OWqiBQtZNnKB0kgW0eJ6EOkENdx2EmwC960CpwSNUqd/GSC
         /Jqm9ok90B9BLaLUqh3xJKl0EmX40E/SlXAClrmOmAZf5n6SgSVGy1tuVIzciWy5GCkr
         I4uLrewChOVgtjFrqyJqua2ZSNc1jgaEZF5DZ+GlI/dsfbQcaVrik75rXUpW1KmB5EF1
         OCbkPylB73wGRAwq+8zCmxvAQGxgy66syf4XNjgdJwURi/c6kQP7uVlQOXJUhVKJFGU0
         JRFQ==
X-Gm-Message-State: AOJu0Yzo900ICQxIFpHclWTfyy9nZMtEaYV1dLyw6zKZI54ml5ekaAGd
	v9LcIrsjfH+gHr8moFRac5ZjjOkoyTa/HK51xFI=
X-Google-Smtp-Source: AGHT+IGqZAEQtK5rvgCLL9PUqmq2gqtVoTqYLtmQvEkXX48B3QOkOsMm7OXOF6p7s0RFGv08Vd3DfQ==
X-Received: by 2002:aa7:d8d7:0:b0:52b:d169:b374 with SMTP id k23-20020aa7d8d7000000b0052bd169b374mr6956403eds.3.1695034458259;
        Mon, 18 Sep 2023 03:54:18 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v16-20020aa7d9d0000000b0052f3471ccf6sm5954407eds.6.2023.09.18.03.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 0/4] expose devlink instances relationships
Date: Mon, 18 Sep 2023 12:54:12 +0200
Message-ID: <20230918105416.1107260-1-jiri@resnulli.us>
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

Jiri Pirko (4):
  devlink: update headers
  devlink: introduce support for netns id for nested handle
  devlink: print nested handle for port function
  devlink: print nested devlink handle for devlink dev

 devlink/devlink.c            | 153 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/devlink.h |   1 +
 2 files changed, 150 insertions(+), 4 deletions(-)

-- 
2.41.0


