Return-Path: <netdev+bounces-12319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B1737162
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E1E28133D
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04A17AB3;
	Tue, 20 Jun 2023 16:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5971773F
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:24:57 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E319C
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so33674255e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278293; x=1689870293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZiePvQp+al3FKzqRXjxppdYvMnDeS6krGk8yswyq9Q=;
        b=fI/g/+kKD47r49rMcbAbcJPR+NnnqJfKICsB7eL0o5deyMZKztnVC73myKB9iRtztC
         4Hn0BVeTuQP5t3t6Vd1k5jHM9yZshtNWIibtlQifw+lCLjHcFVxKe/CwbIas9yv1JI1I
         /o3pXsIVNndYYnHcL7rJwHZsviZxCM0bBIpwOyDEQcD9zkAgliutLs9JkDOgX9k4hQg9
         PcdKCdRclYGW14VSRigyA/7ZedsVpVK0dpw0ck6Kq/qXcnM+dB4tt/yJ2ypTgsPovJi+
         FB3kPB9w4ebf29536naaOnUlPMIS6Pm3IaMBt8Z0GobnS7irhx2wkgg5JppHa6/vNgU7
         7S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278293; x=1689870293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZiePvQp+al3FKzqRXjxppdYvMnDeS6krGk8yswyq9Q=;
        b=Vs/TTR+WYulb7SGinQhhaON/DZ2NrEPPG6P0FVj9rULIzlsLXB79qVVkSmfAydG5av
         Rzb7IwblDHwJ+9EU0MUQy5uSyvr+WMfk7aK9L9hS76+kUQsCbFk4eSOXxBuDLV3DgCa2
         XuKMq+Z62RXFlxO6CkliTgp/JyWU29GHgaemCKlsj9/TixPusa4QoNHUkwBG8A8WiIVb
         lqbIwgCieoacuUqZwE56oo/Ig2xzaSw1Ch4K+V1C+kSNSWX5niHpK8HiGNoDdbFLlVyh
         cAmWG+JBkrZMDvBlX7tjtRF7BCaO5wqbdQwM5j0EhYTm5jUmaQHb/YYDfSMo3bStYbAJ
         NndQ==
X-Gm-Message-State: AC+VfDyhxTszankXAHwtiRN+uq2So7mWRBcmUsa68UodEE4z1Y2LmiRd
	5umtHnaCr0JYcY1HFBuCuZZmNbkhydnic6aHLUGdyQ==
X-Google-Smtp-Source: ACHHUZ4X++gNkgkYQ9NR8U6rUE/PLbEipynm2A8AZLg+tAv7RRPTrtOeK0PvfcP4WlkHktxcCRMyGQ==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b0c2:9ffb with SMTP id y12-20020a1c4b0c000000b003f9b0c29ffbmr4371716wma.27.1687278293150;
        Tue, 20 Jun 2023 09:24:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/6] mptcp: fixes for 6.4
Date: Tue, 20 Jun 2023 18:24:17 +0200
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHSkWQC/z2MSQ7CMAxFr1J5jUVIByGuglikwaFeNK3stEKqe
 ndcJFi+P7wNlIRJ4VZtILSy8pQNLqcK4hDyi5CfxuCdr13nHS6zFqEwYqaC/3RkjZj4TYppElw
 7bLBtKTX11Sa+AfP1QQl7CTkOh7Gcf6qjnIW+d2vuYGp47PsHY5hLqJ0AAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=MNa5Zv2WFB2ZD/+VqaVhvs5aElxmpw5Mk5036ctzZRA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLTrZXGyWJzsiM93UPDbxMayZGi+q+lQqlwQ
 lE9mY6wj3mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS0wAKCRD2t4JPQmmg
 cyhvEACAvM4cqa/ydDhDCawGPClVtar8UI4PjG6ao+G7lEP8B4oH7sP+TDEawGc4JM+1Wm9JEWB
 /suKJ6vMWwbL7i5lqpk8a6y35pfPVl184tth9q2Gtm2uRqWyfBAxesZHuCL+TuP/Ig/PAjmI87Z
 RqfLcg9JJgesS/cRlZfCehYRspt3IYkEUyPHW/Wemr7CkNgq4qHshmy53yTpkOVMA3ebvHHi2sB
 aKS8kLUOLOji9GNmLxE2CrURJHUjmLu8h2MXH6+32U7kDNlQIULT99mX8Y6ch4xedJZ3rcaceCh
 kKt8adyNx8aW+1l/2mS6N/hphYDJP73sVSclLiTM9MPWPz3qa3mGXieAatqjrHHJWP1o9PDZIcV
 EqG4w28G/z4AvQLP6r///6Un1qNhKfB9PXejE4riUT3UAYHmzNiHVl+HfwSHOBTSfPhDaryeAvC
 6PcztG2KdwEVTLDMshc29RC4uXC6QDvGL7TNrX76dChRcKC5wqSKwPSlYCmwMJmhx1fRtSmVsrf
 OyBM5p0aV5gXN25PjmfAMvbLCxjrGRC4hXTr0Fcokmqhr0ucWMDqGg1VIRbTR57UmBH/SntfJ6i
 M72B4ZuW1k3Zo0jzzhzsgt0lyQhOxfrvH4em7QehaDO7pFj1MbxPqQ0wvl+w3+WhOZDv/H4UuJf
 TJVoZyX5aifKV8A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 correctly handles disconnect() failures that can happen in some
specific cases: now the socket state is set as unconnected as expected.
That fixes an issue introduced in v6.2.

Patch 2 fixes a divide by zero bug in mptcp_recvmsg() with a fix similar
to a recent one from Eric Dumazet for TCP introducing sk_wait_pending
flag. It should address an issue present in MPTCP from almost the
beginning, from v5.9.

Patch 3 fixes a possible list corruption on passive MPJ even if the race
seems very unlikely, better be safe than sorry. The possible issue is
present from v5.17.

Patch 4 consolidates fallback and non fallback state machines to avoid
leaking some MPTCP sockets. The fix is likely needed for versions from
v5.11.

Patch 5 drops code that is no longer used after the introduction of
patch 4/6. This is not really a fix but this patch can probably land in
the -net tree as well not to leave unused code.

Patch 6 ensures listeners are unhashed before updating their sk status
to avoid possible deadlocks when diag info are going to be retrieved
with a lock. Even if it should not be visible with the way we are
currently getting diag info, the issue is present from v5.17.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Paolo Abeni (6):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine
      mptcp: drop legacy code around RX EOF
      mptcp: ensure listener is unhashed before updating the sk status

 net/mptcp/pm_netlink.c |   1 +
 net/mptcp/protocol.c   | 160 ++++++++++++++++++++-----------------------------
 net/mptcp/protocol.h   |   5 +-
 net/mptcp/subflow.c    |  17 +++---
 4 files changed, 76 insertions(+), 107 deletions(-)
---
base-commit: 9a43827e876c9a071826cc81783aa2222b020f1d
change-id: 20230620-upstream-net-20230620-misc-fixes-for-v6-4-55ef43802324

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


