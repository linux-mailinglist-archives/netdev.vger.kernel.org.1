Return-Path: <netdev+bounces-39302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9897BEBB0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF8F28198D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DEA1F5E4;
	Mon,  9 Oct 2023 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnUSSg5x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005B2F4E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:36:21 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A592
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:36:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692779f583fso3358850b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883779; x=1697488579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUzqH4BPfnK35CEnN9FodUclrPRYLAez4yl427Wn6/k=;
        b=fnUSSg5xXIE2A6/W1vTo1rnBufyhObeDKrM4PpZFOqFlqL8lIFCh8m6loBfN3j9sP1
         uGQvDvX1oVijNCioVloYL+xIM4iKzEQQIDrR0cTvHLvPto1TJHNXIIUJkKDTdh7vmMwY
         UqMZhE0HRkWabyNXltbgxkzwp4WFZpSICS86zIDW9csenOloiPb+B+0Q5zEZuBm10sX5
         Gyp8uzOb7+MkGa5h1iWJr70Hi32nrCA2ajhDIISSqGrjnBlIlVlB2p0BvfT7CMD5eTj/
         bg4k4TIMbZ9XUe8DyuT/rYlfL8X3bYhFeJbIo7El/rYyX6oQk+BVZUYdD5To5Iz4QrJr
         aRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883779; x=1697488579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUzqH4BPfnK35CEnN9FodUclrPRYLAez4yl427Wn6/k=;
        b=d33X4VnP4xLo7J/O7Ld1XKvbmudwJN5fmqT6q7fdRbZPDGwSMUWvywIGUsn1p/gA/I
         GyYCF4TGosrOY3zCURkteZPeR1A7E2g6LTYhpQnHq+5pCbWvI8Ba7yZxi6iXBYtgk3hm
         SzF+hvD4nNcf8h9yE2QuX/sFPnr9dr0h5NeWDBT1NyrjkhSUYQDFmiuLczQHd4hA3lL5
         dvypfcJ41/y0Ic2mfK6Q7VYrSsZluz77xOJn4GwjlkVvl8cDTrW/800yhUL0qi0ZDrDS
         HNeXFogAHu5+FBzQAQ3b0EKwOxEveG15L9AgLaQphtyb6f7bUZ34PWy3B3rdN3ycStmB
         jBIA==
X-Gm-Message-State: AOJu0YwwBeWjUQspKCcrRu2msWU6/XADcvO1V4G7cVeelw5r+31Qw5cz
	7h2/2zZcfLORUtwgozQPVZWxfahFlM4=
X-Google-Smtp-Source: AGHT+IF6Pk0Em0Zi96P/1CIe7VA6V4rKiYQU4qHPLQc0Y4YMaeIxT97OSsUbqiGemHK/0AudXxataQ==
X-Received: by 2002:a05:6a21:a5a5:b0:153:a461:d96e with SMTP id gd37-20020a056a21a5a500b00153a461d96emr18132716pzc.47.1696883779594;
        Mon, 09 Oct 2023 13:36:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gu19-20020a056a004e5300b0068fbad48817sm6833974pfb.123.2023.10.09.13.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:36:19 -0700 (PDT)
Message-ID: <fa12e9b7-1475-43f8-8f18-9b426ac941c8@gmail.com>
Date: Mon, 9 Oct 2023 13:36:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: dsa: vsc73xx: add phylink capabilities
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
 <E1qpnft-009Ncg-3o@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qpnft-009Ncg-3o@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 03:39, Russell King (Oracle) wrote:
> Add phylink capabilities for vsc73xx. Although this switch driver does
> populates the .adjust_link method, dsa_slave_phy_setup() will still be
> used to create phylink instances for the LAN ports, although phylink
> won't be used for shared links.
> 
> There are two different classes of switch - 5+1 and 8 port. The 5+1
> port switches uses port indicies 0-4 for the user interfaces and 6 for
> the CPU port. The 8 port is confusing - some comments in the driver
> imply that port index 7 is used, but the driver actually still uses 6,
> so that is what we go with. Also, there appear to be no DTs in the
> kernel tree that are using the 8 port variety.
> 
> It also looks like port 5 is always skipped.
> 
> The switch supports 10M, 100M and 1G speeds. It is not clear whether
> all these speeds are supported on the CPU interface. It also looks like
> symmetric pause is supported, whether asymmetric pause is as well is
> unclear. However, it looks like the pause configuration is entirely
> static, and doesn't depend on negotiation results.
> 
> So, let's do the best effort we can based on the information found in
> the driver when creating vsc73xx_phylink_get_caps().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


