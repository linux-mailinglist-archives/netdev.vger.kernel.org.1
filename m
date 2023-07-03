Return-Path: <netdev+bounces-15188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D7746139
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A851C209C6
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77A101D0;
	Mon,  3 Jul 2023 17:14:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E991101C0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:14:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47ECD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688404493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=x5uYhFfluJ3BcMLS5I6088sXdiD5/LEYRuaBE/DPa58=;
	b=XjM/+mZDVuqldBQq+d16K9QSGPXz4PcJAO0NH5lWU38m3vFuQBfo702RTFyrIioy2wXWNW
	/JLUItbCuWJFRXMeG4gS2M4PoR1jM4RlfpaxOjOTJhyj/nikIqrMEvIQvNDWXPshMzvzH5
	8NbM3EuDpQkQ1l0lDOvnwSuEN6efH3I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-G1QemwrQOv6igbVY9k0OWg-1; Mon, 03 Jul 2023 13:14:52 -0400
X-MC-Unique: G1QemwrQOv6igbVY9k0OWg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403429b3331so22966201cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 10:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404492; x=1690996492;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5uYhFfluJ3BcMLS5I6088sXdiD5/LEYRuaBE/DPa58=;
        b=kGX915lNAc6mZm+lAPPkxh22hVaSiZmAr4u5Yz+LiLazNst/VOnACfVb6SngOnVHkI
         dgyFC1XjTDo1F6+dk65Q16u5qxyOUU61ncm/2mNRwwwW8XMzLqyjlSJdSPqCZ5jcVZH0
         rz07zfOHOFhwRhc2gd1LQf5j6F8vRYbNJAGfd9MGGbyS07r//UmADj9zWtf0NKApBrNp
         eoYSZpqWE/1cO/X0eyYIgauXe8gRLLumC2e/eh9xdTwCCmJ8mI+wSQSKohFQcNpeq4/Y
         ZFNyDpHZoIYWP1BP9st45aGR5up3JwtZnjIF4PV1l5U61eohKIIMbVME0uGv/Bdx0hXU
         ziug==
X-Gm-Message-State: AC+VfDwGKDu5ZOgIyqFqfLxjuckuWfVRWOQV1pe2E+NBqERb+XufnB92
	oWH9CnR3kKLWij6f4S8LE+cFTmsbCIfCqLHB49jPR0aKENY4j5qVuWdHgaJVhhJi6pV2mrcX81y
	w9EhzLSN3ZTeK6upe
X-Received: by 2002:a05:622a:1a02:b0:3fd:db88:b0fd with SMTP id f2-20020a05622a1a0200b003fddb88b0fdmr13074024qtb.59.1688404492041;
        Mon, 03 Jul 2023 10:14:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Tukd1y3zBs3bIOJUSFdI2a+pfyQRxS6mRPn6nqW1g+uc8CJ7hW+IrwoH1OtjQQN/j6xOZTw==
X-Received: by 2002:a05:622a:1a02:b0:3fd:db88:b0fd with SMTP id f2-20020a05622a1a0200b003fddb88b0fdmr13074010qtb.59.1688404491780;
        Mon, 03 Jul 2023 10:14:51 -0700 (PDT)
Received: from debian ([193.212.224.150])
        by smtp.gmail.com with ESMTPSA id ci7-20020a05622a260700b00401e22b9fcesm9141646qtb.53.2023.07.03.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:14:51 -0700 (PDT)
Date: Mon, 3 Jul 2023 19:14:46 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Dmitry Kozlov <xeb@mail.ru>
Subject: [PATCH net] pptp: Fix fib lookup calls.
Message-ID: <5cab1bbf6faba3277dab8fc36adfadc9cbf8722c.1688404432.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PPTP uses pppox sockets (struct pppox_sock). These sockets don't embed
an inet_sock structure, so it's invalid to call inet_sk() on them.

Therefore, the ip_route_output_ports() call in pptp_connect() has two
problems:

  * The tos variable is set with RT_CONN_FLAGS(sk), which calls
    inet_sk() on the pppox socket.

  * ip_route_output_ports() tries to retrieve routing flags using
    inet_sk_flowi_flags(), which is also going to call inet_sk() on the
    pppox socket.

While PPTP doesn't use inet sockets, it's actually really layered on
top of IP and therefore needs a proper way to do fib lookups. So let's
define pptp_route_output() to get a struct rtable from a pptp socket.
Let's also replace the ip_route_output_ports() call of pptp_xmit() for
consistency.

In practice, this means that:

  * pptp_connect() sets ->flowi4_tos and ->flowi4_flags to zero instead
    of using bits of unrelated struct pppox_sock fields.

  * pptp_xmit() now respects ->sk_mark and ->sk_uid.

  * pptp_xmit() now calls the security_sk_classify_flow() security
    hook, thus allowing to set ->flowic_secid.

  * pptp_xmit() now passes the pppox socket to xfrm_lookup_route().

Found by code inspection.

Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/ppp/pptp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 0fe78826c8fa..32183f24e63f 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -24,6 +24,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/rcupdate.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 
 #include <net/sock.h>
@@ -128,6 +129,23 @@ static void del_chan(struct pppox_sock *sock)
 	spin_unlock(&chan_lock);
 }
 
+static struct rtable *pptp_route_output(struct pppox_sock *po,
+					struct flowi4 *fl4)
+{
+	struct sock *sk = &po->sk;
+	struct net *net;
+
+	net = sock_net(sk);
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, sk->sk_mark, 0,
+			   RT_SCOPE_UNIVERSE, IPPROTO_GRE, 0,
+			   po->proto.pptp.dst_addr.sin_addr.s_addr,
+			   po->proto.pptp.src_addr.sin_addr.s_addr,
+			   0, 0, sock_net_uid(net, sk));
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
+
+	return ip_route_output_flow(net, fl4, sk);
+}
+
 static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *) chan->private;
@@ -151,11 +169,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
 		goto tx_error;
 
-	rt = ip_route_output_ports(net, &fl4, NULL,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0, IPPROTO_GRE,
-				   RT_TOS(0), sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt))
 		goto tx_error;
 
@@ -438,12 +452,7 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	po->chan.private = sk;
 	po->chan.ops = &pptp_chan_ops;
 
-	rt = ip_route_output_ports(sock_net(sk), &fl4, sk,
-				   opt->dst_addr.sin_addr.s_addr,
-				   opt->src_addr.sin_addr.s_addr,
-				   0, 0,
-				   IPPROTO_GRE, RT_CONN_FLAGS(sk),
-				   sk->sk_bound_dev_if);
+	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt)) {
 		error = -EHOSTUNREACH;
 		goto end;
-- 
2.39.2


