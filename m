Return-Path: <netdev+bounces-238614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19FC5BF64
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3FC3B0120
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4602D8391;
	Fri, 14 Nov 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="inXn9Duc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F523E25B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108378; cv=none; b=KIw+Hd1SdOdd7CzVuMElHN5c6rmTTHO7jf//Xf7N4Fj2RQYfsWpQxAzfmTVsOTphmKRbx+au4K/CYlCO6NoimPwTD49ogRYPDfqdB0KLH1fpuyyIRk5cbE/EQuMts6mlbdl0Dwqsr0BlBfmW27kVe+CLCBrMVgwTGt3T1tVnVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108378; c=relaxed/simple;
	bh=8wW4J+63YtdN88MCXDUEj2nAEnML09chtcOwZzYVjHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr5nMUHe6Rlff6qLXMJsPj7c65XIueEIoGT+hZEqLMGa19XlG76Drpp8ocMEMZvh1VcaXPtgXcAvVB2l+QkpqLvpfq1lGRUaP+0agRWKJRmpaHK6Kcbgn+ccuT9fy/UMIRXaoe92WnzUeAPEsvPdDPdyv2zGY12r/rS2CDBu2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=inXn9Duc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2B4DEC10F5B;
	Fri, 14 Nov 2025 08:19:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D57B16060E;
	Fri, 14 Nov 2025 08:19:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B19C102F29CE;
	Fri, 14 Nov 2025 09:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763108373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jBTnPGlthTueHqGOpJclIDQ8cDTOXhGdG3SwCdGrnAI=;
	b=inXn9Duc3QrSle0ksRriW5U2OP+90saPVG0jbENvS5xT3yRMEzOcLTlHarssyMy6EfOpFZ
	wzP69vVvrWy7AuAt2Fih+P4V4EIIQ79HknF41d1hFT4Io4Lwum4VhmQhYSrahcK6DFe5CJ
	UFgNDGiWv09Mausc/f3AwPlEK9xVEi1mVtyaN70upYMOsy+b/AaWt9Xn+x+3BkKb0ibEjD
	5EsQmdBNdS3ofUM9sayv6b/VzUC1aZNU0Z4z6k1CQBv7gAuNBOJPa6RC999djyp6/bciqj
	OgoE827s+k9jhsXscyEtOk0mAJ4aCATZS8YxHcKY7us4B++mUH7Z/k6FN/dIzQ==
Message-ID: <fbfd62b5-d584-4e00-a666-fad0438709e8@bootlin.com>
Date: Fri, 14 Nov 2025 09:19:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: rk: replace HIWORD_UPDATE()
 with GRF_FIELD()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aRYZaKTIvfYoV3wE@shell.armlinux.org.uk>
 <E1vJbP1-0000000EBqJ-1AjR@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vJbP1-0000000EBqJ-1AjR@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 13/11/2025 18:46, Russell King (Oracle) wrote:
> Provide GRF_FIELD() which takes the high/low bit numbers of the field
> and field value, generates the mask and passes it to FIELD_PREP_WM16.
> Replace all HIWORD_UPDATE() instances with this.
> 
> No change to produced code on aarch64.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


