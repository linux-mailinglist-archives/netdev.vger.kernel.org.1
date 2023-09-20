Return-Path: <netdev+bounces-35263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D091D7A8351
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE00E1C208D0
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3983714C;
	Wed, 20 Sep 2023 13:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AC347DB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:26:46 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE2E6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bc3f8326so2142116b3a.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695216403; x=1695821203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veqgzooa62QmybSGRdTR/S+eXJyNjQh+8DoJnl67H20=;
        b=ipHZ8Z3WL9/25ZW0+MNk9TeR9jY9PL5OAp4V84XHg4ATa/Gnoosw/GPBme6c9Fqo6D
         G0PSRfiSLTg/Xy4sIcmPRj1nbyGi0eR+8SzcbCDnniJHSrOUcBVl3D4prO8p7mORpbUz
         zckcZk3rK1O3fM2OSEMWBwlXQSReckOBeVlChQwcKK9kR8QT1dQj8oLtUMzbcXH2aCzk
         VgnUQjWzJXASaof5gx+RPnydnXM1Gouyg6aXlDizPajes6XEv/hWVaWAvteJbqhalt9I
         7PTHFTe05h8Ko9V2SnyVujMFeZUb1isv1jV2CCNfLuqdAD49vKc9QL2sVX9eHpIT7UH6
         Baeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216403; x=1695821203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Veqgzooa62QmybSGRdTR/S+eXJyNjQh+8DoJnl67H20=;
        b=DPzW64Wwkz1PBTVZ6+h/I0MKlhLQCe8InCANnb9wge6vZlq8sAH5/YKAuhAadpvYli
         N8ayQKALxflxQ01riOw6UaXlfy4gOqEqk7S78ojzF9DZVNWkgl4DGscN/Xv3xwlUz6oR
         rsdoSs1rCgNUcRHQGnfde92UKK+jtf80TgW7oP/9hlfcuiQ4hFWN7UHkTlpvvcJhY2yB
         fZllb57azeEPuY8yYiDPBIUw5x1NrwgnpkzTLp4cZMsZyAUPmkTHqWnu0/2tGZWHPTF9
         pPd3RAuMBc9DHYRd2KfsmrGVbHntT2JQulflouktFHwWDVWUPCQUgAif11vsrp94SkTi
         6+UQ==
X-Gm-Message-State: AOJu0Yy9X761ovBrtNUM1gde6U3LdykZ4Zf65/Afj+SL8X+/ZZ4jnuBC
	idkU0KKbGc5OJXjdGNHzy/3YPA==
X-Google-Smtp-Source: AGHT+IGrw8icTYycFan9t9bmh6BiO9zJv2UR1X/P4OTgg4bKeBs1V+XJvf2VfoYF1DZv3yuXFEJ+qA==
X-Received: by 2002:a17:90b:f8b:b0:274:6ab9:9d38 with SMTP id ft11-20020a17090b0f8b00b002746ab99d38mr2489052pjb.36.1695216403079;
        Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id cl21-20020a17090af69500b002682392506bsm1333485pjb.50.2023.09.20.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:26:42 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Shakeel Butt <shakeelb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>,
	Glauber Costa <glommer@parallels.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>
Cc: netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
Date: Wed, 20 Sep 2023 21:25:41 +0800
Message-Id: <20230920132545.56834-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920132545.56834-1-wuyun.abel@bytedance.com>
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before sockets became aware of net-memcg's memory pressure since
commit e1aab161e013 ("socket: initial cgroup code."), the memory
usage would be granted to raise if below average even when under
protocol's pressure. This provides fairness among the sockets of
same protocol.

That commit changes this because the heuristic will also be
effective when only memcg is under pressure which makes no sense.
Fix this by skipping this heuristic when under memcg pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 379eb8b65562..ef5cf6250f17 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		if (memcg && mem_cgroup_under_socket_pressure(memcg))
+			goto suppress_allocation;
+
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
+
+		/* Trying to be fair among all the sockets under the
+		 * protocol's memory pressure, by allowing the ones
+		 * that below average usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3


