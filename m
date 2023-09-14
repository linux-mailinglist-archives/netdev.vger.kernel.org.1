Return-Path: <netdev+bounces-33948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E27A0CAC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582CFB20961
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40511266C1;
	Thu, 14 Sep 2023 18:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCAFBE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:21:53 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE41BE5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:21:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso1034630b3a.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715712; x=1695320512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyaYyhq2IA/m1JcP9V+2Ublwv7+B6JmhovbhRduSgqc=;
        b=AWAv49XunaS1JJZM5KhkSepZ6mAJ6V3ECjzpswQTFQuogCmguYyEi0a9bMAMLlyl64
         0h7ml/0CG6x13MqaEgK7vS+DDabuGr9l0H7rGXXNzei8mS6K0cgJzrPc4BNaWqqkobrq
         TTWe9+n9Ev+83+AlHZ8pg0KXi9PecRH12hf979YRv1qUF3wqox2GG2774/3HNq2SamQ7
         UAt0ftXjbIjE8WRvP9Rv89PVt84bpzDeHAE05OINHlCtfwafQ6kEfE2n9niNk+Tp0NbU
         tB3ISsdWM66BfdvhlMvuY4ZQje8OH2YBjqX2FnHcHSAOPkzKQZVI4EMEUCsiKhnjwGUZ
         f4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715712; x=1695320512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyaYyhq2IA/m1JcP9V+2Ublwv7+B6JmhovbhRduSgqc=;
        b=B3xyqiaEM7wUIxHxofFnxyy17ueOGOfDDjexjP3e9txcWEizvNG1pxk9o7XDeME/We
         DxA3HfuY7Adq0AbXVYIcwXuJDOAa2xSLVgSYHVrM7oavVSzQMi3985LwpWUuBM9GDl8/
         sr+CQCjtRPmVPwiePeb11b5AcvYGPouGe7JE6YQNAm++xpqouKFfL74ZA/VZXKZ03gT2
         Yr9+e7yKjeozeqtC/5uaHv4O0+zH6yyfATn3VTHPB6qe9wnNszwJQ/ssYzc5qlUwsLYD
         p6livbQFDrlFa+NJuIaGEhsurwa1zghLVCqFKr8wLnw0r3R/0nIJYhpHt6IBMHSPwopl
         D4kQ==
X-Gm-Message-State: AOJu0YwjcAktooqxzX3DlX8IsIxo/WqwbzG5W6SsFKPf/EykyFYFfSqp
	2aQTiAF6i1cN9Ui+QYi8uKs=
X-Google-Smtp-Source: AGHT+IGIAf3ghFnhm1RRPn8AwoqvA7yZyxqMJqS3jYlKRABbdszvxc8w6TEbhEEpg6w2m4w9G3ZYDw==
X-Received: by 2002:a05:6a00:248d:b0:68b:bd56:c783 with SMTP id c13-20020a056a00248d00b0068bbd56c783mr7165138pfv.22.1694715711832;
        Thu, 14 Sep 2023 11:21:51 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s12-20020a62e70c000000b0068e4c5a4f3esm1627222pfh.71.2023.09.14.11.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:21:51 -0700 (PDT)
Message-ID: <df6916f3-8cd6-4201-aa7e-e37afed6932b@gmail.com>
Date: Thu, 14 Sep 2023 11:21:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 2/7] net: phy: call phy_error_precise() while
 holding the lock
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
 <E1qgoNU-007a4C-RJ@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNU-007a4C-RJ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> Move the locking out of phy_error_precise() and to its only call site,
> merging with the locked region that has already been taken.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


