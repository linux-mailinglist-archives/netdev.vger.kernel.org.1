Return-Path: <netdev+bounces-17749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA0752F81
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3616281CBB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77D8A29;
	Fri, 14 Jul 2023 02:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F77EB
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:42:00 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A4272E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:41:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso2449723e87.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689302517; x=1691894517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OmPgs82qehEhicyd4Es3lxW3uviOWIkt4ph6eCLkRY=;
        b=fxxRI1BFMCGQM3EwByzI7GvrScnXDZox4fH7nbts4w7X9vPkUM6Ni2RnsQIgygJokv
         mc1OM/s/qNigpj9SrAZzGY0ZcV9P4G7QLtcoOkG1irq6ZKx0OV2Sx92eqojxpfS806e7
         ub89Tn27LJugQ4glEEfMD2qes8SPV31M5wxpEGPFjAScpYlgIFeA5eiyFuttqLyi1JuQ
         NO8PI/Qg4C+4bmmskIO0N5CLTAd06MHqiNMXgJYcRFzNZloxyAUncjZWFXDvB3Sim9A1
         7AJDM2EaAuL9x8ohT20e/ROuNjKFZ054YW1lfLsxY8zMNr88+WrEG0Kv4FiYQGH+MTGJ
         hXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689302517; x=1691894517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OmPgs82qehEhicyd4Es3lxW3uviOWIkt4ph6eCLkRY=;
        b=R/oSthMa1knTX7lBG7MltWeozi5hvxt8ed4WaDi312Nh0jKISGvxo5djSo9V8iT7kz
         etHCxCcY44Tvinua9Y4+r2DJWaksTm//SVOy13bHR1jKHvcA+KCWw65y5O8o9PluLkPk
         O7hHHceVDH2LaYaiE5pdSupdlFKEy51bZ9QqwU3oOSa7d7XWcaX5+I4Lwcoca6rq2+1W
         kH42PkN2EfYjPbvLtWGs/jjDwQ9e9JZgUzQA4guB5BhYRV691ZFH55A7kXNR9QKS27HM
         6uvMpru5EHy9P7yzA0Pkn4hU1jc8qdfHTyo1EiBPVLF0KlafaISqsT4uDAXdpAplxvFg
         DvXg==
X-Gm-Message-State: ABy/qLYB0G+aqmsYwi1ggEMJrNeTloncbdf++8oO0a8S/OK83IgZn5D1
	eJqtGziwNw7A/9tzBR+mhERBw+/wpwdb048IF8w=
X-Google-Smtp-Source: APBJJlEFmqmz9tnK7MKDDZLEfck5buNk7gYCbKlD1BY1i3MogukPQOOA58aAJq69v+b1iCN2ltOAHYSAjoYRTiUABgo=
X-Received: by 2002:a05:6512:36d2:b0:4f8:e4e9:499e with SMTP id
 e18-20020a05651236d200b004f8e4e9499emr2194877lfs.12.1689302516984; Thu, 13
 Jul 2023 19:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
 <ZK+thg7xIKt7b8X+@shell.armlinux.org.uk>
In-Reply-To: <ZK+thg7xIKt7b8X+@shell.armlinux.org.uk>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:41:45 +0800
Message-ID: <CACWXhKn1V-jMjsmV2kHEvG-Kn_vp4v22145MZdy-zdKaywPrmw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 3:53=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 13, 2023 at 10:46:53AM +0800, Feiyang Chen wrote:
> > +#define PHY_ID_LS7A2000              0x00061ce0
> > +#define GNET_REV_LS7A2000    0x00
> > +
> > +static int ls7a2000_config_aneg(struct phy_device *phydev)
> > +{
> > +     if (phydev->speed =3D=3D SPEED_1000)
> > +             phydev->autoneg =3D AUTONEG_ENABLE;
> > +
> > +     if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > +         phydev->advertising) ||
> > +         linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +         phydev->advertising) ||
> > +         linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > +         phydev->advertising))
> > +         return genphy_config_aneg(phydev);
>
> While it's fine to use four spaces within the if () expression, this
> "return" should be indented with a tab.
>

Hi, Russell,

Sorry for the typo. I will correct it in the next version.

> > +
> > +     netdev_info(phydev->attached_dev, "Parameter Setting Error\n");
>
> Does this give the opportunity for userspace to spam the kernel log?
> E.g. by a daemon repeatedly trying to set link parameters? Should it
> be rate limited?
>
> > +     return -1;
>
> Sigh, not this laziness disease yet again. -1 is -EPERM. Return a
> real errno code.
>

OK.

> > +int ls7a2000_match_phy_device(struct phy_device *phydev)
> > +{
> > +     struct net_device *ndev;
> > +     struct pci_dev *pdev;
> > +
> > +     if ((phydev->phy_id & 0xfffffff0) !=3D PHY_ID_LS7A2000)
> > +             return 0;
>
>         if (!phy_id_compare(phydev->phy_id, PHY_ID_LS7A2000, 0xfffffff0))
>                 return 0;
>

OK.

> > +
> > +     ndev =3D phydev->mdio.bus->priv;
>
> This doesn't look safe to me - you're assuming that if the PHY ID
> above matches, that the MDIO bus' private data is something you know
> which is far from guaranteed.
>
> The mdio bus has a parent device - that would be a safer route to
> check what the parent device is, provided the mdio bus is created so
> that it's a child of the parent PCI device.
>

OK. I=E2=80=99ll get right on that.

Thanks,
Feiyang



> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

