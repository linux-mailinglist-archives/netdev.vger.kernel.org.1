Return-Path: <netdev+bounces-20885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3A761BC1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953711C20ECF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E521D4A;
	Tue, 25 Jul 2023 14:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03921D51
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:30:44 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579226A1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:30:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so80776691fa.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1690295433; x=1690900233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeJ+8u8ZaYUwpLiyi+CCaKydAPqb727pDz7pLVQc0Og=;
        b=phE16iwCP31NqrlalixrwUIhuGyz7U0E5Y0skNncWEjB2mPNscOndY0shE0gYzdtAU
         jj7Mqm1ohFxtjGGh6OVLBA6AjHcIsWRo+/pUpkh1pRhIiVynC5g15qj/kmFdslgdEPjP
         ZoJEdEli/309kprYOVGjdq8EJ+Y7b7i2/QOr2PwEdLWyYf1+ypNr66Db1NmP2ih/v/lZ
         pzFhUaBMVR0I3HxTNy2xbYptBHK8IHpHGKce1buo3UHXtWBGvjmAjBQ871KZcW5WAVXf
         1O91WaEfDO96SSHQ6QXBMKW14FCNPqkK+/BqE1aFg/Qo32mBCh1APXwgs/RcGzT/2cNp
         xjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295433; x=1690900233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeJ+8u8ZaYUwpLiyi+CCaKydAPqb727pDz7pLVQc0Og=;
        b=FBhVaaAIOOIhWkk3wN9jDeHzfbHzBB5dXjU1dJiqdKza5RGxrz1bdfGlfVwdxz0wr3
         WoPifG4D3izvJKrAkz5bCVwfRU0zWBxYCwnuD1dtTZluhVnS47XnrGVSHpny7nnE2PC5
         rH4hgzQRilffLNMLh4X89us394374tpXnkSVkrdWGqDx7+f55Vc0L9tyZJT33BSk3Mgt
         lIZMxE1FsbFPK/R51wiP5Jsb6Zl5vX9MZOn0cCT1iIaxPDHdDFOuSpAM4svhat1ijZOD
         Y8czNrHie2DYy9dMmh1t0K0Dc692QXHsBRPqSRAwNnkrKvHWJ6vfSyZUCkeNcxo3v3YH
         Im7g==
X-Gm-Message-State: ABy/qLbNPkOpDvhGxL9M905iMrQB9/IanSGhsLjYT5liN1v6i4lsLEmp
	UuYRYejt8+LJDVX+i3oN75DGwQ==
X-Google-Smtp-Source: APBJJlGvML6v1TzuUhl0DWjxHNstRMRJ09utxtc+X2zC5yRiM128sQmgAqyZXsoCJCW3ExK9L8DIKQ==
X-Received: by 2002:a2e:9650:0:b0:2b6:fa54:cec1 with SMTP id z16-20020a2e9650000000b002b6fa54cec1mr9474682ljh.48.1690295433490;
        Tue, 25 Jul 2023 07:30:33 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906378d00b0099b4ec39a19sm8348718ejc.6.2023.07.25.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:30:33 -0700 (PDT)
Message-ID: <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
Date: Tue, 25 Jul 2023 17:30:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, lucien.xin@gmail.com,
 liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
 md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
 jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725055706.498774-1-linma@zju.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230725055706.498774-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/23 08:57, Lin Ma wrote:
> There are totally 9 ndo_bridge_setlink handlers in the current kernel,
> which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
> i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
> ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
> nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.
> 
> By investigating the code, we find that 1-7 parse and use nlattr
> IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
> lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
> length 0) to be viewed as a 2 byte integer.
> 
> To avoid such issues, also for other ndo_bridge_setlink handlers in the
> future. This patch adds the nla_len check in rtnl_bridge_setlink and
> does an early error return if length mismatches. To make it works, the
> break is removed from the parsing for IFLA_BRIDGE_FLAGS to make sure
> this nla_for_each_nested iterates every attribute.
> 
> Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: removes the break in parsing for IFLA_BRIDGE_FLAGS suggested
>            by Hangbin Liu <liuhangbin@gmail.com>
> 
>   net/core/rtnetlink.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 3ad4e030846d..aef25aa5cf1d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5140,13 +5140,17 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>   	if (br_spec) {
>   		nla_for_each_nested(attr, br_spec, rem) {
> -			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
> +			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
>   				if (nla_len(attr) < sizeof(flags))
>   					return -EINVAL;
>   
>   				have_flags = true;
>   				flags = nla_get_u16(attr);
> -				break;
> +			}
> +
> +			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
> +				if (nla_len(attr) < sizeof(u16))
> +					return -EINVAL;
>   			}
>   		}
>   	}

Patch looks good now, you should probably remove the extra checks done
by each driver that are now unnecessary (net-next material). As Hangbin
commented you should target this fix at -net, with that:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


