Return-Path: <netdev+bounces-41789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBF7CBE63
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050C71C20993
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88203D974;
	Tue, 17 Oct 2023 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="o6HGc/M9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD5C15F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:04:58 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF66F7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:04:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40806e40fccso2202075e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533495; x=1698138295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLkwIKpccGDhl2g/IAel1atWebFPpXTz7dxlcfet/9o=;
        b=o6HGc/M9L0+fca2bnCFA27whzk7n4BNbIuOCH7SrckAS1oidB4V6G9x0bvmIXAk0eR
         FyoR7ALINRojjkVUgpExmvDhpmVmlqYGMIIudoeqUefaHoJSS2QmACHKLnZZ+jm4TOVl
         CxSehU2wfMzOfR23N3S+7ykwOhGRANroFoGLoWYJToGR4KNdSlkW/5jzAD2KjTrka8gq
         ce/87FYa9j3aIVJUpXApVa2+XRyC5HHZb43YU4YhFYbi44Znp990oyh6IOpFFCzIqRCi
         9PR7g2UoN+XoidXGnaJyorTC7L9ebm86TxLe5NlKgzo0e2yypK/ih8+UaXHo0K/BxdYp
         +axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533495; x=1698138295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLkwIKpccGDhl2g/IAel1atWebFPpXTz7dxlcfet/9o=;
        b=A1Q7e8ONcUePilCwPNiactY7gHo+B7xH1dzYNKly+MIQWgyCFeXpK+oGVqfcs+5u1y
         jR30zxkPNOFz7E/AQWpGkLhnFvdC669fd/q1hkx/0eYizkuSwci2B052kg2mxjw5Rvtw
         914fOrk4EZgkORVAmCuDx/092GeScKo2mQAXQPuugiwyxYK326V3Ak1LD93/Wcdb6lHs
         LUr+17fGRpBoeVVzFoLLcvlhKJKQOeRNv8MDVzx7DccbchhOEtG9JK5n8f94kgYR55ku
         qlCnqqbsQMRwkMgvU5jwt6xDU4B8tsDJvqoZsuf6O7f9WHH1hcCGAjTQyx0SyQL30qKG
         O0FA==
X-Gm-Message-State: AOJu0YxmEIhDD+0D03TRcJyToApf/jwiwkdCj3cF6aC+ula6iyIQk0uV
	6f4jz1B9RqcsAQ+pdmoRqR75ng==
X-Google-Smtp-Source: AGHT+IF3cEUI3F2vErWkTlpLAbSQ5XM/SWvyATBG6VSsHoKO0SkhuTCLQXUl8O/7wmzfxFKQOdeuHg==
X-Received: by 2002:a05:600c:3143:b0:3f6:58ad:ed85 with SMTP id h3-20020a05600c314300b003f658aded85mr1216597wmo.10.1697533495396;
        Tue, 17 Oct 2023 02:04:55 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c430300b004076f522058sm9264765wme.0.2023.10.17.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:04:54 -0700 (PDT)
Message-ID: <6a6a2919-c414-0b13-9488-2c81655c2b8a@blackwall.org>
Date: Tue, 17 Oct 2023 12:04:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 01/13] bridge: mcast: Dump MDB entries even when
 snooping is disabled
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Currently, the bridge driver does not dump MDB entries when multicast
> snooping is disabled although the entries are present in the kernel:
> 
>   # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ff9d:e61b temp
>   # ip link set dev br0 type bridge mcast_snooping 0
>   # bridge mdb show dev br0
>   # ip link set dev br0 type bridge mcast_snooping 1
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ff9d:e61b temp
> 
> This behavior differs from other netlink dump interfaces that dump
> entries regardless if they are used or not. For example, VLANs are
> dumped even when VLAN filtering is disabled:
> 
>   # ip link set dev br0 type bridge vlan_filtering 0
>   # bridge vlan show dev swp1
>   port              vlan-id
>   swp1              1 PVID Egress Untagged
> 
> Remove the check and always dump MDB entries:
> 
>   # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
>   # ip link set dev br0 type bridge mcast_snooping 0
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
>   # ip link set dev br0 type bridge mcast_snooping 1
>   # bridge mdb show dev br0
>   dev br0 port swp1 grp 239.1.1.1 permanent
>   dev br0 port br0 grp ff02::6a temp
>   dev br0 port br0 grp ff02::1:ffeb:1a4d temp
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 7305f5f8215c..fb58bb1b60e8 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -323,9 +323,6 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
>   	struct net_bridge_mdb_entry *mp;
>   	struct nlattr *nest, *nest2;
>   
> -	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
> -		return 0;
> -
>   	nest = nla_nest_start_noflag(skb, MDBA_MDB);
>   	if (nest == NULL)
>   		return -EMSGSIZE;

Finally! Thanks :) this has been a long-standing annoyance.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


