Return-Path: <netdev+bounces-17827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B603975324A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BE31C2152C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2B46AC2;
	Fri, 14 Jul 2023 06:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD86FA1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:52:07 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162910D4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:52:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so15185035e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689317525; x=1691909525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsX/HwzagHl/U9NUofVSt9gp5IqjXm3Ix/udnIwbVEg=;
        b=MyoA07EabM0HyVDlahCi3qkltseQCJ+Jc1mEG/SpYWzpwbUxN74tzeidwTCdE1+ALx
         W4YRQwXpg03kOirBd3GlVaDDOhO9CxzbzqFuyD4PfHVi1OPLAy0UyKE6ej02ES1nwYyC
         06GAWpodkZFYh92g5nlBYzlap9z4VgTVLKmmcEGhm6Xsbg8hNvIhtBq5PwvSJPPE8R7Z
         YFt/lANN2OoeIve40vIt4q2npzQNpml/x5oezKAhuAWxhepQNMVdKAuCfFEtHSqz505M
         h2dLbgUdHIN0kvc2cUgCbF2fvgd5lyPyAFS7RyUItW2BdezjYr+SDOagEkPFR1ayuLRa
         S/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317525; x=1691909525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsX/HwzagHl/U9NUofVSt9gp5IqjXm3Ix/udnIwbVEg=;
        b=NqryNnx7b21jNT0cgEPPe6TIqBC7/6PIXzFuEl/TZFh3C4cJ8bxn5O0+NyOCyCGS+l
         dbfes7Dxs8JBMhLt2lYPWFLw869WxuUdmHjC9TCdqqMNs9XgFVYR6iGkQOCo93eISNcH
         nidcPoLlsHMFn7YqzZ/ySYY/2yM/LgFmlDlOpFUiw4OrUjiwTl47wPvrDGQv0HYjKkLQ
         LACJz3dkPG6oxNtypwHEmLSgWkAptagzcWf6QFjH31b6ZHSf2yHeo5Q8t2zdodufdXre
         HuuNKmHI7ACvLL1NOcRygYI2wT3u5aHWBM7p3suqwZ/n0ecDWStydA9rzJtYgapfIfO3
         Y+uA==
X-Gm-Message-State: ABy/qLYxoIH3l3Xelen9CFPQDaDHTXbSDRw0hJ+KiGAQJFfkxxPQvsc9
	Ijq21seVSGgX9Mmc7C5i7NFuYw==
X-Google-Smtp-Source: APBJJlFQaAb0Wpqr8493ALvXGSHHHdjXllyENsmWVx/KSWrwc4nIRViwKyfIjTQ2VqNVUMvD/fX1zQ==
X-Received: by 2002:a05:6000:50:b0:314:3843:ebaa with SMTP id k16-20020a056000005000b003143843ebaamr3685547wrx.68.1689317524754;
        Thu, 13 Jul 2023 23:52:04 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c7416000000b003fbc9b9699dsm669406wmc.45.2023.07.13.23.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:52:04 -0700 (PDT)
Message-ID: <076ccae1-22e7-d7ab-1143-41a7a6f73b67@blackwall.org>
Date: Fri, 14 Jul 2023 09:52:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 2/2] team: reset team's flags when down link is P2P
 device
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Liang Li <liali@redhat.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
 <20230714025201.2038731-3-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230714025201.2038731-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/07/2023 05:52, Hangbin Liu wrote:
> When adding a point to point downlink to team device, we neglected to reset
> the team's flags, which were still using flags like BROADCAST and
> MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
> interfaces, such as when adding a GRE device to team device.
> 
> Fix this by remove multicast/broadcast flags and add p2p and noarp flags.
> 
> Reported-by: Liang Li <liali@redhat.com>
> Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 555b0b1e9a78..c11783efe13f 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2135,6 +2135,10 @@ static void team_setup_by_port(struct net_device *dev,
>  	dev->mtu = port_dev->mtu;
>  	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>  	eth_hw_addr_inherit(dev, port_dev);
> +
> +	if (port_dev->flags & IFF_POINTOPOINT)
> +		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> +		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);

here too, looks like missing {}

>  }
>  
>  static int team_dev_type_check_change(struct net_device *dev,


