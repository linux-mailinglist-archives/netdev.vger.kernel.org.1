Return-Path: <netdev+bounces-37235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CB7B45A2
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 08:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 87015281DD6
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A282571;
	Sun,  1 Oct 2023 06:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3423D8
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 06:33:44 +0000 (UTC)
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E3BE
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 23:33:42 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTP
	id mm66qKutXNWIemq1LqtF7C; Sun, 01 Oct 2023 06:33:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mq1KqAB4ePoqfmq1KqujDf; Sun, 01 Oct 2023 06:33:38 +0000
X-Authority-Analysis: v=2.4 cv=BbLLb5h2 c=1 sm=1 tr=0 ts=651912c2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=1wfVGpDdhcGxkbiBJp0A:9 a=QEXdDO2ut3YA:10
 a=bOnWt3ThIoLzEnqt84vq:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DrXa2rG6dSCIyhFViMvKaxN9ZljtEbXXYtJDNmxhFcI=; b=rA0c4/TQzJTvID0G+vnwo8cTWP
	247fmP7DGX+RGqHLGzelXVmgqGgwO/N74BuoNGXyKQlXf53/pll05f9d05i4Rae0WbxnMY9oNZglZ
	jZXRz4mWqZhFwrQVCYqjNpTwmcZ9/eYJRfIJnPCE3G5scqoGWV80KDNjorrS4OcTPVfAGsvIBnaMN
	u31d6w4tiTLyknlBsshptooe+/TFDF0H3uc7rgpKSKyDKFJCyTODlNFoXgPWbud/ldzO2awUB4jzs
	E6lMvCcFZzfpUAohT9Frt6M7mwRmqRz8hq22Ht3zDCDIDlSknfd9Yn+R5rsbWQ2Tro8bV9fFPOoJY
	/M6lQPpQ==;
Received: from [94.239.20.48] (port=58074 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qmq1J-001HC8-0v;
	Sun, 01 Oct 2023 01:33:37 -0500
Message-ID: <2a8c5d4f-8404-3198-da8a-ba341609aeb1@embeddedor.com>
Date: Sun, 1 Oct 2023 08:33:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] chelsio/l2t: Annotate struct l2t_data with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20230929181042.work.990-kees@kernel.org>
 <20230929181149.3006432-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230929181149.3006432-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmq1J-001HC8-0v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:58074
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpIlMcaufwswIPGBcic7fF3dNe7X5I2zpG8V3f2UoPaKNI1GmG3b7D8B52AucQLM2PSpYXLd4ICmU9+GnXMgljYtndtjgaOAuML33URsSqZJSUI6ao3
 rdVlg3SLVtTObJZIvaomUt3uK9CW530s+XK7QN7Z45O8CdrViKRmvUT+v3aW4Uq0LD0sZKEXciSFisF7V+ubTZDZ9+CqZGMyPOw=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/29/23 20:11, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct l2t_data.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Raju Rangoju <rajur@chelsio.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
>   drivers/net/ethernet/chelsio/cxgb4/l2t.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> index ea75f275023f..646ca0bc25bd 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> +++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
> @@ -76,7 +76,7 @@ struct l2t_data {
>   	atomic_t nfree;		/* number of free entries */
>   	rwlock_t lock;
>   	struct rcu_head rcu_head;	/* to handle rcu cleanup */
> -	struct l2t_entry l2tab[];
> +	struct l2t_entry l2tab[] __counted_by(nentries);
>   };
>   
>   typedef void (*arp_failure_handler_func)(struct t3cdev * dev,
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> index a10a6862a9a4..1e5f5b1a22a6 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
> @@ -59,7 +59,7 @@ struct l2t_data {
>   	rwlock_t lock;
>   	atomic_t nfree;             /* number of free entries */
>   	struct l2t_entry *rover;    /* starting point for next allocation */
> -	struct l2t_entry l2tab[];  /* MUST BE LAST */
> +	struct l2t_entry l2tab[] __counted_by(l2t_size);  /* MUST BE LAST */
>   };
>   
>   static inline unsigned int vlan_prio(const struct l2t_entry *e)

