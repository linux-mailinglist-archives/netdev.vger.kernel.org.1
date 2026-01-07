Return-Path: <netdev+bounces-247629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22BCFC9A0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF28D3011A47
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977527FB3E;
	Wed,  7 Jan 2026 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fiTzTVNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502E285CBC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774257; cv=none; b=DjIwyUXbyBfRocE3IBXJs/DkYDyar0iMuf3msmRQa0zF++mq+bWUE6gNibemywcDvsHqzBq6MHTUAg2DinuPOvqD/PvODCJJc88yGtWEUSJFURctmczf4EB0UHTHtnVcLs6Irhy9q2qYDU8P9GCA0PVdm8wPb2G2uOeB52Tpsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774257; c=relaxed/simple;
	bh=54aj3R0iIaS17+MZo0BMstHwz1AwMwxQ3C2BjShH57Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmTmfgQO6u3IjXUp/sywHIT2T3Jq8K8tRqaWY3WhH/Th8rngjNz69J/x4LETO/6vjAKDzODvtCgBiAcbJPD8gY/4+fzDoaeChrVMTu3mjsJwcRlYN2ffplxla7TiwYT8bwt1uYVaxiOZZgedT7v1krAB+rm4EFfd9bU0JqppNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fiTzTVNN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3EE2EC1EC8D;
	Wed,  7 Jan 2026 08:23:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45FAC606F8;
	Wed,  7 Jan 2026 08:24:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25FF0103C8597;
	Wed,  7 Jan 2026 09:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767774249; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gR/y6Uc5IExI1wlxJ6ehnKNiWxH7FKN74OHl8YN3mA0=;
	b=fiTzTVNNLJb0Uw8Jv0vWqooScqqTYklPwX2Dhw4LZBn3N80l/kHhwqLjkryGv/ra9alaiB
	5hv+9pfn0gAF0m83ZMFWxvwjGo0458GDt5VYm4lzj/pgzWNe3M+Z7IuRety+tknX2BpJ6U
	5Jz5fWyaN6UPog10egFN5FOUqYk2HxIoJI9Ugo7+kAr1h6HSlp5UTHazRvw6VKglEMzMNE
	AyGlZZY6qGFqrlimOoFxFktvinoNbv/LuufrkCd+ODTwwLYasOj8MMmeA+JOvlAwZcW6hA
	aj3E8kgxhy8EDcTrgSozdGroxAfS0I/iwML02iDoa+qLt9WD/kP9ZjoZqaLFmQ==
Message-ID: <74c648d8-ab86-42b4-a20d-aa0e5ab6f57b@bootlin.com>
Date: Wed, 7 Jan 2026 09:24:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] net: stmmac: dwmac4: remove duplicated
 definitions
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
 <E1vdDi0-00000002E1J-1SNG@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vdDi0-00000002E1J-1SNG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 06/01/2026 21:31, Russell King (Oracle) wrote:
> dwmac4.h duplicates some of the debug register definitions. Remove
> the second copy.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Nice. I was able to confirm with 'grep define dwmac4.h | sort | uniq -d'
that what you remove are all the duplicates, and only the duplicates :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


