Return-Path: <netdev+bounces-39477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B17BF6D8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62031C20AD4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0916416;
	Tue, 10 Oct 2023 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBq4SWQ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B28EA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:09:00 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7DA7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso5691785276.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696928938; x=1697533738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=DBq4SWQ08unPLaN9XsjfjRECOUzfr5cljl/e3fnsZJBm+UUBle6SRqkD5pFLN1xvmA
         WvZSWd8tTgpwQ1ilrHgoEbbQPtD9yBhlJp7eRSf+w4EXkLFy2Uszqi3xrqay8g82lpSM
         8FrpMbWP8x+Ift4vkRWpuPuqG4UzMPz9H8A33z2TRK7bTO7jlIeBtHlX01lKhhJfUszy
         yo2YjWbO+dawxg83FRWTAoA57LXmJzCpyUIDtv9wjjamre+EY/fQmwErFhU8wVIlkmZB
         PiTV/6RtqzIc/gw/TIs8MJU7hQRyH4ASYaOeQHfpXS2xy08GhVbLArxVD6BYQOTwC64I
         Ti6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928938; x=1697533738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=ivCcpOuLuXBTu81QVm9GmznFKa4IeUFUcrCn+WvzyYQ6V2WYMWj1bnIwOx0JVRx+d5
         uiZ5b7CFv4wTbLcMTcyDLSNF2ZqxwrxFbKZz5QBfbIG+Mp8jkbqgmhDhVaQh0Hz9+EsK
         h35QAcfvsEsQ1KWeuQ7yEd9fM54CLmsGgexfhXZzpdG8Q3OPiwKvSqMFUp7QWbmQoGpa
         nk1GGjdf+/mT+R/Dnqvm3lg0jyCagnCsOy2gyG0MIaTkpQVKQRwpYFvsa3/EM3662TQf
         cSVoFgw2edlgiA9TyNgE1JxPA2Nc7mx40OLFL/iB6wzh89CD8zRXWg7/RKbT7g4h3Zxi
         u+Wg==
X-Gm-Message-State: AOJu0YxHbhAQU9mmdNrQe58lk7blELmRLdYBPNhpzC5t98f7lZJZ4H0g
	S7qW0XhtKelOZ1m//n5gB4S/n1P8nynlr6bmHjvgTg==
X-Google-Smtp-Source: AGHT+IEr03R2VHLnNmgsuzntFl4LOazSy5LqhaQqB8IedsfEF3OGb4A0GJMrSUBOxjapz9jpzm8eXqKGDbKWo0GoSnk=
X-Received: by 2002:a25:6a85:0:b0:d99:d1b8:672f with SMTP id
 f127-20020a256a85000000b00d99d1b8672fmr6036146ybc.33.1696928937928; Tue, 10
 Oct 2023 02:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Oct 2023 11:08:46 +0200
Message-ID: <CACRpkdbkhQZn5zF1Qx9JyoW8p6KMuMx9PkOrYEzKVs2xAOzH0w@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
To: Justin Stitt <justinstitt@google.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 12:47=E2=80=AFAM Justin Stitt <justinstitt@google.c=
om> wrote:


> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
(...)
> -               mib =3D &priv->mib_counters[i];
> -               strncpy(data + i * ETH_GSTRING_LEN,
> -                       mib->name, ETH_GSTRING_LEN);
> +               ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);

Not only does it harden the kernel, it also makes it way easier to read!

Way to go.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

