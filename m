Return-Path: <netdev+bounces-17746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCE752F54
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625E0281F7B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D350A4D;
	Fri, 14 Jul 2023 02:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C41809
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:24:53 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D4270B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:24:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso21367201fa.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689301489; x=1691893489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9/7mfBIOMb+0hsVybGzj7u7Q1iyZTD8c3lirpC/46Y=;
        b=U4ODQg+ob9z9R6ODl9EA8LoTWZcugc30CyNuggR1KwgPeyo/UkuYiejlm5rWtfRdJR
         t4c9g6DPxyaqkhVBxjy0y+Zr6VvnrTvQEMH4iuELrAh1rY0UwWKjY0RPFUA5DVS2HM38
         jht4I5BYurb/wp9dbAR7N9/j0fe5uB6XD3MMo1mhZbu1bWD6fNjRd4k0ojSjwUESU5zv
         zzswnWL3VKDmRRtSFnINzv4cyBv6Ryy7WJ0AizhyJuzAtHLLw5ey4YS+3TFia5T2Cbay
         pkfHV7OEw8ZlvR+gPjCSPj1Q4FJXJCGyHc5t5YJCuXV+PIBF0QB+8DvhusMz1UjMhRkl
         ZeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301489; x=1691893489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9/7mfBIOMb+0hsVybGzj7u7Q1iyZTD8c3lirpC/46Y=;
        b=Q+rPO7HULSeQ89xMJsSdkDDBV0nnPcTRC/9jnGrFk+I9yT2vmlwHn5GChWMYnhosIu
         TAfHWF6w3xKFxUTO+ZuSMOLQ00SV8L1YD2ktw49gBan9h8BDGicWkwdAbypHLFsaEatM
         kUTSyLWVNlEGPbJba3empqm+fb9nqon2Z4YsQmDHJBPjg8hvo/YVRsmBPaAEIXj0oOes
         A3HonzBhIZ/236OTW4vsYVmUB6Eg2UYEP4oDSQS3ap8cJNBxPg4KvenKBHjOEvH1Ka+3
         wQ8CSewLtGXxeQr0nvB9mMQNTTb0U8v3ETYnU/nSzOqoKGzgYW6ypV90t8W9llBR8AN3
         rTUg==
X-Gm-Message-State: ABy/qLZ0fZ7W58lMOQRGVENQBvDhs93ASC75NMnIjb5StUtzBDcXyT4A
	WvhdeeFMpNy5iTeY95wldFp4fjaBN3AH3pec4co=
X-Google-Smtp-Source: APBJJlH3CrRs4nvBhPDbsLVdh5lnDzW0lZ0uvsiYM0vGsb5/s+afJZBSYr5uQrKos+aMl17VAoQMFiViwJhYoDEa0fc=
X-Received: by 2002:a2e:8693:0:b0:2b6:dac0:affe with SMTP id
 l19-20020a2e8693000000b002b6dac0affemr3244830lji.31.1689301488784; Thu, 13
 Jul 2023 19:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <e491227b-81a1-4363-b810-501511939f1b@lunn.ch>
In-Reply-To: <e491227b-81a1-4363-b810-501511939f1b@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:24:37 +0800
Message-ID: <CACWXhKmLRK5aGNwDyt5uc0TK8ZXZKuDQuSXW6jku+Ofh73GUvw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 12:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> > Add GNET support. Use the fix_mac_speed() callback to workaround
> > issues with the Loongson PHY.
>
> What are the issues?
>

Hi, Andrew,

There is an issue with the synchronization between the network card
and the PHY. In the case of gigabit operation, if the PHY's speed
changes, the network card's speed remains unaffected. Hence, it is
necessary to initiate a re-negotiation process with the PHY to align
the link speeds properly.

> > +static void loongson_gnet_fix_speed(void *priv, unsigned int speed)
> > +{
> > +     struct net_device *ndev =3D (struct net_device *)(*(unsigned long=
 *)priv);
> > +     struct stmmac_priv *ptr =3D netdev_priv(ndev);
> > +
> > +     if (speed =3D=3D SPEED_1000)
> > +             if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS *=
/)
> > +                     phy_restart_aneg(ndev->phydev);
>
> This needs a comment at least, but if you explain what is actually
> FUBAR in this PHY, we might be able to tell you a better way to work
> around its problems.
>
> > +static int loongson_gnet_data(struct pci_dev *pdev,
> > +                           struct plat_stmmacenet_data *plat)
> > +{
> > +     common_default_data(pdev, plat);
> > +
> > +     plat->mdio_bus_data->phy_mask =3D 0xfffffffb;
> > +
> > +     plat->phy_addr =3D 2;
> > +     plat->phy_interface =3D PHY_INTERFACE_MODE_GMII;
>
> You would normally get this from DT. Is the PHY integrated? Is it
> really using GMII, or would PHY_INTERFACE_MODE_INTERNAL be better?
>

Yes, the PHY is integrated. I'll try to use PHY_INTERFACE_MODE_INTERNAL
later.

Thanks,
Feiyang

>        Andrew

