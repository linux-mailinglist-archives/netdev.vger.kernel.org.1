Return-Path: <netdev+bounces-40685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226537C8565
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64A4B20A5C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD514A99;
	Fri, 13 Oct 2023 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="14m3kXmg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7F14281
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:38 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B73C0
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4060b623e64so13271195e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199035; x=1697803835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BteKlWtczwBbbi14X3hBNkX3nvVNrL0AnYEmsEZz+A=;
        b=14m3kXmgIbIpNzubgIPmYhsCgqkAT9HN3Xcg8gKMInDbqSXVlnVTnR7Crrsq/6xdNA
         tVWe1HU/jqxo3yeqi2/tUNg5mGEEHzJMUtcZL/trpVJaJ/m9+BEg7R+Qv1T2dy8yYs3l
         TW64qYjkZXr8c5iyx+OX9fdkpmw25Awegvn4qV3RFHNEEibfak9vl+0HehKWqxLFniM4
         1UvQatksu57xeHjMN6u8vm5UAno1s6OMiGYW1I3M9O2bn/891YxxIIghC1c2DaMSrN8X
         s/SiGQ08Hbzsl9UYQP5/qMxiblSw3l46bJ4V1Z2cBppnZviflb0TcDWphEOpLJhQhsNy
         UMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199035; x=1697803835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BteKlWtczwBbbi14X3hBNkX3nvVNrL0AnYEmsEZz+A=;
        b=S/uxstdiqc0VrjyYC8FLS9A4R98q1u1M8RrA+pv+Ocdk3730xHdazrzHHZQ1zt66lA
         2ItBYWGoaxecAshG6T2y2C92sW/z+7A/IzyrBlN8XYtBIgteBCfAn5qwajztWm+4a4sV
         nl5cKVnD2/4x4MBhxXg2mbA9htaLOiZbToz3D1U7hVuvclJR0grmxDdc6z9YB6Q2ZDfa
         BXaolSO6QN5mFwKaEk7Dwqa44bJzHQdNjmDDlMAzaX+pRV/eKhyMk3qk4K3DLZqTQBOm
         8yNlX93lqRAoHTmAyCS0DxO6p3QckFjZ8pzi9AwbWhcOxaDUrkuSnacE/0I80B5gYb+3
         jiOA==
X-Gm-Message-State: AOJu0Yyo5FFN7GJAzme41Jejj5iy4j+vTPocpo+UWTM+fRt8bopw0oW6
	jMP+38iIsaa/Pw3qQCyq4TzFZedkZEfk+8rTIrw=
X-Google-Smtp-Source: AGHT+IFRxfF8goVtrFGDSjask3+O/R0TaODjDOIgJ+e66thMh2TQ06GeXjpDVVvnlknZcpDIuEyb1Q==
X-Received: by 2002:a7b:c457:0:b0:401:c8b9:4b86 with SMTP id l23-20020a7bc457000000b00401c8b94b86mr21696614wmi.9.1697199035307;
        Fri, 13 Oct 2023 05:10:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g21-20020a7bc4d5000000b003fbe4cecc3bsm2336288wmk.16.2023.10.13.05.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:34 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 2/7] devlink: call peernet2id_alloc() with net pointer under RCU read lock
Date: Fri, 13 Oct 2023 14:10:24 +0200
Message-ID: <20231013121029.353351-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

peernet2id_alloc() allows to be called lockless with peer net pointer
obtained in RCU critical section and makes sure to return ns ID if net
namespaces is not being removed concurrently. Benefit from
read_pnet_rcu() helper addition, use it to obtain net pointer under RCU
read lock and pass it to peernet2id_alloc() to get ns ID.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- added fixes tag
v1->v2:
- moved the netns related bits from "devlink: don't take instance lock
  for nested handle put"
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


