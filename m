Return-Path: <netdev+bounces-264204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLJvO680qWlH3AAAu9opvQ
	(envelope-from <netdev+bounces-264204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:45:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4D20CDBA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E893302C140
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7C32AAC5;
	Thu,  5 Mar 2026 07:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C063264FD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696739; cv=none; b=FT+1jD0w8fNRRPQ5Grg07gmkZD8ZGjRHimhVqi15wrrev3xA9gsic4k5Xw5QC4q6JtseDPMJut1ficW8ZjdqEml6jGZrQMYuJE5zjcV3j01xMxwXE+OV1tfKnwD3Cu+v6xZRAkGFLNdRIFYCdOmxTWDFv8tnvlVGkiCV3SZZL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696739; c=relaxed/simple;
	bh=1VrdyW7eBzn3eIzcJ/qwIsXSzypVzRQDxfUgekinKYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phQYWiny3W+iipB/GPY4D+oV7qPIQswmG6PEPDQizSA9ym9Yynwlq5PIDKZ8mX3+T2H7v7ByNcoqipY2hO3VjZEG21bU7jy5EdFo8XNFFS3dzojCrgsdwHJWpFUnjZDnP4kVlisWg54COWvMeIUoByMNEn9GNj9HVEWK3d4uYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ff1836b4b5so2096255137.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696735; x=1773301535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLWXJFRzKXYfvRWexgs1gCb/dTgnevi1M5AetCjur0g=;
        b=tkNNmE5Ht11kcR0caE+vML1edKuiPiIPEdR7PokTJNOzdN5zWF4emFLcDj4xNNrVeJ
         ErWrnulVLsqClIxUYSa4V9sBmuNSrVHYUMcby4egLxYA0giZNpyT5oLuL1KvW9JhLgCm
         vU6XGjLKUoJsJyFr/OAMFPUMXsPBi4lx0+icFWaFq7SkbP+K44YjIhO8QOLB8U9zWGyJ
         hLkatoVOyOVJ1+Fnz7MJA+DvRelsvdrMzYhY7V9W82+a6DiKtTb3vLepKOYgzqO2PoR7
         MsFFHGvQCZbfXxnKzS5bDeGMdIvLEuyRIiXD6dQMmpptDd6TKgDzxWuZqMuY8FDlRrNp
         5Knw==
X-Forwarded-Encrypted: i=1; AJvYcCXuypBojou4RgYb9x8BSxnN1IxKwWqegsK2jRFImdVDDfMxXPLHWBIYCINfKdrrQQDGxj1iqfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dK8dHUCakN/ibL18a67MzGFXidxZ/RFncAQnRAnoWHyXWU4p
	633O7RTho6eApIZxETrUy6guWmiHyX4xW92XkTPgpboOngRa/oqVNPZdUAnLh3jm
X-Gm-Gg: ATEYQzzyqXskMRujzVzHQ0CpPaSBiyksUNhdBj9mUDEYNHhFy5OZZpR7b/HLDmIwVpw
	oX85iNqnGNLfhQx0vVE67ENOdbkVM3V4n5EcesDQMZK/CRqsbsYcGp1an1/eqaIQ1319LKdqoYh
	OSTJVwvmaMqmMacrap62VppB5VV6UBLuyLkIB+Dltr/RiRR4HTOV1vkGjZuoEv5l91x8Mac04jw
	xwNtTFFZJ6z8ApZHhTtknOm7S7glnyv0NAmTmWnonggKJYbZBFoBRi/Kl2f4cJZKKbkJmNMBu12
	Kh8QTZunbfWhkAjEF+Bvl+Oub0xkibO/eV8V2qosbCBFKxEEEYz4EBReK6Tk0GHz1nJZ6FqMtOl
	8vT+LfZcdkDEIY0LavGZRZXqsanIsMvcyS3irLFfDF6JDoZQCFtiFtEf/ZBiazAWWG+TEGNjWts
	vv9SlKoXs3IGoMa+tbEDIP7gm0vgd8kpqMnyVDUWu+7h6poq+L/v7hiUP2hnMt
X-Received: by 2002:a05:6102:6106:20b0:5ff:b684:f796 with SMTP id ada2fe7eead31-5ffb684fcb5mr1096789137.13.1772696734964;
        Wed, 04 Mar 2026 23:45:34 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffc3bad550sm2186751137.4.2026.03.04.23.45.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:45:34 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ffa0b23a1aso801708137.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu3D5Zv9lKDMIwJFV/BMj+HZUaux6tJqOIBRuoOg5H4cOxyhBRZrw590/KZomX7Dj4mIT+89I=@vger.kernel.org
X-Received: by 2002:a05:6102:441c:b0:5f9:3a22:85a2 with SMTP id
 ada2fe7eead31-5ffaac72675mr2059267137.12.1772696734612; Wed, 04 Mar 2026
 23:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:45:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
X-Gm-Features: AaiRm52ziEM93YxO07h7pOV0rTYZnULijxTOwLRm9EW_k_lOxLulmwK4PITV2jw
Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where missing
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 02F4D20CDBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	TAGGED_FROM(0.00)[bounces-264204-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[netdev,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,mail.gmail.com:mid,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-m68k.org:email]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
>  drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +

For the Renesas parts:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

