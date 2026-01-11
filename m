Return-Path: <netdev+bounces-248828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2365D0F73D
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 145CA301CA07
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DD33F8AE;
	Sun, 11 Jan 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oofFwwLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BD1EDA3C
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149606; cv=none; b=TjSLieeBAsmS/5bi6Np5tvGIZ6Sh5zIeNDemSf5TQyFmuRVgbmVpfkoP1dIVqI/ofFqDMSnNFOCC3c0f4Xpz+HO0VyrmTRPMlzcDMOx9m4VBAkf5C/MAZMJxjHHCVQQgHAWj8SCGh4qR0ph89UdFV2iwG1lhHZJx8GN8ezkJYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149606; c=relaxed/simple;
	bh=MxMcYVIgRbYfh0rFiiCqsHIOVDVN/kZZi3RDEjnrfCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TbZY9ZgmnRiUvb5ufBdILpnPVPDJHSYgY9f5D4Sj6uu97NwpP67ZnNnDyU1lumTD+MqyzvGfEweXv2ukyqQ6Eu4S+eOSJPehYUd1vhGoaUCvx8Nj3A2lzO9dJSO0wrRhRicivdR5jmhKOQJOwmWA7vOGtHtm4Q8Hvep+eiNtjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oofFwwLI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b21fc25ae1so627966685a.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149603; x=1768754403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WL9Ug8xkqjklDfwBwNk5OOPAvnm8qtO0OGOkv7e+h50=;
        b=oofFwwLIRXuscYKwKeDofAoUNIHGwly8OFgAFwf6xupuz/c+39bApmUUHpYlYi6U54
         TkJibHsT0tF/Srrum2RrAUQJOo/fNBWEjRRfGuAMHJzCw14I8Kj5OXnFzpoBF2n8SdOt
         l89R14Asjo4ApV+fNke5CmrjLFE4eEp1p3KmY2Jmyw6vp9UT0tas+0UUTWg5e2ypne2t
         0xQLKrCHYFjV9dZEYqOe1PAIk79ywjLwvhifFUGEV0loGvt5sTvXOo+JAMhFgrPRXLXK
         Igiml+vjLXJv0UOK/m3DMCBoH/2zT70DHsen3/zMZWfc6+DF5FzbxlLfDyhg9pw5Zi85
         dNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149603; x=1768754403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL9Ug8xkqjklDfwBwNk5OOPAvnm8qtO0OGOkv7e+h50=;
        b=W6vFroZVTdDjFPEys3koPMLwGvlmYqQ4GJ65/CeVNzD2owVbLEBRrm89cR/8zk82WI
         bPb9oSrlA05P75JNL3CVlXUhG82qPb6HPs4P07fdBh07zmfjl5LSjMvbe4gL1j4lSN5d
         Mouh45IWJ42uOk6OcOPsTdasosEwesbSfVDWfkwtCPN1iiZNxMoZOKkdmAB1Uswzdx6R
         q/gc3oOZs4YsEWyJtpS019D6G0QHuMiP11jrpvzqZw90CiccVmvuTpDLJpTeRgXFybQe
         bn0uo/uIuJhPOo8soScLuG/CxIMrDf6SPDDRPg/gL7YkV/NEbBMHiWsv0DdPdCZ3BHyu
         V67Q==
X-Gm-Message-State: AOJu0Yz/16mV+ZpdV2XTJCJkn+IzCT2SL+0pDQDYTe3li5xk1Kbm4QUQ
	p9HjLVB20DJzNAzJrIoT4lktjeuiNNn7JZa3xR62Lq/1ra8vTZusSLZloPr7+jxelg==
X-Gm-Gg: AY/fxX62xkdghfDDDD1T3Lnd+W/tIn9q6rcosy87vOr4VCBqQqELcFaFE5DT7qb6B3n
	I0P+f58t6JLYnfOAkXtD5aOuXTEZ8OPkip1gunPC/P8Q7PsKn3vxecwuDN8qy2kVcv4Poulh6Q0
	qbd6s+9LnuT5B5hQmvhZDMYUhAtrE1acsfbM6726ISXgTqmPutW0UiJRlJIf9Xz5q2l+OR0bQua
	NZqXyrNS8c4vMYaFAQSVRfFENsfKjcMzJBKGraJ1CGNebS74nG6siozcJGNT3reaOphqAAM2h4G
	8uWltZO20I7oMrzQIxGI+Zhw9W91yDo9plIoDc8+JTpWrMggJ57C4r7yMDu2gmvUfovHKy1XptM
	VdtdezWv/Mm5bx+mlY4nSepqpqRapUfntXnwd2xNedPqJAbGtDTnu8TPHWO4zb+4dgvKahhJ0Oq
	kpSsDJh7YVlBU=
X-Google-Smtp-Source: AGHT+IEFX7JXVycdqr/9Yzb7U5IV6nPV70NkmG/kT8Fqxgk9zK0kXga7VUtD2GdRsaC2cWSh2fnhZg==
X-Received: by 2002:a05:620a:4887:b0:8aa:f08:bed0 with SMTP id af79cd13be357-8c38940cd29mr1929733085a.79.1768149603185;
        Sun, 11 Jan 2026 08:40:03 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:02 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
Date: Sun, 11 Jan 2026 11:39:41 -0500
Message-Id: <20260111163947.811248-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


We introduce a 2-bit global skb->ttl counter.Patch #1 describes how we puti
together those bits. Patches #2 and patch #5 use these bits.
I added Fixes tags to patch #1 in case it is useful for backporting.
Patch #3 and #4 revert William's earlier netem commits. Patch #6 introduces
tdc test cases.

Jamal Hadi Salim (5):
  net: Introduce skb ttl field to track packet loops
  net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net/sched: fix packet loop on netem when duplicate is on

Victor Nogueira (1):
  selftests/tc-testing: Add netem/mirred test cases exercising loops

 drivers/net/ifb.c                             |   2 +-
 include/linux/skbuff.h                        |  24 +-
 include/net/sch_generic.h                     |  22 +
 net/netfilter/nft_fwd_netdev.c                |   1 +
 net/sched/act_mirred.c                        |  45 +-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 9 files changed, 698 insertions(+), 160 deletions(-)

-- 
2.34.1


