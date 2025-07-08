Return-Path: <netdev+bounces-205049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0CBAFCFC8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7497ACAB7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F162E2654;
	Tue,  8 Jul 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bil/zHwh"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE52E3AE3
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989963; cv=none; b=fXneQG7NYfywkBGhcCDI+15a1FAzwnd/zNzXjZfNuliAXjiJ5IaZKRn+eM/aKoK5gInf2ZK24pSt2qwAbUDb+C4qEhJvHauwTKi9eS5b6Q4iC3VumLmxh3SbCYMgUax3tUvOQBQatE9ypG9qHcI/4EDA/IEpGX9Rko/dS6JBlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989963; c=relaxed/simple;
	bh=wPY/yyzJW7nbcjSwFdBt5veU6E2VaXCE28m/VP5uIH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDMTkyiBP3zl644vAKYh8W25mchnGaXqFd9k+CnyJXYwv+jAf+KT2jPxqsCoFyVAEvWFLZgXT9kdlpGj9I3YvB9ayQ00/D2msrG5NGf3Kq24jt1OzbpXof3W7qTHU4zfRqh6ugkiN8OfNhxzXEK3EENs0buHPeYaa5dDPlUPTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bil/zHwh; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751989949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uhx9BXxT8rXBhIAoQmEhwOeKsVhpxLRrEy92JVlPP3o=;
	b=Bil/zHwhflkK7tSDvVivZr/7+iaHLV4EvMv3bf8S12TVvPminP0uG9FlfSIt7vqCBv8UPl
	/TbentHPF8gahCQ3FXZolXdn0Og328TVIDZoMcUS1KzJ+lE6zT9g8u2xUhwZBBx8npJUTj
	n/Rlz+1vUW51HAof61St+breofts4xI=
Date: Tue, 8 Jul 2025 11:52:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <20250707163219.64c99f4d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250707163219.64c99f4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 19:32, Jakub Kicinski wrote:
> On Mon,  7 Jul 2025 15:58:03 -0400 Sean Anderson wrote:
>> -	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
>> +	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
>> +	    !phy_driver_is_genphy_10g(phydev))
> 
> Breaks build for smaller configs:
> 
> drivers/net/phy/phy_device.c: In function ‘phy_probe’:
> drivers/net/phy/phy_device.c:3506:14: error: implicit declaration of function ‘phy_driver_is_genphy_10g’; did you mean ‘phy_driver_is_genphy’? [-Werror=implicit-function-declaration]
>  3506 |             !phy_driver_is_genphy_10g(phydev))
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~
>       |              phy_driver_is_genphy

This is due to
https://github.com/linux-netdev/testing/commit/42ed7f7e94da01391d3519ffb5747698d2be0a67
which is not in net/main yet.

--Sean

