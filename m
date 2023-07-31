Return-Path: <netdev+bounces-22768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC337691EE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EACF1C20965
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C001774A;
	Mon, 31 Jul 2023 09:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF2171A6
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:40:00 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788CE5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:39:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso361581e87.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796398; x=1691401198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERFDOKkkrmVzc/iH5Nu4Hb+mXBiAhhvaFu2p7HjWgC0=;
        b=CeC+nM5B9xACasW8Q1RlNGMfSHq4MdON67L27cse0wHK70DQzXqrjYVprXyhvfLrww
         9xWxFFnL/7fItKCHeG+fOzjyhViMm/gwQV+Q9iRSic/vxTEiMdaSjCF0dgb/GCqfzR3B
         8unnsh8WwBUs1EUmKglOYMTzd3TrwNuOAua7d/tg+NRW7Hh7eZC+O0DoRuF+hRqK1tPG
         ESVma6h9DPxoeKYIvGsZy4bRY/zudZcLOoHeFFWyDBocVJ01D2b+zSWn1e1P8Jt39sPa
         bx6z5aVX7OucRLwLXXDxo5uq4J9Ie/Y8eAksI9KayaBG1G2rcEw4s1SIy9b70sUkIK0s
         J0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796398; x=1691401198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERFDOKkkrmVzc/iH5Nu4Hb+mXBiAhhvaFu2p7HjWgC0=;
        b=TFSr2STzOrgwPrqoQ1GxciCRJOUcYjUiykyUhPPfKFdpysMBbM5jEetzXc5XWbKCeC
         48QolEAvrhCUUtJ/3qKDZDGJ2Lt7R3Bq8HmOZ+SxTC0kDEihc/VhPPlWOQuS94UIXIQo
         i4CjW+Wp0TIsJ5CHQoupLkUQI219Kt8vpiNgvEaUdPfR2kb5mLFe6CMfNPR6qzrM6Ald
         t3wGm2Ta1xdNIse2SCZ072kSe04uuBikB8M5dX4PL4IStx9GSSl3kJr3YuIsB+eHDU5D
         zSpRCTmetyxCmszh0UTaz6SRd2KkDLl77d3pTbveAY0whTW+BAz41VRLXxN1d9Q1nEx+
         HeUA==
X-Gm-Message-State: ABy/qLZCrhUDIyvd2D0mad+3D9uHL6s+MYetongxdzG3GKadIJhjcDcM
	tz+OlDoAeW7PoSZEB0RLEJIu7reGkvkcg1jmbp0gKnHvUAPVsA==
X-Google-Smtp-Source: APBJJlGbrAnjHtd1gkuDBjmX8U5Q+n3M0g9kqH9jqa6LW2C+omYyP8BvFoF7s5975gvKEBRQ1Vrm2aIdvYArr/eCJqQ=
X-Received: by 2002:a05:6512:3da0:b0:4f4:c6ab:f119 with SMTP id
 k32-20020a0565123da000b004f4c6abf119mr6502952lfv.64.1690796397556; Mon, 31
 Jul 2023 02:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <a752f67c6cfe481a2329f1f4b477ff962c46f515.1690439335.git.chenfeiyang@loongson.cn>
 <30e8518e-4862-4aa5-afda-2f511dde2b44@lunn.ch> <CACWXhKkYY_g6Eo3G3TVT-AzGRa-HP2fTu9biQ6OtpPh7_hh5HQ@mail.gmail.com>
 <64ebd141-87ee-4186-9b4d-0705402c9e89@lunn.ch>
In-Reply-To: <64ebd141-87ee-4186-9b4d-0705402c9e89@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 31 Jul 2023 17:39:45 +0800
Message-ID: <CACWXhK=Dt1WW=7HmgsYVXVB4SCB3_Cu4sUYQtC-0CWdjB7wj4A@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] net: stmmac: dwmac1000: Add Loongson register definitions
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

On Fri, Jul 28, 2023 at 4:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 28, 2023 at 09:45:42AM +0800, Feiyang Chen wrote:
> > On Thu, Jul 27, 2023 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > >  /* GMAC HW ADDR regs */
> > > > -#define GMAC_ADDR_HIGH(reg)  ((reg > 15) ? 0x00000800 + (reg - 16)=
 * 8 : \
> > > > +#define GMAC_ADDR_HIGH(reg, x)       ((reg > 15) ? 0x00000800 + (r=
eg - 16) * 8 * (x) : \
> > > >                                0x00000040 + (reg * 8))
> > >
> > > please give x a more descriptive name.
> > >
> >
> > Hi, Andrew,
> >
> > The x is now related to the dwmac_is_loongson flag. I'll try to use
> > another method.
>
> Rather than 'dwmac_is_longson', make it represent a feature of the
> MAC.
>

Hi, Andrew,

OK.

Thanks,
Feiyang

>         Andrew

