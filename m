Return-Path: <netdev+bounces-31675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B533178F7BF
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 07:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D88281764
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 05:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E71FA5;
	Fri,  1 Sep 2023 05:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3515B5
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 05:00:01 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519BE7F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:59:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id bwGBqGDKD7HAObwGBqnc61; Fri, 01 Sep 2023 06:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1693544397;
	bh=tv6B7Fos2siGTtUU4mG/KuNAe/GWDCgVkJ/VsTHCG7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HmBpTMjKbHox0amol/pxmlk8yX8lwqZPFvDcxNt9aA1ulkmt4fsL788UCbxgxwa5r
	 UbVitixu7ZMfs8WwkFY+Som0NqzBU3DNdthWNkGG7M6ZUxzePYV3n/qOZ/D3ccNYop
	 YUJhUbhM4zz2A97BmZhQQ1KDatoiETeIDYTlAsv8nApTBvJAPmr3TFf2P65mHQGUC0
	 wu0bQL2Cll1o9luByjPLxvFTpM47CstgJCZwkHKlTTyDMbcDh+leV731TIbjEmiRTk
	 TAW5msQdQWjxTy5jsiuwY4Lh9/jZHNNCrln95KbpB9YatqY0Si78bKUwIZCO3+L1GB
	 iAOpuhfmjoSrw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Sep 2023 06:59:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <58b1e635-f31a-8c76-b704-a707bd11d460@wanadoo.fr>
Date: Fri, 1 Sep 2023 06:59:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ceph/decode=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
To: Li kunyu <kunyu@nfschina.com>, idryomov@gmail.com, xiubli@redhat.com,
 jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230902201112.4401-1-kunyu__5722.10796396888$1693539625$gmane$org@nfschina.com>
Content-Language: fr, en-GB
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230902201112.4401-1-kunyu__5722.10796396888$1693539625$gmane$org@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 01/09/2023 à 05:40, Li kunyu a écrit :
> ret is assigned first, so it does not need to initialize the
> assignment.
> Bad is not used and can be removed.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   net/ceph/decode.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ceph/decode.c b/net/ceph/decode.c
> index bc109a1a4616..9f5f095d8235 100644
> --- a/net/ceph/decode.c
> +++ b/net/ceph/decode.c
> @@ -50,7 +50,7 @@ static int
>   ceph_decode_entity_addr_legacy(void **p, void *end,
>   			       struct ceph_entity_addr *addr)
>   {
> -	int ret = -EINVAL;
> +	int ret = 0;
>   
>   	/* Skip rest of type field */
>   	ceph_decode_skip_n(p, end, 3, bad);
> @@ -66,8 +66,7 @@ ceph_decode_entity_addr_legacy(void **p, void *end,
>   			      sizeof(addr->in_addr), bad);
>   	addr->in_addr.ss_family =
>   			be16_to_cpu((__force __be16)addr->in_addr.ss_family);
> -	ret = 0;
> -bad:
> +
>   	return ret;
>   }
>   

This patch is wrong.
Look how the ceph_decode_skip_n() macro, for example, is expended.
You'll see that 'bad' is needed.

I think that your patch was not compile tested.

Please do not send patch that are not at least compile tested. Even when 
it looks obvious.

CJ

