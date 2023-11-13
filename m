Return-Path: <netdev+bounces-47441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8A7EA4CA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA651F226E0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA80F22EE9;
	Mon, 13 Nov 2023 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzgHaruH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F43250F7;
	Mon, 13 Nov 2023 20:31:03 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246D10CE;
	Mon, 13 Nov 2023 12:31:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5099184f8a3so6458961e87.2;
        Mon, 13 Nov 2023 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699907460; x=1700512260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AOFzE6fszMevBs2fySjWtp2Ne0ycBPPv7xKvrhZJz0=;
        b=PzgHaruHHrqb/qyvkGUB/safa9LkRSwWqL3gGIEUNWTKSU3DMxgD+GxxLsaSNZMWyD
         FFe+iRYaIyN2eW8bN5Hxbowz3oofF/usolRBzWCvUQ/xfOWrAq35YjFS5Tu3e8HkOpvy
         787aot84go160QY1INpYVAU7ArdXK72bglQgT6Tm0Z+E9dC9+GmFLgO4OXOu3F55BIZe
         C9Zs0wTn/AkUjB5+4s3pNx0hRx5Qbd19an+9xo1qPah8QIbV5FSgn9l2IUmVKl2WbS5J
         bjNV/8uwrj0mTrDqGnEbJPmUmhk+wFad9Fkm8kI2D0hAdK5+Z0Ya/zBXc+jUx0TQWRAA
         bfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907460; x=1700512260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AOFzE6fszMevBs2fySjWtp2Ne0ycBPPv7xKvrhZJz0=;
        b=Bw0njxfl8tuxEUUW952Hcs3HBfM666gk1kdJr3sXRAdfzeOOC3/Mue57FyftytoaJL
         GF16gnODO9A+7FbSCSpOKI6M9wZ7iK8MymXMmEGr5UN7pBmWuuixa6ngyrf0iEHol6ob
         2m/GjGgwu0u2ivIyQijjX8trPBHDHWhY2g4kVdTtBK0JJirGxD+TWj/tBzTJYBTzucb6
         L/A3trPcPonjTxY4TlILBoT51OjIQymHOlvQ/smDAtXqSvKIwbdctCZ8M+xuf/9Xz4tc
         mth5jqdiNXddMNRocMb+wXbU8BNoSeBSIKvgz+lPy9pj87W97xcIffglOPQcWA2VvFtz
         Ik5g==
X-Gm-Message-State: AOJu0Yw8+Izc96EAhRSybPmHjAGU2su/5Nj/a5xyF2ZkViZMHo7RkLi3
	iBgRhJFZe3RB/5sQB5aaFyrPCzPX4U+vlAv8BHw=
X-Google-Smtp-Source: AGHT+IFu91WYH5JBbJGD61cP7aUsh8PoxLyC/vJcKrEnLPV01ymoWaakzYPXo92/fESYRJXnwpfasQWuF27LOuqEgmU=
X-Received: by 2002:ac2:5507:0:b0:509:1033:c53e with SMTP id
 j7-20020ac25507000000b005091033c53emr5139326lfk.62.1699907459878; Mon, 13 Nov
 2023 12:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-2-luizluca@gmail.com>
 <87433a37-ca5a-4439-b25a-1c7ad6025b41@kernel.org>
In-Reply-To: <87433a37-ca5a-4439-b25a-1c7ad6025b41@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 13 Nov 2023 17:30:48 -0300
Message-ID: <CAJq09z7Dsq0cPyB0eJ+d5D4Mz-mNezxWCFm==L=zUYiSFVDDZg@mail.gmail.com>
Subject: Re: [RFC net-next 1/5] dt-bindings: net: dsa: realtek: reset-gpios is
 not required
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 11/11/2023 22:51, Luiz Angelo Daros de Luca wrote:
> > The 'reset-gpios' should not be mandatory. although they might be
> > required for some devices if the switch reset was left asserted by a
> > previous driver, such as the bootloader.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Acked-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> If this is first RFC, how did you get the Acks? If this is not v1,
> provide changelog.

Sorry Krzysztof, I might not have handled it correctly. Let me try to fix t=
hat.

This RFC is based on a v1/v2 series that morphed into this one.

https://lists.openwall.net/netdev/2023/10/24/348
https://lists.openwall.net/netdev/2023/10/27/257

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Best regards,
> Krzysztof
>

