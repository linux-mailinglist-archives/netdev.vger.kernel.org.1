Return-Path: <netdev+bounces-248964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69CD11F17
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4AD30517CF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8318283C93;
	Mon, 12 Jan 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WF7SRuOr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F227B352
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214194; cv=none; b=QI4H3JARbhKvgW7w84q8lGhcZzLY5F836p0TVQClZA13L17QiYgRqovJ/LtN/fZ3E5DB7kIgG0jJaXC4J86VpY/aAGbRIC9xHT7FIhO33YivwDuUPvVO6uvm1uIuTsEnPF2GVSu3k++weFUL8EVw+kKEG+pzWSaMkCkMJDnrpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214194; c=relaxed/simple;
	bh=gIBmYwr7TpN3HceztHWlYU834xaZOiq/uxsG7/j0MM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwAT8chEK4uDkZlUkpZAWN0YbpGdO1jJrmUg+ZBymGIK3Mc9EcJ5hxtVzplfrn2CNBnFUqUDJW78NVH86yOvGhPFS6UNS6zF3z7e0VEr8akYy7+5bb5EvcYJqN1tHmx0A3VYRtgTDiVZ2Wn8CTiEypkQHJYULL1efCPBeSMelLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WF7SRuOr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 25450C2085B;
	Mon, 12 Jan 2026 10:36:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 901ED606FA;
	Mon, 12 Jan 2026 10:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EADB7103C870F;
	Mon, 12 Jan 2026 11:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768214188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KEI4RefYwayDl1RTRuRQz6yThwG7qcSsgViVuuBN7rc=;
	b=WF7SRuOrRzAN7XTHrKAThDH+sWv/iydl85sU7Ob2tgSYivP+c8xYsqR3tA9eLQVl6+Pk4j
	ICU8PAsWFVWQO9wDwicCYrFQO50a5G78uY6StGFfOr1wA9HdAInAiBwnqv97hPrqGdzSnA
	w99ehIrbaRoYbhA6IncZqg6nTK9Ow/UJD7MhS2aW01tmJ9WLWC/c4FNxcMn3J7t7Q7uXxH
	8K499CfJ5uM7dX+UgXzFdRNbqbOCZk6nlQB8IZrhYwKfo+J8HXiyec0X7b/Xg1hiE0iSdt
	y55GLt+Mf9KwQDnFogMyMFJf7WsyZ0cY4wCZCoqI0Ny3XM7QrNDFpku9VgY8xQ==
Message-ID: <9a34af80-df77-4b3a-8394-c1b768da6ebd@bootlin.com>
Date: Mon, 12 Jan 2026 11:36:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: phy: fixed_phy: replace list of
 fixed PHYs with static array
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Heiner,

On 11/01/2026 13:40, Heiner Kallweit wrote:
> Due to max 32 PHY addresses being available per mii bus, using a list
> can't support more fixed PHY's. And there's no known use case for as
> much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
> so use an array of that size instead of a list. This allows to
> significantly reduce the code size and complexity.
> In addition replace heavy-weight IDA with a simple bitmap.
> 
> Heiner Kallweit (2):
>   net: phy: fixed_phy: replace list of fixed PHYs with static array
>   net: phy: fixed_phy: replace IDA with a bitmap
> 
>  drivers/net/phy/fixed_phy.c | 83 +++++++++++++------------------------
>  1 file changed, 29 insertions(+), 54 deletions(-)
> 

I've tested this on a few boards that use fixed-link (A turris omnia, a
custom board with ksz9477), and the code LGTM :) I think 8 fixed-phy is
good for now, and the way you implemented that makes it trivial to
change that if need be.

For the series,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

