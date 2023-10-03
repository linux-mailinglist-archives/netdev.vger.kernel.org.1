Return-Path: <netdev+bounces-37860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492E7B7668
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EE1FA1C20441
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB71A28;
	Wed,  4 Oct 2023 01:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F981C;
	Wed,  4 Oct 2023 01:51:51 +0000 (UTC)
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E747A1;
	Tue,  3 Oct 2023 18:51:49 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTP
	id npJ5q0DBfaLCxnr3EqMOM4; Wed, 04 Oct 2023 01:51:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id nr3DqxFyKoD58nr3Eq9rAr; Wed, 04 Oct 2023 01:51:48 +0000
X-Authority-Analysis: v=2.4 cv=Ou1cdgzt c=1 sm=1 tr=0 ts=651cc534
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=7ZN4cI0QAAAA:8
 a=FNyBlpCuAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=cZbiYKqXTMG0Wr-ZeUwA:9 a=QEXdDO2ut3YA:10
 a=Dl0WHwQvj8hGZljrFLtM:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ggHCHkGU+2wCnzyFW6haFKxRKI3yRdbYc3yFtrU2eIA=; b=tTeN4mvJkuNKZc/5rouT9pns/Z
	3cj2Axtd2GRqcmFamUMG7bR/flgJsr33ZbRlsjfZ4NF8P1WNmJ7AxNRT0B6VPxJXkl8GMvZ3S+dqZ
	/Bh4Xio+87sTDSEQITowCpk+ovAD3b8Uxu9N6m8iz7WJSMR0Jp1Ghe7GsGX0edxBKl4HBeeACMbhY
	om2Uqs7CuUAKA2m7DE7enV/S6TQnou42HMdF+ttxzgCuql6QUlQ2UAFXhHn/99caQQGFWV/GeWZtF
	JXF6wX6j/VvN6Kl1ils9iw7DVbjDQCFiiaCbTEQODoJ4g79vEB29on3v+O9eEmRJb1tRNs6XGXC6c
	KBfFF0sQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:50436 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qnoyd-001TCG-1l;
	Tue, 03 Oct 2023 18:38:55 -0500
Message-ID: <37d2d198-d9e7-3427-af4f-05ac42c38ede@embeddedor.com>
Date: Wed, 4 Oct 2023 01:38:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] xfrm: Annotate struct xfrm_sec_ctx with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20231003231828.work.527-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231828.work.527-kees@kernel.org>
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
X-Exim-ID: 1qnoyd-001TCG-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:50436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKHY7ZSGoi8l/b5c92Q78wOnWZw3iIyT+RB53iNp7tMGmPZF2xXBcWhbGRqlNEHdKn2D/7D6+GiASZ/w2J7Nl8Lc4+m2r5h4R3DeRWBvOrCMN449Ukt2
 19vtn9YGoemLssaA7WVl3LgTrWXyBjUZiGpHx1h2V28gROscngnQTPaCgSpeD4DEXVx/sp65ERuZqPucGg0NgMSNH3+leqATQF8okm7nCMTbIC4jIrO7+BzV
 Ahdv0FhentkhuZhiRf9dKwNbokc/0XLXf8YiC8Uh/t/rDNyDP+lP9urNgb2VW/tm
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/4/23 01:18, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct xfrm_sec_ctx.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/uapi/linux/xfrm.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 23543c33fee8..6a77328be114 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -4,6 +4,7 @@
>   
>   #include <linux/in6.h>
>   #include <linux/types.h>
> +#include <linux/stddef.h>
>   
>   /* All of the structures in this file may not change size as they are
>    * passed into the kernel from userspace via netlink sockets.
> @@ -33,7 +34,7 @@ struct xfrm_sec_ctx {
>   	__u8	ctx_alg;
>   	__u16	ctx_len;
>   	__u32	ctx_sid;
> -	char	ctx_str[];
> +	char	ctx_str[] __counted_by(ctx_len);
>   };
>   
>   /* Security Context Domains of Interpretation */

