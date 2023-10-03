Return-Path: <netdev+bounces-37844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD717B7509
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4A94B281445
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EB405DD;
	Tue,  3 Oct 2023 23:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05565405D6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:36:14 +0000 (UTC)
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660FBF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:36:12 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTP
	id nn1eqT4BIIBlVnovZq6T9n; Tue, 03 Oct 2023 23:35:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id novzqD7iRXSUPnovzqQQ14; Tue, 03 Oct 2023 23:36:11 +0000
X-Authority-Analysis: v=2.4 cv=Urdwis8B c=1 sm=1 tr=0 ts=651ca56b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4K7434RxmIIsyNbinaLvFtsZP+hQ9QTxSWFLG6hbGMA=; b=Ujqyqm80k0YHv3IBYynmlQlx7d
	kKIMt5GHRRlv2LVxhId8LYmlimecyG85vvbs2TrxmzJf6K0qRYwp6iZXjJbPSD1nPKi8S1mAao5FF
	yMsQNtGDCiGWnx5CVHLVwPThBZxBjdk49y6GzqXpPqtntWXGMq80rE03NwUWA/ktwjd0+gVydE3vR
	c/swjgsvt5cTyPW2tEbqDd1CK7qh7P8TmteCaOrSWad19xXMolYWphCkgvSpT8SeYzbHg/ZtvLPs4
	eDek4FFnFAIV6eVuA5O/i2NzNtxPJdQDUn/6pNEdwvS91WsaHisthhZo1YLnvxj1wIBGSaLg/ApQn
	YuyrU99w==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:54634 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qnovy-001R8D-18;
	Tue, 03 Oct 2023 18:36:10 -0500
Message-ID: <ec1ae7b4-6563-b4ec-7eff-b1dd29d9ba8e@embeddedor.com>
Date: Wed, 4 Oct 2023 01:36:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_res_table with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20231003231813.work.042-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231813.work.042-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnovy-001R8D-18
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:54634
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 75
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI1BJeCq6BTDAQapiD1hFmh9x30ikh3SWenW6qurX8DHWMbzwN3L+lqHndpzml21wHvy3O7FoBqmF5bJzNUqUHD9jWGFxHbTf2WwzkKla5DxUjhrPKpw
 bLqlH8uZvLoBEnHns5TH0NbfuVPWv9n/Y0Da+MbPGaER01m20/cPa1pO5w5J3UbmhmdtqKNArsMKt1ZF8En7OjTRtmMtRYx1Sdw=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/4/23 01:18, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_res_table.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/net/nexthop.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/nexthop.h b/include/net/nexthop.h
> index 5dc4b4bba8a5..09f9a732e640 100644
> --- a/include/net/nexthop.h
> +++ b/include/net/nexthop.h
> @@ -92,7 +92,7 @@ struct nh_res_table {
>   	u32			unbalanced_timer;
>   
>   	u16			num_nh_buckets;
> -	struct nh_res_bucket	nh_buckets[];
> +	struct nh_res_bucket	nh_buckets[] __counted_by(num_nh_buckets);
>   };
>   
>   struct nh_grp_entry {

