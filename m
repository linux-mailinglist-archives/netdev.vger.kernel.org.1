Return-Path: <netdev+bounces-57883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209781466F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7E28480A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9A1C2BD;
	Fri, 15 Dec 2023 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GjPh/P+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1718029
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58a7d13b00bso396356eaf.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702638658; x=1703243458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbHWpYms3Ol2fmeR9rA2InZuKoMGSgYNUL7OQMzv/KI=;
        b=GjPh/P+0e/m/sNSmZAeAbZF8V6FUCDbVk6bFMJ5DWF4HVAuT1CodyFsXG3BI3LDn+L
         uHkwYxdg+LE7I6VMzWFJT6Y1q4eFbHPOPXKS86YHJH6hTkdw3ml7QFv061VzwG4dQRqz
         +cSSAYI9wjhs9nWKntpwaRE9kOmGIm/qj20jss2a+rXeItzUUXAZQpVao9sdR0bZtZ1N
         A0aFqvxXBZ/InNSFG+3AaS/6OuLaezBxjgnxKrehdssmj5Z2jyo8lq0zd+hpQR1XFMgJ
         W9HJFm/z+TxShbrna/6GRPZGugX/XL5BXAvuvS0rs8DQgCXB1kJYTsLnez+nGmRu8lYv
         6DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638658; x=1703243458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbHWpYms3Ol2fmeR9rA2InZuKoMGSgYNUL7OQMzv/KI=;
        b=RuAhgGbmRl3NxRS82ZmVHpeRJz2FdXfS5l5wPBf6ILFIFMJ18kU1JzzqpesHSVO56u
         pXTKnDq7NFhexjj7aQFgSgRE6Hi2gMDXm0l661ozEDTIbH7Yd+d+mWCoFAajXI3hcHMv
         Dzu+hwo1mNaV/LuajJPPn5n4PVwxlb0mKWEd/9M1GDa6Vbijn8/3kCgHsMMYbkG/Efgs
         jZaMe4RIypdWxaTkNPXWyeI5o/+RXNlVxScmnvohbbMrZsqBsFjm5nGedRcUH7A/s3Q6
         QghXfXKJNCQihI7O324DZxitCIj/sv4B+oRjYChZChxaeURD7uB8guTTcQjD8+viDDkW
         AQgw==
X-Gm-Message-State: AOJu0YwBnN/C1QfpO8AbgRUFtjS31/H0ooLVUrCm6pjso05eXRIraHlR
	JFJRR4NtSP3wCPZoNqHSRWlnvA==
X-Google-Smtp-Source: AGHT+IGj0JhsPWiKNsLHaELQT8WHrU0cYnRLnwnS3BhM36hNgGZJgjaTzoyo584aQYq00sBEsoQUXA==
X-Received: by 2002:a05:6358:cb2f:b0:16e:27b5:3b25 with SMTP id gr47-20020a056358cb2f00b0016e27b53b25mr10662783rwb.31.1702638657944;
        Fri, 15 Dec 2023 03:10:57 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00195000b006cb574445efsm13329045pfk.88.2023.12.15.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:10:57 -0800 (PST)
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
Subject: [PATCH net-next v7 0/3] net/sched: Introduce tc block ports tracking and use
Date: Fri, 15 Dec 2023 08:10:47 -0300
Message-ID: <20231215111050.3624740-1-victor@mojatatu.com>
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

$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block including ens8. Note that the packet is still in the
pipeline at this point - meaning other actions could be added after the
mirror because mirred copies/clones the skb. Example the following is
valid:

$ tc filter add block 22 protocol ip pref 25 flower dst_ip 192.168.0.0/16 \
action mirred egress mirror blockid 22 \
action vlan push id 123 \
action mirred egress redirect dev dummy0

redirect behavior always steals the packet from the pipeline and therefore
the skb is no longer available for a subsequent action as illustrated above
(in redirecting to dummy0).

The behavior of redirecting to a tc block is therefore adapted to work in the
same manner. So a setup as such:
$ tc qdisc add dev ens7 ingress_block 22
$ tc qdisc add dev ens8 ingress_block 22
$ tc qdisc add dev ens9 ingress_block 22
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect blockid 22

for a matching packet arriving on ens7 will first send a copy/clone to ens8
(as in the "mirror" behavior) then to ens9 as in the redirect behavior above.
Once this processing is done - no other actions are able to process this skb.
i.e it is removed from the "pipeline".

In this case, if the packet arrives on ens8, it will be copied and sent to
all ports in the block including ens8.

Patch 1 separates/exports mirror and redirect functions from act_mirred
Patch 2 introduces the required infra.
Patch 3 Allows mirred to blocks

Subsequent patches will come with tdc test cases.

__Acknowledgements__
Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this
patchset
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
  - Added new patch which separated mirred into mirror and redirect
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

Victor Nogueira (3):
  net/sched: Introduce tc block netdev tracking infra
  net/sched: cls_api: Expose tc block to the datapath
  net/sched: act_mirred: Allow mirred to block

 include/net/sch_generic.h             |   6 +
 include/net/tc_act/tc_mirred.h        |   1 +
 include/uapi/linux/tc_act/tc_mirred.h |   1 +
 net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
 net/sched/cls_api.c                   |   5 +-
 net/sched/sch_api.c                   |  55 +++++
 net/sched/sch_generic.c               |  31 ++-
 7 files changed, 300 insertions(+), 77 deletions(-)

-- 
2.25.1


