Return-Path: <netdev+bounces-28605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF977FFC6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FA6282208
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4AA1B7D9;
	Thu, 17 Aug 2023 21:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C31427B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:23:30 +0000 (UTC)
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D62710
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:23:27 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTP
	id WgJYq0wvgQFHRWkSkqnkj4; Thu, 17 Aug 2023 21:23:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WkSkqkDzeor5tWkSkqwr6Q; Thu, 17 Aug 2023 21:23:26 +0000
X-Authority-Analysis: v=2.4 cv=Vqcwvs6n c=1 sm=1 tr=0 ts=64de8fce
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
	bh=uLjm7eVSbAemKtEXh7vE86rFzD3QqYn14hAQB8qstTY=; b=ZQuAjH5Ow5QgCHbUeJSKWprYRg
	cTk2Ou/HefhVr9+5UvBl2nfIhgmzp+eiiOIOIEgLba8C9D4xz6vc+HWk0LC8qUPXIb66wIxPywFCi
	NW2abjuA7PdGkHn2IbL3gJ3yJYUaT+xse5qv/xfXmLlf6yORq2ITy+NzOgDRGWaYMqFObtUuvCkIR
	Sh4Q4be/P92KpLqOSDs9S4xjXHBJDi7YvJVBmF+HBLomk0B/vT8I5vUtfeI9dL85jMOWgLCHysH5d
	0+qLuuXoTifJbEIKl1UGTj+DJo9rhqdAWZOH3RlwQa/87OrwquzezA7rKE/AzlE3Cp9g1vEO6iDR5
	1Cc8kOYQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:35714 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qWkSj-001lIy-00;
	Thu, 17 Aug 2023 16:23:25 -0500
Message-ID: <6ac74722-1516-b1f1-5723-00e624beeb89@embeddedor.com>
Date: Thu, 17 Aug 2023 15:24:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] wifi: cfg80211: Annotate struct cfg80211_rnr_elems
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
 <20230817211531.4193219-5-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817211531.4193219-5-keescook@chromium.org>
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
X-Exim-ID: 1qWkSj-001lIy-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:35714
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 110
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHnCg55sJSdVrOdhZYgV2jiidRChwch1TCMFBsEB/hLqQPYw690yemMrYYlfz93fhNXRIq5SbizNDfWttdAuVdFr4ll787dp041U45guxFsce4IHUebd
 VBi1soUy9aXjF9XOkyLT1yNRjdppWGvJSLo4Pzg7TxMOYqt0C66TsHCS1G2dkxl8Sj1gkrtxgfN5ivvd4yG2M/Kdx8sbFAj68qY=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 15:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cfg80211_rnr_elems.
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
>   net/wireless/nl80211.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index e9ca4726a732..6efe216c01d2 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1204,7 +1204,7 @@ struct cfg80211_rnr_elems {
>   	struct {
>   		const u8 *data;
>   		size_t len;
> -	} elem[];
> +	} elem[] __counted_by(cnt);
>   };
>   
>   /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 9ba4266368db..0ffebf1a1eb6 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5470,13 +5470,13 @@ nl80211_parse_rnr_elems(struct wiphy *wiphy, struct nlattr *attrs,
>   	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
>   	if (!elems)
>   		return ERR_PTR(-ENOMEM);
> +	elems->cnt = num_elems;
>   
>   	nla_for_each_nested(nl_elems, attrs, rem_elems) {
>   		elems->elem[i].data = nla_data(nl_elems);
>   		elems->elem[i].len = nla_len(nl_elems);
>   		i++;
>   	}
> -	elems->cnt = num_elems;
>   	return elems;
>   }
>   

