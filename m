Return-Path: <netdev+bounces-35632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96897AA5C7
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 77851283698
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD4A29434;
	Thu, 21 Sep 2023 23:46:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4F2032D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:46:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2FF9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:46:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c27703cc6so20781857b3.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695340011; x=1695944811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6csgpJFpDA5PtKfzqgjCznSHc6aXm367cMuqjygaB8=;
        b=C+854yH8O0d3UTXHeIzpsQmliFvRM9G9DazBGxmqLywWedsq3qITb6254A2qZ+alPh
         zxNAU/lhViOsOYII5GccOkLjzkDWw0TuAqZprZDRYZaMD5IsgpwDzs7Q92tA29MqZ6tP
         IZJm/sbZu2n+qEUFQTKqxMicFm9VMNzLv3g791PdYEwySh6eSG+bVrIq/Yl5X23HNC2W
         B3cr2T9OO5uf+WVGV18jcTDOGZKpiNYamiWJHi0MrVfP/+98n+CFDQgZdVyf3F3xpC1v
         Zhv+V8H5qGGASydMPwCpQeDVHJ6Y6F2cb/WBK+5Wc+o+IjT9F0lG2xH/MOssHk1h22Sd
         jhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340011; x=1695944811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6csgpJFpDA5PtKfzqgjCznSHc6aXm367cMuqjygaB8=;
        b=QRG4XYjwDSPCfEalrBhloayIEHTlhBXb+6RIsVo+GDLBGaVLPysB/NexsCCGdfkvFB
         vFZ0S0WZvg+NZBmduTfOEKdw5cOm+cCqXjrZ+430DZXTuJPmpMivbA8+4ii1pWP9O/kn
         qwSnk+A2KnOBg/Xns1RHOv1p0s3P8zU7xdn5sJjaoV4fSC4lUIF2EmKn+cyYFsowumRM
         UEsUboDbV8g8TMOyO683HmNp76i8zOXG1jk1igiBMoc6k3FKx0pl1zCt4CJwgjZaKIr9
         D/fLnQbt0Fn6LqnxC1EKm4A+OJcnF853nqYMsgyZl3higC1OObc8081hA1YBJtsYPD7q
         ZDAw==
X-Gm-Message-State: AOJu0Yw39dton+O7hjHLE5KZW1BZxSAacmZjMX+dURlnIuSLgstsIa1C
	GKmTWxQePRZEPGKr8hJ+jFH9PQbluA==
X-Google-Smtp-Source: AGHT+IFuCRdGWyjMeJdLRllnxrPmvyCgE923HJ0zr0IorxoxGnmXcU4xXwJf9NGtZ5WLXNFKUfyQ60nhvw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:cb04:0:b0:59b:f138:c845 with SMTP id
 q4-20020a81cb04000000b0059bf138c845mr105690ywi.2.1695340011423; Thu, 21 Sep
 2023 16:46:51 -0700 (PDT)
Date: Thu, 21 Sep 2023 18:46:41 -0500
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921234642.1111903-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921234642.1111903-2-jrife@google.com>
Subject: [PATCH net v5 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org, 
	kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com, 
	ast@kernel.org, rdna@fb.com, Jordan Rife <jrife@google.com>, stable@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
v4->v5: Remove non-net changes.
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
2.42.0.515.g380fc7ccd1-goog


