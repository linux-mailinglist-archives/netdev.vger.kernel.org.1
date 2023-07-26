Return-Path: <netdev+bounces-21426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A440976394B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F80A281EAC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0791DA28;
	Wed, 26 Jul 2023 14:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC51DA22
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:35:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A7CE;
	Wed, 26 Jul 2023 07:35:54 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9xG36VK6zLnqW;
	Wed, 26 Jul 2023 22:33:15 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:35:50 +0800
Subject: Re: [PATCH 27/29] bonding: 3ad: Remove unused declaration
 bond_3ad_update_lacp_active()
To: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jon.toppins+linux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuhangbin@gmail.com>
References: <20230726143419.19392-1-yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <1e1cd978-549d-e220-437f-f562d8209e94@huawei.com>
Date: Wed, 26 Jul 2023 22:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230726143419.19392-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pls ignore this, will fix prefix

On 2023/7/26 22:34, YueHaibing wrote:
> This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/bond_3ad.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index a016f275cb01..c5e57c6bd873 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -301,7 +301,6 @@ int  __bond_3ad_get_active_agg_info(struct bonding *bond,
>  int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
>  			 struct slave *slave);
>  int bond_3ad_set_carrier(struct bonding *bond);
> -void bond_3ad_update_lacp_active(struct bonding *bond);
>  void bond_3ad_update_lacp_rate(struct bonding *bond);
>  void bond_3ad_update_ad_actor_settings(struct bonding *bond);
>  int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
> 

