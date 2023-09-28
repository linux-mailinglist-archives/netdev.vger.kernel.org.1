Return-Path: <netdev+bounces-36697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E2D7B14CA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0BDD51C20355
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4E30F91;
	Thu, 28 Sep 2023 07:26:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E3523B
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:26:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90D95;
	Thu, 28 Sep 2023 00:26:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rx4gg16HhzNnty;
	Thu, 28 Sep 2023 15:22:39 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 15:26:28 +0800
Subject: Re: [PATCH net-next] xfrm: Remove unused function declarations
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <leon@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230729122858.25776-1-yuehaibing@huawei.com>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <de3b9e86-92c6-108b-272a-9480f9b91f21@huawei.com>
Date: Thu, 28 Sep 2023 15:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230729122858.25776-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ping..

On 2023/7/29 20:28, Yue Haibing wrote:
> commit a269fbfc4e9f ("xfrm: state: remove extract_input indirection from xfrm_state_afinfo")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/xfrm.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 151ca95dd08d..cdce217a5853 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1669,7 +1669,6 @@ int pktgen_xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb);
>  #endif
>  
>  void xfrm_local_error(struct sk_buff *skb, int mtu);
> -int xfrm4_extract_input(struct xfrm_state *x, struct sk_buff *skb);
>  int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
>  		    int encap_type);
>  int xfrm4_transport_finish(struct sk_buff *skb, int async);
> @@ -1689,7 +1688,6 @@ int xfrm4_protocol_deregister(struct xfrm4_protocol *handler, unsigned char prot
>  int xfrm4_tunnel_register(struct xfrm_tunnel *handler, unsigned short family);
>  int xfrm4_tunnel_deregister(struct xfrm_tunnel *handler, unsigned short family);
>  void xfrm4_local_error(struct sk_buff *skb, u32 mtu);
> -int xfrm6_extract_input(struct xfrm_state *x, struct sk_buff *skb);
>  int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be32 spi,
>  		  struct ip6_tnl *t);
>  int xfrm6_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
> 

