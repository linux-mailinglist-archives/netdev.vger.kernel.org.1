Return-Path: <netdev+bounces-47151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD07E8539
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98746280FC2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742E3C692;
	Fri, 10 Nov 2023 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0Y1uN/Yz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7C3C68C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 21:46:27 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183E4229
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:25 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso1201002fac.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699652785; x=1700257585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogI2r9+issRJ+cQKoR7q7HSD3ymR8Kd/8inVj5zs2qE=;
        b=0Y1uN/YzCcl1uneKKgFsYfqT6iSKyFldA+LhH9s6wIcPZ5QMikmjfFLvdQZqQOXBXB
         nDHe5C94PY/Yww+aWtsq7n4DLFs4/Nc/0QxipZ9j/cjFPXUbwUpmrWkZsWtKBt8tvOEV
         fdm4MXFuzrCC0wFe+xKDZXqvORHEIJ402xIV4MXXqZ85KRngydDl9OuKdzxURDTvWR0w
         ooms6ba7oj5AF0cEt5Y3yx8lGRjllKFSwBimYLt+lzewc2DSFsPtwFJhUvlATURiPw+0
         7VbJ6j27mQ3qDqhwO6OTy1UA7mT4NSgL8pnXoio6PVSfXsXGny7o17ZhAOY/DBLG6cqT
         Srnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652785; x=1700257585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogI2r9+issRJ+cQKoR7q7HSD3ymR8Kd/8inVj5zs2qE=;
        b=ux29Ge4ebUqUIaaK7b/0xPhw/2IZ/8h37gJCiLq4/P7JmGu0VRRWQT6BoGGzag/T0r
         9QPueigbkM2QhAmXR41nSTth+fkFtVgdyi6h8Y9JqSlCOj0x88PL++bB4MORRH2nE2cB
         oUxDbNlZUfC5Yt2GdbVucht/j2xWy+01QldFiIBOA03UfqqtK/aaT4FKK9iftfyaQpMR
         qm8DN01Deff6M8iwnQoluHgtgElG3MBhOXQkj0n/hSBK7JW3ioO2jU+0ucUZChxotpYX
         LCkX/m5Kb+EISTigXY2KRRyTxELtXCXUU9zkOhol9/4c82Vspa78+5HPqALg++MKNoUU
         LIFA==
X-Gm-Message-State: AOJu0YzI8w3BWKW2D4JUuiwdvfUHP1povzw4WmK4UmS7/XEQiPkN884E
	vVvRzzfl1+DoYqeXLeTu2ZbM3g==
X-Google-Smtp-Source: AGHT+IEM+YB4mPMSHmgPum3jJQImU20oHlGwu8LSqjN/5T+JxHrVj9CLB99VS0pxSmpdIukkLwBpRw==
X-Received: by 2002:a05:6870:41d2:b0:1ea:125f:cffa with SMTP id z18-20020a05687041d200b001ea125fcffamr474373oac.34.1699652784901;
        Fri, 10 Nov 2023 13:46:24 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:6a74:a464:c4ff:7a79:ee97])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b006b90f1706f1sm166343pfj.134.2023.11.10.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:46:24 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next RFC v5 0/4] net/sched: Introduce tc block ports tracking and use
Date: Fri, 10 Nov 2023 18:46:14 -0300
Message-ID: <20231110214618.1883611-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__context__
The "tc block" is a collection of netdevs/ports which allow qdiscs to share
match-action block instances (as opposed to the traditional tc filter per
netdev/port)[1].

Example setup:
$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22

Once the block is created we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action drop

A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
either ens7 or ens8 is dropped.

__this patchset__
Up to this point in the implementation, the block is unaware of its ports.
This patch makes the tc block ports available to the datapath.

For the datapath we provide a use case of the tc block in an action
we call "blockcast" in patch 4. This action can be used in an example as
such:

$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast blockid 22

When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of any
of ens7, ens8 or ens9 it will be copied to all ports other than itself.
For example, if it arrives on ens8 then a copy of the packet will be
"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.

We also allow for the packet to be send to all the ports in the block
indiscriminately by specifying the "tx_type all" option. Using the
previous example:

$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block including ens8.

Patch 1 separates/exports mirror and redirect functions from act_mirred
Patch 2 introduces the required infra.
Patch 3 exposes the tc block to the tc datapath
Patch 4 implements datapath usage via a new tc action "blockcast".

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

Changes in v5:
  - Added new patch which separated mirred into mirror and redirect
    functions (suggested by Jiri)
  - Instead of repeating the code to mirror in blockcast use mirror
    exported function by patch1 (tcf_mirror_act)
  - Make Block ID into act_blockcast's parameter passed by user space
    instead of always getting it from SKB (suggested by Jiri)
  - Add tx_type parameter which will specify what transmission behaviour
    we want (as described earlier)

Victor Nogueira (4):
  net/sched: act_mirred: Separate mirror and redirect into two distinct
    functions
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_blockcast: Introduce blockcast tc action

 include/net/act_api.h                    |  85 +++++++
 include/net/sch_generic.h                |   6 +
 include/net/tc_act/tc_blockcast.h        |  16 ++
 include/net/tc_wrapper.h                 |   5 +
 include/uapi/linux/pkt_cls.h             |   1 +
 include/uapi/linux/tc_act/tc_blockcast.h |  32 +++
 net/sched/Kconfig                        |  12 +
 net/sched/Makefile                       |   1 +
 net/sched/act_blockcast.c                | 283 +++++++++++++++++++++++
 net/sched/act_mirred.c                   | 103 +++------
 net/sched/cls_api.c                      |   5 +-
 net/sched/sch_api.c                      |  55 +++++
 net/sched/sch_generic.c                  |  31 ++-
 13 files changed, 557 insertions(+), 78 deletions(-)
 create mode 100644 include/net/tc_act/tc_blockcast.h
 create mode 100644 include/uapi/linux/tc_act/tc_blockcast.h
 create mode 100644 net/sched/act_blockcast.c

-- 
2.25.1


