Return-Path: <netdev+bounces-59013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A251818F9A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0178FB23A3D
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56C37D11;
	Tue, 19 Dec 2023 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="U6XdMNc/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543437D3F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3dee5f534so6312385ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009792; x=1703614592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Go2CYApzd7lGMv6OqeeNVCAPHSkKHJF+Rhk2+ef2hQ=;
        b=U6XdMNc/o+TQtSKn7WXkK2cdnJVh9hpCYOTYmn+lBKE0R2+IJs3Y4sDHttucit9/uc
         CJOOpEpDrf1+B0A1r1SnIG3fVxS1sR0l9QcEGrhLNJUTLcBIivBPIXZUsS1ya77Il3jx
         hQ9fTpvHmhBOVeOvd5IgOq263QE3cQ7Qb9eTi3JeR1pTbIvNZeQabgIr4SCLKhinIomd
         W8TxV0EhP2wPJThuafbLcWJxP9d434+uF+WIBXad743qgjScfnPXJjeh5I5FRLRU6GHN
         iHXU1qvym+MlF4wst5sG+q/yOay5Wd0AnrBkK2KSW70YbPgUIOROw3yqk9kSarlSkgPd
         YEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009792; x=1703614592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Go2CYApzd7lGMv6OqeeNVCAPHSkKHJF+Rhk2+ef2hQ=;
        b=dLIm2sP6e1dMWvlD0GKq683IyEB1VDWzG4lBgPgFHLn2tEZNzWf5izZtTbThiJ99RT
         XJaQ9m217l96uP6qMtUx5695JVq7478tUCdvmS/qqilF/KWWo8O1fpMbZpzq+GPA1KCZ
         qd1QpBWymhAMlJmZQqjzVosxTUQkCAjanki7cXzXrDj0v8KLDplvBnZnlp5yfUM+F4i2
         YbVVYH1gKEtFbQO3gL2oGzycTPP1RLAa2wdPS+yKylMiMiF3dq7zq7M2kw0h8xSxn66Z
         v4st9hQy/J88zEvbvqnEJxYuOZXy1R6ivmhd80NzvNjjGg9ID4fzz74dLmazkohUxE60
         2Hbg==
X-Gm-Message-State: AOJu0Yz79BOY3PuhRfuI1AQHOxE5eWBc7TEqarVW4uLVJ3qekzOHHNso
	hQaa8quTWDJzKUIykEg/N2Wohg==
X-Google-Smtp-Source: AGHT+IG9b2YFiA4XaQ182DUCgEb9eZ9k056Ql8gU5fJ/FoNN6fhFY9CUdl02I0L0ca5cGLJtSeNpsg==
X-Received: by 2002:a17:903:2304:b0:1d0:6ffd:610d with SMTP id d4-20020a170903230400b001d06ffd610dmr1901737plh.47.1703009792308;
        Tue, 19 Dec 2023 10:16:32 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:32 -0800 (PST)
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
Subject: [PATCH net-next v8 0/5] net/sched: Introduce tc block ports tracking and use
Date: Tue, 19 Dec 2023 15:16:18 -0300
Message-ID: <20231219181623.3845083-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
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

Up to this point in the implementation, the block is unaware of its ports.
This patch makes the tc block ports available to the datapath.

For the datapath we provide a use case of the tc block in a mirred
action in patch 3. For users can levarage mirred to do something like
the following:

$ tc qdisc add dev ens7 ingress_block 22 clsact
$ tc qdisc add dev ens8 ingress_block 22 clsact
$ tc qdisc add dev ens9 ingress_block 22 clsact
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block excluding ens8. Note that the packet is still in
the pipeline at this point - meaning other actions could be added after the
mirror because mirred copies/clones the skb. Example the following is
valid:

$ tc filter add block 22 protocol ip pref 25 flower dst_ip 192.168.0.0/16 \
action mirred egress mirror blockid 22 \
action vlan push id 123 \
action mirred egress redirect dev dummy0

redirect behavior always steals the packet from the pipeline and therefore
the skb is no longer available for a subsequent action as illustrated above
(in redirecting to dummy0).

The behavior of redirecting to a tc block is therefore adapted to work in
the same manner. So a setup as such:
$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect blockid 22

for a matching packet arriving on ens7 will first send a copy/clone to ens8
(as in the "mirror" behavior) then to ens9 as in the redirect behavior
above. Once this processing is done - no other actions are able to process
this skb. i.e it is removed from the "pipeline".

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block excluding ens8.

Patch 1 separates/exports mirror and redirect functions from act_mirred
Patch 2 introduces the required infra.
Patch 3 Allows mirred to blocks

Subsequent patches will come with tdc test cases.

__Acknowledgements__
Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patchset
better. The idea of integrating the ports into the tc block was suggested
by Jiri Pirko.

[1] See commit ca46abd6f89f ("Merge branch'net-sched-allow-qdiscs-to-share-filter-block-instances'")

Changes in v2:
  - Remove RFC tag
  - Add more details in patch 0(Jiri)
  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
    Reported-by: kernel test robot <lkp@intel.com> (and
horms@kernel.org)
  - Fix bad dev dereference in printk of blockcast action (Simon)

Changes in v3:
  - Add missing xa_destroy (pointed out by Vlad)
  - Remove bugfix pointed by Vlad (will send in separate patch)
  - Removed ports from subject in patch #2 and typos (suggested by
    Marcelo)
  - Remove net_notice_ratelimited debug messages in error
    cases (suggested by Marcelo)
  - Minor changes to appease sparse's lock context warning

Changes in v4:
  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
  - Fix typo in cover letter (pointed out by Paolo)
  - Create a module description for act_blockcast
    (reported by Paolo and CI)

Changes in v5:
  - Add new patch which separated mirred into mirror and redirect
    functions (suggested by Jiri)
  - Instead of repeating the code to mirror in blockcast use mirror
    exported function by patch1 (tcf_mirror_act)
  - Make Block ID into act_blockcast's parameter passed by user space
    instead of always getting it from SKB (suggested by Jiri)
  - Add tx_type parameter which will specify what transmission behaviour
    we want (as described earlier)

Changes in v6:
  - Remove blockcast and make it a part of mirred (suggestd by Jiri)
  - Block ID is now a mirred parameter
  - We now allow redirecting and mirroring to either ingress or egress

Changes in v7:
  - Remove set but not used variable in tcf_mirred_act (pointed out by
    Jakub)

Changes in v8:
  - Fix uapi issues (pointed out by Jiri)
  - Separate last patch into 3 - two as preparations for adding
    block ID to mirred and one allowing mirred to block (suggested by Jiri)
  - Remove declaration initialisation of eg_block and in_block in
    qdisc_block_add_dev (suggested by Jiri)
  - Avoid unnecessary if guards in qdisc_block_add_dev (suggested by Jiri)
  - Remove unncessary block_index retrieval in __qdisc_destroy
    (suggested by Jiri)

Victor Nogueira (5):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_mirred: Create function tcf_mirred_to_dev and improve
    readability
  net/sched: act_mirred: Add helper function tcf_mirred_replace_dev
  net/sched: act_mirred: Allow mirred to block

 include/net/sch_generic.h             |   4 +
 include/net/tc_act/tc_mirred.h        |   1 +
 include/uapi/linux/tc_act/tc_mirred.h |   1 +
 net/sched/act_mirred.c                | 263 ++++++++++++++++++++------
 net/sched/cls_api.c                   |   5 +-
 net/sched/sch_api.c                   |  41 ++++
 net/sched/sch_generic.c               |  18 +-
 7 files changed, 268 insertions(+), 65 deletions(-)

-- 
2.25.1


