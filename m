Return-Path: <netdev+bounces-22769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A667691F2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C21C20B27
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761217752;
	Mon, 31 Jul 2023 09:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E81774E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:42:50 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDDEB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:42:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so62959801fa.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796567; x=1691401367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHiBudAh1G+w+7yBNDUS9EIw0wxBnRGoQ+xkrF+Mw5k=;
        b=lNMc+/VrwdL4JbVu/ope6EaOPz5UlzCo3U/LBv3l1GJ9IX/uuxWZaub+Grxx2FBQ9L
         1A/NH4G3w1lF6hUha1Mee9OSAp9vfTNK35Zl++mEn1O+tbSmY8Z6ExWBEY5PG1y8dyO8
         /XG36Uk79MULOBuwso5DQ1unyZ5boz5Ph6M5lhLwdI4xeCpZ8V0OaksBw97j6BapGnng
         MU/egB2PXDCYZhaxXndi14m7/ot1G/KcKjneB1QggftO5oEsYdQmCnyIk3YM6RG02Jau
         3ijgfKqUHEU00lgIc2PhUjxe2t4E4ezmnQgyOPqr/TEKdFIBw5qBhZ3O/FSUT2I/+0em
         2tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796567; x=1691401367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHiBudAh1G+w+7yBNDUS9EIw0wxBnRGoQ+xkrF+Mw5k=;
        b=Jzc/25ElUm7ab8it8ZppZpGqQRB8GXsEOxBDR2yB1espZEBDMDGMG9s2zQ0mHLab5d
         EDH37sAfyqAtmQABBDdqz0ryK4/qFgl6+EyctHhPf8M8U5y3dFUQPqop2TU9KvmIM6JH
         t8Xq2tf/e6MlgjTpRIpxLi5Nv4/WJve04KWHEYyu72+2kmjmcXV6SNvSxQXs87Z8qIYm
         h6b+MvVaxCtTVN1OLGEDmTrkZvqMGaNgSvcTDS9nakEF6PKWGsELH6G7Mboj08PUZdTP
         3x4AapjN4N1QcZt2JFnGACzi2JZrg01mHHy1CbOVz9iCPrWgykiGCawbFuhBQVSi51Zp
         YCPQ==
X-Gm-Message-State: ABy/qLZ8d8B0PCzY0I3UjPBwtRYtySEpdWsDy0qnmjOFN+QQQwBbrLyK
	cVB1idmjRIUYX3NGDrCgAEIahxVY0GbSmOTJD6GD0d8yKIEu0L4P
X-Google-Smtp-Source: APBJJlHfa2y1+a6KbXHOIJYUerUo7LR5NDOdKUdfzPLfURUCzMJXgDX4hX6XmSXCpNJZlbyTQc3dWMfFDNOJ5VeEv/Y=
X-Received: by 2002:a2e:84c6:0:b0:2b9:ac48:d804 with SMTP id
 q6-20020a2e84c6000000b002b9ac48d804mr6428546ljh.38.1690796567032; Mon, 31 Jul
 2023 02:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
 <1bbba61c-19b7-48bb-8c93-0741b43abda5@lunn.ch> <CACWXhK=rVTf=BYo2G2CDDo6AFOwqJJM_v+H6G=0YNohqh8OycA@mail.gmail.com>
 <a353bda9-2931-4c26-a853-21b6b340e1c3@lunn.ch>
In-Reply-To: <a353bda9-2931-4c26-a853-21b6b340e1c3@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 31 Jul 2023 17:42:35 +0800
Message-ID: <CACWXhKm11Dq-=HNihhp3WWb6sE=xh=bqBGiMJsGKxte65wQDsg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] net: stmmac: dwmac-loongson: Add LS7A support
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

On Fri, Jul 28, 2023 at 4:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 28, 2023 at 09:59:53AM +0800, Feiyang Chen wrote:
> > On Thu, Jul 27, 2023 at 5:18=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > +static void common_default_data(struct pci_dev *pdev,
> > > > +                             struct plat_stmmacenet_data *plat)
> > > >  {
> > > > +     plat->bus_id =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID=
(pdev->bus->number, pdev->devfn);
> > > > +
> > > >       plat->clk_csr =3D 2;      /* clk_csr_i =3D 20-35MHz & MDC =3D=
 clk_csr_i/16 */
> > > >       plat->has_gmac =3D 1;
> > > >       plat->force_sf_dma_mode =3D 1;
> > > >
> > > >       /* Set default value for multicast hash bins */
> > > > -     plat->multicast_filter_bins =3D HASH_TABLE_SIZE;
> > > > +     plat->multicast_filter_bins =3D 256;
> > >
> > > HASH_TABLE_SIZE is 64. You appear to be changing it to 256 for
> > > everybody, not just your platform. I would expect something like
> > > common_default_data() is called first, and then you change values in =
a
> > > loongson specific function.
> > >
> >
> > Hi, Andrew,
> >
> > The common_default_data() here is defined in our platform driver. We
> > have tested on our platforms (LS7A and LS2K) and it can be safely
> > changed to 256.
>
> Then add a new #define.
>

Hi, Andrew,

Should I add the new  #define in our platform driver or in common.h?

Thanks,
Feiyang

>      Andrew

