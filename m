Return-Path: <netdev+bounces-17057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50674FF75
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7E01C20F30
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A401116;
	Wed, 12 Jul 2023 06:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29C7FB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:38:26 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28B19BC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:38:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991ef0b464cso89893666b.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689143903; x=1691735903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tw6o+RiD3xsjf8AwbB7vgQei7f5cIWP68DUtUmS4mTI=;
        b=eKyatQ3esvy/Br++K/ZWzafOnodEk4cb1aY/mG6E84uxtNIAJ4VGVvMrDYaONeNr02
         8PZsdb0Y3LJVkq5iKxZIyZm6N8YriQ5AHGrIstSu5YXcW2wAmTwsb3riI5ZnwxlfLBUb
         3XWey52p+EEUnY65pGla/nqlwWXkH5BIo/6/vv9hvyNwkycdsnA0u1R00nSXgMYMbYCp
         QJoZRFMCG5seYz5oHzp/9WQk2OGEH0cphmXklRUUQD6br/ohNUBuot8pFU5f4da8ZkHX
         XliKyzfX0WiJrOaMwAofZG7b35soOyfOrDw2Qf5L1i3uaLTAzT2xY3RJ4Bx8AcNfvs0D
         fl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143903; x=1691735903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw6o+RiD3xsjf8AwbB7vgQei7f5cIWP68DUtUmS4mTI=;
        b=ALvjUCSOLx/APNIJnp9YEKxuj9Pb5CoEHbtvNA96LR+wA0y69CFNHkoCAWdwRHx6Qb
         rO7VGQOnYUR1WZgk5D2OR8SowmCfv/bsQf2Zt1HFKafdMp2Y5Qsdcm0B6lYG4bwxLNDI
         ZravWbwyzOcjHUaO5aVGzu8lnsPsGFUWOacb1ZsDGjrd5ls7rbBICDp/ed3DKXWsV1T5
         AkVGJa6Ry27rB69UzQrelTaeG8a0GHnTPf33BHtqiYyDqUAPgIhMQCPnWLC8UkT6phFG
         8zwaPQFYx6HLcYazSUsuqpse/3WlaCkrpxi8r0hknLc9j+yzuiS+5UAjsGh8Hsttsisq
         CpAA==
X-Gm-Message-State: ABy/qLYDNwnmUtJ/LDftcE1u26aemMGu6FhWmyjZo4RxPt7m8P3cgzGO
	9mac1Sav3JfJ9xbJeGDjXduQaQ==
X-Google-Smtp-Source: APBJJlH1pEsJiXYEpbrcahZHa72TJ1r2UizTGSEKZDclPp3mbIEsi8BU/qVuxHJVqiEzQgPIfQPF3Q==
X-Received: by 2002:a17:907:6d8c:b0:989:21e4:6c6d with SMTP id sb12-20020a1709076d8c00b0098921e46c6dmr1309099ejc.28.1689143903035;
        Tue, 11 Jul 2023 23:38:23 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id j1-20020a1709064b4100b0098e025cda3bsm2117917ejv.141.2023.07.11.23.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:38:22 -0700 (PDT)
Message-ID: <18cfa70a-35b6-da02-3dd4-0c8ab6639b9b@blackwall.org>
Date: Wed, 12 Jul 2023 09:38:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in
 netns.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, Harry Coin <hcoin@quietfountain.com>
References: <20230711235415.92166-1-kuniyu@amazon.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230711235415.92166-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/07/2023 02:54, Kuniyuki Iwashima wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> This is because llc_rcv() drops all packets in non-root netns and BPDU
> is dropped.
> 
> Let's show an error when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Error: bridge: STP can't be enabled in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/bridge/br_stp_if.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..a807996ac56b 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net)) {
> +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> +		return -EINVAL;
> +	}
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");

Oh well, I guess this should do for now. Hopefully we don't break scripts that rely
on configuring the bridge without any errors. Thanks for the patch,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




