Return-Path: <netdev+bounces-39300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEAA7BEBAE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7EB1C20A09
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B217753;
	Mon,  9 Oct 2023 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbR0y4sf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD872F4E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:35:50 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FE79E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:35:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so4039802b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883748; x=1697488548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAQ/UCvg/yXkYSwtCarMSPcxjAwV0JKInYYgcwieGUY=;
        b=DbR0y4sfsCp215GmS1A5aeJC5gIZ29Qoi+f90beT5atddk4b25fifdzR42KTiQn2tO
         b17Su194lrybRplw9+SMYduHF5EYs63Gsf6wiH6gwb/Z+bm8CVYX92S/KKJDfUpy2sly
         Irp8Yh6G+waS+rT9ctS6vgeBAqacGMF/bOa+n6F631AKtoaaEhPdn1u1UuXM0NvtM4iy
         qWfkZ/JdWDe8/fWLSNqCZeEcyLtlsIKyRNmExEf5XGFfdhQb7E1XfyvVjP8DA6FVt+xp
         sQ2ctjU0ho8/tyJVdwo6lTZqrY44HZjC6h2x9GEwHCraMCmzvY4kn03ru/6eJM1mTcLk
         QUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883748; x=1697488548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAQ/UCvg/yXkYSwtCarMSPcxjAwV0JKInYYgcwieGUY=;
        b=EXa1BKW7kozi5lMoXq+eZEFlrhIj1Gpq8I63Y4OL5o93DR+KNI6ZDuyln6roSCiHTZ
         KtxSiwgZmomoMBZXKREgVps7DaVVVtqwp7ezvqw9OGsnPLsDWSxirSUTZNxqfwXdLAl3
         rtDwLhoRxbPehlUKUOSYe692Lj3dylWIRY4D3tp30zzhTviQI+pVebXC4hV6lwV5op/K
         Fk268WP0P0uzQ85Xropyei08T8WgqSMdx6zYcI6+TNPOHz87a0jtX9qL6wLtMiyPFop9
         vwljMNhO+6jdkFEte7x96WGxoS1UlxTzcThkOkiuUffsGP6UKngtp2TvrypeN5dU0XTy
         QVkA==
X-Gm-Message-State: AOJu0Ywte5+nVnFRQmMKuGfab0usxhPzpT/7/MxtC/7MHloSjB5PEz42
	uJBJSTHICyQZ04UT/81bUyw=
X-Google-Smtp-Source: AGHT+IGLvn+LKC5cbQqanznqVZ1ng5sJbf5NXdLuSsIJnmiVg/rqmD9mwwtATjmRXn6249NC/y/hLg==
X-Received: by 2002:a05:6a20:4420:b0:153:dff0:c998 with SMTP id ce32-20020a056a20442000b00153dff0c998mr21524092pzb.6.1696883748206;
        Mon, 09 Oct 2023 13:35:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gu19-20020a056a004e5300b0068fbad48817sm6833974pfb.123.2023.10.09.13.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:35:47 -0700 (PDT)
Message-ID: <7f47166b-6880-4e5f-ad00-5bd5e58ee8eb@gmail.com>
Date: Mon, 9 Oct 2023 13:35:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: dsa_loop: add phylink capabilities
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
 <E1qpnfy-009Ncm-9D@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qpnfy-009Ncm-9D@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 03:39, Russell King (Oracle) wrote:
> Add phylink capabilities for dsa_loop, which I believe being a software
> construct means that it supports essentially all interface types and
> all speeds.

That is right!

> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


