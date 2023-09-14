Return-Path: <netdev+bounces-33952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79DD7A0CFD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5441C20C6C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4031CF92;
	Thu, 14 Sep 2023 18:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C0C8F3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:39:12 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F1130F8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:39:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34deefc2016so4163765ab.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694716751; x=1695321551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OquP8k3LkxIN0MRYm4ENkGcmE30O47Ru8912r7wdgVA=;
        b=PDXzanUl1h20iET+NIPx8GtSvX0fzia+yNZUJE0H1dMAHUmd87cUa6imB+ziFplPSP
         5hX48/T+sU//bzQd00DuFXaLFsu2thhA30SjftRGKVNB/lZWa6PoPyyagY/WgbAshiVd
         D9lEugvflYlDLISVZTszfXP33IkUPhMRkPH5RaktMJHy9MF0ujgk6iOntsfvxVYneJC4
         JWXQwnSCdgQBCSn6xzgBlZGXOY7svb4R4WiTuDvjB50Tkiu3YnS0OFnGD//CAzEYCvjp
         gxStkyE0VFV+VsfHiz04zFtFTII95IHVL/FsNMesm4sH2N8gTixBbu8lTvi4fgSKQTzH
         lqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716751; x=1695321551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OquP8k3LkxIN0MRYm4ENkGcmE30O47Ru8912r7wdgVA=;
        b=WS6VhUk+pI1O1HzUN/aKYYNykEHzGc95r66ZnbDz/i1wdZ8XeZfT3nCWj27Mx5bmAp
         KETuipzj7rvLODSZwjZVd838LJpcnpfpI+gZkLLqdySqKRKVqxG32nDlQiY2U8x6WuXM
         nVhtC47UY7bOrd/oY6kwAgw+C+BbP1jfAe92dUbK1oowrc1HsLYS8+ijmDKiJ1qXn0Ei
         E4rt6MEMa+upXWLI82j0ZhyRmvrydlxY5chESrQdlq+40o74HYlm54Fvo8mGuC/4BioO
         u/yB+zpZWzOgC/hI2SyAhqbnIoNZswX9Qdi4oJK8skVSTIO58z+RBO5PxYM7gQUyMf1B
         X+3w==
X-Gm-Message-State: AOJu0Yy+JAgGzWQLkbkxX8FCb+kvkERllLvUBW7B2RWs2cPRTrYwp86q
	hhOEJ/qm4XXe/sbPGynqWPg=
X-Google-Smtp-Source: AGHT+IHmOO8W5cMDYtYc+bbjJaawgTokxfaq+GVUVcPWFoTP4FAFFgz0v9BadwUzKuU5m3uMywwvBA==
X-Received: by 2002:a05:6e02:1a0f:b0:34c:abcb:97e8 with SMTP id s15-20020a056e021a0f00b0034cabcb97e8mr7544475ild.24.1694716750993;
        Thu, 14 Sep 2023 11:39:10 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h2-20020a63b002000000b005777a911342sm1462843pgf.59.2023.09.14.11.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:39:10 -0700 (PDT)
Message-ID: <b1f54186-e5f3-77d1-0fe8-4a5fd58cc635@gmail.com>
Date: Thu, 14 Sep 2023 11:39:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 6/7] net: phy: split locked and unlocked section
 of phy_state_machine()
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
 <E1qgoNp-007a4a-Dt@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNp-007a4a-Dt@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> Split out the locked and unlocked sections of phy_state_machine() into
> two separate functions which can be called inside the phydev lock and
> outside the phydev lock as appropriate, thus allowing us to combine
> the locked regions in the caller of phy_state_machine() with the
> locked region inside phy_state_machine().
> 
> This avoids unnecessarily dropping the phydev lock which may allow
> races to occur.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


