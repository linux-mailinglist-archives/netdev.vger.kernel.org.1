Return-Path: <netdev+bounces-247665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C6CFD19D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DBFA3101E04
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7432F77B;
	Wed,  7 Jan 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BEHEs6r1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C82F9985
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779932; cv=none; b=lZg/rsCLP2UvDNY4HPKzOtxZm+57dDpAe3cyI8KbrYxCaPLkaF9r1g8PQQrMU/o7zPUdvOu9AdzqFN5Q03jpUBw9mwSaXKfOkOluCYfgRJ2uuK/B4tdk20CaReRR4uWgiI51iO3yaYGoMYXAnWXVkJEluxf0k+EcXakX+1uwsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779932; c=relaxed/simple;
	bh=EtZ82ALavMPEoWy9HIhTbm4rA+XrdAc5HNg2q8pTQTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNS7kshrmoyjaSwnSQ5e1//wYsgx7zOzS1i7qbspcJbzF8vdJODiApSz0s/jXadFE8RxpZqHaYi+XNazWEOIAS8GlGA0Npc2teXl6JnSLFv/CxRrdnNAiSc5Y5tgNmfOkhd3getFdKfmEvAqaYorrkEbShKzd9aJOAFrVQF7UuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BEHEs6r1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3CF24C1EC91;
	Wed,  7 Jan 2026 09:58:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57452606F8;
	Wed,  7 Jan 2026 09:58:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C1C8103C870F;
	Wed,  7 Jan 2026 10:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767779928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3hqTdpXOizZ/e9efl1zQ2snYZOE+pxVId2PVKDUTgJc=;
	b=BEHEs6r1YL8i+F08IwjLuqAouIREj5O/2e9GWe4vgGbbEyhzWkbr64R3BK2pzfTioswwXs
	U+Zys/9/TLtk2lV08nZX3Z0xw4ok1YQpSCtd8hddmGsy1Ndyc7+OJ6XFPsohj4Rb2pNztb
	YNlaAW2nn2P3qT1WkJdDBdAZA0wYpJtuljWX3mX8+NLkm6ebxl0z+fBgOqCfcOyM+1QRR2
	3Ff7+5B129SsxIepu3zGbxaHN0rJT8Vb7KTcDh72efCpEXpiTWXEn9wOupMWKA9R9WVfFp
	mJLnLWJ+Xbte0JvJegJNZFXJvNsr3ri8RLgJruiOoMkjjodCCJehDNjQufnaLQ==
Message-ID: <02415558-ef2c-4b49-8be8-997376d1ecc0@bootlin.com>
Date: Wed, 7 Jan 2026 10:58:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] net: stmmac: descs: use u32 for descriptors
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
 <E1vdDiK-00000002E1j-3xlF@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vdDiK-00000002E1j-3xlF@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/01/2026 21:31, Russell King (Oracle) wrote:
> Use u32 rather than unsigned int for 32-bit descriptor variables.
> This will allow the u32 bitfield helpers to be used.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


