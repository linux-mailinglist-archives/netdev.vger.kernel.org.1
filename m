Return-Path: <netdev+bounces-17221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B7750CFF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347B9280DAB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1785214F5;
	Wed, 12 Jul 2023 15:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6067214E5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:46:35 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F131BB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:46:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9922d6f003cso912625966b.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689176793; x=1691768793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qsNwSJj66luchpZzX75OoZLSwHVbA5Pm9qid51Ei6Y=;
        b=PF6fmNqjZ/AYqva8v3NNTKu8eEoKH35QAaW5y9va6R7Ux8tb4vtt4fnEqofuxyvjZn
         a0qMZq/JAmWMPbOGYXnJcmQacubZOqKSeNKCmAbvSBNzJdQtuv4yS6Kk+rnWfmfClGBS
         cXP7+SuGhDwzNxvL+iujWDLk0SH2CMgt5PRsdZmx5C+WmX8GF34Se4puFXLXJd2HUjHo
         WUMkEMnuHq2blfogwHyG3OFdUk+EkXNWRaQON2Und7zDQ6c3MKwO483lZw1WfgJ4ShdM
         ga7iF5l42KYLzIqwup5geQ4ilZb0dKAHrextos3SS0y2+nKawPQyy4UD4jy1CfNyZRM5
         Jm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176793; x=1691768793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qsNwSJj66luchpZzX75OoZLSwHVbA5Pm9qid51Ei6Y=;
        b=ex6ajrWnqF8y+L+ADg3GIRovaOT4sOMpsA51XErVRFeFXKwguoMplWxn5G24SHas/+
         tMwLiXm6qwpoK3ZMN1FDkDvcvna4RIooV3dCFUfl3NR1QwBiDCZO2b/1TovQKOUA5OUg
         0iewBaGRxlnABAd27mi+5IaVNXNzLI1q3TR2SHXSsZ04INWQCRWjgj/7VnedoV9N3IGi
         EyqqRKfAenMm13CmWcO6tL/tFiOwPRUHeKion6XgNXKb9VVVZaNPf1uksPi4N65FaoJa
         8MdsTzbMLRXFFsGB5UmN3lbZ9tzu45LHaeaMpJnfHHG9ds3X3jXmuexKV+u91bUlM3o5
         1/9w==
X-Gm-Message-State: ABy/qLag2U6s1IIcQVIG9vWwJXLqCqpf0vDH93WKVrnlQKylM1cQMWHG
	W0Q3esbaUzkQEPgbD9nUoF0ylQ==
X-Google-Smtp-Source: APBJJlF+H1DxTJOqCtmKvaeOHMNy8NffqS1ilyjCJbwvGQxE5YfEKotn1UsSgKe5YzerwlwDlxNuFQ==
X-Received: by 2002:a17:906:150b:b0:982:7545:efb6 with SMTP id b11-20020a170906150b00b009827545efb6mr16230217ejd.66.1689176792780;
        Wed, 12 Jul 2023 08:46:32 -0700 (PDT)
Received: from [192.168.0.161] (62-73-72-43.ip.btc-net.bg. [62.73.72.43])
        by smtp.gmail.com with ESMTPSA id ci7-20020a170906c34700b009934707378fsm2718238ejb.87.2023.07.12.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:46:32 -0700 (PDT)
Message-ID: <28f857c9-2ee9-6a20-ecd2-b4e63307cd89@blackwall.org>
Date: Wed, 12 Jul 2023 18:46:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 net] bridge: Add extack warning when enabling STP in
 netns.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, Harry Coin <hcoin@quietfountain.com>,
 Ido Schimmel <idosch@idosch.org>
References: <20230712154449.6093-1-kuniyu@amazon.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/07/2023 18:44, Kuniyuki Iwashima wrote:
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
> Let's add extack warning when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Warning: bridge: STP does not work in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   - Just add extack instead of returning error (Ido Schimmel)
> 
> v1: https://lore.kernel.org/netdev/20230711235415.92166-1-kuniyu@amazon.com/
> ---
>  net/bridge/br_stp_if.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..b65962682771 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net))
> +		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

