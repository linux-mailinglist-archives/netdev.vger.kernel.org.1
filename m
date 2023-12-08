Return-Path: <netdev+bounces-55478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC780AFC6
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6308A1C20AC2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3301381A0;
	Fri,  8 Dec 2023 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wM7mC16Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B510CA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:41:02 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5dd3affae03so25993817b3.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702075262; x=1702680062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOeswBlcwCDEkoDNTvrsGUjCXtw0cH2uUTlFe6lWar0=;
        b=wM7mC16ZIKoC3HD+mvTeKssI33WXSo8VogE/Vt2ah+CLUma4RBmElfiSJa9dYZ0rXo
         RySjmrmXFiq7+5vSQgFVxm/P4Rm53+EXKgGpUQI7X/Zwgxr+KsYCuqA5xap9wVcV1Mwg
         tqHnkjM8+y41Zzz5sfnJwWOXMN3JmZZAdIMGxVnxLbDOwOtbN3weYoxcBvFjAuGZA9Nc
         5cGuJpa2mcDItGwTecnRxVsHAV6UImnbDMR5qCZ4wK/JaWTIXf4m2NLJn59tGwh/R1oj
         wLVPE/0q5dPYnisoHKDkev7Zb04DGzSmQajrtaiOtgYGqDc3F5K8+Tge7k9E/IAP68vj
         cuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075262; x=1702680062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOeswBlcwCDEkoDNTvrsGUjCXtw0cH2uUTlFe6lWar0=;
        b=YVgcUb8Ea2XcUMfE4Ej0pcTOXh1pdgMEO+78MgYwB4M4Z2hCRbZ85sSktn4dMct5dG
         mpcyMBeD7PHaglWsODmhRL2S3U5bV6h2jRmblI3kCoGhQs4457bPL2SzhiJIPgm7PXrZ
         dszAUQolzbJUFsnVeZCCyiF4jSVrC3B+4zEGKLhJbPpYT7cx9vSgtHgDUQ3FWl5mPCmf
         BLVhJ3//QJMsRwr250oGuj2Pi50612m1/EfR7AJVVgXcBxGShF/uYrZUoOKiFwaTFQOC
         wEHfYPev6eaMq+cJlovKzndWB8S6zj2BVZ+VFuvQ4gU12zNO1xtDlMSxsUIkijZ4pZED
         kRFg==
X-Gm-Message-State: AOJu0YwlX9HzHT6rIWgrmwcsS457zxl8tJujJtivagefLsUkapYRs0fq
	kEBv2ahfJ36vrOx2Bh4/BAoaKvzX+CQDv4h/9oNnqw==
X-Google-Smtp-Source: AGHT+IGPG6wwjhIhjxmQgzlIWaCeOeh/P8IX+Ckabh/ZFHsfrcrYNpTHGSYKiuj9bBM9VmRxiZerXvj9TmtI01nL+yE=
X-Received: by 2002:a0d:ff44:0:b0:5d7:1940:b389 with SMTP id
 p65-20020a0dff44000000b005d71940b389mr788328ywf.85.1702075261922; Fri, 08 Dec
 2023 14:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com> <20231208193518.2018114-5-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-5-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Dec 2023 23:40:50 +0100
Message-ID: <CACRpkdYL1C4iTKV1ovX2coTFK4u0Cn4Oqknu7Fxh3k_gk_OWGQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] docs: net: dsa: replace TODO section with info
 about history and devel ideas
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Madhuri Sripada <madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, 
	Tobias Waldekranz <tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:36=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:

> It was a bit unclear to me what the TODO is about and what is even
> actionable about it. I had a discussion with Florian about it at NetConf
> 2023, and it seems that it's about the amount of boilerplate code that
> exists in switchdev drivers, and how that could be maybe made common
> with DSA, through something like another library.
>
> I think we are seeing a lot of people who are looking at DSA now,
> and there is a lot of misunderstanding about why things are the way
> they are, and which are the changes that would benefit the subsystem,
> compared to the changes that go against DSA's past development trend.
>
> I think what is missing is the context, which is admittedly a bit
> hard to grasp considering there are 15 years of development.
> Based on the git log and on the discussions where I participated,
> I tried to cobble up a section about DSA's history. Here and there,
> I've mentioned the limitations that I am aware of, and some possible
> ways forward.
>
> I'm also personally surprised by the amount of change in DSA over the
> years, and I hope that putting things into perspective will also
> encourage others to not think that it's set in stone the way it is now.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Adding documentation is always good, and the kernel definitely
looks better after this patch than before so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For ease of reading I would personally restructure it a bit, by
putting in three sections:

- History
  Pure development history (for the old code maybe add examples
  of which switches brought about the changes, in the same way
  that the Ocelot driver is mentioned?)

- Policy
  Do this, don't do that. The text has a few paragraphs that read
  like so.

- Future directions
  What we want to do next, or can be expected for the future,
  again the text has a few paragraphs that read like that.

Yours,
Linus Walleij

