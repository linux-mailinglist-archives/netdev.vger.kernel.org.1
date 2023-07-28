Return-Path: <netdev+bounces-22115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589FC76617A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890111C21765
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422AC15D1;
	Fri, 28 Jul 2023 01:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501915CC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:47:54 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07104F2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:47:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so2777489e87.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508871; x=1691113671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFfPfZwjc+uNvV8mG9hFOuvKMgIeKkyutm2C1XzBtLY=;
        b=HhuHcn6qYkMczeFbXyfGSN2yiGRIl02nrEuDfHYX0NIq2cz/I+mnzLPyBd3AvBjueJ
         Mgkf+LPvXQzPC8+7ohkctiq8AkHzeuXKDaIUIHJUzEdBkz55OauhHD2kgDIsfdEyvV1A
         uWHz4S6Yl2noHFvpYVlN76lWWRR869xgIHLZk6pbiZZoeoQyS1og7eI8M7Ghv9CCMAn/
         Jfl8pwe2d/ARmD5AZcryaL3nPKpbBiSt37Cvnu1PqpI6fWohHNmVdG51/tcF4YqPuRH8
         4BlbqZ7QBCfI+30ekZus/wKxGW9VMj4qeAVjTXm3obvvrdnNYd8lMPZdpdSSRRx4KBii
         zznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508871; x=1691113671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFfPfZwjc+uNvV8mG9hFOuvKMgIeKkyutm2C1XzBtLY=;
        b=AnJW+CDolz2+rIBgX+xzLdzgLUeRTmpeTCNVWCDr1PFKBjAlmFxNk/BZOrqIcxkKmt
         Fz0bkL0mkxlgtL7KyqP9r2BIJfGK/AXj8TNbYXh3aa31iW1pDD+z8bsyvyI8MWf76nuR
         Ty9ifOzqpwnnLFtnnm+3Jw4fdswMxb4J4ld3H+p0a+fTjBllI7Vxt6l8x1nNri4xV7hO
         pXMmy5ojPiV7Q3sbq9RFD0+4/0tqgwCKagFUWm3c/xgCFzpWbbyjfccKvsCzqEnmsX6Y
         LOOilZXCZ+hWXMOK6gGXmCbCPGU/wzdOI3+fPP08U7qT9/tftu8bFFQTte6hzNYv7EJe
         xUnA==
X-Gm-Message-State: ABy/qLYt4ZRxT/bSQfKYWzmXDInRki2mWCt+1+tejIcvw/iB3HiK54LA
	v5ImzU3QAUR1eUn3lN9k091FtVQLG6YEXh4aIPk=
X-Google-Smtp-Source: APBJJlHZLbfjtYt0jmpSXISpjxl6oHIS7lr8GkyxK+CeCjm4AxDxmWLTcX0GdHKCKmuz+ioA7/gdeojbKQADmnSz/2I=
X-Received: by 2002:a05:6512:444:b0:4fb:61ea:95dc with SMTP id
 y4-20020a056512044400b004fb61ea95dcmr582572lfk.7.1690508871000; Thu, 27 Jul
 2023 18:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <20aa37fdfd4b03b9614befe1c8f78ffc0ac5dead.1690439335.git.chenfeiyang@loongson.cn>
 <4a59ba65-a4f2-4cd1-8bfe-2ae3e4d0a778@lunn.ch>
In-Reply-To: <4a59ba65-a4f2-4cd1-8bfe-2ae3e4d0a778@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:47:38 +0800
Message-ID: <CACWXhK=-52i75jR6t6avFrEH+SFGKG4k6zXE5_59_av7nAQN0w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] net: stmmac: dwmac-loongson: Add GNET support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 6:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static void loongson_gnet_fix_speed(void *priv, unsigned int speed)
> > +{
> > +     struct net_device *ndev =3D (struct net_device *)(*(unsigned long=
 *)priv);
>
> priv is a void *, so you don't need any casts.
>

Hi, Andrew,

OK.

Thanks,
Feiyang

>      Andrew

