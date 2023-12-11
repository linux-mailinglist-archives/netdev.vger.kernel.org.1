Return-Path: <netdev+bounces-56090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71E80DCE4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD212819C8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402454BF7;
	Mon, 11 Dec 2023 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvTzVuMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B0AC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:24:26 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a8a745c43so39697986d6.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329866; x=1702934666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01qqu4MTDSdCA7sNJjLC+vjowznpskHJ5qIs6aMXgws=;
        b=XvTzVuMUNb5u8ZeevdJRrVkmdgUlsBFHzPX1jcDGJuu6TWao9oWrpwgLVyUKqbRIkU
         sN3acDGn6pef70Q2bdhpw++KYiaD9Dy//A+mezrL5jc9hUj6aNVN1jfouj7utv1N+kJl
         /o2Sh83xx4yQCqqCycXEcGLLwWcKfBz6xTLBA0qWRnLEdGlbzewusR0/rJ79g/HaUBH2
         DL0Cowi7DTue8bfuYW0Rhy7bxUzQTDFJZDyBgOu6tqru9JZOx4FCxrPBy/hu9iI9rUtP
         JxuPDOc5+CDt6eE/pR2HxFVyHAXLLvQcZ4wPojFcpIYMznWbYFtmCHkgTGkWBNlIAARQ
         Wh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329866; x=1702934666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01qqu4MTDSdCA7sNJjLC+vjowznpskHJ5qIs6aMXgws=;
        b=FyhYsFRbqkb5n06Hsd2swrUOzlsaP+BYYZzpYIysQ4pxi7hc6piU+kacSd35lISKcW
         3w5O2Pmd3I+vKJrLmMbdSg/MPpMxc3nr2cjYcrm+z+cPDg+/uCOkA0Q9EprQrsMMZjDr
         7kT2cJihMkMWTfWjkJeE1gMGQWjwvZqnpLikEjtRg/u2W4RZ5uhgfYrG5Bk5TQZnYPiZ
         VAduNFHEZ0F0yeyV4lnXK6cr1AkjpHFfpSDWLk+hPhdwq8UCJr0SZxlHdBkmMApr9xGx
         0NCx4pVEbZLIAJMaak5LO2HMuBLqnpwRYFjMhcmmx9OjBznZxNMpPUIpYEXXdCr6m8el
         5aRg==
X-Gm-Message-State: AOJu0YxP249n2Q8LFubILGRVSKEHeXzqHjGBOjZnCtp2ISoOVPjAfc2+
	3XRa5KlO+/8H5i+KZW42cTk=
X-Google-Smtp-Source: AGHT+IEQKBo8DPeEg2VuX5KGPwL60XF4efpiHPkilO9xQQ6x1sMBs5CKB0cKbubcuFcIbDZTiK50eQ==
X-Received: by 2002:a05:6214:1549:b0:67a:a2a2:3935 with SMTP id t9-20020a056214154900b0067aa2a23935mr6213544qvw.7.1702329865874;
        Mon, 11 Dec 2023 13:24:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pz8-20020ad45508000000b0067ad69c7276sm3610975qvb.75.2023.12.11.13.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:24:25 -0800 (PST)
Message-ID: <55682476-e21c-403c-b8c8-3739192e8343@gmail.com>
Date: Mon, 11 Dec 2023 13:24:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: Rename bogus RTL8368S
 variable
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/23 14:37, Linus Walleij wrote:
> Rename the register name to RTL8366RB instead of the bogus
> RTL8368S (internal product name?)
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


