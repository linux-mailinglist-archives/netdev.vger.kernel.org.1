Return-Path: <netdev+bounces-29360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC7782E67
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1411C208E9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F08BE7;
	Mon, 21 Aug 2023 16:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5488883B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:26:29 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DDE4
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 09:26:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74c58a3dd7so1357316276.0
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692635188; x=1693239988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHeIc4uIPhhfop/jovUZ/PfE5D3amkXZMQILrkiF+c=;
        b=J/c2pO9b7s8LNmNln9ICs3lWssi7/iUTkE+v5wtQ2wgJHvuI9uTCDSkACZewMyIjOC
         JkARqEXLYD76ey98G7kb1yENfVmaqP+RHvh9yO0fJrJoGI9lB/uUrIsyTsJpaZngOTu2
         GwH8BETFoOPB57smgPZpCHO+doiRxjsjzeRrhpOZ9osOhtO9fyPd3iWSjCMDv4Vb7D96
         qWmrDjLQkXM5VwDQwAnbuT0kTouS1ymmwzhmUXXkmNcX7JZsvo5s2GI4y/+vf5PzjkfF
         qJQE3VJHBlQ7aLgrafH7RWLrVNkzS+C16CEJXDeOAkZgJ4VRkTNvrfE4+nr0KMsvdYj+
         zUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635188; x=1693239988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcHeIc4uIPhhfop/jovUZ/PfE5D3amkXZMQILrkiF+c=;
        b=XosIGTygkRwEqsDFqP6L3dab1ehfps36Y9DMtqMz4zby5HT1Q/JN8Q3wMZIf6NXDRK
         WCKAayCmIUQTGYxGSChxnLQFNZHQ7Ci2XHB+hx4BDeom/QJTX01yy5f77Z1xpRUVihXL
         0INdkTX+bR3FIVP9t65qPjwEHFnkh95k2UGBHPPNBBSolZohZKAHjz0UmXXxiR+qu0D8
         F7EpiqDPOx7/RGw6K5eDvG84TWKdr6uhJrShORhVdPpZUqhmwDMUtVNCwC29I3j2bw4y
         poHYkuMvJyfMkreGyRulWt+71d2LKnDgDD/4mJoAil7SX/gJAri9ivZHLi9xGLQ/+/5z
         jypA==
X-Gm-Message-State: AOJu0YxDkY+KHrhX0AGyBKNTwpH0Faf3WBRsJXISp019us0Q65Tb1tBU
	ehbMPFnct6NAwP3SdovDo00RTK4fVg==
X-Google-Smtp-Source: AGHT+IEKk6ir9f3QYR9y/Y9TWPRxBxtvOqvYfm1C6zA/ZsWJLYE/AJF/O5r+aVSAW6ZlhVfWO8yKW4slmg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:d809:0:b0:d4c:d744:2ad with SMTP id
 p9-20020a25d809000000b00d4cd74402admr55674ybg.10.1692635187866; Mon, 21 Aug
 2023 09:26:27 -0700 (PDT)
Date: Mon, 21 Aug 2023 11:26:16 -0500
In-Reply-To: <20230821145933.98511-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230821145933.98511-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821162616.640423-1-jrife@google.com>
Subject: [PATCH v2] net: Avoid address overwrite in kernel_connect
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
V1 -> V2: Rebased on net-next

 net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index fdb5233bf560c..90c07148835e6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3567,7 +3567,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return READ_ONCE(sock->ops)->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
-- 
2.42.0.rc1.204.g551eb34607-goog


