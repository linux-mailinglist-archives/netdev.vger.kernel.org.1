Return-Path: <netdev+bounces-250693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FABD38D54
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7DB30194FB
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C32EAD1B;
	Sat, 17 Jan 2026 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pug73uwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB71256C84
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768642008; cv=none; b=SGWpBTruPrCJo4rLCqShcpWPi8JAOdqCT6sJHJirwHOdfzyTPSzvseU6Ae0VlEH8idZqUeIHMk9979IGzlsX1V0yqEvnkvxzyBhCFu7GpA3sQ8g0F11+e8N3xRp6tfaRQUPmgrHF0Gk58lwW7SROm6S/35evdb9pWsn0n6wfuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768642008; c=relaxed/simple;
	bh=nuhu7N+DPQZTc0puIQeAaKccpbVD7rs2cCCLw5wygtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA0i4B3HI2LqXDdG8m6DBVxHFE+95RgUAayyPqul1LNcXOgry/QAgN6b2/x3Q25qNJwEiQY6U2RP/zSGS00iRV2lyPg2evjIUtDC6lPR8H0LD4J8hvm13/V2WnJ/BtyOq8fpdMpL5Fm8RSuRYypk9+L8ooUHBfsWGINnsaOKarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pug73uwe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E37A01A28E4;
	Sat, 17 Jan 2026 09:26:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A339660708;
	Sat, 17 Jan 2026 09:26:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6AB010B68FE3;
	Sat, 17 Jan 2026 10:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768641995; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=22dRL6sLaeQXaep6GKzfTNrZ7nA1X2tU2tpqpgJzvfg=;
	b=Pug73uwebtcwYIIE9dsy+u5IlfETxLEgM1AUb92W+79v5ZcNuuhxnX36awql6T5cthXcds
	8EzXzI8xCLcS6RgZxTdnFg8PfajoTszCLifFWWzezKQNqZU3+UNnJHbFbNCOig0/hTdyX7
	NQObUlzy5DTbbmk+XF0xixUd2G6FR6UPf0+s0vbsbLalcdpUYUyY14d8ICGI5svHAR/Guf
	F1qLTCS3ATYW7cEOWXHClvK64+Dsh7BrKhSafsBEabhvDZriv944Q7lFe/CSy7R6rwfn6m
	5lvACW0+hZwrUBejSGBLymE0GtpLrl9Q6L0Cjlmtnq7BoUuUYqOw6D+Vx3oNTA==
Message-ID: <afbac1ba-43b4-4c0a-84fd-87866e954fa2@bootlin.com>
Date: Sat, 17 Jan 2026 10:26:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: fix dwmac4 transmit performance
 regression
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
 <ab2d7cc9-e7d9-47fb-95ad-90ae4f5f1f67@bootlin.com>
 <aWrH-FAuWnqmbSaJ@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWrH-FAuWnqmbSaJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> I really give up with when fixes should be added or not, because it
> seems quite random when it's needed and when it isn't.
> 
> And no, don't quote the stable-kernel-rules nonsense that is
> meaningless ot stable kernel people, when they use AI to analyse
> commits and pick stuff completely randomly.

The rule I'm following is the one in the netdev-maintainer doc, that says:

	'for fixes the Fixes: tag is required, regardless of the tree'

> 
>> It would also have been nice to be in CC, I spent some time on the bisect...
> 
> I thought you were, but I see now it was a different Maxime!

Bah, no worries :)

Seems we have a bunch of french people with similar names working with
st platforms or stmmac on a regular basis, I understand the confusion :

Maxime Coquelin
Maxime Chevallier
Gatien Chevallier

Anyways, thanks for the quick fix on that !

Maxime


