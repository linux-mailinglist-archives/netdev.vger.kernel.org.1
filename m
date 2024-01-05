Return-Path: <netdev+bounces-61762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8030824CFE
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959221C2262C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEB373;
	Fri,  5 Jan 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA5XHyzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A4BE61
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso13267531fa.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704422142; x=1705026942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftsw8P+AUQTWOjAYpbsex/EoqXjGH/INYiEvSQNuuk4=;
        b=aA5XHyzthe4v418kO5gpNXQ6bC/VwwLLjf2yEcppZdWUeir+6jCSfBalqmigPX2ak9
         xA9rhkVdKUonoGQZpDm9bJXmCGCTOA4BeFeuAiVlalhIrVdQOE4wlNOsDn9Hlrjrhnav
         OQUyNIvNFJUP/rHfzWHXQ3ZQ9FfgHTuQcYVs5S0Yenvl4QbfoRi/mbpSzNTgJ81QFhbv
         N4As+RKcN7IqSMoKsf7SvR/VNbpiALQ6dUK+JNaqu1/PgKyKbWTsqsCoYcVDLnRrNbya
         gkpjVYEf51J5BX9T9zEdE1umD0zxcsxG9f9ZO7ZTtHVBYB5j3WhDinQPfNhFRYWD6YP2
         UzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422142; x=1705026942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftsw8P+AUQTWOjAYpbsex/EoqXjGH/INYiEvSQNuuk4=;
        b=bQu4jv8m4K48YCE0OjXyNQaE6bblQ1fsSrul7ePa9OSL0kFEiXypp2fKMJ2WqMLVl1
         RASsgtY4ZM0cddbu36NpCU3QbSms3BYk6XyBW2p9picur92e/mJQYHbwmcwYN9+xZkZn
         i5c0/15MGlZw9bk7h2imH/Mi6t1Jhl+NS6ykUEVTA7n+BYkFs9U/F75z1U387y6HUkUh
         lHmF8SNFPhi2YBE4FYqcEROWdp9qjDuAh65aU8HFEU4oTziCkvT0WF2t+pQCbMUsGJBs
         WfkcgL9+JApHo/2IISJf5onFMYsqD9XOod5WK0Yz6oXkScYCwwBVCGIukcszBv6dp2A6
         59sA==
X-Gm-Message-State: AOJu0YxtnYBQI6Oyw2im8pxx+IZ2RI3BibOKGeV2sSnaQjWJhJCzZVpp
	U71Gop1D8GpC6c3YITA/X5uH+GuCxwvBT4FDAcQ=
X-Google-Smtp-Source: AGHT+IE9UDFewyd5jbTk1MFJx54OFn7wLJH0+rTXT7qCQ8EnPgtt2eBCBjk8pnoJaI5AVRjjPsCg0iQClaTQSXxhQf4=
X-Received: by 2002:a05:651c:508:b0:2cd:1d5d:3240 with SMTP id
 o8-20020a05651c050800b002cd1d5d3240mr906885ljp.0.1704422142082; Thu, 04 Jan
 2024 18:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-7-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-7-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:35:30 -0300
Message-ID: <CAJq09z7Jd51b9GKAy7xUXr4cqdLT-bOLd-FaEDPn8eL9Da1bMg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] net: dsa: qca8k: assign ds->user_mii_bus
 only for the non-OF case
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> To simplify reasoning about why the DSA framework provides the
> ds->user_mii_bus functionality, drivers should only use it if they
> need to. The qca8k driver appears to also use it simply as storage
> for a pointer, which is not a good enough reason to make the core
> much more difficult to follow.
>
> ds->user_mii_bus is useful for only 2 cases:
>
> 1. The driver probes on platform_data (no OF)
> 2. The driver probes on OF, but there is no OF node for the MDIO bus.
>
> It is unclear if case (1) is supported with qca8k. It might not be:
> the driver might crash when of_device_get_match_data() returns NULL
> and then it dereferences priv->info without NULL checking.

There are plenty of places that will not work without OF. For example,
qca8k_setup_mdio_bus will return -EINVAL without ports or
ethernet-ports in the device-tree.
That error will abort qca8k_setup. I think it is safe to assume case (2).

> Anyway, let us limit the ds->user_mii_bus usage only to the above cases,
> and not assign it when an OF node is present.
>
> The bus->phy_mask assignment follows along with the movement, because
> __of_mdiobus_register() overwrites this bus field anyway. The value set
> by the driver only matters for the non-OF code path.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

