Return-Path: <netdev+bounces-33319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99879D63A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EB6281B04
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823518C3F;
	Tue, 12 Sep 2023 16:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6489AD49
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:27:14 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0ED10E5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694536034; x=1726072034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arDrHgXlq5TWmThsRmjX5SIzcAkGMAjRoCDv8stogV4=;
  b=IwRkRwTbp/JEz6OqLFOG/IO7HChpxXbd0JlLWqawWgdpMwZYyHBj195n
   LK8fR1WGyCQl1Aw7fDQC2FM12mhoCNJCgvjX3kMVn2FcEBVfmuSgAtZsa
   K9uPtz2ZSXSetHugfgXjXSd0AU13tJwjrgoMzSwVHFtzkEQ6Wxl4FhcoS
   E=;
X-IronPort-AV: E=Sophos;i="6.02,139,1688428800"; 
   d="scan'208";a="1153786450"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 16:27:05 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 2711780543;
	Tue, 12 Sep 2023 16:27:02 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 16:26:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 16:26:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jbaron@akamai.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [net-next 1/2] inet_diag: export SO_REUSEADDR and SO_REUSEPORT sockopts
Date: Tue, 12 Sep 2023 09:26:44 -0700
Message-ID: <20230912162644.60787-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0b1deb44b8401042542a112e8235e039fc0a5f65.1694523876.git.jbaron@akamai.com>
References: <0b1deb44b8401042542a112e8235e039fc0a5f65.1694523876.git.jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.20]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Jason Baron <jbaron@akamai.com>
Date: Tue, 12 Sep 2023 10:31:48 -0400
> Add the ability to monitor SO_REUSEADDR and SO_REUSEPORT for an inet
> socket. These settings are currently readable via getsockopt().
> We have an app that will sometimes fail to bind() and it's helpful to
> understand what other apps are causing the bind() conflict.

If bind() fails with -EADDRINUSE, you can find the conflicting sockets
with just the failing 2-tuple, no ?

Also, BPF iterator and bpf_sk_getsockopt() has the same functionality
with more flexibility.  (See: sol_socket_sockopt() in net/core/filter.c)


> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>  include/linux/inet_diag.h      | 2 ++
>  include/uapi/linux/inet_diag.h | 7 +++++++
>  net/ipv4/inet_diag.c           | 7 +++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> index 84abb30a3fbb..d05a4c26b13d 100644
> --- a/include/linux/inet_diag.h
> +++ b/include/linux/inet_diag.h
> @@ -77,6 +77,8 @@ static inline size_t inet_diag_msg_attrs_size(void)
>  #endif
>  		+ nla_total_size(sizeof(struct inet_diag_sockopt))
>  						     /* INET_DIAG_SOCKOPT */
> +		+ nla_total_size(sizeof(struct inet_diag_reuse))
> +						    /* INET_DIAG_REUSE */
>  		;
>  }
>  int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
> index 50655de04c9b..f93eeea1faba 100644
> --- a/include/uapi/linux/inet_diag.h
> +++ b/include/uapi/linux/inet_diag.h
> @@ -161,6 +161,7 @@ enum {
>  	INET_DIAG_SK_BPF_STORAGES,
>  	INET_DIAG_CGROUP_ID,
>  	INET_DIAG_SOCKOPT,
> +	INET_DIAG_REUSE,
>  	__INET_DIAG_MAX,
>  };
>  
> @@ -201,6 +202,12 @@ struct inet_diag_sockopt {
>  		unused:5;
>  };
>  
> +struct inet_diag_reuse {
> +	__u8	reuse:4,
> +		reuseport:1,
> +		unused:3;
> +};
> +
>  /* INET_DIAG_VEGASINFO */
>  
>  struct tcpvegas_info {
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index e13a84433413..d6ebb1e612fc 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -125,6 +125,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>  			     bool net_admin)
>  {
>  	const struct inet_sock *inet = inet_sk(sk);
> +	struct inet_diag_reuse inet_reuse = {};
>  	struct inet_diag_sockopt inet_sockopt;
>  
>  	if (nla_put_u8(skb, INET_DIAG_SHUTDOWN, sk->sk_shutdown))
> @@ -197,6 +198,12 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>  		    &inet_sockopt))
>  		goto errout;
>  
> +	inet_reuse.reuse = sk->sk_reuse;
> +	inet_reuse.reuseport = sk->sk_reuseport;
> +	if (nla_put(skb, INET_DIAG_REUSE, sizeof(inet_reuse),
> +		    &inet_reuse))
> +		goto errout;
> +
>  	return 0;
>  errout:
>  	return 1;
> -- 
> 2.25.1

