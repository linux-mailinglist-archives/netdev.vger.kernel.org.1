Return-Path: <netdev+bounces-39480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7437BF6F1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC032823C6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D8171C7;
	Tue, 10 Oct 2023 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Hs9C7DGQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4701642E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:13:31 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B8B6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso50925045e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696929208; x=1697534008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys3M6zHOX7Elv2IfAd0le9lr8unUZrC76iPfizmCO4U=;
        b=Hs9C7DGQx9Ph23tep31ySlNqufNeLcfdwgHYu6oIZoMChA2/rAaf9336FPLsdvrOXG
         a4RRAkIbATzOIBb5BYWse2BSZyYphoP+VW4JNjtjzxHhy+WSbDRtsEaxO2BSp0TW/oNe
         Ql9wMguR7ES8gCc8IUeCysOhEWLz8iNP/vy6NzGS48iWe6BJ86eq+qs9zL4NYSSs92Ex
         SYrTehLZbTXHpx59VrQJJpbBU24Ned/dEpAOcYiKE8Gdc4XMFTlwMMn/71Mhi7A1MXv1
         q8NOuOJBj8nTcWqgvwS9KFj+Q79oo0h24GbY3r6E5hpblXULXycdxHDd/i7OXwyFkg1w
         M0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929208; x=1697534008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys3M6zHOX7Elv2IfAd0le9lr8unUZrC76iPfizmCO4U=;
        b=izQhjAMemKB0unGHGO8YilYrezS8TmIYW3eDU8RQs60Gt204nXiWmCB0rDuX2nzMSs
         2NZ4uS7Bra+zvGkmsGBetRhxaMggXCPDiHTXN9EAKTHgHNxIQGFth7Tnm3KmkcvWsiKV
         JB7UMCsOJYJNMpw/Z3zkUx3Q7pRU9BZV6HPdSk4QZGgrGCt5mDLYjKhIa2wIPKjDdYNp
         UhkUdOg0bODryh7F5tVcyReMghxI4LM0vmTwpz8JglIaW+8R9vr83TMko+QtI/KWGDZD
         P+6NZZ93GWXNzfPLkYjG3HJ30brRo8TuDBlrwbJViKmru+JHidHYYMPwh6d5ObDo4CgZ
         eOUw==
X-Gm-Message-State: AOJu0YwJx5raTu0W3oWlXy2g3TcQwLTy+D7QLfu5JGe+nMJxHHOTM70t
	zubFvwgyt/d9IiPcZ5miQ+V4IPXW0rZqH1+kN5o=
X-Google-Smtp-Source: AGHT+IHL0XfEJVFdWtMuB+KjwQviMAE7hhNnajXr2jpbso062dsGLrE+5NWVFcx20NX4At6CEWXwaQ==
X-Received: by 2002:a7b:cb89:0:b0:406:54e4:359c with SMTP id m9-20020a7bcb89000000b0040654e4359cmr15370310wmi.19.1696929208479;
        Tue, 10 Oct 2023 02:13:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d4389000000b0031ad5fb5a0fsm12073528wrq.58.2023.10.10.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:13:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2 2/3] devlink: call peernet2id_alloc() with net pointer under RCU read lock
Date: Tue, 10 Oct 2023 11:13:22 +0200
Message-ID: <20231010091323.195451-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010091323.195451-1-jiri@resnulli.us>
References: <20231010091323.195451-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

peernet2id_alloc() allows to be called lockless with peer net pointer
obtained in RCU critical section and makes sure to return ns ID if net
namespaces is not being removed concurrently. Benefit from
read_pnet_rcu() helper addition, use it to obtain net pointer under RCU
read lock and pass it to peernet2id_alloc() to get ns ID.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- moved the netns related bits from the next patch
- fixed the code using RCU to avoid use after free of peer net struct
---
 net/devlink/netlink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499304d9de49..809bfc3ba8c4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -86,18 +86,24 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype)
 {
 	struct nlattr *nested_attr;
+	struct net *devl_net;
 
 	nested_attr = nla_nest_start(msg, attrtype);
 	if (!nested_attr)
 		return -EMSGSIZE;
 	if (devlink_nl_put_handle(msg, devlink))
 		goto nla_put_failure;
-	if (!net_eq(net, devlink_net(devlink))) {
-		int id = peernet2id_alloc(net, devlink_net(devlink),
-					  GFP_KERNEL);
 
+	rcu_read_lock();
+	devl_net = read_pnet_rcu(&devlink->_net);
+	if (!net_eq(net, devl_net)) {
+		int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);
+
+		rcu_read_unlock();
 		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
 			return -EMSGSIZE;
+	} else {
+		rcu_read_unlock();
 	}
 
 	nla_nest_end(msg, nested_attr);
-- 
2.41.0


