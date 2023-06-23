Return-Path: <netdev+bounces-13301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD173B28C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E198E1C20C40
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EA20E6;
	Fri, 23 Jun 2023 08:18:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AA20E4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:18:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F012112
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687508311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkaQxx+Y1hANa87C64UPOn1w6sw0j2xvZ0R3DPOEvLI=;
	b=Ymn5rdV8Ttuqn+YcSDBP7LmhvFicFmTOcwATFa8iTys3DMaY1ENRPASnla6DKbizfPEkPt
	YumWlm+OL61kndLlfZVuTMvym5rQcB5b1UE1cvjqR+v7lGdJ4jLS0QiiELcX1j0/4uzEzO
	gIuktqJZx0rSXwfOVp+Twuie50NgvYM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-sB9sE1_ZP-ax0jmLRTAqng-1; Fri, 23 Jun 2023 04:18:29 -0400
X-MC-Unique: sB9sE1_ZP-ax0jmLRTAqng-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ff7a8b9aeso928196d6.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508309; x=1690100309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkaQxx+Y1hANa87C64UPOn1w6sw0j2xvZ0R3DPOEvLI=;
        b=Dv5dn5o5Hghb9pwlJwbGxGs0R4y1qxP3q30PFSFqlf6+/iezp2CpliyA6FUWvidu9f
         H8NMwLaeM2BxR+qyi0tYSfXrojAQ0pP0ZMYX1lELIMjuypjGN5v/f+5PiVuMdtTlAsFk
         v1aHH8jPO437GHIq9s3ofV9+ZVt2m4VK+aRLN3G7BYRzIROooJS/wWmfya9u5tRGBfBX
         +EwJScuXbBbsxajqoMDhb6bfMSGc/7S7QFgH8+a8UgpSuuSZKVKzYp8m3l+iZ3onBLOz
         JDWczddbUsPlA75YcPQrwepvl8B6SlX831e7uYe88TUkZIJi8vCnsRtnmYKsfUbuRlMA
         r8Pw==
X-Gm-Message-State: AC+VfDymYW7iQm6LLmVfTJkd5HB6hY3mBo0y/3tRKB9G8fIBvAH7lGG0
	6E1hhYOi/XI63romki4JNiFlkuxmH0aZDO6jEkXr5mxYb4lB9Wk59F1iB7A1mOrXyR/llLxGcD1
	AlQ3bmoro2eNIu7QY
X-Received: by 2002:a05:6214:2426:b0:62f:e386:1e45 with SMTP id gy6-20020a056214242600b0062fe3861e45mr23780096qvb.1.1687508308657;
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FUnG3bG8uHAhc8j3r/ENi0CHUWTQvEeqCtObZFm1IgXCwU67fCwyZEOd9Nuyxm4AXcz667w==
X-Received: by 2002:a05:6214:2426:b0:62f:e386:1e45 with SMTP id gy6-20020a056214242600b0062fe3861e45mr23780085qvb.1.1687508308351;
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id m1-20020a0ce6e1000000b006238b37fb05sm4759922qvn.119.2023.06.23.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
Message-ID: <2ee000f803bd1a099aa8fb02ef79c7b25e5f5b08.camel@redhat.com>
Subject: Re: [PATCH net-next v3 02/18] net: Display info about
 MSG_SPLICE_PAGES memory handling in proc
From: Paolo Abeni <pabeni@redhat.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,  linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date: Fri, 23 Jun 2023 10:18:24 +0200
In-Reply-To: <20230620145338.1300897-3-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
	 <20230620145338.1300897-3-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-20 at 15:53 +0100, David Howells wrote:
> Display information about the memory handling MSG_SPLICE_PAGES does to co=
py
> slabbed data into page fragments.
>=20
> For each CPU that has a cached folio, it displays the folio pfn, the offs=
et
> pointer within the folio and the size of the folio.
>=20
> It also displays the number of pages refurbished and the number of pages
> replaced.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Duyck <alexander.duyck@gmail.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Menglong Dong <imagedong@tencent.com>
> cc: netdev@vger.kernel.org
> ---
>  net/core/skbuff.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d962c93a429d..36605510a76d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -83,6 +83,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/textsearch.h>
> +#include <linux/proc_fs.h>
> =20
>  #include "dev.h"
>  #include "sock_destructor.h"
> @@ -6758,6 +6759,7 @@ nodefer:	__kfree_skb(skb);
>  struct skb_splice_frag_cache {
>  	struct folio	*folio;
>  	void		*virt;
> +	unsigned int	fsize;
>  	unsigned int	offset;
>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
> @@ -6767,6 +6769,26 @@ struct skb_splice_frag_cache {
>  };
> =20
>  static DEFINE_PER_CPU(struct skb_splice_frag_cache, skb_splice_frag_cach=
e);
> +static atomic_t skb_splice_frag_replaced, skb_splice_frag_refurbished;

(in case we don't agree to restrict this series to just remove
MSG_SENDPAGE_NOTLAST)

Have you considered percpu counters instead of the above atomics?

I think the increments are in not so unlikely code-paths, and the
contention there could possibly hurt performances.

Thanks,

Paolo



