Return-Path: <netdev+bounces-32967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7679B6DB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AB2281610
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E317E;
	Tue, 12 Sep 2023 00:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B8160
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:05:56 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840CFEA089
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:37:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so4063790a91.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694475366; x=1695080166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyXUIwp6sVh3PG94YfifNJCLsmaUNVImTDsvvHizJGM=;
        b=aGVCV7mWEeZNqwqjvX0wg7DAsFFQyuDqH9kxfompG4CQOzzAsLrWUXitD5x5Am+tuo
         Cqr2hdwqIumL9jkHaUvtzhI0mWaDHiGpBHdrQrKfM4cIa1sbMqWZijpphA2m3zFoqB+T
         YBxDa2/Oqok6XJ2Gdx/Yu02J7c/mlLhuHE32dDqexHWx3dbCSKxl2kgIrgpC0Up0HOvr
         Wt7jkltc2icHWfWoA1pajXFhDMD+YsS7Jru4X522L6uPrQ5XYRhQK7c/mfz6aipYWKOq
         mBwA4RNdI0vk6yt6T5vZYylgV7vxXiYGNzBL9cQWJhajdCa//YkuJlvEowG3jBwxnfc+
         CraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475366; x=1695080166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyXUIwp6sVh3PG94YfifNJCLsmaUNVImTDsvvHizJGM=;
        b=JyLSOpY8gW0KgPGmA/p1xCUmwCUrRR/qAJzpyz23eDajZNAXuoJFE/lxSMFknEDgTI
         KIpXA53Z9xn9VBvDNMvx4PdsaMOM+Rx/FtM/+Nwdx8nGuwOOp6IerQsYezFPW11bPrcS
         OWyze5aKcKoiw1v7TAI8EIGqIjiFRJAqKn1Q+HfSkkDFWbFFwODGRXoQrc+Mlt8YlLb4
         UnmLHgCfykCBAoV7TV75NluO34BUqOnnvwQ5TUJtdKnrKgV23H87fgyIpLLUCYUYYTg4
         I5H4e47f1B+ZSbhaTFopvup+in8lBO1GcDBzx4R85nsi8HZF5WMYbZkDHkhCa63kLaXx
         7xDg==
X-Gm-Message-State: AOJu0YzWInCmJRmq4qw9k5YCBQANLi3As+qp/EmzkY6x5wN6jyIA1mvR
	FB5GQwBBGOhcThXrGiPagQY+EjJy6S1EtLpQ3Og=
X-Google-Smtp-Source: AGHT+IH1CsV1nRDf/Nzvb1mlH9/A1rqIb7TyG3QAR04zEypM2gqM+BzGmFfkpNkRZPST1atGfzODKg==
X-Received: by 2002:a05:6830:1da:b0:6bf:60a:f79f with SMTP id r26-20020a05683001da00b006bf060af79fmr10331952ota.22.1694474887736;
        Mon, 11 Sep 2023 16:28:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:424f:fdef:90d5:8e0:d9])
        by smtp.gmail.com with ESMTPSA id l10-20020a9d7a8a000000b006b8c87551e8sm3534293otn.35.2023.09.11.16.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:28:07 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v3 0/3] net/sched: Introduce tc block ports tracking and use
Date: Mon, 11 Sep 2023 20:27:46 -0300
Message-ID: <20230911232749.14959-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
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
"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens7.

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

Victor Nogueira (3):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_blockcast: Introduce blockcast tc action

 include/net/sch_generic.h    |   8 +
 include/net/tc_wrapper.h     |   5 +
 include/uapi/linux/pkt_cls.h |   1 +
 net/sched/Kconfig            |  13 ++
 net/sched/Makefile           |   1 +
 net/sched/act_blockcast.c    | 300 +++++++++++++++++++++++++++++++++++
 net/sched/cls_api.c          |  12 +-
 net/sched/sch_api.c          |  71 +++++++++
 net/sched/sch_generic.c      |  34 +++-
 9 files changed, 442 insertions(+), 3 deletions(-)
 create mode 100644 net/sched/act_blockcast.c

-- 
2.25.1


