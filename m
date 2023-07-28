Return-Path: <netdev+bounces-22120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6676618F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C08282773
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C217F3;
	Fri, 28 Jul 2023 02:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72717D0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:00:08 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29C173F
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:00:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe05fbe250so2793924e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690509605; x=1691114405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQRjDvqI2wB+9kV9HDAkrT4+B9QHQmFxny+flLnsotM=;
        b=sTd8an1jg+ArsGizoBbMuupDBtPeHRJzexdcZLypJrDrU2IXDXr8gUl91CViZ++lIw
         VTtRpj2K1F3YC9qlxxxkgoK1Xi4tO+1N9ClyMomgT8el8fElcJYawmv7Oqua5NCEfddn
         SkhCLXYOHmDoCE4l7RNs9Eb9puAWhucz3mXLHBxSfBJPq+j39BGAnL6gxB46b/1BGfmC
         qNa1JhhK8olBB6NHHd1bV1PBJTHwwXhF9fgk5UkIpOc8b4/FdELvi7QMLfMFUogzZPvA
         QtA6AwYQOohdKA7fl19PesiDe0ZTBnfCBAvGYK4NQMHneHOsXpvnwYiJanZ6F3HKbmI6
         Uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690509605; x=1691114405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQRjDvqI2wB+9kV9HDAkrT4+B9QHQmFxny+flLnsotM=;
        b=ZrTUM4ixWrcl9FtnSUpe9Gs9Zg0nBp9OpyGFmMYiM+lbqdl2Bu4yOT4MGIGT4bB4WO
         bWvscEbW9+R3le/BsmIEjxUBur+AwwtdzPePDkH8ffqaWXChdeD57OJD/J8xv+yDsLTc
         Qw5zhyV00HYranq3Kg1DhYUyB2GNswlcUAudoTWZeQTH1c/Ah7jtwVg4gim2GLvR+/H2
         bmeuNjwJr64SkwOiU+ZFfAD7y25bHR9vSBMx7VBdsduEXGIe4Tlj7oHCtQ8yvoLvAb9X
         EkDTMEzTE5iz17YQIMzze1+xghPm9JHJza/xL1tThsaKGDDIBtQYHtGTmc9xlh6ABc7i
         QsDA==
X-Gm-Message-State: ABy/qLbxyvUDvTu2smNTtDZw2l1dk1Z9NyjMRLSIL9dINCdH4G13HRGX
	rSI5F2Dt+UmMutQ4bMfygM95c1TQSmMSwhlXrkw=
X-Google-Smtp-Source: APBJJlFDrZ3zDcRnitvNO9k2G8Jf4yZ3wP9u3pkv+LgOzBuOLQtxjUD/EfN+EFCQd86sAT6E5pzf9LndL0lJ96csXPI=
X-Received: by 2002:a19:641e:0:b0:4fe:85c:aeba with SMTP id
 y30-20020a19641e000000b004fe085caebamr521667lfb.21.1690509605492; Thu, 27 Jul
 2023 19:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <dd88ed0f53e9ee0f653ddeb78b326f8eb44bdbd1.1690439335.git.chenfeiyang@loongson.cn>
 <1bbba61c-19b7-48bb-8c93-0741b43abda5@lunn.ch>
In-Reply-To: <1bbba61c-19b7-48bb-8c93-0741b43abda5@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:59:53 +0800
Message-ID: <CACWXhK=rVTf=BYo2G2CDDo6AFOwqJJM_v+H6G=0YNohqh8OycA@mail.gmail.com>
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

On Thu, Jul 27, 2023 at 5:18=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static void common_default_data(struct pci_dev *pdev,
> > +                             struct plat_stmmacenet_data *plat)
> >  {
> > +     plat->bus_id =3D (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pde=
v->bus->number, pdev->devfn);
> > +
> >       plat->clk_csr =3D 2;      /* clk_csr_i =3D 20-35MHz & MDC =3D clk=
_csr_i/16 */
> >       plat->has_gmac =3D 1;
> >       plat->force_sf_dma_mode =3D 1;
> >
> >       /* Set default value for multicast hash bins */
> > -     plat->multicast_filter_bins =3D HASH_TABLE_SIZE;
> > +     plat->multicast_filter_bins =3D 256;
>
> HASH_TABLE_SIZE is 64. You appear to be changing it to 256 for
> everybody, not just your platform. I would expect something like
> common_default_data() is called first, and then you change values in a
> loongson specific function.
>

Hi, Andrew,

The common_default_data() here is defined in our platform driver. We
have tested on our platforms (LS7A and LS2K) and it can be safely
changed to 256.

Thanks,
Feiyang

>          Andrew

