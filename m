Return-Path: <netdev+bounces-18665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02B7583D4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4327C1C20DB9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B915AE1;
	Tue, 18 Jul 2023 17:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A715AC1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:48:25 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10BDC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702505; x=1721238505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkc9+UzhxGu4Ci5LQoXivVhkr5AGPCD8cusf9B7jktQ=;
  b=On7J3YkFrn43uKQVRtQU2yPe5bC/B1BDScxyXZlynlErL7Gc5faOeEwt
   gPevnvmbZIMrObdaKiSgBnWWJmEz6ciYlz7l1oZo0GSs7/SMQukZynup5
   z/DkQz+liNFPXCYHU2qE/EmzS3qZdwXObI9cXPwDt8OVFug26d7pHGCq/
   U=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="572826659"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:48:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 5DBAE467B2;
	Tue, 18 Jul 2023 17:48:21 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:48:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 18 Jul 2023 17:48:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_fb_xmit()
Date: Tue, 18 Jul 2023 10:48:08 -0700
Message-ID: <20230718174808.58307-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144902.25695-1-ruc_gongyuanjun@163.com>
References: <20230717144902.25695-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Mon, 17 Jul 2023 22:49:02 +0800
> goto err_free_skb if an unexpected result is returned by pskb_tirm()
> in erspan_fb_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Fixes: 1a66a836da63 ("gre: add collect_md mode to ERSPAN tunnel")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 81a1cce1a7d1..914cc941af55 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -548,7 +548,8 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto err_free_skb;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		pskb_trim(skb, dev->mtu + dev->hard_header_len);
> +		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +			goto err_free_skb;
>  		truncate = true;
>  	}
>  
> -- 
> 2.17.1
> 

