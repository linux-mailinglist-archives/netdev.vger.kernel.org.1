Return-Path: <netdev+bounces-42347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D1D7CE637
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5F3281C46
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873041216;
	Wed, 18 Oct 2023 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cohib1ML"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45314F9C4;
	Wed, 18 Oct 2023 18:21:00 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2648118;
	Wed, 18 Oct 2023 11:20:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77421a47db6so437411785a.0;
        Wed, 18 Oct 2023 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697653258; x=1698258058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsI5TzzsSuBq8l9ygfi84roa8xAAGSMzTwOJm7U4bAI=;
        b=cohib1MLIjlV4LIq0GsyrecSuob2+A+qmc5vM4fSntKPVhUmeWcaKTH/vL/FMfYyLe
         h5MSWbZAFVMsP4N8IjJdjHitrxDvxbluYeC3Sls/zmLJ29V0ovQppPAgtNxuT+GwE9hx
         KK9ZmJz/vP3022/u6ZJqDIx2VV3+zS0cMtTwknG7awZqB7imwsMhpJht4rM8DS0GX9v6
         G0TV+AzIGrECQvMzedz0Ks0I1VzICkdQtnuoFnbtUZbNOHiuWTNHAhZQ2sAhAvKTVkBc
         iQho6Ne2VhKRTPiCVQdJnUUgtB7/cJFbXwk4nwy2/XNa/O07J5ASC2o09ZiQkKIAnReR
         3MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653258; x=1698258058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsI5TzzsSuBq8l9ygfi84roa8xAAGSMzTwOJm7U4bAI=;
        b=EiYlyKobHrK9hex8zEShAk4ImdqU5DgVO7qfsHv7pVlp18iKz5lmjuhUf3dRumZyjC
         kQvGnAShYzppe3rVGTCyjPepy2sshumvBzlhwiYWFD73FX4CArp54TTeJjhWtNoKicep
         W6l3pjtI6nKEt+NiXikfE50egEIvJNNTg5kHpnw1uUyU81Kr/gXkqzqNnkPUEA1VcY7A
         Nl6LMT2VCdnTPXhzkDWo9tlvBlONoVI43pyt74keSBkCoO36D9nUPWMGuQ2zHj5j9bRU
         WjzJ9gNgTmO6Y73Nnum63HACm1XuCm2pNNc3jFfrQ/i0tjoZm5Vyc467CssBFubd55Pn
         s0Vg==
X-Gm-Message-State: AOJu0Yyinzxfs2s5F68goAHHVF+Q9XsWGdakorUwf2SLmIivPFEhQgFK
	e5/5ezWOGhf2xTCCkbvB+Hc=
X-Google-Smtp-Source: AGHT+IGmSKfv0+hfyzKpR5QFzcUf5BnweaeZm9C6z+mxT3+76cgWBI2iPN5bWuNipXOpJeVnn3rDyQ==
X-Received: by 2002:a05:620a:2993:b0:778:9813:6c98 with SMTP id r19-20020a05620a299300b0077898136c98mr1663751qkp.35.1697653257740;
        Wed, 18 Oct 2023 11:20:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id vu19-20020a05620a561300b0076f124abe4dsm142147qkn.77.2023.10.18.11.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:20:57 -0700 (PDT)
Message-ID: <f4cfb974-42c6-492c-80fd-85bbeaada9d1@gmail.com>
Date: Wed, 18 Oct 2023 11:20:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/9] net: dsa: microchip: ksz9477: Add Wake on
 Magic Packet support
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20231018113913.3629151-1-o.rempel@pengutronix.de>
 <20231018113913.3629151-6-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231018113913.3629151-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/18/23 04:39, Oleksij Rempel wrote:
> Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> driver.
> 
> Major changes include:
> 
> 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
>     Packet wake events alongside existing wake reasons.
> 
> 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
>     handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
>     program the switch's MAC address register accordingly when Magic
>     Packet wake-up is enabled. This change will prevent WAKE_MAGIC
>     activation if the related port has a different MAC address compared
>     to a MAC address already used by HSR or an already active WAKE_MAGIC
>     on another port.
> 
> 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
>     address changes on ports with active Wake on Magic Packet, as the
>     switch's MAC address register is utilized for this feature.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks good to me, just one suggestion below

[snip]

> +	if (pme_ctrl_old == pme_ctrl)
> +		return 0;
> +
> +	/* To keep reference count of MAC address, we should do this
> +	 * operation only on change of WOL settings.
> +	 */
> +	if (!(pme_ctrl_old & PME_WOL_MAGICPKT) &&
> +	    (pme_ctrl & PME_WOL_MAGICPKT)) {

Maybe use a temporary variable for that condition since you re-use it 
below in case you failed to perform the write of the pme_ctrl value. It 
would be more readable IMHO, something like:

	bool magicpkt_was_disabled = !(pme_ctrl_old & PME_WOL_MAGICPKT) && 
(pme_ctrl & PME_WOL_MAGICPKT));
-- 
Florian


