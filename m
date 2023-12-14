Return-Path: <netdev+bounces-57309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC699812D52
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EE31C20C03
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29E3D3A6;
	Thu, 14 Dec 2023 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4Z+76P5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60772BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcc5e43ba4so370462276.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702550947; x=1703155747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p2m/uomr/sLqZeRFkCt3L9FxHJ2DTM5tGNbeYTXnEs=;
        b=O4Z+76P5JxDkmPw2TloldFlIrXvJYpUvyI0Q63+Xfbn+szEspl5Bb/mnFIFp/3dx4W
         G4+9Q/L22CR1rFzJzy6Zv4l2SuKz7SwmSj78dqFNudrdtsbtJjyHIIq2K5Tbz502gzBj
         o5IeAdbKDLx0jhGrzDfS3duWQmYSZCehKLBJhhGuoGO+6IX/fR7V38DCoHR/HRPNrhOZ
         Q+ybLG1Ji+6rno43XDCmC+cYdJWS0hFH1gFYMaOUYUepctD0rD/3NpJLnt1ns4AYg688
         PBrXO3p8cb8mX4TrmGohj6cz0vrws1+4QuobV5Xy4n+dgH48K05PH85gM5bUgTKtDyXo
         MB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550947; x=1703155747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6p2m/uomr/sLqZeRFkCt3L9FxHJ2DTM5tGNbeYTXnEs=;
        b=sS42GAN6NVtkVxpjKSCpCrkCYdGVolAn55l1oploa81LbsaxyKLm2auEJ67SnPSyj4
         PM8FuicBBTQFk/XVBQtKvlRKZwMCXELmbXcXGDTRLLlM/I8E8WBhMOXkPEa8OiM46qrx
         SKufnQYiH+AjD8hxbAbT41PJPJNnfWrTaRBGFuAImnpFcj+0iCJ6v6xN8qq8EUXnGOW1
         Z24iI9vDaJFO5UCoh+DmwKk00gnUtMs7Q536zvsmzk0D4BBnVaAiybXeaMIjPDP1bKxy
         28wyFkFfGNzcUhRsGMev/S0cjJUqmu4oVAvPry3DYjE7FcYz86D3cJFwHqV5MacJBJSa
         lgKw==
X-Gm-Message-State: AOJu0YySydTCS8kMqYqrM9Y5OVNZcj0kwkAtQu2sjVS9yj+FhvuYFr/X
	VdZYCus0lc7Ncmr/wgTu0IeSSjf6xN0y2g==
X-Google-Smtp-Source: AGHT+IFznD59i7K+wRf7S1KzvZWK9iWA83sfwmxqgSYreIH/bTM/9SGiiPh4pkuexMDRwwLzhP5uBCNkR6BqKA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP
 id p13-20020a056902014d00b00db53aaf5207mr165419ybh.3.1702550947614; Thu, 14
 Dec 2023 02:49:07 -0800 (PST)
Date: Thu, 14 Dec 2023 10:49:00 +0000
In-Reply-To: <20231214104901.1318423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214104901.1318423-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214104901.1318423-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: Namespace-ify sysctl_optmem_max
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

optmem_max being used in tx zerocopy,
we want to be able to control it on a netns basis.

Following patch changes two tests.

Tested:

oqq130:~# cat /proc/sys/net/core/optmem_max
131072
oqq130:~# echo 1000000 >/proc/sys/net/core/optmem_max
oqq130:~# cat /proc/sys/net/core/optmem_max
1000000
oqq130:~# unshare -n
oqq130:~# cat /proc/sys/net/core/optmem_max
131072
oqq130:~# exit
logout
oqq130:~# cat /proc/sys/net/core/optmem_max
1000000

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netns/core.h   |  1 +
 include/net/sock.h         |  1 -
 net/core/bpf_sk_storage.c  |  3 ++-
 net/core/filter.c          | 12 +++++++-----
 net/core/net_namespace.c   |  4 ++++
 net/core/sock.c            | 10 ++--------
 net/core/sysctl_net_core.c | 15 ++++++++-------
 net/ipv4/ip_sockglue.c     |  6 +++---
 net/ipv6/ipv6_sockglue.c   |  4 ++--
 9 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index a91ef9f8de60bb7c83086c97612bf4b0a8067a18..78214f1b43a20199f2dd315b149141c90eb1b066 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -13,6 +13,7 @@ struct netns_core {
 	struct ctl_table_header	*sysctl_hdr;
 
 	int	sysctl_somaxconn;
+	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3c10e1457866a6d777433d4f7fce3..8b6fe164b218dc90fa5f2b3c7a36ba7d6b226866 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2920,7 +2920,6 @@ extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
 extern int sysctl_tstamp_allow_data;
-extern int sysctl_optmem_max;
 
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index cca7594be92ec6f84cf67992b2deca74f311670f..6c4d90b24d467e35aec7b227af1ead927d7979e3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -275,9 +275,10 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 static int bpf_sk_storage_charge(struct bpf_local_storage_map *smap,
 				 void *owner, u32 size)
 {
-	int optmem_max = READ_ONCE(sysctl_optmem_max);
 	struct sock *sk = (struct sock *)owner;
+	int optmem_max;
 
+	optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
 	/* same check as in sock_kmalloc() */
 	if (size <= optmem_max &&
 	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
diff --git a/net/core/filter.c b/net/core/filter.c
index eedb33f3e9982f6f2de1b9fc885c2d49d2a36c1c..6d89a9cf33c9fd3e45f8c0d0790a070d874449e5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1219,8 +1219,8 @@ void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp)
  */
 static bool __sk_filter_charge(struct sock *sk, struct sk_filter *fp)
 {
+	int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
 	u32 filter_size = bpf_prog_size(fp->prog->len);
-	int optmem_max = READ_ONCE(sysctl_optmem_max);
 
 	/* same check as in sock_kmalloc() */
 	if (filter_size <= optmem_max &&
@@ -1550,12 +1550,13 @@ EXPORT_SYMBOL_GPL(sk_attach_filter);
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
 	struct bpf_prog *prog = __get_filter(fprog, sk);
-	int err;
+	int err, optmem_max;
 
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (bpf_prog_size(prog->len) > READ_ONCE(sysctl_optmem_max))
+	optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
+	if (bpf_prog_size(prog->len) > optmem_max)
 		err = -ENOMEM;
 	else
 		err = reuseport_attach_prog(sk, prog);
@@ -1594,7 +1595,7 @@ int sk_attach_bpf(u32 ufd, struct sock *sk)
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk)
 {
 	struct bpf_prog *prog;
-	int err;
+	int err, optmem_max;
 
 	if (sock_flag(sk, SOCK_FILTER_LOCKED))
 		return -EPERM;
@@ -1622,7 +1623,8 @@ int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk)
 		}
 	} else {
 		/* BPF_PROG_TYPE_SOCKET_FILTER */
-		if (bpf_prog_size(prog->len) > READ_ONCE(sysctl_optmem_max)) {
+		optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
+		if (bpf_prog_size(prog->len) > optmem_max) {
 			err = -ENOMEM;
 			goto err_prog_put;
 		}
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index cb8bcbff9e83a1a3aee32a98c74f3a3b74610be1..72799533426b6162256d7c4eef355af96c66e844 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -372,6 +372,10 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 static int __net_init net_defaults_init_net(struct net *net)
 {
 	net->core.sysctl_somaxconn = SOMAXCONN;
+	/* Limits per socket sk_omem_alloc usage.
+	 * TCP zerocopy regular usage needs 128 KB.
+	 */
+	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 
 	return 0;
diff --git a/net/core/sock.c b/net/core/sock.c
index 08ecdc68d2df6167f0d45f7e421e307cdc2f0038..446e945f736b3eb8f9bd98f1d821bb2b2a435b66 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -283,12 +283,6 @@ EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
 
-/* Limits per socket sk_omem_alloc usage.
- * TCP zerocopy regular usage needs 128 KB.
- */
-int sysctl_optmem_max __read_mostly = 128 * 1024;
-EXPORT_SYMBOL(sysctl_optmem_max);
-
 int sysctl_tstamp_allow_data __read_mostly = 1;
 
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
@@ -2653,7 +2647,7 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
 
 	/* small safe race: SKB_TRUESIZE may differ from final skb->truesize */
 	if (atomic_read(&sk->sk_omem_alloc) + SKB_TRUESIZE(size) >
-	    READ_ONCE(sysctl_optmem_max))
+	    READ_ONCE(sock_net(sk)->core.sysctl_optmem_max))
 		return NULL;
 
 	skb = alloc_skb(size, priority);
@@ -2671,7 +2665,7 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
  */
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
 {
-	int optmem_max = READ_ONCE(sysctl_optmem_max);
+	int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
 
 	if ((unsigned int)size <= optmem_max &&
 	    atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 03f1edb948d7dfb4594b9b6a8f7735537c26335a..0f0cb1465e089245d0ddc0a2c6499bc54f1e9860 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -508,13 +508,6 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "optmem_max",
-		.data		= &sysctl_optmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
 	{
 		.procname	= "tstamp_allow_data",
 		.data		= &sysctl_tstamp_allow_data,
@@ -673,6 +666,14 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.proc_handler	= proc_dointvec_minmax
 	},
+	{
+		.procname	= "optmem_max",
+		.data		= &init_net.core.sysctl_optmem_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.extra1		= SYSCTL_ZERO,
+		.proc_handler	= proc_dointvec_minmax
+	},
 	{
 		.procname	= "txrehash",
 		.data		= &init_net.core.sysctl_txrehash,
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index d7d13940774e837a9f9baeb4f971126abc26d9fc..66247e8b429e43c8fd5887d651e1a98d31453901 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -775,7 +775,7 @@ static int ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval, int optlen)
 
 	if (optlen < GROUP_FILTER_SIZE(0))
 		return -EINVAL;
-	if (optlen > READ_ONCE(sysctl_optmem_max))
+	if (optlen > READ_ONCE(sock_net(sk)->core.sysctl_optmem_max))
 		return -ENOBUFS;
 
 	gsf = memdup_sockptr(optval, optlen);
@@ -811,7 +811,7 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 
 	if (optlen < size0)
 		return -EINVAL;
-	if (optlen > READ_ONCE(sysctl_optmem_max) - 4)
+	if (optlen > READ_ONCE(sock_net(sk)->core.sysctl_optmem_max) - 4)
 		return -ENOBUFS;
 
 	p = kmalloc(optlen + 4, GFP_KERNEL);
@@ -1254,7 +1254,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 		if (optlen < IP_MSFILTER_SIZE(0))
 			goto e_inval;
-		if (optlen > READ_ONCE(sysctl_optmem_max)) {
+		if (optlen > READ_ONCE(net->core.sysctl_optmem_max)) {
 			err = -ENOBUFS;
 			break;
 		}
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 9e8ebda170f14f7fd5faf370507bb3a8d1c75931..56c3c467f9deb907ac6e6b84dcd33ec44bde0682 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -210,7 +210,7 @@ static int ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 
 	if (optlen < GROUP_FILTER_SIZE(0))
 		return -EINVAL;
-	if (optlen > READ_ONCE(sysctl_optmem_max))
+	if (optlen > READ_ONCE(sock_net(sk)->core.sysctl_optmem_max))
 		return -ENOBUFS;
 
 	gsf = memdup_sockptr(optval, optlen);
@@ -244,7 +244,7 @@ static int compat_ipv6_set_mcast_msfilter(struct sock *sk, sockptr_t optval,
 
 	if (optlen < size0)
 		return -EINVAL;
-	if (optlen > READ_ONCE(sysctl_optmem_max) - 4)
+	if (optlen > READ_ONCE(sock_net(sk)->core.sysctl_optmem_max) - 4)
 		return -ENOBUFS;
 
 	p = kmalloc(optlen + 4, GFP_KERNEL);
-- 
2.43.0.472.g3155946c3a-goog


