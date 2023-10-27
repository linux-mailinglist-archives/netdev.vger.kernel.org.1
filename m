Return-Path: <netdev+bounces-44654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C67D8EF0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FF91C209CE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99918F51;
	Fri, 27 Oct 2023 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0akZ8Fq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4966101
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:50:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F601B1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698389438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7+kgIpkRnIzz2eHdQqimJOoF4TSWTI0yuTdLxUk9Ko=;
	b=R0akZ8Fq2zF0LkS7SpCr1G+zavePmgA3hOTmLJ+Y5ySwKvq3mdG+TMmdqXECJRitn1x+8j
	5lBdCHPO3R9DUxCROrXu23ss0CBK3h8AVLZcvkuNDk7DORxiCt4UzUP68+piKzq+9C7/yq
	3O6KRKUw4b2AvN9lLB+v52ZJhTNFtr8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-IGTdo9skPyCRKqFhJyt14A-1; Fri, 27 Oct 2023 02:50:35 -0400
X-MC-Unique: IGTdo9skPyCRKqFhJyt14A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso1971515e87.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698389433; x=1698994233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7+kgIpkRnIzz2eHdQqimJOoF4TSWTI0yuTdLxUk9Ko=;
        b=VbzxW5RdEaR0P66iXHistx8Dcp/AAWeMTyy83rKFtBPdvlQ5Bsqc5ozmCU0GE9zzpS
         g38lu7f8eTQhC0q1dWrqZFsjEqcJtS+x0l+4FKrx6BCtYpY1c2sZBef8OtLDz55Lqzxr
         DpLHw606zYAT8r2ZpFHzkrRlmiWWdelUlTVL4sd0f3aKg6ixbNQBySsXRGQ9Qwux/q9B
         wqc1dK3Zk8jECAUWBoG1i5yp5Z6B9AxKER+aSYIslPbwUE9AU4aroPXskDpDImkIORjl
         Bb5dIDnL8HKsrXWkt6G2GFavqaiYoq2iSLRH7KugiEGqAn1NYrZw0Xdzlgb67Vl61PjC
         FEdw==
X-Gm-Message-State: AOJu0Yy0Sx2Zo9QExc7gJXIYlciIXH7sqXb+tDrYTnEBtGNi4ZLqnS0T
	Io2UFXmuOHhM4PaQwbF5C0k91+WnSRsQ2gY5p+A3KZySPNGBrbrSE0INMfklvwxETo2qYP4+wiv
	AJBf/0nttWXTziAp1FoAIHa3fekqwK0ki
X-Received: by 2002:ac2:5f69:0:b0:501:bd6f:7c1e with SMTP id c9-20020ac25f69000000b00501bd6f7c1emr1160388lfc.33.1698389433625;
        Thu, 26 Oct 2023 23:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrsaeGI3Jo6Jp2Ssgu51RQYavSOuYL0EFM9TLHWye8++tMBTcIO+V++RD9Z65TfDRulDwCu8jfvEYPwaZU2/g=
X-Received: by 2002:ac2:5f69:0:b0:501:bd6f:7c1e with SMTP id
 c9-20020ac25f69000000b00501bd6f7c1emr1160365lfc.33.1698389433222; Thu, 26 Oct
 2023 23:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026190101.1413939-1-kuba@kernel.org> <20231026190101.1413939-5-kuba@kernel.org>
In-Reply-To: <20231026190101.1413939-5-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 14:50:22 +0800
Message-ID: <CACGkMEuf5K0BKmniYmqeDtHcDpZFgzsrnFhnCKA1aD0gsM3U7w@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jhs@mojatatu.com, arnd@arndb.de, ap420073@gmail.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 3:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jhs@mojatatu.com
> CC: arnd@arndb.de
> CC: ap420073@gmail.com
> CC: willemdebruijn.kernel@gmail.com
> CC: jasowang@redhat.com

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/amt.c        | 1 +
>  drivers/net/dummy.c      | 1 +
>  drivers/net/eql.c        | 1 +
>  drivers/net/ifb.c        | 1 +
>  drivers/net/macvtap.c    | 1 +
>  drivers/net/sungem_phy.c | 1 +
>  drivers/net/tap.c        | 1 +
>  7 files changed, 7 insertions(+)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 2d20be6ffb7e..53415e83821c 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3449,5 +3449,6 @@ static void __exit amt_fini(void)
>  module_exit(amt_fini);
>
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Driver for Automatic Multicast Tunneling (AMT)");
>  MODULE_AUTHOR("Taehee Yoo <ap420073@gmail.com>");
>  MODULE_ALIAS_RTNL_LINK("amt");
> diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
> index c4b1b0aa438a..768454aa36d6 100644
> --- a/drivers/net/dummy.c
> +++ b/drivers/net/dummy.c
> @@ -202,4 +202,5 @@ static void __exit dummy_cleanup_module(void)
>  module_init(dummy_init_module);
>  module_exit(dummy_cleanup_module);
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Dummy netdevice driver which discards all packets se=
nt to it");
>  MODULE_ALIAS_RTNL_LINK(DRV_NAME);
> diff --git a/drivers/net/eql.c b/drivers/net/eql.c
> index ca3e4700a813..3c2efda916f1 100644
> --- a/drivers/net/eql.c
> +++ b/drivers/net/eql.c
> @@ -607,4 +607,5 @@ static void __exit eql_cleanup_module(void)
>
>  module_init(eql_init_module);
>  module_exit(eql_cleanup_module);
> +MODULE_DESCRIPTION("Equalizer Load-balancer for serial network interface=
s");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
> index 78253ad57b2e..2c1b5def4a0b 100644
> --- a/drivers/net/ifb.c
> +++ b/drivers/net/ifb.c
> @@ -454,5 +454,6 @@ static void __exit ifb_cleanup_module(void)
>  module_init(ifb_init_module);
>  module_exit(ifb_cleanup_module);
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intermediate Functional Block (ifb) netdevice driver=
 for sharing of resources and ingress packet queuing");
>  MODULE_AUTHOR("Jamal Hadi Salim");
>  MODULE_ALIAS_RTNL_LINK("ifb");
> diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
> index bddcc127812e..29a5929d48e5 100644
> --- a/drivers/net/macvtap.c
> +++ b/drivers/net/macvtap.c
> @@ -250,5 +250,6 @@ static void __exit macvtap_exit(void)
>  module_exit(macvtap_exit);
>
>  MODULE_ALIAS_RTNL_LINK("macvtap");
> +MODULE_DESCRIPTION("MAC-VLAN based tap driver");
>  MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
> index 36803d932dff..d591e33268e5 100644
> --- a/drivers/net/sungem_phy.c
> +++ b/drivers/net/sungem_phy.c
> @@ -1194,4 +1194,5 @@ int sungem_phy_probe(struct mii_phy *phy, int mii_i=
d)
>  }
>
>  EXPORT_SYMBOL(sungem_phy_probe);
> +MODULE_DESCRIPTION("PHY drivers for the sungem Ethernet MAC driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5c01cc7b9949..9f0495e8df4d 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1399,6 +1399,7 @@ void tap_destroy_cdev(dev_t major, struct cdev *tap=
_cdev)
>  }
>  EXPORT_SYMBOL_GPL(tap_destroy_cdev);
>
> +MODULE_DESCRIPTION("Common library for drivers implementing the TAP inte=
rface");
>  MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
>  MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
>  MODULE_LICENSE("GPL");
> --
> 2.41.0
>


