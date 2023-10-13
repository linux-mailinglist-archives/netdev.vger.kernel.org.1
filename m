Return-Path: <netdev+bounces-40683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A877C8563
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA41C20A61
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80C1428D;
	Fri, 13 Oct 2023 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JHU3hOf+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9913FEC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:36 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CDBE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32caaa1c493so1648233f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199032; x=1697803832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHVfvO3MlPwgipBqf8fIUHB4tg3hP0RiE/TueHCrbc0=;
        b=JHU3hOf+AHBfijUVD1y45lfoX02gTakrnalwQpjGxK7+Pm4B20bDbbIB8zjj9Fffy+
         NUJbTu+SwLSYlB1JBPpe5cj1ZPLH4N+rXvrHN/BsLCAJ5w4ahTTcVAnqyugxX2Oyul5m
         takJoAGyHa12GTn5YmBkMHxrc1nELDMKNlpqSnR8Mkf9hJx5OZyU8OvkOaQLLgk1cW2k
         TTVgbzovQlgdlM7oRDJE5q/2CuFGdXxE0uXZm8kH104lCO0/eymNWtI2mMnB49OKEgew
         P73Un4va0fp75yGJU/7f8vPzAyu296ChIOq8kIP5sdPiykgkhbkwLdQHpmfkMyVlqIL2
         nYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199032; x=1697803832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHVfvO3MlPwgipBqf8fIUHB4tg3hP0RiE/TueHCrbc0=;
        b=Q1boXzbFDLB96OTNgnZeP0XngA7mJ1jr+KToJRkEdaSXc2K/2UGy/u2syUcc/kSDQv
         OHOgtZFCukWZykbFtNAOzzVLTxpjMQj+sAx6s5mtbQYcrto+3DergukSJOsmRoNe1x+I
         4FAVFgIYQhjGISTPQ5Gh2ODSGDh5IROHNnpCo+giuOYZOxQnT4C2eMokoKl23U70FReF
         kyqvT9nwZb0M4QBLCG7Nb29crBX249Rx+c+AfTFLh32BmePneiAxw//U1B/PG08B3jef
         1mgeso+2uR3a2TU7UcCorupIdkv8QFjxuvCzBj6lvabrGUPm5bOPBwKAMw1AoPio4EAa
         wmOQ==
X-Gm-Message-State: AOJu0YxilCmaWJ2O/YrjIhboHewqNPi6n7tNvVcO5IxbOLU8cxevK3Mk
	EzYTgS0NIw3z9Jqku++8C9MlBUPw3RgqG3vpRt4=
X-Google-Smtp-Source: AGHT+IHQHpzItosV4h5YaWT/r8JHnkbLxfcvBCJlc51C6rr6qQ4kgSRgDOIJI4O+Fpyvonn44MSGmQ==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id c11-20020adffb0b000000b0031fc1b5d4c1mr21576232wrr.35.1697199031765;
        Fri, 13 Oct 2023 05:10:31 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bq6-20020a5d5a06000000b0032d895d24desm6344931wrb.65.2023.10.13.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 0/7] devlink: fix a deadlock when taking devlink instance lock while holding RTNL lock
Date: Fri, 13 Oct 2023 14:10:22 +0200
Message-ID: <20231013121029.353351-1-jiri@resnulli.us>
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

devlink_port_fill() may be called sometimes with RTNL lock held.
When putting the nested port function devlink instance attrs,
current code takes nested devlink instance lock. In that case lock
ordering is wrong.

Patch #1 is a dependency of patch #2.
Patch #2 converts the peernet2id_alloc() call to rely in RCU so it could
         called without devlink instance lock.
Patch #3 takes device reference for devlink instance making sure that
         device does not disappear before devlink_release() is called.
Patch #4 benefits from the preparations done in patches #2 and #3 and
         removes the problematic nested devlink lock aquisition.
Patched #5-#7 improve documentation to reflect this issue so it is
              avoided in the future.

Jiri Pirko (7):
  net: treat possible_net_t net pointer as an RCU one and add
    read_pnet_rcu()
  devlink: call peernet2id_alloc() with net pointer under RCU read lock
  devlink: take device reference for devlink object
  devlink: don't take instance lock for nested handle put
  Documentation: devlink: add nested instance section
  Documentation: devlink: add a note about RTNL lock into locking
    section
  devlink: document devlink_rel_nested_in_notify() function

 Documentation/networking/devlink/index.rst | 28 ++++++++++++++++++
 include/net/net_namespace.h                | 15 ++++++++--
 net/devlink/core.c                         | 34 ++++++++++++----------
 net/devlink/netlink.c                      | 12 ++++++--
 4 files changed, 68 insertions(+), 21 deletions(-)

-- 
2.41.0


