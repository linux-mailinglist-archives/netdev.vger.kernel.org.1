Return-Path: <netdev+bounces-18133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAD75574B
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 23:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C3E1C209B0
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9348F7C;
	Sun, 16 Jul 2023 21:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDB79C1
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:09:24 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18DE56
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:22 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440d1ba5662so894079137.2
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689541761; x=1692133761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPmeh74mbfvjyqs3+8cn756OjNU9G3nDoqAIifmkRso=;
        b=QZkSHL8G2ZRtw5XdSQbQrOTLODnMrF4X9ITT5mS/aaZb3nST19V6VPQE9xtbr5BQYV
         Bj7jYkofewrrZlkBhPJu69W3Y829aWSPOgRAqnVC36xqZoJP2yjJnezeZQy05y4215a2
         +aw/WqWAtV0kIy1tGx2q6tOrAbO8LlOjGeJpizkqMIgnBIVwevioLKcw00/gUl0qHBa5
         BWDozK4nebqBalefN/2OQKwQK9L/WNlFkHnoJRGjEOU2oh4tJa772CKZ61etP6VYI96Y
         O0D0TPvvtGtQDJAXKY5izBM/lhBQS78megNE7/mCUWrFTJ20rYPKsFtKjV6KklXtUGOM
         I5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541761; x=1692133761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPmeh74mbfvjyqs3+8cn756OjNU9G3nDoqAIifmkRso=;
        b=U6lGDYp07YNamh2BRf/lDKUil2CsdaqhnIVILruMLrOgFJsZEa/w8cC8FKd+Azin6h
         KpxRLs1bzo5ZnThlrFmReYzXZz9nfHlelGCLg7NcmR5tsYb9nzMJUsgvH+ZO+E7VYPMo
         suwbcVciAL/NbMfIdSgtUCbfZYHAjZpOjcCr9NU7F3aDgceza+aKfIDyPrbtP7iM3zy8
         r2G+a9rAP4Xp5z124Zk/3K0RcMNIlCOYunpS4VULMhPaMck/VnOux8AtyTc48Cu2u0eZ
         N7t2dVSVOuS5QqqlCSVdBWrFE2FBilKamM0lx7D2bzjmxbUAML+wVQzowdzMwzQlhfTW
         wAXA==
X-Gm-Message-State: ABy/qLZlxMTxkCcPDKYLnZRELbwKzyL494mjYr296aVm4t7VXOMpsXy4
	L+ERTXXOrh/hASECuD2Z3CepbyYZdjxRLA==
X-Google-Smtp-Source: APBJJlHrEqUkgb6GOcOLCIfTQy5XMVcnhvq6cr1wQN/LvObNoD9w6JVR//yE7rwxLXoMM/c/SI0J8Q==
X-Received: by 2002:a67:bb04:0:b0:443:621e:d138 with SMTP id m4-20020a67bb04000000b00443621ed138mr3799081vsn.5.1689541761378;
        Sun, 16 Jul 2023 14:09:21 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b0062635bd22aesm4654745qvl.109.2023.07.16.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 14:09:20 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	dev@openvswitch.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH net-next 0/3] net: handle the exp removal problem with ovs upcall properly
Date: Sun, 16 Jul 2023 17:09:16 -0400
Message-Id: <cover.1689541664.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the OVS upcall, the original ct in the skb will be dropped, and when
the skb comes back from userspace it has to create a new ct again through
nf_conntrack_in() in either OVS __ovs_ct_lookup() or TC tcf_ct_act().

However, the new ct will not be able to have the exp as the original ct
has taken it away from the hash table in nf_ct_find_expectation(). This
will cause some flow never to be matched, like:

  'ip,ct_state=-trk,in_port=1 actions=ct(zone=1)'
  'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=1)'
  'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=2),normal'

if the 2nd flow triggers the OVS upcall, the 3rd flow will never get
matched.

OVS conntrack works around this by adding its own exp lookup function to
not remove the exp from the hash table and saving the exp and its master
info to the flow keys instead of create a real ct. But this way doesn't
work for TC act_ct.

The patch 1/3 allows nf_ct_find_expectation() not to remove the exp from
the hash table if tmpl is set with IPS_CONFIRMED when doing lookup. This
allows both OVS conntrack and TC act_ct to have a simple and clear fix
for this problem in the patch 2/3 and 3/3.

Xin Long (3):
  netfilter: allow exp not to be removed in nf_ct_find_expectation
  net: sched: set IPS_CONFIRMED in tmpl status only when commit is set
    in act_ct
  openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set
    in conntrack

 include/net/netfilter/nf_conntrack_expect.h |  2 +-
 net/netfilter/nf_conntrack_core.c           |  2 +-
 net/netfilter/nf_conntrack_expect.c         |  4 +-
 net/netfilter/nft_ct.c                      |  2 +
 net/openvswitch/conntrack.c                 | 78 +++------------------
 net/sched/act_ct.c                          |  3 +-
 6 files changed, 18 insertions(+), 73 deletions(-)

-- 
2.39.1


