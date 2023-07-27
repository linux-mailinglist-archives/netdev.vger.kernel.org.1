Return-Path: <netdev+bounces-21897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A47652C2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FB51C21624
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D015AF8;
	Thu, 27 Jul 2023 11:44:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25301E57A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:44:08 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAA2109
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:44:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so1057587a12.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1690458245; x=1691063045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Pd52QAOVtNNbgDqHYQEjCrAzdyOOjihPSFq0M5Ik4Y=;
        b=Bbak6hOsd1TyATRGYe05W+0/rKMMCiOckHsDdv6SyfQ0uqHMfd3rafUSrblXXzZoyK
         FHmSWmyL7uuFub/fafa5s6Gam61mZI3IzRKmsHFU0ZiMqKVeVGtqm5DR7DqF7JXKTXUF
         aH+mx/OTorlYbaLSNJgaozLQQOD+gkVjFPJryET2EKavzdFF74BjnpzS0aMo5Q7aO3++
         DfWTnOH1fDDHf/iOk1+Vek4v6aZDcu8EJJ/ZEiXBsQtUnj/6LXvYIGvW1+7cYa3iH/aX
         NNhAbdaKjxHA33v71NGTz73iWZdfrmjAVdhuUqBoLHqsSK82OhCjmn5onGqGbvwAQWUf
         PGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458245; x=1691063045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Pd52QAOVtNNbgDqHYQEjCrAzdyOOjihPSFq0M5Ik4Y=;
        b=gDNtcmV4HjuBM3IEV/IeblRd0WaY0fR4s4NIH4xcsMy/QMMo85R5X79vSk/1wxiGbo
         FZt/6+GlsNhw5OgmYp6E2wKkDxZgGBG4xKXdMlWdz3rOIJpuOJUyezBtAT6t+xBDf9YI
         xUFrx0BsXgJAm+cZ5/zPJI0YPbiRnhXMF9LxurdPeg+BDIt++72VKJR1yjwCyGeGfSr/
         AY973kj4QybWniuJcBRwdVMYcNol9TkVCUQyimJAYWlszs4nPEJddG++9e6jF0DRmTAu
         a6R4Sio15eQKhPyEodeMfadBrSWu3k5PiwNh1MxePWd+pyiL79acjUHo1ZnDl2OVwYie
         oIEQ==
X-Gm-Message-State: ABy/qLa+zi/c3164XhgJMP1ZZeOGIL13lTkeZZQZw5jJ2je/t+HLw8bS
	hVP64INcMGYhUmB7Q0bJUhY2xhXtJyqT/C3kafY=
X-Google-Smtp-Source: APBJJlHxaXVKfTJi3HvDwrCK+UddDlp4jZfELrpULv5ukfq77Dm+KA3G/1qp1PoAPSnHwBXlpw+QCA==
X-Received: by 2002:aa7:d65a:0:b0:518:6a99:cac3 with SMTP id v26-20020aa7d65a000000b005186a99cac3mr1394418edr.31.1690458244681;
        Thu, 27 Jul 2023 04:44:04 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402078700b005221ce96801sm565226edy.35.2023.07.27.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:44:04 -0700 (PDT)
Message-ID: <bd9e39da-088c-976e-982e-f5e2d4f4528b@blackwall.org>
Date: Thu, 27 Jul 2023 14:44:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
Content-Language: en-US
To: YueHaibing <yuehaibing@huawei.com>, roopa@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230726143141.11704-1-yuehaibing@huawei.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23 17:31, YueHaibing wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   net/bridge/br_private.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 51e4ca54b537..a1f4acfa6994 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -974,7 +974,6 @@ int br_multicast_set_vlan_router(struct net_bridge_vlan *v, u8 mcast_router);
>   int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>   			struct netlink_ext_ack *extack);
>   int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val);
> -int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
>   int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
>   				  unsigned long val);
>   #if IS_ENABLED(CONFIG_IPV6)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


