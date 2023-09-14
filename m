Return-Path: <netdev+bounces-33953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E550E7A0D1A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89DEB20B0B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF402110E;
	Thu, 14 Sep 2023 18:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4281CF92
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:39:26 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109244209
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:39:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c4194f769fso6380925ad.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694716764; x=1695321564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItLTmVYTLz/L5hKnYjQqEkXStBVo7QUsg2RZyEWd3Ec=;
        b=efWtZrkKO1dq686uKMB2xYjflIw8rUUokKfBSiIj4bh/PiJOK3svFUAJaVLb0tcMRp
         mxuFliiVfddzlZ83YAhPYYrOrN70EYUkeqUU9K8T89YLCfgNP8cvMMig6qvcRmsQE4ec
         OUYtyjTirOb5j2yDV5zunvTRsfcDuIftLvNd+0yTSApLm2YbzsnOY2GqySFFXcjMQbxu
         QOzeZ8t1VYlfnZyiKOp7A82hfpQAUZqe0toe7WmsdR/WG10hCcaOCwIPllq+iCWQOhFi
         404SMddkAiIy/OjqOxAH4xXP6BrXaj5C+pdU6Rm3d78NRUuurLWTru0zu7dxzp1BilPY
         pfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716764; x=1695321564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItLTmVYTLz/L5hKnYjQqEkXStBVo7QUsg2RZyEWd3Ec=;
        b=L+dPNijk+Ss6D2Y7zH9Oj8df4y6bZGcikPhQkNhShys48c0ksyxCGSyF89Tki+i/1V
         CFJsQCyO+IYrZeOddI5BGGtSDaaJ4k1G0d7EGQ1+x2XoSG9gKOd3dAADX/4/TypWdluN
         Vt+aBXymxx1TCFuk5VpUgBaheGUh7qSRCO5vuHYEFC5Ro6RCgiN7OgHuJ7VLvo/pA8Bq
         Bq1yL9QxfQ/SrN9B/UmidOilvTUSApmrgDCVtXoRZyQmp2O9PFHMeTyeqEvbkUYUk5hA
         4/RBFsHOOu9jdncfzg5lJdJYBzynjOTAmmg7+WtOqenP9nmUQNKP8dtcr2ZbR7plxfcv
         hkRQ==
X-Gm-Message-State: AOJu0YzLVVd0JFZRiDeEKieA+wImaxYUvZW8SyRajXrR5nIf2cl1vYWe
	W9byvcBTuSrjIjUj/NoAXLI=
X-Google-Smtp-Source: AGHT+IGSAVR18gP0tRt1UC2RvdPns5RT77kh5Mx8XScLRRcW3WJyjgudEcGA1baQcckR2weBwPkGVw==
X-Received: by 2002:a17:903:2284:b0:1bc:8fca:9d59 with SMTP id b4-20020a170903228400b001bc8fca9d59mr7354255plh.29.1694716764379;
        Thu, 14 Sep 2023 11:39:24 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b001b9dadf8bd2sm1931810plk.190.2023.09.14.11.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:39:23 -0700 (PDT)
Message-ID: <efbf483a-69fc-7918-74d7-52bb173ea44f@gmail.com>
Date: Thu, 14 Sep 2023 11:39:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 7/7] net: phy: convert phy_stop() to use split
 state machine
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
 <E1qgoNu-007a4g-Ha@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNu-007a4g-Ha@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:36, Russell King (Oracle) wrote:
> Convert phy_stop() to use the new locked-section and unlocked-section
> parts of the PHY state machine.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


