Return-Path: <netdev+bounces-44561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6877D8A2E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AC3281F8B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD013D3A5;
	Thu, 26 Oct 2023 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RSsAOL0f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE44426
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 21:23:26 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA621B2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698355404; x=1729891404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uZlt55EZq3hlOJnoeppZjmQcRB33DlPvfGCgW9bx8/s=;
  b=RSsAOL0fri3yQUOrtGILFiXH40t3uV93dufvRukwZfynq5dAWQNtAxBl
   3macjTtV6OMKibXpwZWI2CXJ355wrZHCHlzsf2bE8GTsUt/Z3LfMBUnXZ
   EJqofrCvbvPDpcUclLSIUFI9IxsR6Ov5cfcuPUpfvjGVrpA/zYN38STjf
   4=;
X-IronPort-AV: E=Sophos;i="6.03,254,1694736000"; 
   d="scan'208";a="248546952"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:23:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 61B6D8A910;
	Thu, 26 Oct 2023 21:23:22 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:55582]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.230:2525] with esmtp (Farcaster)
 id f1320d71-27fe-46d1-9285-2553e4b2c0db; Thu, 26 Oct 2023 21:23:22 +0000 (UTC)
X-Farcaster-Flow-ID: f1320d71-27fe-46d1-9285-2553e4b2c0db
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 21:23:20 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 21:23:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] af_unix: Remove module remnants.
Date: Thu, 26 Oct 2023 14:23:05 -0700
Message-ID: <20231026212305.45545-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.42]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Since commit 97154bcf4d1b ("af_unix: Kconfig: make CONFIG_UNIX bool"),
af_unix.c is no longer built as module.

Let's remove unnecessary #if condition, exitcall, and module macros.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e10d07c76044..45506a95b25f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3344,7 +3344,7 @@ static const struct seq_operations unix_seq_ops = {
 	.show   = unix_seq_show,
 };
 
-#if IS_BUILTIN(CONFIG_UNIX) && defined(CONFIG_BPF_SYSCALL)
+#ifdef CONFIG_BPF_SYSCALL
 struct bpf_unix_iter_state {
 	struct seq_net_private p;
 	unsigned int cur_sk;
@@ -3606,7 +3606,7 @@ static struct pernet_operations unix_net_ops = {
 	.exit = unix_net_exit,
 };
 
-#if IS_BUILTIN(CONFIG_UNIX) && defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 DEFINE_BPF_ITER_FUNC(unix, struct bpf_iter_meta *meta,
 		     struct unix_sock *unix_sk, uid_t uid)
 
@@ -3706,7 +3706,7 @@ static int __init af_unix_init(void)
 	register_pernet_subsys(&unix_net_ops);
 	unix_bpf_build_proto();
 
-#if IS_BUILTIN(CONFIG_UNIX) && defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	bpf_iter_register();
 #endif
 
@@ -3714,20 +3714,5 @@ static int __init af_unix_init(void)
 	return rc;
 }
 
-static void __exit af_unix_exit(void)
-{
-	sock_unregister(PF_UNIX);
-	proto_unregister(&unix_dgram_proto);
-	proto_unregister(&unix_stream_proto);
-	unregister_pernet_subsys(&unix_net_ops);
-}
-
-/* Earlier than device_initcall() so that other drivers invoking
-   request_module() don't end up in a loop when modprobe tries
-   to use a UNIX socket. But later than subsys_initcall() because
-   we depend on stuff initialised there */
+/* Later than subsys_initcall() because we depend on stuff initialised there */
 fs_initcall(af_unix_init);
-module_exit(af_unix_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NETPROTO(PF_UNIX);
-- 
2.30.2


