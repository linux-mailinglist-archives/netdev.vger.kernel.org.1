Return-Path: <netdev+bounces-18218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F17755D94
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F1A1C20AA7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167B9467;
	Mon, 17 Jul 2023 07:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E9466
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:54:33 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC8CC7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:54:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b8413671b9so31856481fa.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580469; x=1692172469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZSBd91l9FNsoBWVb9MzxA3Uq4ofSW5cSlRh40pUiQk=;
        b=IW94wvQ5HIaX+HQfYIRd395f9Jz97urs+aA4EiV0ktMZLxdkEDlD+PldNzTG9JNiny
         RtHygeaWia6NLjdICYkJBjYMzDlHR4ar+HWFJgCFqq/obGuWJr8Lj5XKzDLJ7xB8/FCS
         1a2vhEQD9LrxbxMYeEI0NvZfEk2dY+OaKqyl8FX6cvCkhAX47GKbSS6iqO7XYwWz1sz5
         2D48miHERFsp2djM7UA/bUsYNM9x+PWQQ0rzcx9+aQOHfjn5Aikj18xYpD08Xc2y42Wb
         NH4N5W3lyb/9NpD4yvy79ta6uPJwQBV7VAWu56Z2raWd1YQ/fP/b83oiSDDHGt+YDGgu
         R8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580469; x=1692172469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZSBd91l9FNsoBWVb9MzxA3Uq4ofSW5cSlRh40pUiQk=;
        b=JFHJcbLMPrifN/T200lq+NiCoLS9yjM0zdmVjwaedrDTtgRy/xDI9WMUTu2MptuOrw
         RwMYcYbE1RTygPWJ/khZEd/XngH5fR4o+YbFmCnM4TdngQIGS1oWQjV62PIMwLATtVv6
         pHHsv6vsvF6w6xpaPiycc0Xx3/KuyeCjeibEbEg52MGGDgjGzhv/0EHMVz7N2LoPdI5Q
         7KcKv3LKVDgUXm2E4gqjcx25+PenVzlv/SpQMcyzynkLn4jELydbHDpU93kYXGDWpC6p
         mHIXlJeA01aZvsQtsNIM11XHLWwly/X/BteBHAM4SwwPIyrSNkaNxT0ohPdvs2YSoOqH
         a3yQ==
X-Gm-Message-State: ABy/qLYm6FMDXsW+EcJy22H1t2p8u2b0jXndwHVRk0FcZIcTfeBKHRjZ
	xr+20L5bjmOwDJw4I4NdP0B9p2iM2DwSX4asSuKR6e7UpV5SJQ==
X-Google-Smtp-Source: APBJJlHkWSMUXS4UBL74h9kbGuWgo5PkhE7BDL9rPNe9ixI+NMu6TeZ/CeSZFhe8qMy1rMCCluWE2GbEY685B/4KUAo=
X-Received: by 2002:a05:651c:3c1:b0:2b6:ef8a:d98d with SMTP id
 f1-20020a05651c03c100b002b6ef8ad98dmr3171003ljp.20.1689580468883; Mon, 17 Jul
 2023 00:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <e491227b-81a1-4363-b810-501511939f1b@lunn.ch> <CACWXhKmLRK5aGNwDyt5uc0TK8ZXZKuDQuSXW6jku+Ofh73GUvw@mail.gmail.com>
 <ZLELE5ysytsynpjr@shell.armlinux.org.uk>
In-Reply-To: <ZLELE5ysytsynpjr@shell.armlinux.org.uk>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 17 Jul 2023 15:54:17 +0800
Message-ID: <CACWXhKn6Tv+Fk9Nxc-kQKkF847+ZAO1uVxSYkMoaiCaeGYCXzg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn, 
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 4:45=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jul 14, 2023 at 10:24:37AM +0800, Feiyang Chen wrote:
> > On Thu, Jul 13, 2023 at 12:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> > > > Add GNET support. Use the fix_mac_speed() callback to workaround
> > > > issues with the Loongson PHY.
> > >
> > > What are the issues?
> > >
> >
> > Hi, Andrew,
> >
> > There is an issue with the synchronization between the network card
> > and the PHY. In the case of gigabit operation, if the PHY's speed
> > changes, the network card's speed remains unaffected. Hence, it is
> > necessary to initiate a re-negotiation process with the PHY to align
> > the link speeds properly.
>
> Please could you explain a bit more what happens when "the PHY's speed
> changes". Are you suggesting that:
>
> You have a connection where the media side has negotiated 1G speed.
> The gigabit partner is disconnected, so the link goes down, and is then
> replaced by a partner only capable of 100M. The link comes back up at
> 100M, but the network card continues trying to operate at 1G?
>

Hi, Russell, Andrew,

This bug shows up in the following way: when the speed is set to 1000M,
PHY is set up correctly and its status is normal. However, the controller
and PHY don't work well together, causing the controller to fail in
establishing a gigabit connection, which leads to a network disruption.
So, we need to use this bit to check if the controller's status is correct
and reset PHY if necessary.

if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)

The troublesome issue is that we have to check this bit in stmmac.
As a result, we are forced to place phy_restart_aneg() there.

Thanks,
Feiyang

> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

