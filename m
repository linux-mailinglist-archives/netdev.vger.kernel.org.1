Return-Path: <netdev+bounces-33951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE27A0CB3
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4338DB209D5
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4226E1C;
	Thu, 14 Sep 2023 18:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355DFBE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:22:54 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059D1FD5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf55a81eeaso10195975ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715774; x=1695320574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+QEr7Bk4Kv/i3+AJi30w1CQ/rrzwoHOKhKyt7TpsVI=;
        b=VzCj+zSAhu0L1fUIhEs1yG3F2M0TworKFgJ7T5hc9CpwYxMvH8fLY46mmNpk2WlYaM
         yAenBjLPDe+FizFw2iRWUi2VHPu6FOH2XFy6LZlr0X0E7eOrfaHlVUMHpC20UU0qZwaC
         CFLoYRq6JrHCATPJ57F+KQ8goCvJusRytvDpxbtU6zA+gh/Ya3q3DMsT5HfrEao2ilZI
         5X4lSqGhZx/EjAAw5qZ/gHffSn+i55zIaxAlrgOUHivCRlgnwgAUwrVtyjqleHLKW65n
         76lMpg1T1SppBpoHhA2qmlDuUP33UT51DkYvSFCPA8GCTUZQRGwf0EXVwH/Cq25fiBU6
         O5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715774; x=1695320574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+QEr7Bk4Kv/i3+AJi30w1CQ/rrzwoHOKhKyt7TpsVI=;
        b=S4Dzo/DJeOFRoUukp7Hz3dYB6j/JvhXoOXdAgKs2n44tj5nXqwAbKX5h8/wbbbe6ut
         LhWIo7dhuzhmyJEVsZA9ZzMyIhPdiOsHn8gPKiG5HwxdnQEphB2X7cva+21cC/aVnxds
         uWZ7tpdPnQ3ItOqV+RB9SOxarnqXRxIxQS4YG6eX7WoARMHYKJnYXw7pA45b6q10Opyn
         pMnV9y27sJ2A4ljj2ok1RGxBmE32mx7C71lKKYeHRVLZvEhhn8sVbUHVgMxnKIkBobt4
         SsbpmaTCGqKaV6CUyihs8Df29qh6MJ8RSKOJ6BnIxDkexTEJPFn+S3c9lpE7Q8RkQtF6
         beYw==
X-Gm-Message-State: AOJu0YzIJL8ca9C03lWN5PQMkfvva7iKnez16BvLxyt0FzM8M7uJXq0W
	yqPJ7gw0ZbzGHztwb6lrw4Y=
X-Google-Smtp-Source: AGHT+IE9G8LDesBNK3jj0hTEwPnMkheEYzgw3puw8XQZT/5Mngx8zUmnz8ZUZPsIjH/w51vt7ZIeVg==
X-Received: by 2002:a17:902:c412:b0:1bd:e5e7:4845 with SMTP id k18-20020a170902c41200b001bde5e74845mr8397342plk.26.1694715773771;
        Thu, 14 Sep 2023 11:22:53 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w13-20020a170902d3cd00b001c3c68747a3sm1878503plb.260.2023.09.14.11.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:22:51 -0700 (PDT)
Message-ID: <af478971-897c-e749-1614-071ebcdf791b@gmail.com>
Date: Thu, 14 Sep 2023 11:22:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 5/7] net: phy: move phy_state_machine()
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
 <E1qgoNk-007a4U-8r@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNk-007a4U-8r@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> Move phy_state_machine() before phy_stop() to avoid subsequent patches
> introducing forward references.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


