Return-Path: <netdev+bounces-58294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D26815BBB
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471351F229FF
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E415AD2;
	Sat, 16 Dec 2023 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QHIcYER9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4E1DFDA
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2031b9c8389so1325989fac.1
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702759483; x=1703364283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybN/JQklFxxdvbFcBG4Es2B5/vNf6JnHtZJeVvDftTs=;
        b=QHIcYER9Vp3rlzGLhWuxn1xYemBN7USeWW2ov7ALw7anbNaaP1ItiGVlGry67HYrK6
         G6+yIhBh8nejVnQsehlhFckqV3ULFuID9yHOz2UP/WhZhEzr5XQ8u/QqBkwfzyiB23Y5
         rksL7ca2oSBLMz3qZLXZ/hOXUNREG1H1UqtxUoK8OOnrRndI92SpgRLxnw8PVDvwyxTh
         G3shtEx7OUa/CAttWXMjvLCvTlS31H2Z5trdH+i33hNMPn6DAkOGwJXr78mkLeZNBx5H
         6qx7QW0QIz1cGO9Q72eaz/B7GGA9lZMceePu39TW6jgSRwIGT55y/izxy/lPDS6gnm3Q
         NU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759483; x=1703364283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybN/JQklFxxdvbFcBG4Es2B5/vNf6JnHtZJeVvDftTs=;
        b=GpPGwnUFJKnEfHxWu0kbNpy1okeykn/egOhR4UmynMFdlqCAqaDfBg4/jHZyDWshJl
         G+sEjJmrJB3A8fcR+To1D1DhvZq4kO5wPh288mMRJFZ6N+EmkiDBIuSC2kI+enqzwSWO
         iZ6Qt9zItJ7E8+1uDcXbvJhgt492MquhzLdBUOzeUmWmn4CXp0P8q0K88nn+pZ4JiPFK
         7obzD6HE5uaCxdAGYo85JEDtcapDhlsFnsa1nBCtK5ojB8OQwgizkYwdzwTKEJmLyzwL
         487gDgsw2IM9QjDYx6U+p7I7QaavIV8oQLJRND6GWssGrzCvXDN59LgUhJp0x9L0ZIZN
         ujwA==
X-Gm-Message-State: AOJu0YzCr83ueYm3Q6htaB795TB/MH2BPHw8Yf1VX9WpmfvE2Wx8vRvf
	2jLw0OwlrMHC+6A1lX0WNN27Ug==
X-Google-Smtp-Source: AGHT+IFS+D7hlgHMH9sAM++x5AYwE83AGRQcAr/xbc7bmuINTK8pJP72qUuiI6LP/a5rxdqYqmX+Cw==
X-Received: by 2002:a05:6870:2803:b0:1fb:64:1b25 with SMTP id gz3-20020a056870280300b001fb00641b25mr17527329oab.24.1702759483328;
        Sat, 16 Dec 2023 12:44:43 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b0028b5739c927sm1380343pjb.34.2023.12.16.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:44:42 -0800 (PST)
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
Subject: [PATCH net-next v5 0/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Sat, 16 Dec 2023 17:44:33 -0300
Message-ID: <20231216204436.3712716-1-victor@mojatatu.com>
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

Changes in V5:
- Drop "EXT_" from cookie error's drop reason name in doc

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


