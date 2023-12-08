Return-Path: <netdev+bounces-55476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F480AFB4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A128F1C20B78
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8149F79;
	Fri,  8 Dec 2023 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHAcGViN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318C10CA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:36:44 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9d2f2b25aso1610680a34.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702075004; x=1702679804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjAI3MUxVIHO3UergoKMVlR3NyTOib7GSFuefs47gBM=;
        b=JHAcGViN7deS/U/aBeuRpPePy6jylmw/Sl3kRzWmtQDx1/0RJdyW9RnyqzjU5h3EfY
         u4ape24LM5kx5obEcl1aeocDj9wSGV/PqMp2PS/FhR2EpHvSqZJ5a0MkI783X7L3bjhT
         DTW+j4lOASsVW1wYQ+oulJ8Hkcg4/OopratQHGVImpvZtAEh3Re8T5bIfm+adEElQekd
         UpAv12aFGl1eNq5FKwphWLbjVLSvPtzP18KXoXPcbcyYrB+uv4toaV6SdLH/9/kHvp0q
         lV+X+G0/ma0xlEVwf6A5CdvXVxinZYsJFbWeutjzCH5M4hG08bGsca9/0zXz6hPQ74JX
         eTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075004; x=1702679804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjAI3MUxVIHO3UergoKMVlR3NyTOib7GSFuefs47gBM=;
        b=Qn70CSAVKhH5ufKckoQeWQjLtUG5l0pkmHs1het/WEYQ5kGESusOV/rSU2KyWc3IlI
         +GASkcXqPf079n8PTUqAmw69zFghdfPFQUqLKeIk1xTC1Ox5eH7mcTsNFPFfkWkyOXKy
         a7af4Lx71DMyaOwmY4RjBBkK6O89PFG5z5Y/4xGzOwiUuIPzi5CdtdK+xH9wQ23f4Sza
         eEj+RLaJMNYa/xXM2tCL491zGO/shZsXMVw573oePhUUZBelO67wPs2iI4RzsBjPCYPW
         ++2YZ9VEOXKJhWcwsIeDJ8r5hDY94+9BjQzaS3W4uHymigv30BscS+GagmRE2t99ysJJ
         FFRQ==
X-Gm-Message-State: AOJu0YwgR4oJ4QUKVIVAk+ZgTxuUOWhNrT0CzWYKNRWOYg4x7ooCPvbK
	MeTzOcTPbd/NTTx5uqFkV2U=
X-Google-Smtp-Source: AGHT+IEbiR6KH2VI3gIqCfT9q1lpZ0sb16BhU4VK4wadZCf/u0qioFHic6Kz0sQ+IACfgt3UAftWPQ==
X-Received: by 2002:a05:6870:961d:b0:1fb:75b:99b0 with SMTP id d29-20020a056870961d00b001fb075b99b0mr880887oaq.95.1702075004043;
        Fri, 08 Dec 2023 14:36:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f21-20020a0caa95000000b0067a17c8696esm1146526qvb.82.2023.12.08.14.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:36:43 -0800 (PST)
Message-ID: <f4e08518-290d-492f-89ea-31fea9974abe@gmail.com>
Date: Fri, 8 Dec 2023 14:36:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Madhuri Sripada <madhuri.sripada@microchip.com>,
 Marcin Wojtas <mw@semihalf.com>, Linus Walleij <linus.walleij@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231208193518.2018114-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 11:35, Vladimir Oltean wrote:
> There are people who are trying to push the ds->user_mii_bus feature
> past its sell-by date. I think part of the problem is the fact that the
> documentation presents it as this great functionality.
> 
> Adapt it to 2023, where we have phy-handle to render it useless, at
> least with OF.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   Documentation/networking/dsa/dsa.rst | 36 ++++++++++++++++++++++------
>   1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
> index 676c92136a0e..2cd91358421e 100644
> --- a/Documentation/networking/dsa/dsa.rst
> +++ b/Documentation/networking/dsa/dsa.rst
> @@ -397,19 +397,41 @@ perspective::
>   User MDIO bus
>   -------------
>   
> -In order to be able to read to/from a switch PHY built into it, DSA creates an
> -user MDIO bus which allows a specific switch driver to divert and intercept
> -MDIO reads/writes towards specific PHY addresses. In most MDIO-connected
> -switches, these functions would utilize direct or indirect PHY addressing mode
> -to return standard MII registers from the switch builtin PHYs, allowing the PHY
> -library and/or to return link status, link partner pages, auto-negotiation
> -results, etc.
> +The framework creates an MDIO bus for user ports (``ds->user_mii_bus``) when
> +both methods ``ds->ops->phy_read()`` and ``ds->ops->phy_write()`` are present.
> +However, this pointer may also be populated by the switch driver during the
> +``ds->ops->setup()`` method, with an MDIO bus managed by the driver.
> +
> +Its role is to permit user ports to connect to a PHY (usually internal) when
> +the more general ``phy-handle`` property is unavailable (either because the
> +MDIO bus is missing from the OF description, or because probing uses
> +``platform_data``).
> +
> +In most MDIO-connected switches, these functions would utilize direct or
> +indirect PHY addressing mode to return standard MII registers from the switch
> +builtin PHYs, allowing the PHY library and/or to return link status, link
> +partner pages, auto-negotiation results, etc.

The "and/or" did not read really well with the reset of the sentence, 
maybe just drop those two words?

>   
>   For Ethernet switches which have both external and internal MDIO buses, the
>   user MII bus can be utilized to mux/demux MDIO reads and writes towards either
>   internal or external MDIO devices this switch might be connected to: internal
>   PHYs, external PHYs, or even external switches.
>   
> +When using OF, the ``ds->user_mii_bus`` can be seen as a legacy feature, rather
> +than core functionality. Since 2014, the DSA OF bindings support the
> +``phy-handle`` property, which is a universal mechanism to reference a PHY,
> +be it internal or external.
> +
> +New switch drivers are encouraged to require the more universal ``phy-handle``
> +property even for user ports with internal PHYs. This allows device trees to
> +interoperate with simpler variants of the drivers such as those from U-Boot,
> +which do not have the (redundant) fallback logic for ``ds->user_mii_bus``.
> +
> +The only use case for ``ds->user_mii_bus`` in new drivers would be for probing
> +on non-OF through ``platform_data``. In the distant future where this will be
> +possible through software nodes, there will be no need for ``ds->user_mii_bus``
> +in new drivers at all.

That works for me, with the above addressed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


