Return-Path: <netdev+bounces-15853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0974A298
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FDD2813A5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFABA28;
	Thu,  6 Jul 2023 16:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE7BA23
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:55:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D01986
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
	b=DltiuwmjNVpOwioKT0lnA0kc5c1RjjRB/kLmODFfMh+pc/jB3OlgsxGr2Vey7u/egaq3gz
	+gadSB44iugrH67MqU29HBpAq0+2oBufXBXigK/QIDh/SytxDfn0K3ybfjO9I7UxWhKSUW
	Xjb2cDYP9Gjfww8Nve4PgBfigM//s1E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-azRm-YyBPsSP0u6e3oSCcA-1; Thu, 06 Jul 2023 12:55:17 -0400
X-MC-Unique: azRm-YyBPsSP0u6e3oSCcA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-978a991c3f5so69749766b.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662516; x=1691254516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
        b=aGxnOAIQmQmqkYHvj/2kz3cIbvmu9zkQaEdnlOMy1BMY1LTLYvYruBEEM3/PnkDJfo
         qQwXhzdtLBKmi5TfkuRsFexzchussaOWT1Nxl23eabU8ucrSUVZ4K8tD9N93cBQzcp3V
         6T8PubxLHl+MA7uFKiQ5Lz6NPSKcBe2/x3O7ghmuFkRjk17MfPSo1F3J/Mgn8Z4n9bWo
         qUBfp8i0kblPQiWfRuh+EkXQuYevj181TbB+9u4Gh88G1m/fNW76ci4finSNVWIoooTV
         X1hskhms8KgcpRhRHaXROoGOyGdNOpIrOiOTz5EXB/SbnbSphgbroNDyOcIBX961rTTf
         WDLA==
X-Gm-Message-State: ABy/qLagyQqjsGmHKRQf6NFoiI2mUgJSjT2uUGHkc+0AX9RsoGWBS4xd
	mq01fnlxDBSX0QhpKnF1LgDZZgSeX4WkP/KWSIP7pXUU6uX04mgwMNUrzEywmr69MyGNeJyEx+h
	9Z1V++KXq+/F8fftr
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id 10-20020a17090602ca00b0097965f0ccedmr1934022ejk.17.1688662516700;
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkD0rlqSdTev+Q2IqNmZT5B5F3idaEZ37dXEcrn3WdUID6ErjT2MTHmJfkU0j9eSLaJFZ9qQ==
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id 10-20020a17090602ca00b0097965f0ccedmr1934002ejk.17.1688662516511;
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b009737b8d47b6sm1023809ejb.203.2023.07.06.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 09/17] vsock: enable SOCK_SUPPORT_ZC bit
Message-ID: <vaknax5rfvbb3ymylshak4cih2ddhsfhiq5dualh5frbedczmw@zduzizg2g6pa>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:39AM +0300, Arseniy Krasnov wrote:
>This bit is used by io_uring in case of zerocopy tx mode. io_uring code
>checks, that socket has this feature. This patch sets it in two places:
>1) For socket in 'connect()' call.
>2) For new socket which is returned by 'accept()' call.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 033006e1b5ad..da22ae0ef477 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,6 +1406,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>+		if (vsock_msgzerocopy_allow(transport))
>+			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+
> 		err = vsock_auto_bind(vsk);
> 		if (err)
> 			goto out;
>@@ -1560,6 +1563,9 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>+			if (vsock_msgzerocopy_allow(vconnected->transport))
>+				set_bit(SOCK_SUPPORT_ZC,
>+					&connected->sk_socket->flags);
> 		}
>
> 		release_sock(connected);
>-- 
>2.25.1
>


