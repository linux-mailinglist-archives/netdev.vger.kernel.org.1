Return-Path: <netdev+bounces-247656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BA8CFCEBC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02783027CC2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBEE313E14;
	Wed,  7 Jan 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ewBilwLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D9313E0D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778121; cv=none; b=cmYHTvAeEARxfdlpXUNXs6QGQJLQPj3CWOOMHP/5TFzcE9N8AoZtqmebCvzE+mmNbhMnUx1suinhAVd+YcixMpHLGycvU5j7TbC768TGGgr9IqMK6xLKvqYSyq5l5nCK0rt/U7DO6QT1OU4EiyCEKjG2/Rvl7yUv8EOdblHTFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778121; c=relaxed/simple;
	bh=IVqZUpb1NrHu3CJySInDcWMsMnrsyUvCEH1FT5eM04Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzFQQW5nvSzwLQpyleH6GohNPBmufpxnv72H7h9iSbKBLHUNpiOP+lDvJB5JyO9/SKry/+17vWNH8IUjwIEDSZuHKouGjsIaSJglKHu8vI8+Af1fSm0Z2Urkq91GKA9VP2yg/dPpDQXrQt+Zu0Vmj9bx/PUL8G9dCkab740XNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ewBilwLc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CCFA1A26D6;
	Wed,  7 Jan 2026 09:28:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE3C9606F8;
	Wed,  7 Jan 2026 09:28:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4985103C86EC;
	Wed,  7 Jan 2026 10:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767778116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BEdNlkEF+V3ZVxV9iTH2XUM+56WQ6cgNcIhMWG/iqaQ=;
	b=ewBilwLcIsdlR/rISBOifhW9NG3hWv/rqiNaL1s1Hx/KJBA7QLNO2DBxaa3u+7jRM9tPuJ
	3kkp96dTDeQ4j76e9zUtCvmYBXhW6vxT/R1aBuSWiRK6dIzoooOniOVArr81TuXqrs9sbD
	q6ia7XtQsjgD1b51QhUUfzbPRt65YTk1cDANUKyzIxFBpohKVnKHzyHZH5HvhkqwV7Cnij
	uYLM9Jcm5xIfLh4PF1E4cEEjkx5/933XTa8KjuQlVgyCPQ3IzKFzuQ3hNzW4SZi9K8LFX+
	rYziEn9zmmxehRkVCGMSYfyPF8LQr8VqswYNr4H31tSMbU5lP5z5L7g9kXIFAg==
Message-ID: <4bf4ec53-c972-4009-b827-5083e080f32f@bootlin.com>
Date: Wed, 7 Jan 2026 10:28:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] net: stmmac: descs: fix buffer 1 off-by-one
 error
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
 <E1vdDiF-00000002E1d-30rR@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <E1vdDiF-00000002E1d-30rR@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 06/01/2026 21:31, Russell King (Oracle) wrote:
> norm_set_tx_desc_len_on_ring() incorrectly tests the buffer length,
> leading to a length of 2048 being squeezed into a bitfield covering
> bits 10:0 - which results in the buffer 1 size being zero.
> 
> If this field is zero, buffer 1 is ignored, and thus is equivalent
> to transmitting a zero length buffer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Should it be a fix ? I've tried to trigger the bug without success, this
seems to be fairly specific so I'm OK with it going to net-next.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


