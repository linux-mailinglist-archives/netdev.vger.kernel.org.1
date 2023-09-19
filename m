Return-Path: <netdev+bounces-34841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F177A56AD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8710E281E8F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C215A3;
	Tue, 19 Sep 2023 00:46:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E41872
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:46:41 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110210D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:46:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c39acfd9so3703625276.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695084399; x=1695689199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DM2x/0dEjxiH90pAnx5OiSC5Yve6BvtplaNk7VqGVyY=;
        b=3ISQyGW/vdGRxxoHyCmeqoFJ0pJT/HnSRx+NDN5Ncsrj90jF2FroinqSMMjHp6r1yk
         FVyfHBVbEqkqVCRr9g2+5fH7pn6MXhOEjKTUtjg0BL7caZuT8jlCdu//UHZbTfB9YSav
         Ba59zXQLTGj+AGqvZ8m/ftcbiX9Y0FUMd5GR/DohCrde9wCbNcDI/ZT6vTp2F1h/dxPk
         v4jSN2RyCiFFf1jmBcSL6OgoxppsXCMExiX7ivszARwpk7d+dhn3UOKxnDhkqsme9nKm
         oE4hCXwXqd1uDYVp5mITezgD5UFXzApL3eZAqKq26/ZN4Awjhw1DBqZ3qj3p0sZ718a2
         MpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695084399; x=1695689199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DM2x/0dEjxiH90pAnx5OiSC5Yve6BvtplaNk7VqGVyY=;
        b=cJMbl9SXvZvw+fTjgoa2nwDp6vlMeBza4e8kYfrJYWFKxlIn4JiEGxibMshNjO/YPA
         OpAlbOEq2QnsBovMszpTAXvkQkd4Kis+r9REI48BJtC0haby4vSfiV3c3YZMMiuU+qj8
         j2P0keLTtRkoN4d6A3M0OYXqMIlPoZnPTlZ7cRSJ513DXBu0GWk9r6vMr34IC7t6TAQv
         cgQVcqYqCukeBBxjN8tkFh1pr9yCRaf367nQCxE1nZmPDAVdWxX+SIhjD6s3/CYe5qrc
         Q72J2I1bVq0eL2RQ1EcgGvQkUHyDuYc0qLbdosfgLEZmuseTSPMljaZcbGO4MFa0gaoI
         QEsA==
X-Gm-Message-State: AOJu0YwaTDJ13NPrR3oqH3vutdpaZU2M5OerHk3pfmOJW6Hg92yQL2fW
	GzavBluT8uQx3IAYyrqjaDjZtB3LbQ==
X-Google-Smtp-Source: AGHT+IGjUW36J2qfz9f3Vsve/RLs53v/rHWYidYbROr23LH7bQc6qj/kjH0FzjmKQ4iFYvohOVtjRXQCUQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:144d:b0:d81:503e:2824 with SMTP id
 a13-20020a056902144d00b00d81503e2824mr238240ybv.10.1695084399615; Mon, 18 Sep
 2023 17:46:39 -0700 (PDT)
Date: Mon, 18 Sep 2023 19:46:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919004636.147954-1-jrife@google.com>
Subject: [PATCH net v3 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, Jordan Rife <jrife@google.com>
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
Signed-off-by: Jordan Rife <jrife@google.com>
---
v2->v3: Add "Fixes" tag.
v1->v2: Split up original patch into patch series. Perform address copy
	in sock_sendmsg() instead of sock->ops->sendmsg().

 net/socket.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index eb7f14143caed..2d34a69b84406 100644
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


