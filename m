Return-Path: <netdev+bounces-54988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AE8091E6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DBC1C208CC
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396A4F8A5;
	Thu,  7 Dec 2023 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHmAb+kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1DA5
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:50:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50c222a022dso777154e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978625; x=1702583425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6xSmX/HnKitf1GhebNLKyeeVpaRU5wUPHAuVIh8Vdw=;
        b=cHmAb+kkFjpi8BETbft/JUJpfkvWXLLgDjweJ7ASUGckicU3+nQ2Mj21bxFbSbVH/h
         MBhRCuwNNG4/MTEjSct89dV1DdV0qg9x/+G6Zl1k2rmpJsxeZRWKFKVXrt1uSq/amQX0
         LFVljJ9oHa/aILDElCB04v2MU5QvZxAnuR4VIpaupUfIL+ZMnJi5TrRV/mKWRNbqHg6e
         NKjshHR1EkHs+IsC6NpuiEGrCY1CNMLAnp8n9l/xMEKXCTGTEwd5zw63boug5U7YeQR+
         wENjAuBPGKgSOxUeVTEJhM3KV50tAVZRVfYqKwjTBdEqC7Uc+v9gmTUzvp+UXUPp7UEc
         bsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978625; x=1702583425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6xSmX/HnKitf1GhebNLKyeeVpaRU5wUPHAuVIh8Vdw=;
        b=dT6yb2CQmdPtla9E4SBP++fp20IJTuVopHdte1A6t/5J6yQN7S+7wEwd2pofSw/X/h
         SMRLDYQY8SVANCnhWNTFJ58zRL6vxIsqVTJrXPAm0X4enD21sRYGKgl1E2y4DcxKHJap
         npoOsOcIO7GT2wbvLqFY5agF5p32YTyxAMN2VzLiBiEgGq88eHFyUWjLiThef4nVnp8m
         FpuoIk0A6vFT3qNDegdnyp8bSDNsXPRyGmrz1ZYYHr5pEtNrLNBs4bwOJbj5Y/KJEODb
         BsU0znpOfUVldMyAfQ5dc1kIK8Do9ErGiKtfFkKA1ClppxxVfrjB6dSGU0U/JSefk7ZM
         vaZA==
X-Gm-Message-State: AOJu0Yy4SeFgon0CvuXtXo+KK2ylHsajyv/dLSNR1e5utTk2W7LZaZsz
	d2asgDNS8147bnYsucv1s8E9vLlnC0hN8/2cK90=
X-Google-Smtp-Source: AGHT+IEi72kvnxIN1Iof2XY21PZ3u+M45ptVN5LMpL5QgipQzglXHcv+0DaKormz3oOMZoqoQ90ghbUZsbKAd2czHrc=
X-Received: by 2002:a19:500a:0:b0:50c:e90:e0c4 with SMTP id
 e10-20020a19500a000000b0050c0e90e0c4mr1930761lfb.84.1701978624398; Thu, 07
 Dec 2023 11:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117235140.1178-3-luizluca@gmail.com> <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
 <20231120134818.e2k673xsjec5scy5@skbuf> <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org> <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com> <20231207171941.dhgch5fs6mmke7v7@skbuf>
In-Reply-To: <20231207171941.dhgch5fs6mmke7v7@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 7 Dec 2023 16:50:12 -0300
Message-ID: <CAJq09z7j_gNbUcYDWXjzUNAXat-+EyryFJFEqpVG-jPcY4ZmmQ@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Mon, Nov 27, 2023 at 07:24:16PM -0300, Luiz Angelo Daros de Luca wrote:
> > The "realtek_smi_setup_mdio()" used in setup_interface isn't really
> > necessary (like it happens in realtek-mdio). It could be used (or not)
> > by both interfaces. The "realtek,smi-mdio" compatible string is
> > misleading, indicating it might be something specific to the SMI
> > interface HW while it is just how the driver was implemented. A
> > "realtek,slave_mdio" or "realtek,user_mii" would be better.
>
> The compatible string is about picking a driver for a device. It is
> supposed to uniquely describe the register layout and functionality of
> that IP block, not its functional role in the kernel. "slave_mdio" and
> "user_mii" are too ingrained with "this MDIO controller gives access to
> internal PHY ports of DSA slave ports".
>
> Even if the MDIO controller doesn't currently have its own struct device
> and driver, you'd have to think of the fact that it could, when picking
> an appropriate compatible string.
>
> If you have very specific information that the MDIO controller is based on
> some reusable/licensable IP block and there were no modifications made
> to it, you could use that compatible string.
>
> Otherwise, another sensible choice would be "realtek,<precise-soc-name>-mdio",
> because it leaves room for future extensions with other compatible
> strings, more generic or just as specific, that all bind to the same
> driver.
>
> It's always good to start being too specific rather than too generic,
> because a future Realtek switch might have a different IP block for its
> MDIO controller. Then a driver for your existing "realtek,smi-mdio" or
> "realtek,slave_mdio" or "realtek,user_mii" compatible string sounds like
> it could handle it, but it can't.
>
> You can always add secondary compatible strings to a node, but changing
> the existing one breaks the ABI between the kernel and the DT.

HI Vladmir,

We discussed something about that in the past:

https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/#m04e6cf7d0c1f18b02c2bf40266ada915b1f02f3d

The code is able to handle only a single node and binding docs say it
should be named "mdio". The compatible string wasn't a requirement
since the beginning and I don't think it is worth it to rename the
compatible string. I suggest we simply switch to
of_get_child_by_name() and look for a node named "mdio". If that node
is not found, we can still look for the old compatible string
(backwards compatibility) and probably warn the "user" (targeting not
the end-user but the one creating the DT for a new device).

I don't know how to handle the binding docs as the compatible string
is still a requirement for older kernel versions. Is it ok to update
the device-tree bindings docs in such a way it would break old
drivers? Or should we keep it there until the last LTS kernel
requiring it reaches EOL? As device-tree bindings docs should not
consider how the driver was implemented, I think it would be strange
to have a note like "required by kernel up to 6.x".

Regards,

Luiz

