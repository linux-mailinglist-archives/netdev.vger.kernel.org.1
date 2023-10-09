Return-Path: <netdev+bounces-39351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9B7BEE85
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9594E281A11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3B1F171;
	Mon,  9 Oct 2023 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcB4F6dV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6D1428B;
	Mon,  9 Oct 2023 22:53:26 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE09D;
	Mon,  9 Oct 2023 15:53:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7740c8509c8so288856285a.3;
        Mon, 09 Oct 2023 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696892004; x=1697496804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lekoIS635mFSnJFnmD86U+ekn9Tz8INaPVzVfkQ9DI8=;
        b=lcB4F6dVnE8vmlomKYhAD6xLlirfWAQlZGW5XaRFiitOHkB4S7AuNbxdP/mgSR6tvB
         lWtE5iEKX1vWBouR2/GtTNFtYs6nmgtvu8ot8NI7md5LpT/Iv5iN5x4MaHv4h+bAtd7E
         GAY1PPuOJQQCICPBJRCH0d51mzbJDip9Y/bIT3qIHMdCUeYZQwNkFa6OWvjRBsKrYsQu
         oJ3C03Cju910vdRsu6jX3JJQGPX/GAbnuJG4oi9/pkSW7TeW6W1I/vmbo3zrMKFuMzfg
         tJClLMc+8q1xqFHzjl4CpynbawOAdJaY9tEd2UvP94AsZvhpaYWMzTzDp1rxNf0NDwIX
         2CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892004; x=1697496804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lekoIS635mFSnJFnmD86U+ekn9Tz8INaPVzVfkQ9DI8=;
        b=tIboxvVzo9aAT/Ygbo9LrvURb5DLcgmR4lbNs6FJbbukI/XJMu213cGGq/k01WlclK
         /IMn4HvJVHkhyJsTd30LOZOyZlffGffnndKfROVwS6bW6eUw+i4BHDbpFE/2ivbWCBZy
         bkVXCtYfaptCv04xmttNCWGIpuw/wDR96JH54iaw4tzTwrxldinM4ipZ+mBjSU4eR31q
         75w2cxUHXS8QOg7DN8Q4ySPrnHO1gM4KIJIiiBV1DbmBG00oNprLB6/ad0SKO99rMXn7
         Fpknom+iRbO1/bcLc/9HWvE0HrG4lQ6mc7rgCJDgu7wPVVOHuXC5oQBB18NE00jv4djZ
         3k3w==
X-Gm-Message-State: AOJu0YzX5lbn9Z1lm/hYk+sLXIevnemA7qIAY/1AYvGY2S6IdBMPBZD5
	h1/08TSJB3VTpbCEn7sS1RI=
X-Google-Smtp-Source: AGHT+IF75Yik8/0jIF2RqOUNQnY9bTOnJl4g2qUttvz+Z+detbNQwh4rD+tWcbdphWbz63ONoho2GQ==
X-Received: by 2002:a05:620a:240f:b0:775:90b5:f91b with SMTP id d15-20020a05620a240f00b0077590b5f91bmr17404095qkn.3.1696892003976;
        Mon, 09 Oct 2023 15:53:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id os7-20020a05620a810700b00767e2668536sm3860565qkn.17.2023.10.09.15.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:53:23 -0700 (PDT)
Message-ID: <ff39e0fd-9745-4646-a0b5-91af7673cd45@gmail.com>
Date: Mon, 9 Oct 2023 15:53:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 15:43, Justin Stitt wrote:
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


