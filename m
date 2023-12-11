Return-Path: <netdev+bounces-55711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB080C089
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A539C1F20F09
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064C1C2AF;
	Mon, 11 Dec 2023 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSu22FFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E1ED
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:02:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be10acaf9so3988445e87.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702270962; x=1702875762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cco2MLJ8ujJrpVdbk24at5YDTrQp9ynvCaZmZRwJw8=;
        b=NSu22FFZmVZqVV0zSU3UMIceR7iZy1zipA2CqP2NiqH/oBeT8ZGB0PVru4aGJj5bs5
         obUvRInNwwr8YyiNgawLe9pHThI8MwZB2yXEpeETeohRAl/TMuJasNerTJamWZrymWHg
         aGa2mBo0DnpSarMRmxRiRv2AISpLBSdYFznDesfcoCROE75o+WKC3zZ7A8lYcPU1Dfa2
         3rjYmOjbQeirKMZ02mD7ZjSU0JGrTUjxAU8RN7QvhlKS2DNTCzkWsv951MxrEQKmntmp
         FhzFFAD6kAs2b4uxWuB0N99yiRm/s5iA8nePU0E1VsPDSX5hMC5c1yt/Nu08HS9GxXpr
         vxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270962; x=1702875762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cco2MLJ8ujJrpVdbk24at5YDTrQp9ynvCaZmZRwJw8=;
        b=OzKB0sQItoYMLPrcv9TgLk5c6yF/nKH5qtb6GVypJJqn7Q6LLMfoCK7/2rKLR9bHsZ
         ydt+L+E0vYqObFv1xzdarw1jp1eZFIXI4zNfdfdGR8zcG61k/VAPSQ1986932Q4YueHG
         sYhlhfrmOCQUkyWkEumjwTQ3gNfiafAHo1xSM+17uASCg7WaAPuohAioZheoKJ9GSE+s
         J2LrzUMpapEjwruU3Z/BtLrQeyhs5go5PZ3CJI/JmsFhzwG7TemaCLA+WL4pYOSZlJ6W
         zCVgDx7/hfVxGOcpXE6Ty2+m86wnoiuBQunkdDBGUwy/Lr3XcQcm2j/ULShvsxLijBgC
         poVA==
X-Gm-Message-State: AOJu0YyWNM8xR2gmkV2PaiqNtrrXuI98L32fbySkzSzFbFm9APYQeVfd
	BmypWzpBeOuZxsk6L25V+oIkDxFepBR4oipyasg=
X-Google-Smtp-Source: AGHT+IGPrmR+RGEpatZcvmJq8CACB039jOVZgfxFGpZVqPhxVjXkmEvEi3CQzWMkkdk0PqpEXLmE8ZF2RP74ZL9fRjQ=
X-Received: by 2002:a05:6512:3d10:b0:50b:bddf:f939 with SMTP id
 d16-20020a0565123d1000b0050bbddff939mr2466407lfv.9.1702270961919; Sun, 10 Dec
 2023 21:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-5-luizluca@gmail.com>
 <4ltsthrk2oli6ickjiy6uy3pc3kpdddse7lab34qefbadjafhy@oaxoemtrhw3k>
In-Reply-To: <4ltsthrk2oli6ickjiy6uy3pc3kpdddse7lab34qefbadjafhy@oaxoemtrhw3k>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 02:02:30 -0300
Message-ID: <CAJq09z4YtJPnpLb3OqYaGdiPU3zPO636tu=jG08a=ROD0A=dRQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > +struct realtek_priv *
> > +realtek_common_probe_pre(struct device *dev, struct regmap_config rc,
> > +                      struct regmap_config rc_nolock)
> > +{
>
> <snip>
>
> > +
> > +     /* TODO: if power is software controlled, set up any regulators here */
> > +
> > +     priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->reset)) {
> > +             dev_err(dev, "failed to get RESET GPIO\n");
> > +             return ERR_CAST(priv->reset);
> > +     }
> > +     if (priv->reset) {
> > +             gpiod_set_value(priv->reset, 1);
> > +             dev_dbg(dev, "asserted RESET\n");
> > +             msleep(REALTEK_HW_STOP_DELAY);
> > +             gpiod_set_value(priv->reset, 0);
> > +             msleep(REALTEK_HW_START_DELAY);
> > +             dev_dbg(dev, "deasserted RESET\n");
> > +     }
>
> Another thing I would like to suggest is that you do not move the
> hardware reset and the /* TODO: regulators */ into the common code. I
> actually wanted to add regulator support for rtl8365mb after you are
> finished with your series, and I noticed that it will not fit well here,
> because the supplies are different for the two switch variants.
>
> If we were to do the hardware reset here in common_probe_pre(), where
> should I put my variant-specific regulator_bulk_enable()? I can't put it
> before _pre() because I do not have the private data allocated yet. If I
> put it afterwards, then the above hardware reset toggle will have had no
> effect.

We would need to move the HW reset out of common_probe_pre(). Putting
it in _post() or between _pre() and _post() would not solve your case
as that happens in interface context. The probe is currently
interface-specific, not variant-specific. Maybe the easiest solution
would be to move the reset into the detect(), just before getting the
chip id, creating a new realtek_common_hwreset(). That way, you could
set up the regulators a little bit before the reset in the variant
context.

We could also change the interface-specific to a variant-specific
probe like this:

rtl8365mb_probe_smi(){
       priv = realtek_common_probe() /* previously the _pre func */
       realtek_smi_probe(priv) /* everything but the common calls */
       rtl8365mb_setup_regulators(priv)
       realtek_common_hwreset(priv) /* the reset code from common_probe_pre */
       rtl8365mb_detect(priv)
       realtek_common_register(priv) /* previously the
common_probe_post without the detect */
}

rtl8365mb_probe_mdio(){
    <repeat rtl8365rb_probe_smi but replace realtek_smi_probe with
realtek_mdio_probe>
}

rtl8366rb_probe_smi() { ... }
rtl8366rb_probe_mdio() { ... }

But it would be mostly 4 times the same code above, with lots of extra checks.

For the sake of keeping this patch as small as possible, I would
prefer to maintain the reset in its current location unless it is a
merging requirement. You can easily move it out when necessary. I
don't believe preparing for a potential future change fits in this
series, as we may misjudge what will be needed to set up the
regulators.

Regards,

Luiz

