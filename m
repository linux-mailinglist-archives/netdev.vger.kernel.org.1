Return-Path: <netdev+bounces-57655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DE813B99
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E255F283286
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00486DCFA;
	Thu, 14 Dec 2023 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="r4dvXJy/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08946AB85
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d04c097e34so8916585ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702586143; x=1703190943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+TqvwP/EFl+CV4zGbPTLRMOhRUewFvnieNA65y+ujw=;
        b=r4dvXJy/tMtWjsMqZ7O0q/WQ79tVP8pUXUXIwFA5/Ir+dmR6RUPzbHyuXMef9DuPnc
         AuZS2Cmc6ptCxndivoSloTd4Qg/sXNzY9bb4tF73pue/Fos8am2m306G5OzRXyYQzJR4
         Rs/MFzDxvmZ+mShyOA557SgiUTiuBkVwNoJGw76FHjzR5adDfrpEoABzubjGlTLuBxDk
         K0I7/kWoydUaCyv2ruQvJzrr5dep2uaD0FozxeYViajHx1mGY6S0J0aGOt5FUHvfl9cU
         OKb11Cs0Ncvfa4KaaAvws42RpsWnpSF/7CGrlUImhxHBtUPCnYKT6ExYXAlGLW2jbE9B
         Etmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586143; x=1703190943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+TqvwP/EFl+CV4zGbPTLRMOhRUewFvnieNA65y+ujw=;
        b=VG8ebPNAFPyZu5nYHzHTzAzaua4VvtXhRtY01wpUXiDr/EpQNSF1sUtN8v+78H9KYm
         MF2XnV0siKFE0W9CNeXVFfzg/pfNIlseac8/4vZbzSrHSdPrpfTGf4wSReYSQCv+oYb9
         59MIaEg2iciNCgcJvdDLG2lg7ktqkciJmuWSgbMF1OH+MSAx6HfCvd/uTKn3MVj9dHs3
         KvkuYBoCZEu7LNT0DY+sUBMiCbRVJN4ELrfrkWn4QGezVRFHEYZbY0/iOYOmNoSAf2EE
         pEZc3s2cmfhBsBWCgQvG6ZffntwgvZshRjIom5tyQeDVePW/HtJr4Cl9e8LYl3EERmPA
         O+Nw==
X-Gm-Message-State: AOJu0Ywc+Dcwo72E+FzxaF2wRzF92PDBXtn1NVMHpjp7yW4xHLmeTPdR
	QbA5aB/e6TacSTednUEvteVfuQ==
X-Google-Smtp-Source: AGHT+IFwoBOUCdScVDDc/fZ3IdaTDG5YO069ghSDdblnJ3HIoSS5/Sd5MY5F4n/9OkM5BY59uQCmmQ==
X-Received: by 2002:a17:902:db09:b0:1d3:3f3c:c237 with SMTP id m9-20020a170902db0900b001d33f3cc237mr6485173plx.32.1702586142923;
        Thu, 14 Dec 2023 12:35:42 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm12842871plk.171.2023.12.14.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:35:42 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 0/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Thu, 14 Dec 2023 17:35:29 -0300
Message-ID: <20231214203532.3594232-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch builds on Daniel's patch[1] to add initial support of tc drop
reason. The main goal is to distinguish between policy and error drops for
the remainder of the egress qdiscs (other than clsact).
The drop reason is set by cls_api and act_api in the tc skb cb in case
any error occurred in the data path.

Also add new skb drop reasons that are idiosyncratic to TC.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Changes in V4:
- Condense all the cookie drop reasons into one

Changes in V3:
- Removed duplicate assignment
- Rename function tc_skb_cb_drop_reason to tcf_get_drop_reason
- Move zone field upwards in struct tc_skb_cb to move hole to the end of 
  the struct

Changes in V2:
- Dropped RFC tag
- Removed check for drop reason being overwritten by filter in cls_api.c
- Simplified logic and removed function tcf_init_drop_reason

Victor Nogueira (3):
  net: sched: Move drop_reason to struct tc_skb_cb
  net: sched: Make tc-related drop reason more flexible for remaining
    qdiscs
  net: sched: Add initial TC error skb drop reasons

 include/net/dropreason-core.h | 18 +++++++++++++++---
 include/net/pkt_cls.h         |  6 ------
 include/net/pkt_sched.h       | 18 ------------------
 include/net/sch_generic.h     | 32 +++++++++++++++++++++++++++++++-
 net/core/dev.c                | 11 +++++++----
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 31 +++++++++++++++----------------
 7 files changed, 70 insertions(+), 49 deletions(-)

-- 
2.25.1


