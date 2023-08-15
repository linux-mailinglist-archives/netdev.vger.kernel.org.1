Return-Path: <netdev+bounces-27720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717A77D011
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300311C20D51
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F8156C0;
	Tue, 15 Aug 2023 16:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AB134AD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:26:23 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4262D1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a9918ec08so33700461cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692116780; x=1692721580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSo8JkNWnlvAsK6e+EDXfZDS1GveeIilj2Axf8e13BY=;
        b=t2oQPpDs6UWTpuyE9878BkI1eTxpgAG9DJ5fT9yiYoGClBNOSM5c6vtiws0a9tPVF8
         vr40pkgLxQUz5hbZNY5TS9btlpjhzEXOL7yxbMH+4fMN5Jsd7z5bFSVCMTLZBJmKCdAe
         kJYEae4DjF7oCDSswpW6PJyhc1GjUG82J4eHjIX7D5VJUrdnVmqENujN+DaUtvP82Sxj
         mB59ze2DXYWXLd1F0c+u5JalgtZEvr1NDIy+KBXV1nERS7x85cvNzSL27+5FMs2saJkX
         dG5yiisRS6TqO4hNQNPyDhb92oscVE1gPZOhVmA8kHgBFiJ0lcLE+894/fdoDPI2moDI
         1duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116780; x=1692721580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSo8JkNWnlvAsK6e+EDXfZDS1GveeIilj2Axf8e13BY=;
        b=OZsWYYw32zHpejmKv7Lj5QkwhlDtjrvYnE1OdCAVYpMARkfAX1JXXZPFf0BFDEjIQK
         6H/K75ZshPk4l4r3r/+LX3zltaf0rQRZoVYzl0p7c9jt7bcB78iW8bEeCTqrZdLTboyS
         BOdmgdPZqkdvv5LE8HmENXilWRERJTQtsdZWCcwuH7fw689J0rKO0fdtjmxQ/NfpKCYp
         sR+U9cmx28Ab/o2S7z6nxqwsqvC9vRUxWEEX1B32N8o1X4+5Raln2VQv1Y98gvWje88m
         ZwINBXEmLaIAq0Fdau3Z2V8daPt26IhMui/+ivb8T+6CEnCGAw53Lc4cNrrORVrG6JXE
         PRBA==
X-Gm-Message-State: AOJu0YyoXefTRbXRNT3vsE1/HAwk1qsbXxqhUEkz+JmsSW3gmGL9m/Sb
	mDxTCRpDwsopNwAYwsLkkp+cxw==
X-Google-Smtp-Source: AGHT+IELxdy+sX7RyLwuc3JHXdaev2JRZM2pulyK9X+emekDgBCXMZOpbUJzSUbnaOdweHBsVSZgBQ==
X-Received: by 2002:ac8:59cb:0:b0:403:fdf7:2e90 with SMTP id f11-20020ac859cb000000b00403fdf72e90mr17701202qtf.29.1692116779787;
        Tue, 15 Aug 2023 09:26:19 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b003fde3d63d22sm3874640qtp.69.2023.08.15.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:26:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: jiri@resnulli.us
Cc: xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH RFC net-next 0/3] Introduce tc block ports tracking and use
Date: Tue, 15 Aug 2023 12:25:27 -0400
Message-Id: <20230815162530.150994-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

In this patchset we introduce tc block netdev tracking infra.
Patch 1 introduces the infra. Patch 2 exposes it to the datapath and patch 3
shows its usage via a new tc action "blockcast".


Jamal Hadi Salim (3):
  Introduce tc block netdev tracking infra
  Expose tc block ports to the datapath
  Introduce blockcast tc action

 include/net/sch_generic.h |   8 +
 include/net/tc_wrapper.h  |   5 +
 net/sched/Kconfig         |  13 ++
 net/sched/Makefile        |   1 +
 net/sched/act_blockcast.c | 315 ++++++++++++++++++++++++++++++++++++++
 net/sched/cls_api.c       |   7 +-
 net/sched/sch_api.c       |  83 +++++++++-
 net/sched/sch_generic.c   |  37 ++++-
 8 files changed, 463 insertions(+), 6 deletions(-)
 create mode 100644 net/sched/act_blockcast.c

-- 
2.34.1


