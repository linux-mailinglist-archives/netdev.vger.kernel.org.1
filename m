Return-Path: <netdev+bounces-38366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD6E7BA953
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 25B661C208BE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960603C68A;
	Thu,  5 Oct 2023 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YTdnCZaq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE422E65A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:42:52 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A75C0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:42:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692d2e8c003so1899265b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696531370; x=1697136170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Og4ZdxssU8L1R5eTzBywzenE0Sa3mA8E/G01mteTkJU=;
        b=YTdnCZaqlfz3clHtXEnUIxWcF9TZwsCgj3FjEWzcd9ky5IzLOZ5xtPiOyVOR7stlyU
         qJemCUZhvFmFNGnQK2ZFugnJ0EWHIIBTQgpEQjHjKudYsEjQMRw9DRGR/qiHEyYRhUUI
         jW6W1kzIDznroi5rplm8jYf+iEGcVJCE3e0V+UIuBFLR4W9xRnG3shb+KhvJ+baOqd/C
         nT3Tehe1Euvnooad6cttausudwY2Ik2o0+vIhxY18BO4ZltkVlwDa1hvPFLmmvePzeSi
         3z/3WPoyx4hIOjNQNX/a96r5sEDBd4Zd9N9XfVsHQGmSsIvvCfWVu6R5G+Z32jpAAr+q
         9l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531370; x=1697136170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og4ZdxssU8L1R5eTzBywzenE0Sa3mA8E/G01mteTkJU=;
        b=YifhIrFxdSAdACd+MK8t64Be/TCUwG+8JTPQmZ5kjeN0U57k5Ua6B/YduYo0TCt7uo
         mTT5rBY+WE1jUJba11adk62eE15Y6+dpvP2eYLT51D1g3WmrU8uH/CqsHBbj10Vboh8Z
         BSAWKSeLDcX4EezjhTGLq9pjEX3thsHYnx2NEagfoWUBt260eyAjp+FO86rPP5oPNIUd
         dkyQcwkZieC0ncmBJfQ+M7JzTgeXivMvgS+kMRnPSNnWNbv8emKi58HUeQmNdlpnp+cf
         MC8ZWQx/L1EOWlmw587Bjhz03vrePSgcZrFSH6xUXgqhMVfrkUPLf8Pbnv8aC3ktPTsC
         f3fw==
X-Gm-Message-State: AOJu0YwBrH/eRKbXsT7Whs1THgeXnwRD2I4vnWUWEg/N51Tud5myQkgH
	W9GMds5wfE0YNkkcmQ+dTM/X2A==
X-Google-Smtp-Source: AGHT+IERHDyiGcSySCG+0kXDAyTbk6izd1tli09B3QVLHc6xKDva6Bmp+Ji4dTG0yy6fRPHee7P+5A==
X-Received: by 2002:a05:6a20:8e28:b0:140:d536:d434 with SMTP id y40-20020a056a208e2800b00140d536d434mr5531865pzj.10.1696531370037;
        Thu, 05 Oct 2023 11:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:b6b7:54d9:6465:eb2f:5366])
        by smtp.gmail.com with ESMTPSA id x28-20020aa793bc000000b00690d4c16296sm1725831pff.154.2023.10.05.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:42:49 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports tracking and use
Date: Thu,  5 Oct 2023 15:42:25 -0300
Message-ID: <20231005184228.467845-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
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

__Context__
The "tc block" is a collection of netdevs/ports which allow qdiscs to share
match-action block instances (as opposed to the traditional tc filter per
netdev/port)[1].

Example setup:
$ tc qdisc add dev ens7 ingress block 22
$ tc qdisc add dev ens8 ingress block 22

Once the block is created we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action drop

A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
either ens7 or ens8 is dropped.

__This patchset__
Up to this point in the implementation, the block is unaware of its ports.
This patch fixes that and makes the tc block ports available to the
datapath.

For the datapath we provide a use case of the tc block in an action
we call "blockcast" in patch 3. This action can be used in an example as
such:

$ tc qdisc add dev ens7 ingress block 22
$ tc qdisc add dev ens8 ingress block 22
$ tc qdisc add dev ens9 ingress block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast

When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of any
of ens7, ens8 or ens9 it will be copied to all ports other than itself.
For example, if it arrives on ens8 then a copy of the packet will be
"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.

Patch 1 introduces the required infra. Patch 2 exposes the tc block to the
tc datapath and patch 3 implements datapath usage via a new tc action
"blockcast".

__Acknowledgements__
Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patchset
better. The idea of integrating the ports into the tc block was suggested
by Jiri Pirko.

[1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-share-filter-block-instances'")

Changes in v2:
  - Remove RFC tag
  - Add more details in patch 0(Jiri)
  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
    Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.org)
  - Fix bad dev dereference in printk of blockcast action (Simon)

Changes in v3:
  - Add missing xa_destroy (pointed out by Vlad)
  - Remove bugfix pointed by Vlad (will send in separate patch)
  - Removed ports from subject in patch #2 and typos (suggested by Marcelo)
  - Remove net_notice_ratelimited debug messages in error
    cases (suggested by Marcelo)
  - Minor changes to appease sparse's lock context warning

Changes in v4:
  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
  - Fix typo in cover letter (pointed out by Paolo)
  - Create a module description for act_blockcast
    (reported by Paolo and CI)

Victor Nogueira (3):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_blockcast: Introduce blockcast tc action

 include/net/sch_generic.h    |   8 +
 include/net/tc_wrapper.h     |   5 +
 include/uapi/linux/pkt_cls.h |   1 +
 net/sched/Kconfig            |  13 ++
 net/sched/Makefile           |   1 +
 net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
 net/sched/cls_api.c          |  12 +-
 net/sched/sch_api.c          |  58 +++++++
 net/sched/sch_generic.c      |  34 +++-
 9 files changed, 426 insertions(+), 3 deletions(-)
 create mode 100644 net/sched/act_blockcast.c

-- 
2.25.1


