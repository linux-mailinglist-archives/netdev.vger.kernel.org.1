Return-Path: <netdev+bounces-214513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE16B29FD0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246E71963B1C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC3261B70;
	Mon, 18 Aug 2025 10:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B5261B65;
	Mon, 18 Aug 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514692; cv=none; b=he1uVgO2D7Fx/yPcVysXyKLOwVm4yEUdNLomnYflTpeusLxSpLvxLAcJAR95Se4Kv0nPlf9JZUTJ/zjJ0ybUrtzjlffYM/XzjeNBPK4eO3hQT7Nkp4vooMJzdv4uSFa0oISiRp6RcSgYsJ62G9iB8yIQhGQvrAlaftt8USQMbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514692; c=relaxed/simple;
	bh=1OYMZNFgCtewx/LdH3kO7ZHFgEX+oJiXBsil7YTth9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X27g9jE+BfzfPv0QsvBjxCbL2Wz2fn9z4FHHP8WgysjDCSXVI5xo5ZSP4NPZWTRQERa9IhdmKPePyKyz4lFzu+dxQbe9gdntPw2208N9IxTN5QvDUJdxb9ARCtfEAWotmr14SwdUa0iaq6wbaMJzxr4+UO+bVcMGi/8jrLgB5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-50f85ec0885so2805364137.0;
        Mon, 18 Aug 2025 03:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514689; x=1756119489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvZGag46yLy/ylpKI2G9AQ0htuztjd8d1AFLuXJK53I=;
        b=ERElPTbHRDMijH8RP4RRjJAjzT6SlswR2IE+2cv0CxY0eICyNdH00K9w+c9yilVB1Z
         MWicG/Pgv/3KVUxGDZH/mhk2PTXgA9olK9x53ALPeilye1QJzIeRZTx84xI8wwmhWf0v
         m9ixzEMoNH7Hk9oN7fJ68YpI89qraQHQc2zxjl4Khcbq01QFs4mNRde4iKd1qGOBPSIN
         iYJLmegdm9U0+N6i111xgShaQxbZwE1lpGhNNAUcpmDhn94gWV+qL1sT7ygFpjPtTEXA
         6T8ii4qvUpiOz7qSoenAOcRnkMNT+jnlQ3JAMc+7qjlH2pR/PL5M0+7qXv2SGqcpLXCi
         HCMg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZn+d97M7JVX6z2F+TQeUPpsO+llWvRWHw5ArYait2xoKZ0hr5dhdrOAgRHgQCxbhEBs5jKqtXF8X7hP5@vger.kernel.org, AJvYcCX0hSp7WPaZ5fhvU3ugA7Ys34Tttjt6bcGw74hcYTkg8h7BjjuY+UipjSKER/ACUgQlZ2IDJbCRrXb8@vger.kernel.org, AJvYcCXfV63Q77aG4JkgUjzH2xlUbKCtgMo7Vvx/Zh9vK0W1z9YLF0UJBcuBAqhofJB0CnI0cBzHaon4@vger.kernel.org
X-Gm-Message-State: AOJu0YxNusP1t+nvJMYlIf4chWfRJ11DnZ7UBFjHA1SRoAhyjI3ETYWQ
	FhOCuRaVIzSquMWkods7/IaSc2qypORYgB4N/8EL/ujE8kZVWIA6Yb3KNOzsAMx5
X-Gm-Gg: ASbGncshB30GkWnRw5L+wWpkSBR5aN2MvF+AYItaNVENgjXLHx1ekQyAqloz27PIgp4
	8ll+H16WmH8AkbgtWntFMzFf9Ukv9+wHVvROlfjYFXs3BN/1q6MUOqqqmrzSolgeiekKy2YnY8t
	EUCqfKlI9jLDrfFOEO8GyfrZNjdvVJyDOfAqQLRFLq3hJsCxc4gEHdHqe3KQ+vrUVjvJ9bp6b51
	SPJuq3GM4m79tP6QpTUccmRV67Xizj6otMlgbKAkgI/jMYF65fdK96CcO0tzekj9RsEZCUUFgLW
	pVuTEZtVD1/C981cfNtALuK51YmmR7kk2X7O1+HQ1JZqC2BXBuQHjhtalZUS/ncCOSIr8tfQWGg
	71g5LqW31iV6UHHQfk3eqSss5CAKmm1QX2an/Nise2jpY1cZUO602kdnxVJ6/fVBN
X-Google-Smtp-Source: AGHT+IFCZiCwB1knN9/9a6I3MlWrbQ31oMbjAXU/1TSkzk97Gbr6eSgrdivV3Q+k1E/3JnGo+34X4A==
X-Received: by 2002:a05:6102:6306:20b0:517:1303:630f with SMTP id ada2fe7eead31-51713036e6bmr763552137.5.1755514689228;
        Mon, 18 Aug 2025 03:58:09 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bdb84f5sm1747700e0c.13.2025.08.18.03.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:58:08 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b1738e8e3so3112959e0c.1;
        Mon, 18 Aug 2025 03:58:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpPoy2QXHzSIK2xI9CDbosaMmbav+jncjaClUIntwVPCnmbsCRlevugTjlUsnFwMqM2W/sz9GWsNvRdSQM@vger.kernel.org, AJvYcCVthG6vouNou/SuHbwTYv47u4mxJrbbxOt9WBA8zq2HwdxozkEDNKebyq1oI4bK4AmXSqKrunn9@vger.kernel.org, AJvYcCWBjSLhw99MH++kjgXJHodlVZPef+mzcVNXeCkK9iGEGj3c/wbliY94wHcJ/aCztxaxWY+CLih9P6h4@vger.kernel.org
X-Received: by 2002:a05:6102:dc8:b0:4e6:f7e9:c4a5 with SMTP id
 ada2fe7eead31-5126d30d22emr4017732137.22.1755514688621; Mon, 18 Aug 2025
 03:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu> <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu> <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org> <295AB115-C189-430E-B361-4A892D7528C9@coresemi.io>
 <bc96aab8-fbb4-4869-a40a-d655e01bb5c7@kernel.org>
In-Reply-To: <bc96aab8-fbb4-4869-a40a-d655e01bb5c7@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Aug 2025 12:57:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0NZHCX1V01N4oay-yKuOf+RR5YV3kjNFiM6X6aVAvdw@mail.gmail.com>
X-Gm-Features: Ac12FXwgapf6Ilge_fJ2aLB6KswOb-DOfIP2gi-yDMzAml5eljyD22BBTTZoEkE
Message-ID: <CAMuHMdW0NZHCX1V01N4oay-yKuOf+RR5YV3kjNFiM6X6aVAvdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "D. Jeff Dionne" <jeff@coresemi.io>, Artur Rojek <contact@artur-rojek.eu>, 
	Rob Landley <rob@landley.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, 18 Aug 2025 at 11:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18/08/2025 10:21, D. Jeff Dionne wrote:
> > On Aug 18, 2025, at 17:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> git grep jcore,emac
> >>
> >> Gives me zero?
> >
> > Um, right.  It=E2=80=99s not upstream yet.  Thanks for your work to get=
 that done, Artur.
> >
> >>> If an incompatible version comes up, it should use a different
> >>> (versioned?) compatible value.
> >>
> >> Versions are allowed if they follow some documented and known vendor S=
oC versioning scheme. Is this the case here?
> >>
> >> This is some sort of SoC, right? So it should have actual SoC name?
> >
> > No.  It=E2=80=99s a generic IP core for multiple SoCs, which do have na=
mes.
>
> Then you need other SoCs compatibles, because we do not allow generic
> items. See writing bindings.
>
> > This is the correct naming scheme.  All compatible devices and SoCs mat=
ch properly.
>
> No, it is not a correct naming scheme. Please read writing bindings.

Can we please relax this for this specific compatible value?
All other devices in this specific hardware implementation were
accepted without SoC-specific compatible values ca. 9 years ago. AFAIK
the Ethernet MAC was the sole missing piece, because its Linux driver
was never attempted to be upstreamed before.

Thanks!

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

