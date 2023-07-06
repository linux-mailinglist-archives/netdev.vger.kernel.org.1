Return-Path: <netdev+bounces-15873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D984274A33C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F28D28130E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBBABE5B;
	Thu,  6 Jul 2023 17:39:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB39460
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 17:39:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBF1FDD
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688665145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHHbMtv2Yw061BT7CmjmxQ5Xv9gcyC1gSAWRuva95Fw=;
	b=R9vkiv5tbCq4ATPBRFAHCZj5tKbr5x0PQGOZd3NU5L9CpyvWrLWKpSATWCsQw5o1jTbj8C
	kjD/NmRCcuu/3jLsVS0urmp2N0Kqtd92gYiJYEaTqUL9aHks9Fsuj7H/D+27WYM8Ybi7/k
	2Vomdje6I0slkQ01+TO54p7/QGe4eQ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-C7NLLUu3OvijoTgK7NzSDQ-1; Thu, 06 Jul 2023 13:39:03 -0400
X-MC-Unique: C7NLLUu3OvijoTgK7NzSDQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-402fa256023so1930481cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665143; x=1691257143;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHHbMtv2Yw061BT7CmjmxQ5Xv9gcyC1gSAWRuva95Fw=;
        b=hVcH81SeVUjDjhLZ6LB8nh8WM1dzc92WKfABYcoGAjOKhcYdPHZb2o7k5gEQMg0b4l
         IweGzv0a80Zz2FtGBW/otcSwbLfhEt3oeEJhmla/Gpri6CYrdvQBqa9dmIMuyWj31Ro2
         uyYm0tO0/Nye21kcmdXHUv4ICSURs+y+FW1gVnm4XNslVRx8I9uBV5R1mGK0PgwVBHxl
         flKv559DlrTSOdmrGKpa0ZylC4uz7ArHdK5YMu0YmYhyhyLAP8SfUASnAKLeqkdllRET
         Qn8LtTQCucsW7X9fNcokHlfkv9TtghMO8elxJ2YtPfA8dSqGg4mQcgsnARcAKIoSxM7m
         ZCOw==
X-Gm-Message-State: ABy/qLamnGb3jWhOcj+OxoB2YOJYmWGmzq7RJIbRcdhChmZmKX4p19db
	HLHu+u/vy++EzQY9SRwr3C676PZUxzCoXxucKGYqPmMzLoTdb5HnsEjZLjwb2EQS0UqShbNBVMK
	IbMT55XiLb9kGkp/w
X-Received: by 2002:a05:622a:251:b0:403:2c71:3ac with SMTP id c17-20020a05622a025100b004032c7103acmr3215756qtx.0.1688665143460;
        Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIrVwBwkUyIKxW2YU5c9N4y7BwKpqmVhgcwOSLYf+V82LWVN/+E31wgze/mdwPbvyZ2mLIvg==
X-Received: by 2002:a05:622a:251:b0:403:2c71:3ac with SMTP id c17-20020a05622a025100b004032c7103acmr3215738qtx.0.1688665143225;
        Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b00402913ecba3sm817639qta.34.2023.07.06.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:37:54 -0700 (PDT)
Message-ID: <f10c5eb17d6598def7ba17886e4e2e6e4aea07e0.camel@redhat.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
From: Paolo Abeni <pabeni@redhat.com>
To: Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,  David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Neil Horman
 <nhorman@tuxdriver.com>, Satoru Moriya <satoru.moriya@hds.com>
Date: Thu, 06 Jul 2023 19:37:50 +0200
In-Reply-To: <20230706172237.28341-1-ivan@cloudflare.com>
References: <20230706172237.28341-1-ivan@cloudflare.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Thu, 2023-07-06 at 10:22 -0700, Ivan Babrou wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
>=20
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
> ---
>  net/ipv6/udp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..debb98fb23c0 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -45,6 +45,7 @@
>  #include <net/tcp_states.h>
>  #include <net/ip6_checksum.h>
>  #include <net/ip6_tunnel.h>
> +#include <trace/events/udp.h>
>  #include <net/xfrm.h>
>  #include <net/inet_hashtables.h>
>  #include <net/inet6_hashtables.h>
> @@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, str=
uct sk_buff *skb)
>  		}
>  		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
>  		kfree_skb_reason(skb, drop_reason);
> +		trace_udp_fail_queue_rcv_skb(rc, sk);
>  		return -1;
>  	}

The patch looks correct and consistency is a nice thing, but I'm
wondering if we should instead remove the tracepoint from the UDP v4
code? We already have drop reason and MIBs to pin-point quite
accurately UDP drops, and the trace point does not cover a few UDPv4
spots (e.g. mcast). WDYT?

Thanks!

Paolo


