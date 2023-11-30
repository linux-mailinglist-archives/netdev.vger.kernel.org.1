Return-Path: <netdev+bounces-52623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECD7FF7FF
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E264B20F65
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395775646B;
	Thu, 30 Nov 2023 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2FEZlcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6C1996;
	Thu, 30 Nov 2023 09:17:34 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d05ff42db0so13790077b3.2;
        Thu, 30 Nov 2023 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364654; x=1701969454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4ItrsGzT/WvTQH/WrTuyHNbLnHImVbBz/zIs/Lb/tg=;
        b=D2FEZlcJWvOhJwSUEllnY2RaHaeX8OZfOZQLJ5Z5sknSuwjswt2HHR3PN1DF5hfwzl
         UbtX7PSxHGHh5LFsB6ZdtPIW3LIQNHp6Aip7lsazOOEYBP/pNqvaVDdSBxokEmh3hKp2
         KkEcIUAXFzCnp/hzWWrKREjwPuVudeOkVg8JcK7fxWXTT9aB+ua1tSHBcrBtjTH2G2ux
         OGHS8p4uEbr3DqZON9iOVEZ/Pqrk0p6/jr0mSt0pFUYqVR3fZVGo7r/BQU+I1EJfyDA3
         Q74Id7NgMsQRNyDXJrCvaMbOwzgtga0/98/MAxSqX+r/ICSv/NmAi9skxoQ/6v0KTASt
         jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364654; x=1701969454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4ItrsGzT/WvTQH/WrTuyHNbLnHImVbBz/zIs/Lb/tg=;
        b=EuBsZRKLZIY3QTmptgRROHNxT6mYeeObhU+k530HoqlnUJnLQkglAMvXs6qs8UbX2Z
         7jTa8gWiYqfoDBGYGZlnDx0RWWmtT4lKoi8IPO73TWh6UbitkpMNWuVU+1YX4ZV8oWii
         bn3riWe+cXEjsbrzCSpyecpg9YZ8OH0T28C+3kiLBNxf5/V8a1KdCfPvT7VZwUeYDL8a
         A7XRTdjjx9yB/Ewp6uBGQBkPo6kKET2oNqc8jEnpbHcB61jAQe7xDpEYwfSJcC1nPAxD
         AS/bM7Unc495l5zybtglBlOC8Qr1g3FgFGG4CMn8qm+M/5FdHncT0cJGvKz5mom41QUF
         uZwQ==
X-Gm-Message-State: AOJu0YxDZdnBSQ/+VgyG/aJmWKWiJ68R89IkczUpzL8AfORtkASKlbKb
	3AtUgzhrv0fyVza2GeOcV3y6PsLa75OgAU6krzI=
X-Google-Smtp-Source: AGHT+IFRYlx8Y2pZgDDnTjk34oWVAWqB8FSjJ3g/yr2nSX2rg4cTZh7j2qWaWLqE1aKFFeAOp9O2b/2sC6qDD70RNAw=
X-Received: by 2002:a0d:f2c7:0:b0:5cd:3d82:1ac6 with SMTP id
 b190-20020a0df2c7000000b005cd3d821ac6mr21961033ywf.42.1701364653930; Thu, 30
 Nov 2023 09:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch> <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch> <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com> <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
In-Reply-To: <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 30 Nov 2023 19:17:22 +0200
Message-ID: <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.torgue@foss.st.com, tali.perry1@gmail.com, edumazet@google.com, 
	krzysztof.kozlowski+dt@linaro.org, linux-stm32@st-md-mailman.stormreply.com, 
	benjaminfair@google.com, openbmc@lists.ozlabs.org, joabreu@synopsys.com, 
	joel@jms.id.au, devicetree@vger.kernel.org, j.neuschaefer@gmx.net, 
	robh+dt@kernel.org, peppe.cavallaro@st.com, 
	linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com, 
	venture@google.com, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,


On Wed, 29 Nov 2023 at 01:31, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 27, 2023 at 05:19:15PM +0200, Tomer Maimon wrote:
> > Hi Andrew,
> >
> > I took a look at the xpcs driver and the stmmac driver and it doesn't
> > cover NPCM use.
> >
> > in the NPCM case the stmmac ID=0x37 therefore the driver is linked to DWMAC1000
> > https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/hwif.c#L139
> >
> > to enable the xpcs, the stmmac should support xgmac or gmac4 and in
> > the NPCM is support only gmac.
> > https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L555
> > https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L573
> >
> > and the most important thing is that the XPCS is handled through an
> > indirect register access and not through MDIO. the MDIO is connected
> > to the external PHY and not to the XPCS.
>
> What really matters here is, is the PCS hardware block you have an
> XPCS? We don't want two drivers for the same block of hardware.
>
> MDIO vs indirect register access can be solved with a bit of
> layering. That is not a reason to write a second driver.
I will check with the xpcs maintainer how can we add indirect access
to the xpcs module.
>
>         Andrew

Thanks.

Tomer

