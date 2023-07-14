Return-Path: <netdev+bounces-17826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8753753249
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D5F1C213DF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD86AC2;
	Fri, 14 Jul 2023 06:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0641C35
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:51:53 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F71986
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:51:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so1776371f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689317510; x=1691909510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxL70Bl+bfjY7rozANQJNAw4sVfMgZ8wYFTP/Yz6aqU=;
        b=TTCi4RRSiPs1IWRCnHUzDdx5MWSF3NBMuqBDYKZPwYANUMRUBGqu7sHXlJpTon8pj+
         RjebqVqjHhS24J3CN5zgivegEEnzygdHohqx+nme028xf9JV4g35tuHH4TkoaQEEAKoz
         EL4InjwynXt5O0brbeWQJFF3qewYbRZ6fD2Llx2SA7APXTYq3sUZhLd+hhJMQXDuz5iO
         5iacoyfmc3tUwxNLVD/bsXTdq62HjLqCQSdhpMrVxQLkw449Vx2vUtLC02wBDSK0acDL
         lx5dOYR/R0tgKkZDGmmhvhocim4KnV3Q1GI6zOouBcy6Fy16t9cqZoEj70QtSqK9MnNs
         Fdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317510; x=1691909510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxL70Bl+bfjY7rozANQJNAw4sVfMgZ8wYFTP/Yz6aqU=;
        b=QubNjV1jYFglq4sMMtdsr6QgFZ4nW2e3TzsrnvLFseEnvSPHcdYEcHY6e/gfCB6MNo
         UfumehyCqh21hsb/AOjbB9zyLEGUTuBDkK3O6gMLs9Hy8zcVQhzpTv6Vv5AUYKPFMCxU
         piFXWVJpMvHZZkbdeyiGGbs8G9CRr4DwCOm3e3DVNxqS/FXUTjGmZxXET9UdxD7YE1/0
         JT8U5jEWjkJl4CWbrMFOSsvoC5jDGI/5PE8/Q75m1epu41jIp6remFBu3PtSjQFkvpOB
         s50dRWzW6c+mfGsPNszImgTzpYew1KutzsxZmpsYeA2mGmkIRT1lw3IlcaOvgZaOs73W
         t9RA==
X-Gm-Message-State: ABy/qLaaHcRkVb8BVaqYpW0vWTKg3kj9xaW3lTDNIP3K9qTtaxfMA5HV
	tw6ghFeS5lYDVhX3bEvJ29vkSg==
X-Google-Smtp-Source: APBJJlFYbF7mSGz/PbI5f6/TiLZuu9CiwsTYgmlT1/4LRa6Lnk5ffNruTBTKGN1hYXZ4H20WfssbTA==
X-Received: by 2002:a5d:4e85:0:b0:313:ef24:6feb with SMTP id e5-20020a5d4e85000000b00313ef246febmr3474655wru.3.1689317509747;
        Thu, 13 Jul 2023 23:51:49 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id t9-20020a5d5349000000b003143b7449ffsm9960000wrv.25.2023.07.13.23.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:51:49 -0700 (PDT)
Message-ID: <b13b4fab-22e7-56dc-caea-6ee3a67ad882@blackwall.org>
Date: Fri, 14 Jul 2023 09:51:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 1/2] bonding: reset bond's flags when down link is P2P
 device
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Liang Li <liali@redhat.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
 <20230714025201.2038731-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230714025201.2038731-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/07/2023 05:52, Hangbin Liu wrote:
> When adding a point to point downlink to the bond, we neglected to reset
> the bond's flags, which were still using flags like BROADCAST and
> MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
> interfaces, such as when adding a GRE device to the bonding.
> 
> To address this issue, let's reset the bond's flags for P2P interfaces.
> 
> Before fix:
> 7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default qlen 1000
>     link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr 167f:18:f188::
> 8: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/gre6 2006:70:10::1 brd 2006:70:10::2
>     inet6 fe80::200:ff:fe00:0/64 scope link
>        valid_lft forever preferred_lft forever
> 
> After fix:
> 7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond2 state UNKNOWN group default qlen 1000
>     link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr c29e:557a:e9d9::
> 8: bond0: <POINTOPOINT,NOARP,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/gre6 2006:70:10::1 peer 2006:70:10::2
>     inet6 fe80::1/64 scope link
>        valid_lft forever preferred_lft forever
> 
> Reported-by: Liang Li <liali@redhat.com>
> Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
> Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7a0f25301f7e..0186b2d19e8d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1508,6 +1508,10 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
>  
>  	memcpy(bond_dev->broadcast, slave_dev->broadcast,
>  		slave_dev->addr_len);
> +
> +	if (slave_dev->flags & IFF_POINTOPOINT)
> +		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> +		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);

missing {} ?

>  }
>  
>  /* On bonding slaves other than the currently active slave, suppress


