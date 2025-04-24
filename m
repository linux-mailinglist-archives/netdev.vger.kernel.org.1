Return-Path: <netdev+bounces-185708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B621DA9B804
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2881BA5E84
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913E2918F5;
	Thu, 24 Apr 2025 19:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19815A79B;
	Thu, 24 Apr 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521540; cv=none; b=UVErDoTqyMbPS05hMwgTtCfmOJiLEZ6qV8awFTGJ7XOhXdeB4T4W5c7596R3vozoAikeC/8XuakVQ2moM2ODrclgabRs86uOrgw7QwvSbrUvV5H0pyhVzIY7acsqel6EC0Fusdw2Z3DhGnziTISoro5m8wKLe9Ob6LxL0AjtWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521540; c=relaxed/simple;
	bh=YBKsUW/EPfANNhvxLG05JedW2Qch1UwPCKwOdSUXq7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxUcfvZh9VBv9LyAgQlmKkGUdhkYFTv5rKZ+HubTB5hrkv5EtZRNGhQIL/iKV/5su/T1hZrolf+3rwMEXA8zdP1kjn3QEn0NUD2ZkU3ILP8RyjFkG7VEQ65coiY7iFsmdcenP4y8S0O8vYSWp05vIEQ3CWxqsXkRTo9mFi08qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549b159c84cso1557132e87.3;
        Thu, 24 Apr 2025 12:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745521532; x=1746126332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBKsUW/EPfANNhvxLG05JedW2Qch1UwPCKwOdSUXq7M=;
        b=tBK3H7W4KGSvhDLY8sNBkMaO9mA2urm+n+/0elGxXlR5TAV2sCrZbQSuATrg3r6Cyq
         U9PvAoqRqclyUfkF7RRWx/aCZieUXFIITb4IIAhmA6RVE6wjogkG9PHPi0iloVcCwi/E
         +NKKp4CWqp+FMCboip9uf7ZSSIxIip0xvJSCJmuS2gZybsLpNq7CH0wCE+mV8Pz3i7N2
         +BcBDyT14Me6I4GSk8Ko8fLgN2NkYeW+a4eadr2uFhr65ut4rR2uAIPtBMaRciSrsqoF
         5AK1IZxgJQ+6FqEO9Pb8fmBhtnbz3CKpJ0RQGmzde79wKnPue/GE1vyOzEzoO3CfG4eb
         30ow==
X-Forwarded-Encrypted: i=1; AJvYcCUBbxrOmTUpK2E8/pnWb2u8Gf9n408TNhzgk73BMuU1JZdYgBLfsK/aQLB0tKW4dPeqoFcKIDO0@vger.kernel.org, AJvYcCXMybMy+FYezPn7jwOv+Kjpb5nG+4aDj/OUe11Tx0xKHULkre6SOoNQFzmAHU/AhxOD9kKZjWPC6mOL@vger.kernel.org, AJvYcCXYQs7zYZ+mMAgz3aOhCY8aRvzxXGCqw030XWmjo0s3tZletn3sx+6Flx4IBdZcjdrMt0OuDxez/c5uVp5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pg9pZCnMDKjdrysOeX61eiOcw7Dgt7NCSjxq75Lsob2nQH00
	sX3/QE5iv6KmzTX1oqYmq/rdXILFqoTCStp9KNURCxPZ9l+g2hQbs5MQRISB
X-Gm-Gg: ASbGncsO/FMxFpEF6rsCjZiRDyV22knplz/TxGELQ1DY8H0kWE4Wwc66PJXauzaS7sH
	0BcNhga9Zm7wG1wZOaXRj7loo/JE2vlMfIvcBY/RO7FHUs5gFKNEft0Qw9bwkoOIxk9dRiaWJYB
	60w7p9jeCQDutW7odpDaikvGtT6pjvYN1u+GBSU5sTrXc3s+e60s5EkxeQ4/vd4VvxX7/3yd8zm
	b8aCCAxsuy5wmNiKOF8Mda5bV0zpv95kYCzNLqdqPP2y+HZSbz13IiXCuSsIogjbwT0rS9Pmevs
	jx4TM6GiAlqFOef7EDWM9Swgo3jhT1A9KWlFdvxFsanOh+gVE0L/87ENBjJXcBBqbdOfgRiisw=
	=
X-Google-Smtp-Source: AGHT+IEsbKglHj0+ZmpOT9e0DSaTuqXLhNwZZhy9Y7yOuXcTleopSQjDPj+pvXxiJ4Q1bPR2tZ2RWg==
X-Received: by 2002:a05:6512:224c:b0:54e:819a:8327 with SMTP id 2adb3069b0e04-54e897762f9mr117827e87.13.1745521531610;
        Thu, 24 Apr 2025 12:05:31 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7ccb7791sm321155e87.211.2025.04.24.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 12:05:30 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so14880681fa.1;
        Thu, 24 Apr 2025 12:05:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8AdpW76NLMcFLGVxVO0z+G1jk4NCJLDqKII7KvWQBM//2stPPJisqfM1Te6Ib7/7lmHfpw3vjtjAk@vger.kernel.org, AJvYcCViOc+D3UxJ1IXeiA5ND4T23vM/JwEsp8AkYHDXxrtMOvgt2EjjZNC74mRkjA1aOsSEJlDPK5gR@vger.kernel.org, AJvYcCX4iJEyHR24K6A7BhizQHYTLkFqc3aSdTAbcGhy+/TrBX1OL7nCiElV2zFKeLhMYuR3/t30AsOmd8b1NV1Z@vger.kernel.org
X-Received: by 2002:a2e:bc83:0:b0:30c:2d44:c212 with SMTP id
 38308e7fff4ca-318a7ef5782mr3267911fa.9.1745521530295; Thu, 24 Apr 2025
 12:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch> <20250424150037.0f09a867@donnerap.manchester.arm.com>
 <4643958.LvFx2qVVIh@jernej-laptop> <7fcedce7-5cfe-48a4-9769-e6e7e82dc786@lunn.ch>
In-Reply-To: <7fcedce7-5cfe-48a4-9769-e6e7e82dc786@lunn.ch>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Apr 2025 03:05:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GPqr5Vnqb_MhAJBAjQzd-vKi1g1pJ53oUnF0Ym2PH9g@mail.gmail.com>
X-Gm-Features: ATxdqUHHFIvGhKguImv0eKl6AhZd0EW8z8xCFHbw-GoYUR64Hf9zgUT_-m4qJRA
Message-ID: <CAGb2v65GPqr5Vnqb_MhAJBAjQzd-vKi1g1pJ53oUnF0Ym2PH9g@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, clabbe.montjoie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:02=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > In my experience, vendor DT has proper delays specified, just 7 instead=
 of
> > 700, for example. What they get wrong, or better said, don't care, is p=
hy
> > mode. It's always set to rgmii because phy driver most of the time igno=
res
> > this value and phy IC just uses mode set using resistors. Proper way he=
re
> > would be to check schematic and set phy mode according to that. This me=
thod
> > always works, except for one board, which had resistors set wrong and
> > phy mode configured over phy driver was actually fix for it.
>
> What PHY driver is this? If it is ignoring the mode, it is broken.
>
> We have had problems in the past in this respect. A PHY driver which
> ignored the RGMII modes, and strapping was used. That 'worked' until
> somebody built a board with broken strapping and added code to respect
> the RGMII mode, overriding the strapping. It made that board work, but
> broke lots of others which had the wrong RGMII mode....
>
> If we have this again, i would like to know so we can try to get in
> front of the problem, before we have lots of broken boards...

I think the incident you are referring to is exactly the one that Jernej
mentioned.

And regarding the bad PHY driver, it could simply be that the PHY driver
was not built or not loaded, hence the kernel falling back to the generic
one, which of course doesn't know how to set the modes.

ChenYu

