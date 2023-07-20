Return-Path: <netdev+bounces-19447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9075AB26
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79727281CA1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600D168D2;
	Thu, 20 Jul 2023 09:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1219A04
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:44:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48712111
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689846240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBu9TkbzMOCSD1eOi7WHPZMb2sgit8YCwrw/vhRzZt4=;
	b=NjhA5ivea08H2hUbgsFBx/15WFMitOQUJbGKsz0ILMMvCWL5Tcq02kmNe3aNCMjMaQflho
	IuHLhE6dwfliQhcNMylfhfs0+pVXeGsELEX3qrrlZcefsSQ/tB3dpF/xqvujFz8brOQ3bS
	ojmCa8D25uWaNt5M23pB1kE/k8wyp6s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-tj-Z9c9iPVORVGLOCpeCkg-1; Thu, 20 Jul 2023 05:43:59 -0400
X-MC-Unique: tj-Z9c9iPVORVGLOCpeCkg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-639d9eaf37aso1750886d6.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846239; x=1690451039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBu9TkbzMOCSD1eOi7WHPZMb2sgit8YCwrw/vhRzZt4=;
        b=FSlFQbyw1OkKcEiKIeuVTP0YJneXMqpl0pa0iG+BL5J9t23w/afwr38TO8b7fvtkxw
         mCFY+FXhlixs0Tu4KkmVnlGYCIQU4LRftBv+twzDRWR74R+CeVV5zqu+2RFwC+utNRmQ
         +U7ddT6RG0F/ueS+Y9tiGxJzHJhzG91YgiYGdPbAYLsb5LT+UZ2DIK22HD7WNGDu+93w
         HkMs5wN4wdpOe0UTixwoO8xu/mAo3Z5Q4kauyDLWtcKeqW/g7O2IDPKz49VJbBC4A2eC
         l31XKUWEKw4XINZpjhULNu/FvKwaZLvrkyjXr/Ucb3YNi6eIbk6TI8k7Dqmc3yPFkVsa
         92KQ==
X-Gm-Message-State: ABy/qLa+34EC6amQ9MVwTL25Hpev92WkCAMH8Wh+N7pOPVWeqhJ/pj8M
	g+NZBM4+uUzGY6uRIfg1VDonV3s0fdi2lzKlLUYuQC5nFyvAHMjTt5Q7tbdsF7jQGCeDW4vRiGK
	N2uiDt3swmNQg7Y+3
X-Received: by 2002:a05:622a:1811:b0:403:c2fa:83b with SMTP id t17-20020a05622a181100b00403c2fa083bmr2914714qtc.4.1689846238952;
        Thu, 20 Jul 2023 02:43:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6adGPSviX9fvdcZEGW3p8Vwn5iHiFTcF1R8oieFqEBc6y7+ycrNqyaQuwRaGY5bZ/xT8YgA==
X-Received: by 2002:a05:622a:1811:b0:403:c2fa:83b with SMTP id t17-20020a05622a181100b00403c2fa083bmr2914706qtc.4.1689846238661;
        Thu, 20 Jul 2023 02:43:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id w10-20020ac86b0a000000b003f9c6a311e1sm193610qts.47.2023.07.20.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:43:58 -0700 (PDT)
Message-ID: <e839c959417f813444567556177c8d3a1ef83467.camel@redhat.com>
Subject: Re: [PATCH net-next] ipv6: remove hard coded limitation on
 ipv6_pinfo
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Chao Wu
 <wwchao@google.com>,  Wei Wang <weiwan@google.com>, Coco Li
 <lixiaoyan@google.com>, YiFei Zhu <zhuyifei@google.com>
Date: Thu, 20 Jul 2023 11:43:55 +0200
In-Reply-To: <20230718202437.1788505-1-edumazet@google.com>
References: <20230718202437.1788505-1-edumazet@google.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-18 at 20:24 +0000, Eric Dumazet wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3613489eb6e3b0871da09f06561cc251fe2e0b80..b4d5cc0196c3d73f98c484b01=
a61322926da2f14 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3988,6 +3988,7 @@ int __init mptcp_proto_v6_init(void)
>  	strcpy(mptcp_v6_prot.name, "MPTCPv6");
>  	mptcp_v6_prot.slab =3D NULL;
>  	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp6_sock);
> +	mptcp_v6_prot.ipv6_pinfo_offset =3D offsetof(struct mptcp6_sock, np),

Checkpatch spotted that here ';'  is needed in place of ','. Yep, mptcp
is always a little special ;)

Cheers,

Paolo


