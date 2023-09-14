Return-Path: <netdev+bounces-33950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060447A0CAF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBAB20AEA
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947D266B8;
	Thu, 14 Sep 2023 18:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A6FBE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:22:35 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8801FD5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2747b49cac4so636741a91.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715755; x=1695320555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sihlz3OCtaLL46xr27YbwP72t3ckO0UHMLS6yXuKjUA=;
        b=hWdN+3txJzQbZJK7i6X5pccdQVPrdK1zIWWDoaYjycyrQS5POWb/LI6Ir2ksxavajU
         FOimkdaQ59iqPAp85wEzeOHZt4jX/oiFzXwyizGUdizJL0xAdD4IlrQeJveSLGb5Smb6
         NwhdWCFk82uENBOW6+7Z5JV0CcPlncKRvd3rNP6flXZFXZRAalXC93EbWn+diugprwNf
         EjfUp1PijoKFP4GXS0XEOdWaUDNbMD70I8crG9e2MShtzJ1DrWI9U7vv4NJ3SvT+GDWw
         jA6x9c/myaLp6ij0d3I8e9N8wWN3dvQiIHfa/UkLiVg6LFLwNVp4ky/onrrXMymW6r8T
         82hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715755; x=1695320555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sihlz3OCtaLL46xr27YbwP72t3ckO0UHMLS6yXuKjUA=;
        b=Flq5M0qMJVfc//r8VHsTFPmxZDp26W3adTwJcsSsxcv6A7IIZcJSN8xVYD6nrriYDE
         Z9BKT/ZkwsGIu00nQGzM/PX6lU22TLEBs7F0ScHO0foAS7a8Sy/acy0jWobvaz50B3SJ
         TamiTLpJpnAbF8N8tEhR1eQWMOSadDCIhjXgsOjyp6yR/s0eEpVpYCTq6R5OHTj0cYQG
         H3YoaH7VGerKaB7ewLn7b7csYI4AJljMwk7NZOucD2c8p4cWCrjDx9+a3Z8pKgjTWarv
         Dd9V4Dd2HJ/SxH4W/SDRSOkYQ3AGxcjGYWBnPGp+kSe2UoHpHwRX+NDa1SZt8lEI9Lob
         FGOQ==
X-Gm-Message-State: AOJu0YxvHhncbB8OWMdARMuLKZWJo7x9OrufRWVSKAp6g32lRVrUTTFK
	WKrxgory+0O8vkCUkOfDgwE=
X-Google-Smtp-Source: AGHT+IF3jJJjBT2kaNwXxl/MjDPELcmuxysQv/FobPWV1DzIE4hIzFnPFDpOp2mFNe06nBqBqCwf7A==
X-Received: by 2002:a17:90a:7bc4:b0:26b:4e40:7be8 with SMTP id d4-20020a17090a7bc400b0026b4e407be8mr6071116pjl.12.1694715755042;
        Thu, 14 Sep 2023 11:22:35 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u11-20020a17090ae00b00b00264044cca0fsm4177860pjy.1.2023.09.14.11.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:22:34 -0700 (PDT)
Message-ID: <e683d959-e743-cee5-176f-fd4b0c79b3b7@gmail.com>
Date: Thu, 14 Sep 2023 11:22:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 4/7] net: phy: move phy_suspend() to end of
 phy_state_machine()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jijie Shao <shaojijie@huawei.com>, lanhao@huawei.com,
 liuyonglong@huawei.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
 wangjie125@huawei.com, wangpeiyang1@huawei.com
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
 <E1qgoNf-007a4O-47@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNf-007a4O-47@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> Move the call to phy_suspend() to the end of phy_state_machine() after
> we release the lock so that we can combine the locked areas.
> phy_suspend() can not be called while holding phydev->lock as it has
> caused deadlocks in the past.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


