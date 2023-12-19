Return-Path: <netdev+bounces-59085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2578194A9
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 00:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1951C20D76
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D723D3A0;
	Tue, 19 Dec 2023 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD4LIhBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D13D0CC
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f09756761so42682496d6.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703029110; x=1703633910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4dCIowv5n1t3eI/DXvgwN8ICcevWFK0pwtv3M0mcLo=;
        b=nD4LIhBO2DfKjK6vedCAeKO+MrAT/uiGb0PISRBkhLyxSYN1gvQKkaiwE/GqMv0MgM
         VnW+2EMTqsImiTOqf+X/c8mZalcHM99rn3iFGUHjVs8wSihTzQOO1HcW7X1BJ6iflguS
         6NVK4FxTc9hAFQHMx29XCRBk0ngQ0P59PJ7AZ50mKF8PGJEB1ceQrIodDDlOBFG0hdTD
         f+EkSiW7okwKgaG/zPwT0HQWDCWwEPYZ4UolViV4KmmCZqZps8gnYG46le/xayxlumOS
         o6fJVa1SXFKErm33n0o68g8sUEOuaFzTXFr6JkL8X+qkBFdzuj+awioNtrkwuOdrJC0a
         4rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703029110; x=1703633910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4dCIowv5n1t3eI/DXvgwN8ICcevWFK0pwtv3M0mcLo=;
        b=iEk/SpudqzuukeXdw5CadpMyfbd8vu0p/xpe7tYkRlJNefQMZMEtiEeul1xlpSDHoa
         bhtcfOjikzxC1Z3Ur+LTN/GQ7PbjEm4Lw72a73JfYSSlfR68M9lXN7zeWQi7q1IWp/bw
         NAwbgnzklgnKi79fBfpPs8U9MIZU0hlQJgWGos8o0shSrLyGZ5dKm4/ITPY0Se72YHzu
         qTwAY44k17YNObv5HIsgvM5/yNssn7BjxhnFcDpli49b+BtvvbMDkDslhhQ7Jz1FAGL0
         J4MklSCTevn3KjoFOQilQZ3m5qP5CheEYdwAa06Z4KXPCyCoVbySwoNlQm3cP7ceX4Dh
         pbVw==
X-Gm-Message-State: AOJu0YzwE1EeNXKGdk/ER0XdBfMytvKc3MYO3vB72QLihYAx7nUHObfw
	LSah1Z0FumAWcusRye3mn5SML4BIdy0=
X-Google-Smtp-Source: AGHT+IF4LgJ70iBrJCsWZ07RvO2n7id15m/pRzgxPkeYn/jteju+vSxrLQaDDep+IZZvEebZmnaz/A==
X-Received: by 2002:a0c:c482:0:b0:67a:a721:f311 with SMTP id u2-20020a0cc482000000b0067aa721f311mr20302104qvi.81.1703029110437;
        Tue, 19 Dec 2023 15:38:30 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id x11-20020a0ce78b000000b0067a10672b80sm1963655qvn.48.2023.12.19.15.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 15:38:29 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 net-next] net: pktgen: Use wait_event_freezable_timeout() for freezable kthread
Date: Wed, 20 Dec 2023 07:37:57 +0800
Message-Id: <20231219233757.693106-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A freezable kernel thread can enter frozen state during freezing by
either calling try_to_freeze() or using wait_event_freezable() and its
variants. So for the following snippet of code in a kernel thread loop:
  wait_event_interruptible_timeout();
  try_to_freeze();

We can change it to a simple wait_event_freezable_timeout() and then
eliminate a function call.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Replace 'HZ/10' with 'HZ / 10' to fix the complaint from checkpatch.

 net/core/pktgen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 57cea67b7562..ea55a758a475 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3669,10 +3669,8 @@ static int pktgen_thread_worker(void *arg)
 		if (unlikely(!pkt_dev && t->control == 0)) {
 			if (t->net->pktgen_exiting)
 				break;
-			wait_event_interruptible_timeout(t->queue,
-							 t->control != 0,
-							 HZ/10);
-			try_to_freeze();
+			wait_event_freezable_timeout(t->queue,
+						     t->control != 0, HZ / 10);
 			continue;
 		}
 
-- 
2.39.2


