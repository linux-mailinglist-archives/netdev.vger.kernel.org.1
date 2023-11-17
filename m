Return-Path: <netdev+bounces-48570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827F7EEE2B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7914A1C208A3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E3F4FC;
	Fri, 17 Nov 2023 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C095D4D;
	Fri, 17 Nov 2023 01:13:03 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a92782615dso19899157b3.2;
        Fri, 17 Nov 2023 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700212382; x=1700817182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvynnOaR8xM7O4hHqd8ZbKUHknCSu+mkNKpvTcNlZWQ=;
        b=GHRcOfaG5VipmUy/IneoL5CEqTXarwStwUggOYUG1ZSippxel2jD4co44MZJOwNVLe
         Y2Nwo0Gr7wx7AvoEYLrr7SgTW0L0NToXbuKLYM5+tME4gPaw8OPgbtBrc/hRiks1Umkx
         ZviMS4j09PdCp/wj+gAKzb3uY3X7Ym0r7AxfUis8xUlzNu728Pz1PXHbpeDBxkEv4nB/
         zsT84VDKE74nF31Oxvj0SJXU2VRnuq6lZKbgGmZ2aLktY0fFOTsGgNIo2fSZmrXtoFqb
         kVdm3ySnbqJ0tPD2gbNm7mLvI61ngTc8tojmo0CqaTv0nV3Q+NR/QvVOCiTKRuSkdKFr
         HaOA==
X-Gm-Message-State: AOJu0YwO+lmOXIxos05q9CUmU60UKB05lgcpai1P0qtBerabfERoi0Th
	Vlwwh3cWd1g9xxYDk2Oqqo0rHdEJ9WXA7w==
X-Google-Smtp-Source: AGHT+IEqV1d1S2TY2YJglHD+oyTEHEWo7a4JuRmZM51yO10Dcd15gTMUTbR9JEBfeNoNGyOIOmKnBQ==
X-Received: by 2002:a0d:ea55:0:b0:595:89b0:6b41 with SMTP id t82-20020a0dea55000000b0059589b06b41mr20205664ywe.38.1700212381096;
        Fri, 17 Nov 2023 01:13:01 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r7-20020a0de807000000b005b054a1ec5dsm381553ywe.126.2023.11.17.01.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 01:12:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-da077db5145so1707161276.0;
        Fri, 17 Nov 2023 01:12:57 -0800 (PST)
X-Received: by 2002:a25:3792:0:b0:da3:743d:ea3e with SMTP id
 e140-20020a253792000000b00da3743dea3emr18343937yba.21.1700212377409; Fri, 17
 Nov 2023 01:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <f253b50a-a0ac-40c6-b13d-013de7bac407@lunn.ch> <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
 <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com> <20231116-stellar-anguished-7cf06eb5634a@squawk>
 <CAMuHMdXdeW9SRN8hq-0722CiLvXDFVwpJxjFTGgdc2mhT=ppYw@mail.gmail.com>
 <b4a3a139-4831-447e-94ed-d590986aed8c@collabora.com> <84fd076b-6db4-4251-aff8-36befc28e574@collabora.com>
In-Reply-To: <84fd076b-6db4-4251-aff8-36befc28e574@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Nov 2023 10:12:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVXAx+b6=70PdgJrpbegBkDpb3w1UF0_u1Odi=JoYL2-w@mail.gmail.com>
Message-ID: <CAMuHMdVXAx+b6=70PdgJrpbegBkDpb3w1UF0_u1Odi=JoYL2-w@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cristian,

On Fri, Nov 17, 2023 at 9:59=E2=80=AFAM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> On 11/17/23 10:49, Cristian Ciocaltea wrote:
> > On 11/17/23 10:37, Geert Uytterhoeven wrote:
> >> On Thu, Nov 16, 2023 at 6:55=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> >>> On Thu, Nov 16, 2023 at 03:15:46PM +0200, Cristian Ciocaltea wrote:
> >>>> On 10/30/23 00:53, Cristian Ciocaltea wrote:
> >>>>> On 10/29/23 20:46, Andrew Lunn wrote:
> >>>>>> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote=
:
> >>>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY suppo=
rting
> >>>>>>> RGMII-ID.
> >>>>>>>
> >>>>>>> TODO: Verify if manual adjustment of the RX internal delay is nee=
ded. If
> >>>>>>> yes, add the mdio & phy sub-nodes.
> >>>>>>
> >>>>>> Please could you try to get this tested. It might shed some light =
on
> >>>>>> what is going on here, since it is a different PHY.
> >>>>>
> >>>>> Actually, this is the main reason I added the patch. I don't have a=
ccess
> >>>>> to this board, so it would be great if we could get some help with =
testing.
> >>>>
> >>>> @Emil, @Conor: Any idea who might help us with a quick test on the
> >>>> BeagleV Starlight board?
> >>>
> >>> I don't have one & I am not sure if Emil does. Geert (CCed) should ha=
ve
> >>
> >> I believe Esmil has.
> >>
> >>> one though. Is there a specific test you need to have done?
> >>
> >> I gave it a try, on top of latest renesas-drivers[1].
>
> [...]
>
> >>
> >> Looks like it needs more non-coherent support before we can test
> >> Ethernet.
> >
> > Hi Geert,
> >
> > Thanks for taking the time to test this!
> >
> > Could you please check if the following are enabled in your kernel conf=
ig:
> >
> >   CONFIG_DMA_GLOBAL_POOL
> >   CONFIG_RISCV_DMA_NONCOHERENT
> >   CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> >   CONFIG_SIFIVE_CCACHE

CONFIG_DMA_GLOBAL_POOL and CONFIG_RISCV_NONSTANDARD_CACHE_OPS were
indeed no longer enabled, as they cannot be enabled manually.

After cherry-picking commit e14ad9ff67fd51dc ("riscv: errata: Add
StarFive JH7100 errata") in esmil/visionfive these options become
enabled. Now it gets a bit further, but still lots of CCACHE DataFail
errors.

> Also please note the series requires the SiFive Composable Cache
> controller patches provided by Emil [1].
>
> [1]: https://lore.kernel.org/all/20231031141444.53426-1-emil.renner.berth=
ing@canonical.com/

That series does not contain any Kconfig changes, so there must be
other missing dependencies?

Perhaps I should just defer to Emil ;-)

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

