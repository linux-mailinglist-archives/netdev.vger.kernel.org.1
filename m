Return-Path: <netdev+bounces-39383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D618B7BEEFB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FF31C20B52
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166545F7B;
	Mon,  9 Oct 2023 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwOdykwl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91805374FC;
	Mon,  9 Oct 2023 23:14:16 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CB2D69;
	Mon,  9 Oct 2023 16:12:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77412b91c41so292090985a.1;
        Mon, 09 Oct 2023 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696893148; x=1697497948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkeLMCni1HNBHZQn/gCPq7DkQ4+vPia3kJm12hspXig=;
        b=NwOdykwl8kPTTDWmdnuF+rtCyb8ISYykAhIgGVLP48K44ZMUlWuNHUbwHWYTfO+Noi
         HcRVl/VLpvGIPbfqGl/aYLRSxFkTtlG0Le/E+GyqpcqUzqSkhmPPJkFfRUi+S1JpM2ht
         MJfy5tEOUp76pTWcEp1P4KQtaQmNFcJ3tu3PyOfUArC24r1JT22B5ruBPSZbF80n8hIH
         TYCcybY9469LmE9/Zif004pEgS+lIfYGISWlk8Phl7Or6c30ruAwkxhEIbyEbzQ6Nzr6
         pautwjD7vB2Bm1GEQB4TjAYfzVDi1wZ8P5Ken7xmmR/sCVlIz4bnW8muDoCbeJc9HfBI
         dxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893148; x=1697497948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkeLMCni1HNBHZQn/gCPq7DkQ4+vPia3kJm12hspXig=;
        b=xKHEWMpgNmiLfyvdfzdYDNrzfA2V7/lJY/nNRkQed0Xtc6PTTfdgjaJDCB2MkLNXdM
         c1F/d6j576ZQkZtBOyZafxglZm4PPpyP1P1bjOqoUoIQRYi4TeVNe9ex3UC9LUTQMCdh
         rLxzB0cEcF/YEw00tPMWAm8PYVXQuKx8R7gkaeUa/2nKwUx/Kr1TFipz45aDmTCKE/2K
         By/Cg11MV/+wVTBAZwCxeIWKpMidneUbFZdbJr/j9uoUVVe//dI1pIkH+8yeo6vllaP4
         j3kO8F8/o+HioJp38M9vUYPjnygFrmRMC/ppW+Ca1gdwyWxX8ErwEWvTYr7OITpldHJe
         Er8Q==
X-Gm-Message-State: AOJu0YzLB9gp7yu3ekCTn7EMe/pj0AJDMNY7p2q41i+LTcfF8nc4cPrr
	SDM3AOdgGxfaKEjCIv0sPf0=
X-Google-Smtp-Source: AGHT+IGc2aMNQFQLpboYasVnQkU2PgIhkqo9/vLEFaIJRpQrgURxpDUvwvg4Q6XR11bC+jPnJFPtkA==
X-Received: by 2002:a05:620a:51cb:b0:775:7be2:8c8 with SMTP id cx11-20020a05620a51cb00b007757be208c8mr15282943qkb.61.1696893148588;
        Mon, 09 Oct 2023 16:12:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s27-20020a05620a031b00b00767d572d651sm3874915qkm.87.2023.10.09.16.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:12:27 -0700 (PDT)
Message-ID: <cfce3793-3e96-4b3b-a9b5-9dbdb32725c2@gmail.com>
Date: Mon, 9 Oct 2023 16:12:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 15:54, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


