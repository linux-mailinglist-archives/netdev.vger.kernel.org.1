Return-Path: <netdev+bounces-29276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B97826B4
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C761C2085B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059EF4A23;
	Mon, 21 Aug 2023 10:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD78185B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:00:34 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12CCA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:00:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d71f505d21dso4184837276.3
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692612032; x=1693216832;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swvi3ieojHhCvQQpx72cte4QxiiCM5j7oYg+ZxiM74E=;
        b=cvgU8FXTpKdCtwoTjxNnX6sQPFfAsNgppPSATw18C9q9ZaC4k5npg8x6dxPcLxL1KS
         dTxkw+LK6LKhAfeyzFkwSJHS5/kcNMhSfAbE9KtkXQB/0VPVDKypOpu0y5EVbPknePDR
         qXqu36LVxgbrXh8XmHGhMNd4ObnWG70CBsIOl7xkB9CosgVSKtc8bAb20loCxZxZV7tt
         HiEHWzcV790qHpp7jqxZLyCnTqQbOALu6hLDy1gkNDgqIIWxc0ObBKO5eistYVblpCK/
         vhegaK98mBXHqObY7qw48cS6aoXf72CiORQ/WQhRPxhyKNqASClfSnwVBC62JvZXJZTI
         3fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612032; x=1693216832;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swvi3ieojHhCvQQpx72cte4QxiiCM5j7oYg+ZxiM74E=;
        b=iLyiPcWv/H3B6rK84DrwvaSbYlOIqoB4a6n6LCB+Za+O1QN4maumyweGfRYv60wjzJ
         SKcEhGTuWwhGLW/WGjpleoGLBnqaIRjJzRsxfR8n0qLETkE1FvqtRcV6F90IcuOkiFrc
         bSg8SAvIFGvBpNWWRVSi/q9j//+fue9CRiYfl/ePp/lmr/9MeKS17JZlHfi30BHa/lPv
         O9YBuXMMkjgPEsWO5LUmyEPy8ZHrJTIEfknAr/BtBBOlqqV32PXpgkt8Xqqv/ddlDiGT
         fsj9iN0vc/jn6T/eEjfieuacEUOwis3G3RA6DlsRYG3EGuADuBW+CoXhCNXXjqJTD4w2
         oAUA==
X-Gm-Message-State: AOJu0Yzt+daghFX+6dTsQDyZgjRI5MlLs2vYkL70ji4jPy/lA/ifGPev
	p6iPzNqZQ22EQdvXPpsWgW45xsdd+g==
X-Google-Smtp-Source: AGHT+IFwLl6U5xfzq5IjUGIq/3QDZbdd+TbKCCLmc1xALIyYwiiWimhpsga1UQ4xW2wdvWixBxUedn6snQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:25d7:0:b0:d4b:99ce:5e51 with SMTP id
 l206-20020a2525d7000000b00d4b99ce5e51mr41387ybl.6.1692612032776; Mon, 21 Aug
 2023 03:00:32 -0700 (PDT)
Date: Mon, 21 Aug 2023 05:00:06 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821100007.559638-1-jrife@google.com>
Subject: [PATCH] net: Avoid address overwrite in kernel_connect
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, Jordan Rife <jrife@google.com>
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
 net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c8..f49edb9b49185 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3519,7 +3519,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
-- 
2.42.0.rc1.204.g551eb34607-goog


