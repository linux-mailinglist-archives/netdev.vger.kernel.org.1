Return-Path: <netdev+bounces-211346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92FB181B9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F60A172AA6
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE81D23C51B;
	Fri,  1 Aug 2025 12:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5623BCE3;
	Fri,  1 Aug 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051133; cv=none; b=GR5HmmTGuuHYBCJfO79xia876rQqw41k3MEOewyd5XLuS8q7iVulcat03FVGkKZYzMT4hhRf7SqywJUpyhJo5AgB3QQRHaIXn906FiZ7Hv+jjp5Qg4J5EUZQvlDuP0Z65iFVpGXC/A/js9tc0X9++tZeUXYIJLIUuq91aQgV3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051133; c=relaxed/simple;
	bh=U91X4ClFB78bbaMRNQ0V5HfuvYVoKMe+7y1GNkBNfnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzlqIf6s3n3mWMIe3Xdcf+4xV6VCV1d/DsnFzwdD2Xo+bEoCWzVuNFya5gYY+ln2pjB4KdBTbOPM6x+mbYCRXV9AsCXpINi3XqKrykGj54FbiB8kv9YmlX4BRpUuo5wlrp8QS5rriOD8oTzyiL0qegfehjf35XX0B63VxM0dZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-539360cc274so808159e0c.3;
        Fri, 01 Aug 2025 05:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754051130; x=1754655930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccsTt7QMMxp6k9w4VZsz6QJ7TVPvRY3FqOylTrTxO6I=;
        b=g6OZvKXDUaJMwmBb3v+1CP+TQSjfjzqP4i6VOG6D/BMJw/sSIEQJnbftH7418dFY7t
         G/g+NQZ3OUP/WaiiuxWhjyQPia1Dc+rRUAJ+kF7fFhn8b21+DhBVIuxJ9eLwPu3kNCL9
         wtNa39Bh7WayT6gGQWAp1JfClRNb/cbKbgplt1NnGBOWuMgAbzmIGKhZvk8oGn5cPQuv
         LBrf/8TRIqC/21Ou6KrTApaooOFbrYKxq6JWc0YRqFx8G1KWIiEcyXfEyIenAWjCvDDw
         KTyLtesSNRcf+x03RwUz6ST/BYjcUYRSM6eP0tkSUkfV3GPlwnLVn2UW/YGTH7behJkx
         m9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUgzWjTbdChpSBcXY/htaIf4gr2vRjA2K8gPcYFEqAYFmtFYX5QFk6xl8wVxKUBvlAn51r9Hf/JzGne6gE=@vger.kernel.org, AJvYcCXxmZDQtiLr49XCOFxG5Z+LOYFzp3m1DzyIeppxX2rBThRT4WE/gQysz2FKJFqEjzOJB/eM/XdF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/BOSH6anr2itA+Uy/jMn7MFGoB0vTmCXgK4kDkxcAo9irQWi
	wyK/4dZiwQRMftSloKubMRAf7DYK7oOdjZEcudVmaCDYRRUlIs7DWFmo2MBYr0AE
X-Gm-Gg: ASbGncuU6H+rk7fiv8144kqNPT07BHwG2ZDFEgLfAdoTI7Dc34XsU0wpi1lFmpAz42o
	3lMbkTVGyL9N8gZjqJy3ISQKZUYpFhZ20mQO7kkIKvy6+vChIwUoonH3BnqvAoSzFOZZbb7Cbgl
	rxRSUiI7wBa5faaK3mvo7j0Mfg2BkVOai3FQxYZtUfMnT0gPJXd9v4UpWJgJ3t7KEoCV8sNpMb7
	1U39D7+5mFZkI2ct/LRafCAAEsT2UABLXVtlenxjLhv6NkVK8Mh9w36HnYvI/HnSx/+b7cJ8Xff
	RIrZ0mWLZzL1U3FhKj4iuX28PuktHyxfXb4lmapNRgYATMBPkam+K0KKK11kGtwAoISRYza2re9
	F6n4UfXs4xDVTPGB7/rZxd03Ac+JX/lh0lFVnf77t9VAunQ6Jhgg4duNbzGxF
X-Google-Smtp-Source: AGHT+IEwku6ceq4PfOD67wMF0HvEPiygpEm0qz5dJIxALtGP83zcvgP9odpISVnpiucwomX6ayID9A==
X-Received: by 2002:a05:6122:903:b0:523:dd87:fe95 with SMTP id 71dfb90a1353d-5391d00d017mr6810694e0c.9.1754051130222;
        Fri, 01 Aug 2025 05:25:30 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936d4f96bsm1006467e0c.35.2025.08.01.05.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:25:29 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so1378663241.2;
        Fri, 01 Aug 2025 05:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDvFFNKAmuv7QXZhZvxBTp/2qWcXs5NUU3EoC2GRHYqyaWHhDE6vPT8RVtFny5swgwqQLVyHiLzk028r8=@vger.kernel.org, AJvYcCXwZhaUOIOtPEmidFcj0RZUqrZOFP4C/XgxEmVNsaviGPZmEvkbaVD2TI4V46jfV7Loxdtrzvqi@vger.kernel.org
X-Received: by 2002:a05:6102:b09:b0:4f3:1731:8c01 with SMTP id
 ada2fe7eead31-4fbe87b48camr6625477137.19.1754051129317; Fri, 01 Aug 2025
 05:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728153455.47190-2-csokas.bence@prolan.hu> <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
In-Reply-To: <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Aug 2025 14:25:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
X-Gm-Features: Ac12FXyU90mDKtUzbqHALW08Hifnf3dt-i3DeXukP-dAn-ISIoIkJfshWRZUYP0
Message-ID: <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>, 
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, 
	"David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Csaba Buday <buday.csaba@prolan.hu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, 1 Aug 2025 at 14:01, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 28, 2025 at 05:34:55PM +0200, Bence Cs=C3=B3k=C3=A1s wrote:
> > Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> > devm_gpiod_get_optional() in favor of the non-devres managed
> > fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> > 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the d=
evm
> > functionality was not reinstated. Nor was the GPIO unclaimed on device
> > remove. This leads to the GPIO being claimed indefinitely, even when th=
e
> > device and/or the driver gets removed.
>
> I'm seeing multiple platforms including at least Beaglebone Black,
> Tordax Mallow and Libre Computer Alta printing errors in
> next/pending-fixes today:
>
> [    3.252885] mdio_bus 4a101000.mdio:00: Resources present before probin=
g
>
> Bisects are pointing to this patch which is 3b98c9352511db in -next,

My guess is that &mdiodev->dev is not the correct device for
resource management.
We had a similar issue before with non-GPIO resets, cfr. commit
32085f25d7b68404 ("mdio_bus: don't use managed reset-controller").

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

