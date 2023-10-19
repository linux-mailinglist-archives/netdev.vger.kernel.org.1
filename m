Return-Path: <netdev+bounces-42632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F002D7CFA29
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B5628206C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA3225C0;
	Thu, 19 Oct 2023 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="REMbpiVL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0120EB
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:01:07 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAE5248
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:00:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c603e235d1so473652366b.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1697720411; x=1698325211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8Ms0yNFRQJK9861ZM5MWFRhg9RkBb72jPqvrqjteFk=;
        b=REMbpiVLvEhqpAnI8AfCnZCQXL/TnJhUT99HjjZXAeYBSC7umrXpc115lc6RWNCWbF
         OPVUwI00Tdh27nod9aHq4yobrUSjNfFv4511RM2T704Rcqun8kmc3BjW/Q2KXSs8zgpW
         MXpCdckVfQtgVh5shI2UunzvqgWlpHjmiIy0pnalWaymelP+X0rJRO50SDRCAbQFG1nT
         3uOFxZcxswsXSEvlrjiyxBtgemY5+KWrLtTvsj826QWdZ9C+dZPrGSnqlEPLb4iRVhMY
         4OEAg4YTYuTMo/czR8Fhmwye8DE1IM/Lr/ecKb6cp8Z+WYyd6IeYriHMxduhzAh9AafM
         LIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697720411; x=1698325211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8Ms0yNFRQJK9861ZM5MWFRhg9RkBb72jPqvrqjteFk=;
        b=qlqgBId0oFp/VHz6R5rpQBLZCR6i6nyJzCddXKM44RCzUU65a8rs1t2NFONiLSUjdX
         QGJYIzydjldNncZXNiXlnNONJUiWH0C4zjyPaNv2u8Aeis3E6LhCvqGTB2bFsSZQf+ky
         uNTWtuSCfxFczm3MIj7lb2idtyQlpxNMJrwABhijFV44dgpXSlwLprytHxTvy3TzNwAE
         7m4i6rKyZOjTYNythu0aLgwVDMsV19PyFKCRFK48r94eO0z/bBT6MxeVex0T1PQ9Ykqk
         v+rlu0wZkmFc2i3rcj95aQL2xuPNMMh1ymIc0ojRgEdhqAd+9ltqSLDw2EW9NB5tdrjf
         tA1g==
X-Gm-Message-State: AOJu0YyBuhqE/nH/QPIdxfbBUjKUUyoKEa3gJ7ysUGHXGEOt0P5h7Q70
	yQv2A/Qt4s+reUJ/NCysZRBxM2HeE4b9c9lX9arBaiBx
X-Google-Smtp-Source: AGHT+IFEsX/rmUK3axy1+vj7JHvPLXTOSHGyV7XlPdMRtNw5zB3qQtNj1ewyE6Ej8rQgjfky4LOJlw==
X-Received: by 2002:a17:907:36c5:b0:9b2:b153:925 with SMTP id bj5-20020a17090736c500b009b2b1530925mr1821535ejc.21.1697720410816;
        Thu, 19 Oct 2023 06:00:10 -0700 (PDT)
Received: from localhost.localdomain (2a02-8388-1ac6-6200-94b0-27b3-1dd9-8373.cable.dynamic.v6.surfer.at. [2a02:8388:1ac6:6200:94b0:27b3:1dd9:8373])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906081000b009c4cb1553edsm3510463ejd.95.2023.10.19.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:00:10 -0700 (PDT)
From: =?UTF-8?q?Moritz=20Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>
To: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev
Cc: chuck.lever@oracle.com,
	=?UTF-8?q?Moritz=20Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>
Subject: [PATCH] net/handshake: fix file ref count in handshake_nl_accept_doit()
Date: Thu, 19 Oct 2023 14:58:47 +0200
Message-ID: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If req->hr_proto->hp_accept() fail, we call fput() twice:
Once in the error path, but also a second time because sock->file
is at that point already associated with the file descriptor. Once
the task exits, as it would probably do after receiving an error
reading from netlink, the fd is closed, calling fput() a second time.

To fix, we move installing the file after the error path for the
hp_accept() call. In the case of errors we simply put the unused fd.
In case of success we can use fd_install() to link the sock->file
to the reserved fd.

Fixes: 7ea9c1ec66bc ("net/handshake: Fix handshake_dup() ref counting")
Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
---
 net/handshake/netlink.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 64a0046dd611..89637e732866 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -87,29 +87,6 @@ struct nlmsghdr *handshake_genl_put(struct sk_buff *msg,
 }
 EXPORT_SYMBOL(handshake_genl_put);
 
-/*
- * dup() a kernel socket for use as a user space file descriptor
- * in the current process. The kernel socket must have an
- * instatiated struct file.
- *
- * Implicit argument: "current()"
- */
-static int handshake_dup(struct socket *sock)
-{
-	struct file *file;
-	int newfd;
-
-	file = get_file(sock->file);
-	newfd = get_unused_fd_flags(O_CLOEXEC);
-	if (newfd < 0) {
-		fput(file);
-		return newfd;
-	}
-
-	fd_install(newfd, file);
-	return newfd;
-}
-
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
@@ -133,17 +110,20 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_status;
 
 	sock = req->hr_sk->sk_socket;
-	fd = handshake_dup(sock);
+	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err = fd;
 		goto out_complete;
 	}
+
 	err = req->hr_proto->hp_accept(req, info, fd);
 	if (err) {
-		fput(sock->file);
+		put_unused_fd(fd);
 		goto out_complete;
 	}
 
+	fd_install(fd, get_file(sock->file));
+
 	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
 	return 0;
 
-- 
2.41.0


