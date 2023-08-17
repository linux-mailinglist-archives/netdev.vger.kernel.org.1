Return-Path: <netdev+bounces-28601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401F77FFBA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B492820C8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D71ADD9;
	Thu, 17 Aug 2023 21:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2A1643A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:22:40 +0000 (UTC)
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F0C1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:22:38 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id WjdTqiZRhyYOwWkRxqtqyW; Thu, 17 Aug 2023 21:22:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WkRxqUm8jr28JWkRxqtO9h; Thu, 17 Aug 2023 21:22:37 +0000
X-Authority-Analysis: v=2.4 cv=PIQcRNmC c=1 sm=1 tr=0 ts=64de8f9d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=stkexhm8AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=6UV5UrL1aO4bJEFlmkAA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wgoIFsvs5xLnCx7q6HCwBasYA5R0F0VgetzOCKQWKAY=; b=BCBP7qvIvC+L9+9rKPpZHnkX1m
	kBrpap7OckaNKzcVzUpWFO6dYAzPm14FR7eIT3p+/zfPXevDya4tOq2i39znbhx2jhhk+fkAjG04z
	XO0uZv+AaeI5bT6FaID6EGiBOf3EYLrham7Dp1V+f/VdZgSa1g0kRk2A9Tu2Bg09xaZEF29wWvJT2
	8a8B5JO5cQ4Cz29jH/aPA6xuuJtjF7RIkKQL+KSS7Jxb5o8s5DSj9HBFvYTno887Se4vUmxBmx3fF
	Jvs7S8Hxdi8v8R9xMKxU/ZgmTOuyHMG1Qng54rRQHM2j16/ZqM5nkOWqdMjBtrnBqpfRYFXRf09fF
	RIUs0Nrg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55954 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qWkRv-001kOC-3D;
	Thu, 17 Aug 2023 16:22:36 -0500
Message-ID: <d720192a-6381-3122-4e7f-bcabaae8cd4b@embeddedor.com>
Date: Thu, 17 Aug 2023 15:23:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] wifi: cfg80211: Annotate struct cfg80211_acl_data
 with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230817211114.never.208-kees@kernel.org>
 <20230817211531.4193219-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817211531.4193219-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWkRv-001kOC-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55954
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLFnMVUWX6jS6M3TnUJidIidyZB06Wyyw0+L1q2XK/K7mgjTRycY1ecsZswShPuicRVC/g+rhej8IrDVuTaqrMSlLEsjxczYtobxtxzZWOseu+WVG4No
 V6cI358Lehk+nkRbo/Dzjq5es4x60pbWeMWvTYxVKQxIWs6TQ032+i4wfDmzaB4U4usF+tzTMj130ZFKRAkILbhHhI+DnvlLQgk=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 15:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cfg80211_acl_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/cfg80211.h | 2 +-
>   net/wireless/nl80211.c | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..eb73b5af5d04 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1282,7 +1282,7 @@ struct cfg80211_acl_data {
>   	int n_acl_entries;
>   
>   	/* Keep it last */
> -	struct mac_address mac_addrs[];
> +	struct mac_address mac_addrs[] __counted_by(n_acl_entries);
>   };
>   
>   /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 8bcf8e293308..80633e815311 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4889,13 +4889,12 @@ static struct cfg80211_acl_data *parse_acl_data(struct wiphy *wiphy,
>   	acl = kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNEL);
>   	if (!acl)
>   		return ERR_PTR(-ENOMEM);
> +	acl->n_acl_entries = n_entries;
>   
>   	nla_for_each_nested(attr, info->attrs[NL80211_ATTR_MAC_ADDRS], tmp) {
>   		memcpy(acl->mac_addrs[i].addr, nla_data(attr), ETH_ALEN);
>   		i++;
>   	}
> -
> -	acl->n_acl_entries = n_entries;
>   	acl->acl_policy = acl_policy;
>   
>   	return acl;

