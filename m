Return-Path: <netdev+bounces-24622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D898C770E0E
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936462826F4
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C251FC5;
	Sat,  5 Aug 2023 06:16:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1331FBE
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:16:07 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76DC4ED0
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 23:16:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so4721558e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691216164; x=1691820964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh6SRGbJORTbe+GAilPaW6UAhKkkXC3v6kD9gFIi0D8=;
        b=O2ppzbiRiIufLekbkyXFJVNImwWXCXfDZZ7A/asBFIyTqOkzUuJN3RLT7Zk8GiGdib
         0jtCxMgMUlBOxr2FRKBPdjhWgTZ12RiM6dNOWT8yy15OSL9ym6cru3jSC75Vuur/2Dbm
         yIZCadSD9CPDDZTjhJdSRmfhH8Xbj+Uq4xAeq7lTSIxn1GO43JirwVVCK30c/MYiKNCZ
         bYtoDsKi3GTmGyEWkVuEv3HHAeLRlhaKh4SmIifvgijYeOipCFsH+RM65r6NRSAagnD2
         /1feQ2YOkhS0YSoOdAAozId94yKfnwSMkGcpegDja2edIEncjg2cW+l6lAUyKmEn2eYp
         uaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691216164; x=1691820964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh6SRGbJORTbe+GAilPaW6UAhKkkXC3v6kD9gFIi0D8=;
        b=cQvX2pp4mPWTqSJoviOHbwzbBV6cApMSb/Su/ENLD7BbPxlOiBkV9ituchAJSBcAAB
         CeK4yIxnEdjuCpwN/9wb0oFFZNTi4a5MAG81YYgk2cuz9V/7wxQ+1t5gKg1AhQWqtrKS
         z7WVVxcHsF5K+VJ3U3OWVtFiBI1MFVCJ8tt6Tgax9u/zsISdqIcbeJsk3zXxCiyvR+zp
         7uQxctGkA4wP+ZJ2DoWbIOAndxDxxaj+cD6ap8+LfCOcl1nlWFnwtpWf90kMELNFVjyw
         Yn89Xv1FtGjgH5RgQ68CkOZwW68j7wvpwd9NMhtDI2c1F7kIA9KGr2po439bdhXmODnf
         vKpw==
X-Gm-Message-State: AOJu0Yy9MtXirLfDcNBptyb2y/laHKvOO8t/2WBfNTrkSygAp9MKOpke
	na8DzbiCrFXjQVxa7h+yDhEuvHLB4oaspZj1sWg=
X-Google-Smtp-Source: AGHT+IEUBdCZnd/K1wZelx2W44FaqV4Fg0ZaSZR5Q9IiNBU6y8iF7wu6rjZT4H6nayPnFiY3lte7UyGdnssLv8qt3H4=
X-Received: by 2002:a05:6512:12c8:b0:4f9:556b:93c2 with SMTP id
 p8-20020a05651212c800b004f9556b93c2mr3247385lfg.1.1691216163857; Fri, 04 Aug
 2023 23:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1691047285.git.chenfeiyang@loongson.cn> <021e4047c3b0f2c462e1aa891e25ae710705ed29.1691047285.git.chenfeiyang@loongson.cn>
 <ZM1hwjttrnM8jFXJ@shell.armlinux.org.uk>
In-Reply-To: <ZM1hwjttrnM8jFXJ@shell.armlinux.org.uk>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Sat, 5 Aug 2023 14:15:51 +0800
Message-ID: <CACWXhKnK+iJgmXacvOjBcxn_283n4_e-7jfnZEJD1HKaJxrPvw@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	chenhuacai@loongson.cn, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 4:38=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 03, 2023 at 07:30:35PM +0800, Feiyang Chen wrote:
> > +
> > +             if (priv->plat->disable_flow_control) {
> > +                     phy_support_sym_pause(dev->phydev);
> > +                     phy_set_sym_pause(dev->phydev, false, false, true=
);
> > +             }
>
> Given that stmmac uses phylink, control over the PHY is given over to
> phylink to manage on the driver's behalf. Therefore, the above is not
> very useful.
>
> The correct way to deal with this is via
>         priv->phylink_config.mac_capabilities
>
> in stmmac_phy_setup().

Hi, Russell,

OK.

Thanks,
Feiyang

>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

