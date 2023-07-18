Return-Path: <netdev+bounces-18502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F7757623
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73DB1C20908
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3DCC8C4;
	Tue, 18 Jul 2023 08:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D6DDDF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:01:56 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD21FEC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:01:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26598fc0825so4258235a91.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689667257; x=1692259257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnM9nZGED0j+3M+5Jdu+PHmIla1kdgEWpFteqMN3fvg=;
        b=hGWtDNzsO57W3kgZaoOyFRndSBbW8PFSdf6StKkZdJYX9MNhJfYvlSjDa3kmZy5QUR
         EMe0umOSXtqjfXZtlKufotZHNTjNpVLqm3ClA0I0WQ+LwWCWaQNC5Z3iWCyR4Q1YsI69
         jOLNthQ+OhaVocMROm+PzYQpeXru+i4zuCo4aZKqJK6aPia6xgiMHq7tgMX/vikTvgYu
         fCxW8P3PxFMeQZms7pmk2B5WDBxVgF+QthFwSV1t2QxIWTUD7/tHG2NR8165WwXssslB
         qf2j7M0EUQDdybK6/yI4w//sN+Waf9xNp8yqwIjLlFsUs/JxvIr/eL7/g3hi4q/cmDRc
         wvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667257; x=1692259257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnM9nZGED0j+3M+5Jdu+PHmIla1kdgEWpFteqMN3fvg=;
        b=hOv9m9qAJu1ndzvTjCPjiSS9KNrCbo1K8IWcomi0LJp7qgM2LT2LR6+OGcguQeBRGy
         N98yvrLzI3WtwzFtZzewboDpukj+W9bd2cku3DQhcohQ0mTDL/2ya8v3/RuC/lRAfM8y
         DuuDWa82hcYnr2hyejdqGhnD7SQ378LALrg9aKys2V3tA1QkQ+MrUWNMcbbEqpPeuMvf
         2k8CKoJfvQfrYnEg6vAiyqduyYYT6DUlznGoMWzRX9pG/E3OmT3PClTyVYWwmv5qqV4y
         RXTQ8whrStbZ2OHZLRCMwzg75bqHC610GDzlN7qYYUDSxgFhD0fSl5X9klpWO/O5/eGo
         Dl6w==
X-Gm-Message-State: ABy/qLaQXdKI4PM3WZQo0qQXBzYneWVceApiKovdTWcEx2EmB5aJyieA
	kyVXstNr3A08BRkiqGha8Dk=
X-Google-Smtp-Source: APBJJlGFKGfscoeStB6dH34JmJ4B+KNUFy/DK9edaqzDyoxh0bD04zC84tsnIy6I1A6PN637BAMdhA==
X-Received: by 2002:a17:90a:dc08:b0:262:ce9e:8a25 with SMTP id i8-20020a17090adc0800b00262ce9e8a25mr15213482pjv.22.1689667254922;
        Tue, 18 Jul 2023 01:00:54 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a019000b0026333ad02c1sm971657pjc.10.2023.07.18.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:00:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush fib
Date: Tue, 18 Jul 2023 16:00:44 +0800
Message-Id: <20230718080044.2738833-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
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

After deleting an interface address in fib_del_ifaddr(), the function
scans the fib_info list for stray entries and calls fib_flush.
Then the stray entries will be deleted silently and no RTM_DELROUTE
notification will be sent.

This lack of notification can make routing daemons like NetworkManager,
miss the routing changes. e.g.

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 192.168.5.5/24 dev dummy1
+ ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
+ ip -4 route
7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5

After update:
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5

Suggested-by: Thomas Haller <thaller@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv4/fib_trie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 74d403dbd2b4..1a88013f6a5b 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2088,6 +2089,8 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+				  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
-- 
2.38.1


