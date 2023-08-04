Return-Path: <netdev+bounces-24559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189767709A4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A061C209B7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD361DA20;
	Fri,  4 Aug 2023 20:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A01C9FE
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB6C433C7;
	Fri,  4 Aug 2023 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691180567;
	bh=mJPmHyLOkGpK69AsXk3c3GmJNt2uDzbdpkpkFRBxrys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uDPuqB+VSTCFlH9K3f5xa+feDSgZGs9z3PHDu4UbxC/MPvTFK/spwtTIQlG2mF9bS
	 0/sHN7VfUEg8bfVw8ruZBbgkfFxHsZk9ZJjNRpTckbq8XzywJ7rPbaCw+dn666+O1I
	 AyfZt9TvNGj2St5prRTfX7AO0mj6tQC6KorswJObe6yMNjeah5NNKQYo7E3KjGTP+h
	 Vi+C9yQRWymx+RKJdZSnPuovHsjrQPqdHLQGLOc9jPz2vA23+yEI4akT/tNbAOEhI6
	 I7z0NssmQPPUOAmtBFMiGfK0f74+R0aGB7QhTX4JmgNFwHr8J5+ZjU+jDydY5qX/8z
	 bqa2d0fPhL4iQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso39819181fa.2;
        Fri, 04 Aug 2023 13:22:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywcx+KeCf2Pc5Pq0by9GxA7ZIQ4bibiza7vaNxU3MVGaFpxHhSU
	JGATjNI4pdCvNohHuQfrtWK++OwpJx2VtyqevA==
X-Google-Smtp-Source: AGHT+IFPE8bt2C0u4ES/8ggtuWUfuMIdun39dIp8D9Bs54ggHQwbY5aRZ+vpXub420MPURu7KyM9S2U65TtTtnEHZGo=
X-Received: by 2002:a2e:9f08:0:b0:2ba:18e5:1064 with SMTP id
 u8-20020a2e9f08000000b002ba18e51064mr2197002ljk.14.1691180565027; Fri, 04 Aug
 2023 13:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com> <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
In-Reply-To: <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Aug 2023 14:22:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
Message-ID: <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Nick Bowler <nbowler@draconx.ca>, Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saravana

On Fri, Aug 4, 2023 at 11:52=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> wr=
ote:
>
> On 2023-08-04, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Aug 4, 2023 at 10:54=E2=80=AFAM Nick Bowler <nbowler@draconx.ca=
> wrote:
> >> Oh, I get it, to include this driver I need to also enable:
> >>
> >>   CONFIG_RESET_CONTROLLER=3Dy
> >>
> >> Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it?
> >
> > Maybe. Do other platforms do that?
>
> Of the ~40 platforms in arch/arm64/Kconfig.platforms, there appear to
> be 5 that do select it.

Then selecting should be okay. Unless there's a desire for resets to
remain optional (which is going to rely on the timeout).

> >> However, even with this option enabled, 6.5-rc4 remains broken (no
> >> change in behaviour wrt. the network device).  I will bisect this
> >> now.
> >
> > It would be good to know why the deferred probe timeout doesn't work.
> > If you disable modules, the kernel shouldn't wait past late_initcall.
> > Though this functionality keeps getting tweaked, so I may be off on
> > the current behavior.
>
> I don't know about the deferred probe timeout, but I bisected the 6.5-rc4
> breakage to this commit:
>
>   commit c720a1f5e6ee8cb39c28435efc0819cec84d6ee2
>   Author: Michal Simek <michal.simek@amd.com>
>   Date:   Mon May 22 16:59:48 2023 +0200
>
>       arm64: zynqmp: Describe TI phy as ethernet-phy-id

I don't see anything obviously problematic with that commit. (The
#phy-cells property added is wrong as ethernet phys don't use the phy
binding, but that should just be ignored). I'd check if the phy probed
and has a DT node associated with it.

fw_devlink tracks parent-child dependencies and maybe changing to
parent-grandchild affected that. We don't yet track 'phy-handle'
dependencies, but we'd have a circular one here if we did (though that
should be handled). Does "fw_devlink=3Doff" help?

> So, reverting that on master appears to correct the issue (together with
> setting CONFIG_RESET_CONTROLLER=3Dy).

