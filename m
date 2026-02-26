Return-Path: <netdev+bounces-261398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBHXHZ9qoGmBjgQAu9opvQ
	(envelope-from <netdev+bounces-261398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:45:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7921A909D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF4CD3182A15
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6993D3CEC;
	Thu, 26 Feb 2026 15:19:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB9270545
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119174; cv=none; b=CBARHJwF2M1SV2I2G3P4TeMk/Sdh9VjHzd0flvyNgk/yR7Xst4h1rDO6RdH8OGDntJUH1a7yZH6BwrRChmiVJjsEqk67ZTy7eCfO+xkh7QhpzIJs41DcIx30vOzpEX5QbtF9Gq0nmmcVMMT6lBvaStg5BA2Dc65BvNQlePjkjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119174; c=relaxed/simple;
	bh=sNTeNXb0XfUb+HMFHcNwV1x7mN0bxpTI+7ku1DBJKwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INVKnLFYBliv3YZs5wXoPHsASLhvfywGTs1c/f1nhaIDXTNhOMCPqQhX4lgDnJHJFpn77kcLQ3KnGzxrzScwjllIREVQiG2+0/mbpHvkQ7YKZDWIebT7VyARQE5vMohaZ4qHZyfYLFSqPeLcrJ6L0UVsk2/8qGtbHwa9fManaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a84f2bf7bso1138761e0c.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119171; x=1772723971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0ezGVOcarv9ScNAFNBu6P5NdLNkz1RoEz4XxD5dNpA=;
        b=qFR5dRtWiC9uGk0qW3jkyGzRcsCXiLFiH+n1bKm5x2O69GhulXKcje/zanawMdbV9v
         sfhQH/t1uLf9exET8LTwIWanzzlH4bWLrRAsPGRzq6tWMuBPdf6XFCxz00U/oej/W3+0
         s5bmdX0BdiUCvmt5Zyly0yZPx5lB42ODIpYXRV8+iExMJoyWRKyh+aMfqbO9tI40UqPG
         PAhXbeDDNM2YeHeULRa20Md+LmVbFZvQY/L1Sa+qwTXxOM+jSABgYGCY0fcumKrT9zAV
         TIOBGODaa2KLaCB3DMv798KWc9NWsktethvc/hSO0XKKD/nb20YD9oqWGMDieCRNZSXv
         28Lg==
X-Gm-Message-State: AOJu0YxyabepE2CieP22gbbo+univ6blYN23oRgOrpky8q9fRz8kzktm
	t1OjbyRBUlXf+mduLkIrCV0xwQ7HuvAld1htoFifsj5VdKr4IPVgdLzroRpXJVjq
X-Gm-Gg: ATEYQzwJBG5r6M4X42MrMdhzThaJ0ukTr4AUr75YwX47TxxQQnquSi+MiK4XNOWmApu
	MEgDG5RPdkPfUv2xQ9Au/HfYdcY3mJl4SBJk+z3LWkWVqI+/A8le+aMqk8XPrSeGJzR2y6lb8at
	ptdKEOAR3gclVPp9/QyDIwWk6WtHQW/IFW1DSr7cFOlnX/gl+hhrb9+oL0KGIWPUiUCU+2oL01/
	bak83hogyVCgW5K0pqFSRW8BurpReCrsFS07EigxZ9Wc/dV+J7K18XsHhdvwv0B2KVZELg1pIo2
	HkxQPCCsiOjZKAa1FyShRC/3nN8dA01N+/cDHuUBAi4hQRy7EuylGvk6bAj234HBZ1jjfLlAMAw
	5fcNlDXX/vz/PWBrWnIknKzb9q8I8b5Jclct7/aNxt11ry/SLpIZ4RcCqxEp5m4DeEBDhx/ydBU
	KRCG0sbhz+5Z5pjW0Ldsjh/4sSiRxzU9GhDlpqKDYzLZIjkmUDtVlLj0ZOEJKiozp8Hdh3o8U=
X-Received: by 2002:a05:6122:46a0:b0:566:2fc9:6c89 with SMTP id 71dfb90a1353d-56a9315a679mr1509393e0c.10.1772119171400;
        Thu, 26 Feb 2026 07:19:31 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bb4fbesm2879160e0c.5.2026.02.26.07.19.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:19:31 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so653437241.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:19:31 -0800 (PST)
X-Received: by 2002:a05:6102:3a09:b0:5ef:6550:e9f0 with SMTP id
 ada2fe7eead31-5ff20c71950mr1513822137.36.1772118850413; Thu, 26 Feb 2026
 07:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com> <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
 <20260226151036.x4z4bdlxwgsqlkhs@skbuf>
In-Reply-To: <20260226151036.x4z4bdlxwgsqlkhs@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 16:13:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKbiKUkP=+FDA_-Kd_qx1X6vzSuyPU+Tdd9MgR=Q5WMw@mail.gmail.com>
X-Gm-Features: AaiRm50hl5iFqVfPGnJ3OyUGaG2ytMnVkvc4q6N2_1XHwxz7HIPlFh5Oi8AcHkM
Message-ID: <CAMuHMdXKbiKUkP=+FDA_-Kd_qx1X6vzSuyPU+Tdd9MgR=Q5WMw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Daniel Golle <daniel@makrotopia.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Lee Jones <lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,collabora.com,foss.st.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-261398-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 0A7921A909D
X-Rspamd-Action: no action

Hi Vladimir,

On Thu, 26 Feb 2026 at 16:10, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Thu, Feb 26, 2026 at 02:22:29PM +0100, Geert Uytterhoeven wrote:
> > > +config PHY_COMMON_PROPS
> > > +       bool
> > > +       help
> > > +         This parses properties common between generic PHYs and Ethernet PHYs.
> > > +
> > > +         Select this from consumer drivers to gain access to helpers for
> > > +         parsing properties from the
> > > +         Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
> > > +
> > > +config PHY_COMMON_PROPS_TEST
> > > +       tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> > > +       select PHY_COMMON_PROPS
> >
> > This select means that enabling KUNIT_ALL_TESTS also enables extra
> > functionality, which may not be desirable in a production system.
> > As PHY_COMMON_PROPS is bool, this extra functionality is even part of
> > the base kernel if KUNIT_ALL_TESTS=m.  Unfortunately PHY_COMMON_PROPS is
> > invisible, so this cannot just be changed from "select" to "depends on".
> > But perhaps PHY_COMMON_PROPS can be made visible if KUNIT_ALL_TESTS,
> > so the select can be turned into a dependency?
>
> Is this what you're asking for?
>
> -- >8 --
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 02467dfd4fb0..1875d5b784f6 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -6,7 +6,7 @@
>  menu "PHY Subsystem"
>
>  config PHY_COMMON_PROPS
> -       bool
> +       bool "PHY common properties" if KUNIT_ALL_TESTS
>         help
>           This parses properties common between generic PHYs and Ethernet PHYs.
>
> @@ -16,8 +16,7 @@ config PHY_COMMON_PROPS
>
>  config PHY_COMMON_PROPS_TEST
>         tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> -       select PHY_COMMON_PROPS
> -       depends on KUNIT
> +       depends on KUNIT && PHY_COMMON_PROPS
>         default KUNIT_ALL_TESTS
>         help
>           This builds KUnit tests for the PHY common property API.
> -- >8 --

Yes, that would work.  Do you think it is acceptable?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

