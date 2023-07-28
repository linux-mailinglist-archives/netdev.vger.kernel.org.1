Return-Path: <netdev+bounces-22121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A156D766191
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5D282830
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996217F9;
	Fri, 28 Jul 2023 02:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1A17D2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:00:49 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B4173F
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:00:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2767702e87.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690509646; x=1691114446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msn98uSrmp3cbj/UxZcQv417B0dm9hgVkWLxRLCqOCQ=;
        b=BvIcPDaQ3ylQNdxQD1U56Hg2yNKmULsOKTaZ3U6AoWBLBiYlr45miZGrm78z9pM+fY
         Bj9wXo7Puosr6BGQSTY/7v8RhPPZoGfMJ1y0Bc+YecZ8VZzo3ETW6YKlPtVIsUDY+U0w
         Fj9fzjslJEBpa7rPK+MzcTpnnvKLg6QFGL0MbUb3uDxpO4LbREqfKTKQKqm/UsTu+xUa
         hPD4DxuVXQ4reKx0dBaxI3obTLKkKQDyDkX1ylLOw07f6ya0S0sWrw/7QRmco+676Fh0
         hD53xEcgm+pRu4IiIgyy/c1CMEJQfKcEBTaGDIp0MP2I4X9kozn8Sou+YNs6XSmIfRAg
         m4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690509646; x=1691114446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msn98uSrmp3cbj/UxZcQv417B0dm9hgVkWLxRLCqOCQ=;
        b=RqBa2691YZY8k2lqvmKsZ9uk3awdQ/SgDJxqbpBtOhIEdoJKgcvx1V4UW0fChEIFIY
         IeiS+MWcUFs2yaTqHVYaX/JwHRdSym1qUPK3wiBbVG5fKJlJCY9/3FaceeXOuqK0mUqr
         04sEEDzpFaaeNBEWphBT4RqB6F7K9iqVXpGt7nrVJ/PSwAR0wDu5kP93KImh1z2ifvB7
         b2Y5g3FnVKpg5CyR6WLmYacZDucnKv1pwUu1sunZNniF/7b2pOLEK0vvMblZUX3C0eJF
         qBVOkZo/BX03qs0K2MdKVHBZe19Uglcf3JntjHAqTzs5rhTtX6ZmV4CjeBqQcyhTCW9T
         huUQ==
X-Gm-Message-State: ABy/qLbx04crvl6ba+aKOHyhVnBEruq7Bk0bQuMZvXkgGVu4F3O6H15k
	9VoXL/N1jnjKZIIm4SlOnu1y7oTY10Sqrs+tikw=
X-Google-Smtp-Source: APBJJlGfZAxG1J/1uxcdjl7oEhK0DiCdnf7IwT3YZFXU8CAr/+XLxn4pJSUAatCqRLpMUGFqX2cCgotDd7v1uvFYLkI=
X-Received: by 2002:a05:6512:ad6:b0:4f8:5b23:5287 with SMTP id
 n22-20020a0565120ad600b004f85b235287mr676034lfu.62.1690509646152; Thu, 27 Jul
 2023 19:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
 <9add374b-27ba-47c9-95cf-eec896231d58@lunn.ch>
In-Reply-To: <9add374b-27ba-47c9-95cf-eec896231d58@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 10:00:34 +0800
Message-ID: <CACWXhKnmEgt9FFKrtcMZN75bNDuEqNoOqNtHWUP-W2s0U2JkQA@mail.gmail.com>
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

On Thu, Jul 27, 2023 at 6:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int loongson_dwmac_probe(struct pci_dev *pdev,
> > +                             const struct pci_device_id *id)
> >  {
> > +     int ret, i, bus_id, phy_mode;
> >       struct plat_stmmacenet_data *plat;
> > +     struct stmmac_pci_info *info;
> >       struct stmmac_resources res;
> >       struct device_node *np;
> > -     int ret, i, phy_mode;
> > -
> > -     np =3D dev_of_node(&pdev->dev);
> > -
> > -     if (!np) {
> > -             pr_info("dwmac_loongson_pci: No OF node\n");
> > -             return -ENODEV;
> > -     }
> > -
> > -     if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
> > -             pr_info("dwmac_loongson_pci: Incompatible OF node\n");
> > -             return -ENODEV;
> > -     }
>
> There are a lot of changes here, and it is not easy to review.  I
> would suggest you first do a refactoring patch, moving all handling of
> DT into a helper. Since it is just moving code around, it should be
> easy to review. Then you can add support for platforms which don't
> support DT.
>

Hi, Andrew,

OK.

Thanks,
Feiyang

>         Andrew

