Return-Path: <netdev+bounces-29448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4117834FA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46E6280F2E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF612B6D;
	Mon, 21 Aug 2023 21:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBE1173C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:46:21 +0000 (UTC)
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B2CE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:46:19 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1bf00c27c39so5211351fac.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692654379; x=1693259179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhZMw6nXfPUVMGSdT90V9xaZcJzl+brHZxnb3PHJabI=;
        b=pI4rj+kYd2M19yXVgTYW5FQff9hUwA1WNs8hPyesMiGGqoplGgWuU4UG7rnJzhJfBP
         rtPCa7et8MsNxS1vDrVDMhS/eO0SaH3d9Fj+KmPhXi6//05WMhQb9h/JgCcOVxI8HB2R
         +sWqvZNOm9JBb0KtswXgdYYNeOYM7lXZOorVqzODREGIR9XU95OOYeFXYvPkrtEyVenR
         HDhtJTfm6lp3GzWZi477TgXSEoDkldxj4kx1FtaFcAmFQgXutKMBbGgftQtu3xLqH+Jr
         YDPU4jduyN+V0KMBE8ueDTIMOLtt/ygbEw1ORrsJcZqNnE54kOxLrxaJ5STfQENZ7VRb
         heNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654379; x=1693259179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhZMw6nXfPUVMGSdT90V9xaZcJzl+brHZxnb3PHJabI=;
        b=c/1cGrR2HhQZN2TotBO81CD7Ff3Q6qKav2ZYrYXAQHd8bMcClq9WCpRkmdZP4tAO6p
         zhWoPA34r6TIwwgJJc67zFKQJeIeYRnEZUAl4xpP4+dXTdb2qR7P8+nmjTk5RSfkaOA6
         wzHpyAWjyIzOPcJunCoyKCRAxqQzMRR7l11qbwI9FBdGWcygiiJ1UiJI+/rBvX0wzZL/
         WNQpDTYTtcQVEKFQXQeyiLKtQ+89GrGYAFE9SgzgYVwHBf/EChv4LjEbFBIYFjICRdIC
         urigSC5REQ/+JFTdu29VlUCLxy1nO46QOF8T3AHv2UyMytaAOOzmjEhF/McWccuRxe6I
         fIIw==
X-Gm-Message-State: AOJu0YyXpYzrjSE7TjOO8Ry8S7gLFdlDmDPEHSha+QbCcUaSv04ZeEgz
	T8Tqs+K9mLy2arWl2ebihUO2b7fSCg==
X-Google-Smtp-Source: AGHT+IFY2rg/zfHiwkr13cpMBocY1V23wqDCHAXxzEgXkucckOqrpb/cZVKL0AWR4FEhn++ODtmu7fhBPA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6871:6a95:b0:1bf:d3b8:5cae with SMTP id
 zf21-20020a0568716a9500b001bfd3b85caemr86820oab.10.1692654379200; Mon, 21 Aug
 2023 14:46:19 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:45:23 -0500
In-Reply-To: <20230821162616.640423-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230821162616.640423-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821214523.720206-1-jrife@google.com>
Subject: [PATCH net-next v3] net: Avoid address overwrite in kernel_connect
From: Jordan Rife <jrife@google.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF programs that run on connect can rewrite the connect address. For
the connect system call this isn't a problem, because a copy of the address
is made when it is moved into kernel space. However, kernel_connect
simply passes through the address it is given, so the caller may observe
its address value unexpectedly change.

A practical example where this is problematic is where NFS is combined
with a system such as Cilium which implements BPF-based load balancing.
A common pattern in software-defined storage systems is to have an NFS
mount that connects to a persistent virtual IP which in turn maps to an
ephemeral server IP. This is usually done to achieve high availability:
if your server goes down you can quickly spin up a replacement and remap
the virtual IP to that endpoint. With BPF-based load balancing, mounts
will forget the virtual IP address when the address rewrite occurs
because a pointer to the only copy of that address is passed down the
stack. Server failover then breaks, because clients have forgotten the
virtual IP address. Reconnects fail and mounts remain broken. This patch
was tested by setting up a scenario like this and ensuring that NFS
reconnects worked after applying the patch.

Signed-off-by: Jordan Rife <jrife@google.com>
---
V2 -> V3: Broke up long line
V1 -> V2: Rebased on net-next

 net/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index fdb5233bf560c..848116d06b511 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3567,7 +3567,12 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return READ_ONCE(sock->ops)->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
+					     addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
-- 
2.42.0.rc1.204.g551eb34607-goog


