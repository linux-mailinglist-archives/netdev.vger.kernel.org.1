Return-Path: <netdev+bounces-62614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D3828332
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4B1C23E75
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05233CD6;
	Tue,  9 Jan 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OiWUbppT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAE2EB1A
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4678161e4cfso670603137.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704792627; x=1705397427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5Mv0Nl8yaYPCz0vAzjt1yZi38rbxQe3qLZ0/Dp0y6Y=;
        b=OiWUbppTWd8ByIVIdFWSBoDLEVWTHXqrCyWlFClMgQ3YoyaAkq1vSvW9siv1dzKwu9
         xyB3hEDAN5ftmhma+YkectTj6fsFtPyQiYMsCSUjvgpLHamS6JURN5gx6ZLR53AAubP0
         OznoRPara4vPKPARQmJ6NhIQPMrPbXIxJzI3JVK6rFp1/iywkouASqsbcistOirQJ0zP
         p++XPCDhI5woLkWWOAnhPazqtc0uwxmghTLvtbEDqkEkerIQ0cwBx9HT5pOhBbnFzzjy
         s4/ELTPtfsLtSM6YULIhWe2bs0OCGcSf7zvCSEvia4zkbDPHp5eo5th9xKCT98SEmS8E
         plmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792627; x=1705397427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5Mv0Nl8yaYPCz0vAzjt1yZi38rbxQe3qLZ0/Dp0y6Y=;
        b=eL59qtK+bxoPfA1SWqWkYkWClubwC60XorvTxwsa/h3z2SR0vNCGrWAw2Doq5QHS8G
         fj1z30ziqPBcVQb3LHZ7rPtLkCoUZnoB00sVMFtZohgSFEnSR09Ty06IUCUrY0Y+l8y+
         6QjTO+rG3sz3n1tOfAtIzo+mMlX2O6OFFPQ2xvRAOn1u4lDJzd3zxWHt1k37miblnHB1
         nPALhQwJ18wXCnEgKbXDEefDJxHTjoI9Zzqr4KQhWXVx1+eU12rU55jhCSstQmfpJl3X
         Qlc4LhfkaSugq5nbIRqQ0X+8Ca/Glr1Q6+5a9Su/p3ShuIfU6leW+adoRdRvJ8x8W/5L
         qkDg==
X-Gm-Message-State: AOJu0YxvsjJDcYS92P8KtFGDpV3x+23qQ1yKjx8jlmfFLKQ9jsVfgCDI
	zH65BYyQO8I8N5INgV475ab7QwPqgJnexidS7hLlJZGPA3KSNw==
X-Google-Smtp-Source: AGHT+IEnh+p9dVhhp4GsPf85OaSuUfAr/hUhqX3r3kxg1wHgmsrumWNQGZCR9EvDSRlqvmMKLX62tyOlBKfNRwBkGSw=
X-Received: by 2002:a05:6102:d89:b0:467:dda2:825c with SMTP id
 d9-20020a0561020d8900b00467dda2825cmr1755368vst.26.1704792627714; Tue, 09 Jan
 2024 01:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-7-brgl@bgdev.pl>
 <20240108191052.GA1893484-robh@kernel.org> <CAMRc=Mc7D1rVHaA4yoOC2DHDkkCptF4wjAm=24Rr=kkqM1ztjg@mail.gmail.com>
 <CAL_JsqKGrW-v=fr_9NYKg-8cho_-XbVQ92eXpjYYC1ma0_8UuA@mail.gmail.com> <ac2a2370-322c-4cdd-a940-a07ba99dae06@linaro.org>
In-Reply-To: <ac2a2370-322c-4cdd-a940-a07ba99dae06@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Jan 2024 10:30:16 +0100
Message-ID: <CAMRc=MfaupJnT4qfjX-qe5THSRMpJkzceaPSL-cU0yFZ4iSwBw@mail.gmail.com>
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:17=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/01/2024 03:56, Rob Herring wrote:
> > On Mon, Jan 8, 2024 at 12:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>
> >> On Mon, Jan 8, 2024 at 8:10=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >>>
> >>> On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>
> >>>> Document the PCI vendor prefix for Qualcomm Atheros so that we can
> >>>> define the QCA PCI devices on device tree.
> >>>
> >>> Why? vendor-prefixes.yaml is only applied to property names. 'qca'
> >>> should be the prefix for those.
> >>>
> >>> Rob
> >>
> >> I didn't have any better idea. PCI devices on DT are defined by their
> >> "pci<vendor ID>,<model ID>" compatible, not regular human-readable
> >> strings and this makes checkpatch.pl complain.
> >>
> >> I'm open to suggestions.
> >
> > The checkpatch.pl check predates schemas and we could consider just
> > dropping it. The only thing it provides is checking a patch rather
> > than the tree (which the schema do). It's pretty hacky because it just
> > greps the tree for a compatible string which is not entirely accurate.
> > Also, we can extract an exact list of compatibles with
> > "dt-extract-compatibles" which would make a better check, but I'm not
> > sure making dtschema a dependency on checkpatch would be good.
> >
> > The other option is just ignore the warning. PCI compatibles are fairly=
 rare.
>
> Yep, the same warnings are for EEPROM and USB VID/PID compatibles, and
> we live with these, so I don't think PCI should be treated differently.
>

Got it, I will drop this patch.

Bart

