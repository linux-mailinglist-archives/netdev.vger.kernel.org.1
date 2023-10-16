Return-Path: <netdev+bounces-41224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B077CA446
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C251C20A7E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6381F60A;
	Mon, 16 Oct 2023 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pIqt7Ahx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552E1CFAF
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:09 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE22DE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:07 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66cfc96f475so22893446d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448966; x=1698053766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=pIqt7AhxmLxtkpAm3ipvXF5+o9f+Un7QoplShNrF8YS3wmGmAl2ZiC8a7Ku8qWciUZ
         vidRDJkAWXD3J+/oUj2dZ6pD1ynTc71VkAuAydEWp+fwU1Rje9U7b0HBEV+kBO4T6061
         V38Z2fC//DXwyNzf5dAjFQnGRRF3MD4GjeW8iwm1Ppt1QDMuX/BjpE69EkIb1A+qcK2R
         coCg/nBg32qxrRrvK98y53Y3juk8MSooeslSRQBzoAQehUhO/zksZW0cxbLqHYKks2tC
         QJkH0kjYsS+SdRrTzwKOxQKf/4wSYR5zmDCzCYk/2/9Gpjn0Q/s83cSaU0nbsnqKWTdx
         Rifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448966; x=1698053766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=vxVUP8Elb0rgEgdkGphRfj9A/GN3+F8sSEv1J+IOLJL0BQxd4mwIBosgjwC6j8eYSe
         tArAM4ni5bHtYR3Bp9TgP9UJENELr6nYzGI9QEcsmD4W+C3RVpS9fR8uezWELF9EweMd
         lxc74q5uSPh/3mncZyknLe5HrSZ1Fx8DbVR+Bw8Kh15ghiZPXxolSTJLYw6yQMXSED/n
         afpfDsPp1epQGDGSanEpKlAdjq4jaJwfnzpl1U1EZnYhAMMpMZNGAGx6rj7FV6xFwIHk
         bbSImbTeKJfOr7fr9t7SL48TqANyLizgiGO0kiJNJ0hm+tIvLqOI4yNh24N/vVzsUruz
         rgsA==
X-Gm-Message-State: AOJu0YzwjCNVtrlFRr8Y1/+gwQ/n6zn0yUslBRij2nHLQFxkYRqtbAGL
	3B4xPu7HrY2RRsKDd0f/yqP5fiZW+X8UCEfUgs4=
X-Google-Smtp-Source: AGHT+IGn0wJvuD8uIX9MYxyBChV0jozCS3lomppYD9HUzs946bFyUyZPzxxGXH5ndF6u+1F4ZeKgaw==
X-Received: by 2002:a05:6214:301b:b0:65b:1594:264e with SMTP id ke27-20020a056214301b00b0065b1594264emr36165284qvb.51.1697448966418;
        Mon, 16 Oct 2023 02:36:06 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 06/18] net: introduce rcu_replace_pointer_rtnl
Date: Mon, 16 Oct 2023 05:35:37 -0400
Message-Id: <20231016093549.181952-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
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

We use rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held()) throughout
the P4TC infrastructure code.

It may be useful for other use cases, so we create a helper.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306c..971055e66 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -62,6 +62,18 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rcu_dereference_rtnl(p)					\
 	rcu_dereference_check(p, lockdep_rtnl_is_held())
 
+/**
+ * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
+ * its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ *
+ * Perform a replacement under rtnl_lock, where @rcu_ptr is an RCU-annotated
+ * pointer. The old value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr
+ */
+#define rcu_replace_pointer_rtnl(rcu_ptr, ptr)			\
+	rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held())
+
 /**
  * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
  * @p: The pointer to read, prior to dereferencing
-- 
2.34.1


