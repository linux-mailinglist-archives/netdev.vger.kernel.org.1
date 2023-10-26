Return-Path: <netdev+bounces-44586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AD7D8BD1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B8B282064
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D992F506;
	Thu, 26 Oct 2023 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HPgwuGk4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A49273D1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:46:54 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A901A7
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:46:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b3f6f330d4so870141b6e.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698360412; x=1698965212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbL0TTTZqVqyToBL8BkI/grVyi5nFMYmF/SHdWco+ZY=;
        b=HPgwuGk4vaD7Z4Ev+1i/NVNYZoOvuK50acBw8RzailPNdaA9u2zgiUcI9AwUpe73QJ
         nVwf7bybiGxjLto3p11Lky1exjCDK8JHjVnDolf/yq/HZIYqUt8baQuhsHLZd6q2x6hE
         YOoqkc7TGCpEfOLTAOcO7F3rfC0DwZqntrzU4pXno53lnSSjmbJdztlNC6+gjkzpsz+T
         IER0L0yO4iXQBjnY0f2Sw5vQeOOWW3co3pAOP8szroCIGh0S9qoTbHO3X8SeSoPG0e+2
         qdP6gEKy4K0wwzYDHNLWynFu0sMboXYZOu48dOFXXVUqpGygH1UMyHz90OV2/NBsi1lf
         4vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360412; x=1698965212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbL0TTTZqVqyToBL8BkI/grVyi5nFMYmF/SHdWco+ZY=;
        b=DylG4uFFZxuRQTnMM4PXkyzJzUGtBvs8kkA5R8LGXK8ZlIWXKgq+1ghI773O50qkdy
         1tRtFQtSp0RayxCZO/ySW0b6X2JcTYiVXaGiohHmXMANrpwIqIh3k9AAF+7h/PL3y9Gp
         3/61rLAdnVolkbwgti0rh1xS/36Og1lJLPYaR3wfIizFtJ75TDs9sWqb/rfx5ICMvuqP
         KnHmWaV6C0QenoxYfv5IgpvhHTJZDIKvXqOBDwG/t5MTl9AF4fZdD6XSym5KGQLX4vC1
         qq0MS9kRAhc8NFoM7FT78W+xkAt8vxgr1D5vzzeW1bIpFB7j1YcPJ0U4VI52n4/Jp4/f
         RJBQ==
X-Gm-Message-State: AOJu0YycIKRhbODHr38/iwEbO+UMF7zM/C24tcGVY5OkXhG1Ek4a+U+T
	iV++qeeHDaBzWpt6K/fVXIPt31vBl41M+RNuBhnGqPTHfgxT7Zan
X-Google-Smtp-Source: AGHT+IFEKExXtXtf2ixYLX+K9x1wqgxqIIRShWEYFkQzaWpsuJpUUUvivH1OJM+BQYRh447ikQrYSZazp9VWX1x0lOY=
X-Received: by 2002:a05:6808:7ce:b0:3a7:c2e8:5e7c with SMTP id
 f14-20020a05680807ce00b003a7c2e85e7cmr731857oij.43.1698360412031; Thu, 26 Oct
 2023 15:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026190101.1413939-1-kuba@kernel.org> <20231026190101.1413939-5-kuba@kernel.org>
In-Reply-To: <20231026190101.1413939-5-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 26 Oct 2023 18:46:41 -0400
Message-ID: <CAM0EoMnGTeMg4xgQh2JfKYtrV=WbdkBNoeNLp72txjcR5qRB6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, arnd@arndb.de, ap420073@gmail.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
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


Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
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

