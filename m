Return-Path: <netdev+bounces-29122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62531781A8B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384801C209E0
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5009174CB;
	Sat, 19 Aug 2023 16:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897CA57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:35:26 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F5903D
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a812843f0fso1225929b6e.2
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692462923; x=1693067723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOa5d3MtBHvlpkPyCHw2RFP5+0E3lvg0jIriJ65G6pA=;
        b=p+7i5QpPtfdDdkZpZfEW9s04212CfmWzd72aSaDXYAyANcx3U3hEbfHZl9M0dgP6La
         VTEl16/WR45ytADGMTCFYf+gDS2gPxguNfTdJSrx1BAsO9ebiCwSKmpnhwqkfAlDN9No
         VwW0rL+OM+YZzMnLzdCiX/ZG7qUQbZr8dRZrScbYq+0cxrbIWTD/1DIAkasX5oGG/aTu
         iYj3j+0v3TcgTWZo8PIZMOoYCbk0SJAbxIoPFWJTs8p6zRO/46UQa/LQU4AlhHkaq+iT
         /QYIpWiJFEQVHYJnDFJNVzvQGpYbNAoPD69K+XIyCF05pctcwIISeyyOePh257TNTZI/
         AF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692462923; x=1693067723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOa5d3MtBHvlpkPyCHw2RFP5+0E3lvg0jIriJ65G6pA=;
        b=JLUVxs5B7o5pu/gwuy4aF8l7pW165hk5hKaLdrn18HWuhtXsIHyI64/Faw53N3gNQb
         zZ1fPhYI2Qr+9g9mnmZ4pBbgQ7jSRcRS1+3awjTXD6Ao/GQOTeEwYqMSxn0j2/LZ6cVr
         RiHSOv+OAYj4XF4ehT+F2F7eLzL+PrKfn4hDt+5Sd2zsyL23I3TsEa6f0w/6LShmAMfD
         VL2ORcGWSz4MFl8yl+QnlaKWYKnZj3Y+j4s4uEChtWZsbC7OZR5QnvDzdbm0r+r4vyiO
         ld5L//kw1MNxvIywmMqyEP3rETZiUv82CTou8ArHkGzhMIjBW5a4eJPKgBAm9YSXa305
         ZZuA==
X-Gm-Message-State: AOJu0YwbYplmZT7lkCxgcnRVfuIi5wRSoOcx1bo8THuLfj9R7ntaMs1C
	zKPFQYNGiembNuiFdUYmsr+K2g==
X-Google-Smtp-Source: AGHT+IGQiE73pYQLLT6iLNFjRj90QKQ3FLg7fel7EHmnptsTBU8FKZel3M1cjAbwlYGXhCQR9NjoBA==
X-Received: by 2002:a05:6808:3ac:b0:3a1:df63:60cc with SMTP id n12-20020a05680803ac00b003a1df6360ccmr2338605oie.59.1692462923472;
        Sat, 19 Aug 2023 09:35:23 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:d019:34ee:449:f6bb:38e9])
        by smtp.gmail.com with ESMTPSA id p187-20020acaf1c4000000b003a7847cf407sm2098303oih.44.2023.08.19.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 09:35:23 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 0/3] net/sched: Introduce tc block ports tracking and use
Date: Sat, 19 Aug 2023 13:35:11 -0300
Message-ID: <20230819163515.2266246-1-victor@mojatatu.com>
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

__context__
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

__this patchset__
Up to this point in the implementation, the block is unaware of its ports.
This patch fixes that and makes the tc block ports available to the
datapath as well as the offload control path (by virtue of the ports being
in the tc block structure).

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
"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens7.

For an offload path, one use case is to "group" all ports belonging to a
PCI device into the same tc block.

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

Victor Nogueira (3):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block ports to the datapath
  Introduce blockcast tc action

 include/net/sch_generic.h |   8 +
 include/net/tc_wrapper.h  |   5 +
 net/sched/Kconfig         |  13 ++
 net/sched/Makefile        |   1 +
 net/sched/act_blockcast.c | 299 ++++++++++++++++++++++++++++++++++++++
 net/sched/cls_api.c       |  11 +-
 net/sched/sch_api.c       |  79 +++++++++-
 net/sched/sch_generic.c   |  40 ++++-
 8 files changed, 449 insertions(+), 7 deletions(-)
 create mode 100644 net/sched/act_blockcast.c

-- 
2.34.1


