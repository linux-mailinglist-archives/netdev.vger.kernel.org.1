Return-Path: <netdev+bounces-44863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F67DA260
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680A9B2147F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45D3FB2F;
	Fri, 27 Oct 2023 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmhlaWbN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223C3D999
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:23:19 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB6129;
	Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2021946a12.3;
        Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441796; x=1699046596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Q8nuDM9k/u/LkEVyOR5WiT5bOMm5Q+OB4cIkeRtaU=;
        b=cmhlaWbN1TGM8ws9BFqH5zPVIf7v18ASDhEzHwt7V41QZxn+4AjnATuM/ebrDhwob6
         R76iOK4rJSa82QRaPnrhH2duIPcc/1A0RcX7IKInGXWwYmvOkiMda73BPV76waQILJdL
         +zqe2/IMTqvIGzQ+vjIzNvS7nIwU/NJlNuSasZ9vvLFVJ2aZ35tGake3DOi0WnAdZ9wE
         cRNo/20r3aLJEJyoOM0tlcYnNiXwT+hvauEYXz/rAy5xucUMXPjlBOagAXGcWbf5N1MM
         Wr/Cgl4mFGP8ruSfFOOXaLoatwqVtgPNeUsNdQdD5zMgg3LQRP11c4nzCfhTej6G3+qq
         x19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441796; x=1699046596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Q8nuDM9k/u/LkEVyOR5WiT5bOMm5Q+OB4cIkeRtaU=;
        b=oGJltj/dtRtw5faMumG1coWGEfUViIj5K5WqDrvuSFdKH4dBp7E9sZugTgWyzy3o2k
         rqUPDcJJQT4BcWuXL7Lkkdi8QUfAHOAmc1B74AsCOLhpVwYHlLhWZyDiRr1J+MRETnJi
         6cY08Zjck/iiAt/imglO/ygcGRZOXJ4AL1ebknDrwrt2f3FJvbS4+Y8EJcR+KkxKqXL1
         vjoigxZV5Zck16L4v7pqxdKoPxkbV+ogW+cyvl14mLyrmaZ0SrxgUwOtXIRyuuhnvKUR
         QWRh7xsJ+6vtkpP0Kac1KMZ58rPVJy0Em0vD1gJSY023sD5YRcjbpLshGJNsfrStQN90
         Kz7w==
X-Gm-Message-State: AOJu0YxHzgNLTIiXSlvYQ1NOKwM2CNqQsq7+1FCdUpCRjdZ6WP/yhuUU
	z0gBv2stbWDqh0q4VvlzMtU=
X-Google-Smtp-Source: AGHT+IHOo+0S/yy4dCT4+non5a027LK29puQBNN6VplAOiPcx9hoopgfc8N7HSD0Q+p+5xmzhH/UxQ==
X-Received: by 2002:a17:90b:103:b0:27d:9b67:7fa6 with SMTP id p3-20020a17090b010300b0027d9b677fa6mr3543660pjz.3.1698441796212;
        Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p1-20020a17090a0e4100b0027768cd88d7sm5171675pja.1.2023.10.27.14.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:23:15 -0700 (PDT)
Message-ID: <95f324af-88de-4692-966f-588287305e09@gmail.com>
Date: Fri, 27 Oct 2023 14:23:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You would want your subject to be:

net: dsa: tag_rtl4_a: Bump min packet size

On 10/27/23 13:21, Linus Walleij wrote:
> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.
> 
> It turns out that sometimes, but not always, small packets are
> dropped by the switch for no reason.

And we are positive that the Ethernet MAC is also properly padding 
frames before having them ingress the switch?

> 
> If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> (1518 bytes) everything starts working fine.

That is quite unprecedented, either the switch is very bogus or there is 
something else we do not fully understand...
-- 
Florian


