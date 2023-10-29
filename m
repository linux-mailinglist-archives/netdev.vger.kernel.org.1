Return-Path: <netdev+bounces-45031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B17DAA3F
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 02:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83701C20937
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 00:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC0191;
	Sun, 29 Oct 2023 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdAYS7Ch"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119918F
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 00:06:45 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F560CF
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 17:06:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ec9a79bdso2322129b6e.3
        for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698538004; x=1699142804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUkEh3tHkfI0S9GOoC3gSJqNUbeBd7p0TPf4wZ8XTE0=;
        b=EdAYS7ChJ4UXb4jeF9HAG46+crHYEXNNOyZn43mMZ9uD68dmAikCj6NxnEMTWkQCG6
         DTj3gorhzJjX3g/xTwtbpebdmQupqqw+enSVHIXQ1Kqho+VNYOZlXQ1iaf/cRSLav9UV
         oENRwBv8PhBFbaEJa6cW+pcAomybPIQLj/3L1Ku2hP4ZXubiiIFl9Hk6FlApzNIpPKUw
         PN0vPzylCICRn5E3RXkc4aKnO5ryfwt+k6poBC72kyHjeNwZo8iD2hsaFst36XDENf2U
         XUdzIeVpH0d36x8VhmcP1MgBqnktlvsD53bZnZ4U9BMd7SW0u8KjCZi+vc1v4xj6TEo8
         /ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698538004; x=1699142804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkEh3tHkfI0S9GOoC3gSJqNUbeBd7p0TPf4wZ8XTE0=;
        b=WiQbQ+VlKLqKWm/0wgWL1tPMY1AiZENUpSod/UHilPHtXeNR9uEV2FmHXfM1aBuLky
         +fhjr1RN2dcNkRSqNb/+6J/3sI9uvUSUqMMkylmxTn62or7e9gABMHKSMcqZ1BB2CEaC
         ITiCJ0kIoXWDA77Okzs8v7NoDiqR5aHM2NQtHBIO61n9HeCro/adUQAkvW6K6JtveIqO
         baTy9xhP5sjn/oZw37uCeeAled0dca/KYWEYIzsOp/3EwVVFy5Gzxx4FXMQlDj+Sk6OP
         MNmeac5OmF2c0KJ5hWGDDxOb7qpGK2xrP+I9zLv/bW07zzqE0g6ou8CFeQWBZhx9k+rO
         wC5Q==
X-Gm-Message-State: AOJu0Yxj4RZQJsgWTA79p1y9zTmeegt8X8NJNHGIJhDD5+jY+6yJwp4U
	w5hP+WLt4xK1DYyet86vHeHWDuxYr1c=
X-Google-Smtp-Source: AGHT+IEa+G78wXtuEtKH/W61LGQQBeRe6JF38ZXbitt/d2YrVG2Bp+7i3GnRZOL+44jBsHseI0TEMg==
X-Received: by 2002:a05:6808:f8e:b0:3a7:2690:94e0 with SMTP id o14-20020a0568080f8e00b003a7269094e0mr8642762oiw.4.1698538003813;
        Sat, 28 Oct 2023 17:06:43 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n4-20020a056a00212400b0068883728c16sm3525954pfj.144.2023.10.28.17.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 17:06:42 -0700 (PDT)
Message-ID: <fbb52a88-bd73-4843-92f8-6c16564ca496@gmail.com>
Date: Sat, 28 Oct 2023 17:06:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 1/2] net: phy: fill in missing
 MODULE_DESCRIPTION()s
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20231028184458.99448-1-andrew@lunn.ch>
 <20231028184458.99448-2-andrew@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231028184458.99448-2-andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/2023 11:44 AM, Andrew Lunn wrote:
> W=1 builds now warn if a module is built without a
> MODULE_DESCRIPTION(). Fill them in based on the Kconfig text, or
> similar.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

