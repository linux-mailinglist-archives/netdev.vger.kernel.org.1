Return-Path: <netdev+bounces-35044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889D7A6A3A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2175C1C20B65
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A629347B9;
	Tue, 19 Sep 2023 17:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B918460
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:53:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9B98F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:53:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d817775453dso6023743276.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695145988; x=1695750788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qQrU6vyyJK+GpT4LI0fE5qrjc1subTmaNwUd6fCEDnk=;
        b=UdMK2/GAiIcYKbSCU2NzF2OfoRrK/BwzwC2mdG7chDSb1yyhEZDui20rNe8ZE+PipI
         aweEiHOL7S16kCjvK9SraDEDDGXQbC4vCjDNK8MrEUSqWnNstCZWRYwQblXulWDd0yf0
         qHZMG8R1VlFKnUyAAlJkeKU4ZJ9K1Orwmi+JwyO+y5+Db5vALMdhEOA9OfBMuCA71kR5
         EvumUP4J3bbsi1zB85nimpuDP34xIoehNEqkgTjnl1a3jHrdk3U9hS+ObjRR/KqI5BMJ
         9ZVPhIvkz5Sg+E/+jeHgmEXHt3SZXanV6jvSZxbDDSw0uUC4MCd2UYaL+4PrZq6ZYMxc
         TRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145988; x=1695750788;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQrU6vyyJK+GpT4LI0fE5qrjc1subTmaNwUd6fCEDnk=;
        b=CX9gxDRBiu7pbbcR4kWAYViU86mK/S20geVZQEXM1G6oSmKRizQDCKAPIQ8VcMu7q6
         GmXD0eAifTofP4MuhT2gx0FOCaCQCsS+EAkiIZaIKBEfGd1Xomr9rq1L6EHlc5M6XJtf
         QlJeqRSKk3+xEoI4tVTQk0nsIW9YMVe9AcCwqysA4OMBBRhv7Y/Y+P47wYznqPAo4p/K
         rISms8DbV1cD2JBLj//yn5a1LRZsA0nq4WhfUWUvVrP6FEXb5t6mxAy+Hpjf0vUsjGnT
         +JeEvqGSMtTyDtPva4ZDBINSqMQUFWJ6JwGVfMt6iP+8mU/2IgELpDqxoELKgFPQX39X
         paRw==
X-Gm-Message-State: AOJu0YzIFFZ0oak+rt5cdlypJvD7fUvOP4o+HGlfFHNN+gLAxLBAXlBE
	8UfTOsE3xgRL8imxrnIxmBmvopfnng==
X-Google-Smtp-Source: AGHT+IETHz79JtKbYe4YlHoLjiYBboCMucFwvA1gNs5nXByDf3BIdsqRTUVYiJExuerG3s27zBa9cqYPDA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a5b:dc7:0:b0:c78:c530:6345 with SMTP id
 t7-20020a5b0dc7000000b00c78c5306345mr5693ybr.7.1695145988018; Tue, 19 Sep
 2023 10:53:08 -0700 (PDT)
Date: Tue, 19 Sep 2023 12:52:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175254.144417-1-jrife@google.com>
Subject: [PATCH net v4 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, Jordan Rife <jrife@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
space may observe their value of msg_name change in cases where BPF
sendmsg hooks rewrite the send address. This has been confirmed to break
NFS mounts running in UDP mode and has the potential to break other
systems.

This patch:

1) Creates a new function called __sock_sendmsg() with same logic as the
   old sock_sendmsg() function.
2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
   __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
   as these system calls are already protected.
3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
   present before passing it down the stack to insulate callers from
   changes to the send address.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
Cc: stable@vger.kernel.org
Signed-off-by: Jordan Rife <jrife@google.com>
---
v3->v4: Maintain reverse xmas tree order for variable declarations.
	Remove precondition check for msg_namelen.
v2->v3: Add "Fixes" tag.
v1->v2: Split up original patch into patch series. Perform address copy
        in sock_sendmsg() instead of sock->ops->sendmsg().

 net/socket.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index c8b08b32f097e..a39ec136f5cff 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -737,6 +737,14 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	return ret;
 }
 
+static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	int err = security_socket_sendmsg(sock, msg,
+					  msg_data_left(msg));
+
+	return err ?: sock_sendmsg_nosec(sock, msg);
+}
+
 /**
  *	sock_sendmsg - send a message through @sock
  *	@sock: socket
@@ -747,10 +755,19 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
  */
 int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
-	int err = security_socket_sendmsg(sock, msg,
-					  msg_data_left(msg));
+	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
+	struct sockaddr_storage address;
+	int ret;
 
-	return err ?: sock_sendmsg_nosec(sock, msg);
+	if (msg->msg_name) {
+		memcpy(&address, msg->msg_name, msg->msg_namelen);
+		msg->msg_name = &address;
+	}
+
+	ret = __sock_sendmsg(sock, msg);
+	msg->msg_name = save_addr;
+
+	return ret;
 }
 EXPORT_SYMBOL(sock_sendmsg);
 
@@ -1138,7 +1155,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	res = sock_sendmsg(sock, &msg);
+	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;
 }
@@ -2174,7 +2191,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = sock_sendmsg(sock, &msg);
+	err = __sock_sendmsg(sock, &msg);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -2538,7 +2555,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 		err = sock_sendmsg_nosec(sock, msg_sys);
 		goto out_freectl;
 	}
-	err = sock_sendmsg(sock, msg_sys);
+	err = __sock_sendmsg(sock, msg_sys);
 	/*
 	 * If this is sendmmsg() and sending to current destination address was
 	 * successful, remember it.
-- 
2.42.0.459.ge4e396fd5e-goog


