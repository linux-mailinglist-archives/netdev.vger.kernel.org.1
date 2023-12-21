Return-Path: <netdev+bounces-59757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E874181C029
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114861C23D74
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73876DD3;
	Thu, 21 Dec 2023 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Xb1jHxeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334F76DB0
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f6729a57fso17680766d6.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703194274; x=1703799074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DlnstI1JxXvOLsvyNvBSo0y1ds4y8NpPDiZp2JnUrHw=;
        b=Xb1jHxeHn0qTWnL3FiSwEYMILHEy0sA+kEf43idKdG9Bw1KHO8YpcMCCAw/PPXATxR
         Y+Cdjy7KnQJNW4Md64xy8rYozcgItlqR/oM48RZ1rQt7T8sqcDliQ2oneHL3NAKCSViD
         eUAEYQM3hKJwSw/lj4pq83CpgV+aSzcmH/Ll87mBGlXtNFRYAaiWKJknQcRE9U+oITsG
         cGKZeTtO6R4jVOPBO3Cyydfmoq+noW4isr2eFLvyXUwGduEZBCektW1PqIhB4r/KpyFI
         UQ6qXRset4obzPtMrF/R3MxGDFzT1MESb1fuKej2Gu2ZVyMzL3Z4+mjVGx4VcMUNWET4
         dyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194274; x=1703799074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlnstI1JxXvOLsvyNvBSo0y1ds4y8NpPDiZp2JnUrHw=;
        b=Vzo5zxuZqQYNUvaGhnPWwCHHhO9alzSIqfdNw0FI5pNULGzVu8nLcFZ8PCa6zW8oZh
         /YVawEicRdvrW3mczLb7pSwLNL8MhOHaEUr76UMgg2D3Ej9wfCQBHMjShv9lPvSUR560
         PRJru3q7NJLYxAxFQ2hF8FmjWp4i2h7ZCWqs6qZQb0gHj86w1apXpnQe4Q1TGMHZmpXI
         php6v58JxtC5RwSLjdUrP1a8cGcMVemhRw/AkV3O5djjnRjcSkS/ZJBH0ERS5Qb5jddJ
         3EjxPJu3HT1/KM8igyypbp6W42FfM77AIrjpLiLrhulZ/UkbZiJ+uMRsxx5073HXnHDB
         vcMg==
X-Gm-Message-State: AOJu0Yx+E+tzEgmtxFDVxak7EA0YJMgy+35RfCCCw6P2GWcIlyOaBhbY
	/ipSbQawZBpa0Ne9pfwYv4qKqZLZ1BnC
X-Google-Smtp-Source: AGHT+IE5UUrNyrzdHiim0UfR4A54XvLxIRYKuZ9df3XAYPiXm/0ZGeqiLxT2owpcKFkW9T/PA7JqFw==
X-Received: by 2002:a05:6214:e88:b0:67f:26c9:ffdb with SMTP id hf8-20020a0562140e8800b0067f26c9ffdbmr668073qvb.22.1703194274537;
        Thu, 21 Dec 2023 13:31:14 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id k17-20020ad44511000000b0067f79b4c47bsm891617qvu.5.2023.12.21.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:31:13 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	fw@strlen.de,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 0/2] net/sched: retire tc ipt action
Date: Thu, 21 Dec 2023 16:31:02 -0500
Message-Id: <20231221213105.476630-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In keeping up with my status as a hero who removes code: another one bites the
dust.
The tc ipt action was intended to run all netfilter/iptables target.
Unfortunately it has not benefitted over the years from proper updates when
netfilter changes, and for that reason it has remained rudimentary.
Pinging a bunch of people that i was aware were using this indicates that
removing it wont affect them.
Retire it to reduce maintenance efforts.
So Long, ipt, and Thanks for all the Fish.

Jamal Hadi Salim (2):
  net/sched: Retire ipt action
  net/sched: Remove CONFIG_NET_ACT_IPT from default configs

 arch/loongarch/configs/loongson3_defconfig |   1 -
 arch/mips/configs/ip22_defconfig           |   1 -
 arch/mips/configs/malta_defconfig          |   1 -
 arch/mips/configs/malta_kvm_defconfig      |   1 -
 arch/mips/configs/maltaup_xpa_defconfig    |   1 -
 arch/mips/configs/rb532_defconfig          |   1 -
 arch/powerpc/configs/ppc6xx_defconfig      |   1 -
 arch/s390/configs/debug_defconfig          |   1 -
 arch/s390/configs/defconfig                |   1 -
 arch/sh/configs/titan_defconfig            |   1 -
 include/net/tc_act/tc_ipt.h                |  17 -
 include/net/tc_wrapper.h                   |   4 -
 include/uapi/linux/pkt_cls.h               |   4 +-
 include/uapi/linux/tc_act/tc_ipt.h         |  20 -
 net/sched/Makefile                         |   1 -
 net/sched/act_ipt.c                        | 464 ---------------------
 tools/testing/selftests/tc-testing/config  |   1 -
 tools/testing/selftests/tc-testing/tdc.sh  |   1 -
 18 files changed, 2 insertions(+), 520 deletions(-)
 delete mode 100644 include/net/tc_act/tc_ipt.h
 delete mode 100644 include/uapi/linux/tc_act/tc_ipt.h
 delete mode 100644 net/sched/act_ipt.c

-- 
2.34.1


