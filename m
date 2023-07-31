Return-Path: <netdev+bounces-22923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66976A082
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B4E281640
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6D18B01;
	Mon, 31 Jul 2023 18:40:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54780372
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:40:41 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FB9E;
	Mon, 31 Jul 2023 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690828840; x=1722364840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdX52nkveqrBNCZb7CBVWE1vKssTmJSxH9qrLsYuR7A=;
  b=hXKSspP9dwGa/timWXJZpFQfY9B/U5PpyQy0Oq5x5ytcKSjj4sh3JLQG
   yaBQuJFw+7HS8wpMIFm6XofdLemRfLxuiD56WhKjdazD8qsmhhf4ffOFN
   E8Bm0aGMGCF3uB18ioVMx0FRQb9FOjUGRLDopWxDd8Ceuf+930fdGs1Ck
   M=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="19591887"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:40:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id EC5A840D45;
	Mon, 31 Jul 2023 18:40:36 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:40:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:40:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] inet6: Remove unused function declaration udpv6_connect()
Date: Mon, 31 Jul 2023 11:40:24 -0700
Message-ID: <20230731184024.9011-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731140437.37056-1-yuehaibing@huawei.com>
References: <20230731140437.37056-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.27]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yue Haibing <yuehaibing@huawei.com>
Date: Mon, 31 Jul 2023 22:04:37 +0800
> This is never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/transp_v6.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/net/transp_v6.h b/include/net/transp_v6.h
> index d27b1caf3753..1a97e3f32029 100644
> --- a/include/net/transp_v6.h
> +++ b/include/net/transp_v6.h
> @@ -33,8 +33,6 @@ void udplitev6_exit(void);
>  int tcpv6_init(void);
>  void tcpv6_exit(void);
>  
> -int udpv6_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> -
>  /* this does all the common and the specific ctl work */
>  void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>  			   struct sk_buff *skb);
> -- 
> 2.34.1

