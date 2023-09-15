Return-Path: <netdev+bounces-34191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6A7A28B3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EDC28252E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22C18E18;
	Fri, 15 Sep 2023 20:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3C18C2A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:52:36 +0000 (UTC)
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB444A8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:50:28 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTP
	id hAJpqk2AFQFHRhFlkqvYfi; Fri, 15 Sep 2023 20:50:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hFljqWw1ll7rxhFljqtdIt; Fri, 15 Sep 2023 20:50:27 +0000
X-Authority-Analysis: v=2.4 cv=QJB7+yHL c=1 sm=1 tr=0 ts=6504c393
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=6UV5UrL1aO4bJEFlmkAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t1igbisZY4JCWWgBASjQDcN1v+RkxDKKqSatW1+S9XM=; b=sKPpkHuMAovyz+fDocXbW2MFAa
	ywDePibb21uafX2s669sT+OE2D58ARk4umNIBaQAtiV/Qm0rKtU/I1Z8Ix7s7treFlOFVzDmN/3W/
	p9YbuFyfcNYHAkt++bR2FUpVoI7mnwORg+F92gB3RzU6JpVBAqRrQh1LLj2ycUDSbZQT0XbFwik4T
	CO3kaQcZEiIfRC3LxVT4khAA1YS4XZExZo5nt85QERzvr84DWcgQbikuyZtdPq2f5SVG/CeiUYyO5
	D8c3YJE6PLSZ+Le1B2+Tqm1nAw0QiLokMLIfM2IN6w3vMY6bcmCNUM3ZiANJZP/gXCssZxRDE29iL
	XMGWUxIQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38950 helo=[192.168.15.8])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qhFlh-002fk4-1a;
	Fri, 15 Sep 2023 15:50:25 -0500
Message-ID: <8e9b414f-52bb-bf47-873b-4bc537e62da6@embeddedor.com>
Date: Fri, 15 Sep 2023 14:51:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230915201510.never.365-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201510.never.365-kees@kernel.org>
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
X-Exim-ID: 1qhFlh-002fk4-1a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38950
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 470
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMdYt+V7itmmGqFiEtU9seEjRdmPITZeVurryCpcsSyqlIFiWPQOQ6yc0xc4N2qKKDYDfJoDXeiQ+CxAx029pM6/qRPV5GQIJLkbh8IcsGpe9KC/GYZO
 z1QUPQqHWK01JhB8iJc2oc0Hs8Q615TZfyrBHZAMO+61WiL7iQk3R5dSTsv1pUcVJRDuWH1BaWdp3VjXrfIgEXOj7hgSWtcDgxY=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/15/23 14:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/ceph/mon_client.h | 2 +-
>   net/ceph/mon_client.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index b658961156a0..7a9a40163c0f 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -19,7 +19,7 @@ struct ceph_monmap {
>   	struct ceph_fsid fsid;
>   	u32 epoch;
>   	u32 num_mon;
> -	struct ceph_entity_inst mon_inst[];
> +	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
>   };
>   
>   struct ceph_mon_client;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index faabad6603db..f263f7e91a21 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   			       GFP_KERNEL);
>   	if (!monc->monmap)
>   		return -ENOMEM;
> +	monc->monmap->num_mon = num_mon;
>   
>   	for (i = 0; i < num_mon; i++) {
>   		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   		inst->name.type = CEPH_ENTITY_TYPE_MON;
>   		inst->name.num = cpu_to_le64(i);
>   	}
> -	monc->monmap->num_mon = num_mon;
>   	return 0;
>   }
>   

