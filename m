Return-Path: <netdev+bounces-33947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9EE7A0CA6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A482818CC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EC266B5;
	Thu, 14 Sep 2023 18:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CAFBE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:21:40 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929A1FFB
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:21:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b44247123so1020545a91.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715699; x=1695320499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+5CeJXazo2QRDMUU4sovotB5k9105A3ZHct2kq21uM=;
        b=SakGLrzAO6XvwKJCkPNz0ZZROPsXKqapgHopa+ysh4/MD91FfOD60bDCqyW0AgciPn
         Bv20g3qbrtwby29FsX3zOvVP/xMtwTt8Wp0Cf4yKdQdYp5LJQHJ7k6y+3dWPaveEwOux
         YZXLQ0/1lG9s8cil30UZRtJLQ7tCOtTIRwmhv8zpwVD4m6vsL+y6DHl4awqtMtiJh03i
         CBKdqIKuOxFymQwWGnztmKQ0dFYSEeZkfLVV0Tt+RzjBbqyJ7WnyqnpjQNhsD5MVjzjM
         83kFgOj3OsXbo98lHDUUkf0RnXODjtTyXPNWZFWhSIjfgQIshPWaVKj2CNCODt5lIFbK
         2S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715699; x=1695320499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+5CeJXazo2QRDMUU4sovotB5k9105A3ZHct2kq21uM=;
        b=iMJKjlFD6DMJBXhRgDzpPehNQeICh7LanNJczh8tu4j5qR+ODWaM5Ut68S4kMW6c6J
         kcn7w0yfD8wSxHMhrY6aSKFMV+sL7QL0gsSQ+HMEAqND+nm9/Jjn/zB5QdMTJoaqhL4k
         ZzghgOkXDvk14G0ju3J9eX6eD/vNhFgCixVmIW/dxzXQqZ0JMNJtkJCQK4HWrjG1e0Ks
         tJ0geyIvn06fntpDtw7H4YdVEn6Fd5r155sdVeHd+9rWn7V/9haaT2w57YyMBwl0i7lS
         WN+ZbWXOeN65R3IBi5m/5HKI72UpWU9CZCs9f8bts5PXdOAAcuxCZOnhNLZT3+oY1HKL
         56fQ==
X-Gm-Message-State: AOJu0YyjFImKuFyIBo/4n9betsbutM6dIjMwsdKIImbKsjhxe3YvhLJm
	DsSlm8V0zOKmYGHYmkGYOu8=
X-Google-Smtp-Source: AGHT+IGEz+uMK06qpofRCIQ585LlzQsSUcgrE9k0G+ICCId+ds5FPCkucJX94TLLsyq6X1lbh/9VhA==
X-Received: by 2002:a17:90b:38c4:b0:270:b961:1c3d with SMTP id nn4-20020a17090b38c400b00270b9611c3dmr5788617pjb.22.1694715698790;
        Thu, 14 Sep 2023 11:21:38 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b2-20020a17090a990200b0027463d5b862sm1637968pjp.49.2023.09.14.11.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:21:37 -0700 (PDT)
Message-ID: <87028f85-bdc7-0ce6-ed4c-cfc6b8322fe4@gmail.com>
Date: Thu, 14 Sep 2023 11:21:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
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
 <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> phy_stop() calls phy_process_state_change() while holding the phydev
> lock, so also arrange for phy_state_machine() to do the same, so that
> this function is called with consistent locking.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


