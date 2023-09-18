Return-Path: <netdev+bounces-34377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5017A3F7F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 04:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CFE2813C7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEA636;
	Mon, 18 Sep 2023 02:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580291389
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:50:34 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6411F
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 19:50:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b957fd276so4595465276.0
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 19:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695005432; x=1695610232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc4hWRXZVJ9Z0u2xJJLIA18YUkUwZEXzAw8JxwuM2fQ=;
        b=g0xAapbr2Y5ocSy+ohbg0iUtoTsu2glzdngfdg3vo1UDWqAlb4dURY2x7wXRXuLi7p
         kisQbGmVPwW2jl+u8mpM6irBTRl22FjS1wNb8Gkv0QFblQNraVV9wTD4XudGb5k1vfrF
         d7nss3271dm42ELA34lE8BsAb+nwgrL/2L55ZNaZhwnbMKkZILhH6+qjLn8/3RqWGY0m
         JyUZH5RWcxbtqjxG3fGJw9Wypmj/ecPDMZ1mX5cAwHdbzQ/APp1eJRopyrX1VQV1stiL
         Bve0qtmpq9CKerIkYGE0HofQPI6sCy6m6fd8/dXsvptQ3DMHmHgphF+OleDuC7loS9VC
         +Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695005432; x=1695610232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc4hWRXZVJ9Z0u2xJJLIA18YUkUwZEXzAw8JxwuM2fQ=;
        b=PGGWIfoAMfk6spSTdh2W/UX8x9ekWTDOGQkecHWfs6JruH5MUt5tvqkCprqsiKoG8L
         VTCxOBUWUP7uVTdEs7K3GZEzPK8/PToEDJC2Ljia0TWB5HpaSySSaPx/yuH2GFj2HN4t
         nzXhGYW4vPazjQPgRoA4DP6+gRFmVPDTxPw+Qy0T60TPhX1drR5xN4VGd1YdjonRIdaI
         7z/q4F0MnY412OMj/43Rui9urNu/4vvDQxGkbABOTFIQn2q9nsma/Ckpoq5V8G9K2n6z
         IqaW/8RiPnLnDdDbxbfQm6xGPRw2Jt5cuFHaC2N9AOaRU5+T4LtupnsdrOeUrJ1CV5aY
         bJuA==
X-Gm-Message-State: AOJu0Yw9ikXDWHUNkKgJcRVyIl/45WVTOWd07+sn3jYxMPLLXDH2K2Hh
	IauI1TvEjH81iqgoA/iY9tPj/BoKqQ==
X-Google-Smtp-Source: AGHT+IH47entmNVDVGpZop6CykjtUr6lQjOv5thhwvIl/r52RRKD2gCC977J0uRrgejGpblqMLD7oMUM9w==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:d108:0:b0:d7e:7a8a:2159 with SMTP id
 i8-20020a25d108000000b00d7e7a8a2159mr174245ybg.5.1695005432245; Sun, 17 Sep
 2023 19:50:32 -0700 (PDT)
Date: Sun, 17 Sep 2023 21:50:19 -0500
In-Reply-To: <20230918025021.4078252-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918025021.4078252-2-jrife@google.com>
Subject: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, willemdebruijn.kernel@gmail.com, 
	Jordan Rife <jrife@google.com>
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

Signed-off-by: Jordan Rife <jrife@google.com>
---
v1->v2: Split up original patch into patch series. Perform address copy
	in sock_sendmsg() instead of sock->ops->sendmsg().

 net/socket.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index b2e3700d035a6..b0189b773d130 100644
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
@@ -747,10 +755,22 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
  */
 int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
-	int err = security_socket_sendmsg(sock, msg,
-					  msg_data_left(msg));
+	struct sockaddr_storage address;
+	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
+	int ret;
 
-	return err ?: sock_sendmsg_nosec(sock, msg);
+	if (msg->msg_name) {
+		if (msg->msg_namelen < 0 || msg->msg_namelen > sizeof(address))
+			return -EINVAL;
+
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
 
@@ -1138,7 +1158,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	res = sock_sendmsg(sock, &msg);
+	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;
 }
@@ -2174,7 +2194,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = sock_sendmsg(sock, &msg);
+	err = __sock_sendmsg(sock, &msg);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -2538,7 +2558,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
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


