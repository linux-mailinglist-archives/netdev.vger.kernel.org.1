Return-Path: <netdev+bounces-41791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E067CBE6B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13272817F5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616C3D987;
	Tue, 17 Oct 2023 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EH2evoum"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA771C15F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:05:42 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00514102
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:05:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507973f3b65so6232761e87.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533539; x=1698138339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZa4jSa9DeYf42hNR0hEqm7HskiNNDncoqwV74WZCOY=;
        b=EH2evoumctYE2/YZmqFmmwTAWb7dJol7Ea2ebKlJC2ub9xtbLYwNKwcVXjDJyw+cF9
         7U/Tut8f2e4n2+dVwmk4bK10px+BtzZFMWUia69nkjnyarlNAbt2NL/6tYqAcRBV0b0w
         +IPKSBQXKI60txwzvfvGWXibZQMGeAHJAEy77hsydPMHk92JIb9XOD2GdrHXUla/p1yW
         dZde1YRD0+a7fowt49gDpcdnBBQ9haPue+77neZJBZ5ly3D1/aCd6ymsoIEsFIl+n173
         j1SuIpCTWTvQSwgPx7dh4aj69Bcv8zjQnErb/JeEFKZFF+BJ7j4F/TpKWRcArC3F8cYt
         8qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533539; x=1698138339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZa4jSa9DeYf42hNR0hEqm7HskiNNDncoqwV74WZCOY=;
        b=bLRG9SIEMIEcH2+3txRd6gbWs55X90ctYOCe43qldFc4+Dd58OXQSldR9yQfh5Ti02
         c1HIQYb3hfMEIjac0/SyPauIyH7qtTpKidAa3BotktQvHxOan2JB8qxf1+sMNbQ+h470
         8bwt0GPeJPnYgGZkrEdn70thvGZ6zC0DsaoFXJpLIL38GV7TsLgaSVrDUs+xUTDHKJE6
         Bh7oSFQBDwdfBgEM3y0mTRI+KVjAIv0yiBSmtoHV37lXTqoIlL8tGW2jiHTmWE7P7h4G
         F8UzX65zS7xY8/zfAWQTzLk9IELBa1hvtQbLPogXUSbYI+3pQUjI4S2ypunSY0ZAF9xA
         O4Dw==
X-Gm-Message-State: AOJu0YyEfcEVx64SZbM4oQVrRLvfzRRwBitJCP4fiVq8HO4JFi2GqpsO
	+3JcnRbSbxa50gOXMs2bPJq/IA==
X-Google-Smtp-Source: AGHT+IE8dxfJKfC4+jZzTbx5iphUVdczDo3vmj167ld5bxxc1ryi87YlDVraI6DOFRC+EbBkS1qEfA==
X-Received: by 2002:ac2:4893:0:b0:504:7e12:4846 with SMTP id x19-20020ac24893000000b005047e124846mr1291198lfc.30.1697533539195;
        Tue, 17 Oct 2023 02:05:39 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0031f3ad17b2csm1198396wrt.52.2023.10.17.02.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:05:38 -0700 (PDT)
Message-ID: <2ba8e4fd-7dd1-0a6d-fc83-be8595cf7bef@blackwall.org>
Date: Tue, 17 Oct 2023 12:05:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 03/13] bridge: mcast: Factor out a helper for PG
 entry size calculation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Currently, netlink notifications are sent for individual port group
> entries and not for the entire MDB entry itself.
> 
> Subsequent patches are going to add MDB get support which will require
> the bridge driver to reply with an entire MDB entry.
> 
> Therefore, as a preparation, factor out an helper to calculate the size
> of an individual port group entry. When determining the size of the
> reply this helper will be invoked for each port group entry in the MDB
> entry.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 08de94bffc12..42983f6a0abd 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -450,18 +450,13 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
>   	return -EMSGSIZE;
>   }
>   
> -static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
> +static size_t rtnl_mdb_nlmsg_pg_size(const struct net_bridge_port_group *pg)
>   {
>   	struct net_bridge_group_src *ent;
>   	size_t nlmsg_size, addr_size = 0;
>   
> -	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> -		     /* MDBA_MDB */
> -		     nla_total_size(0) +
> -		     /* MDBA_MDB_ENTRY */
> -		     nla_total_size(0) +
>   		     /* MDBA_MDB_ENTRY_INFO */
> -		     nla_total_size(sizeof(struct br_mdb_entry)) +
> +	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
>   		     /* MDBA_MDB_EATTR_TIMER */
>   		     nla_total_size(sizeof(u32));
>   
> @@ -511,6 +506,17 @@ static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
>   	return nlmsg_size;
>   }
>   
> +static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
> +{
> +	return NLMSG_ALIGN(sizeof(struct br_port_msg)) +
> +	       /* MDBA_MDB */
> +	       nla_total_size(0) +
> +	       /* MDBA_MDB_ENTRY */
> +	       nla_total_size(0) +
> +	       /* Port group entry */
> +	       rtnl_mdb_nlmsg_pg_size(pg);
> +}
> +
>   void br_mdb_notify(struct net_device *dev,
>   		   struct net_bridge_mdb_entry *mp,
>   		   struct net_bridge_port_group *pg,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


