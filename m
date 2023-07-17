Return-Path: <netdev+bounces-18412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAD756D4D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E6A28132F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8ABC150;
	Mon, 17 Jul 2023 19:33:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2C253B8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:13 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83C9D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689622393; x=1721158393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OixhNAAYu4kRvQkjGfyEZk66sJ8LfUJ4TRGW8zTn5h4=;
  b=F3Qp5OC5bqWlriAztMrvz5+OJesQTZYCFA8c9OJTjbGTUYKhG8CyQzt8
   zLL+ixWHYBruC/Q8awd1jfXS94mGARiwoAtAO4LfXfCfurJPUvtkpGsQR
   oSrJBarsBRWVSr/QmaW2W7gvcjA5/cAx1SjGb2LrLDMqCztXHrPnVwe6z
   U=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="345056600"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:33:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 7FC7E40D74;
	Mon, 17 Jul 2023 19:33:10 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:33:10 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 17 Jul 2023 19:33:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <ajit.khaparde@broadcom.com>, <netdev@vger.kernel.org>,
	<somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] drivers:net: fix return value check in be_lancer_xmit_workarounds
Date: Mon, 17 Jul 2023 12:32:59 -0700
Message-ID: <20230717193259.98375-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144532.22037-1-ruc_gongyuanjun@163.com>
References: <20230717144532.22037-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Mon, 17 Jul 2023 22:45:32 +0800
> in be_lancer_xmit_workarounds, it should go to label 'err' if
> an unexpected value is returned by pskb_trim.
>

Fixes tag needed here.

> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
> index 18c2fc880d09..eba29a2e0e8b 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -1138,7 +1138,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
>  	    (lancer_chip(adapter) || BE3_chip(adapter) ||
>  	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
>  		ip = (struct iphdr *)ip_hdr(skb);
> -		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
> +		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
> +			goto err;

This should be `goto tx_drop`, or we'll leak skb.


>  	}
>  
>  	/* If vlan tag is already inlined in the packet, skip HW VLAN
> -- 
> 2.17.1

