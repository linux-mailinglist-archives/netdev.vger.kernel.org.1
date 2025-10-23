Return-Path: <netdev+bounces-231998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F5BFF9E4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229283B252B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8D301003;
	Thu, 23 Oct 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdorGzg2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEF2E2DDE
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204012; cv=none; b=h2fIJaEQujQXF0eaCJUKH3JU4DXSKeGwnbPltwfDpnRkaHITJsDKnz3811bptz+dK7tReAOqMRXdmIWXcCtf4hCzaCK6J+i6mjE3YZhThaBj/JIZ2rxYywWml+NkztwBOKLSB3403ufIgNuYg9bIrmUMT117nhPWy0UWmd2z7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204012; c=relaxed/simple;
	bh=G/t2VvjuBXb+VnFasPy1eyg56gnyrjAHlOAt5VTEvTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+lzvgb4GY/da4fGJnfyYCTN6VaEiSe9VACGudBVx/yqvuPebJ1cxsNgfqgm+VWuKUe5Yp4SE43HFSc7mWzQUt4Hj2YzMYI0dP1VTOr0oHRUKeNZXmGM8rs8udDQlch6KzocQNqPQcv9p3OZ3IllJ3PI/sC0T378XvsBTR0I8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdorGzg2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9BFE54E412A0;
	Thu, 23 Oct 2025 07:20:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 670866062C;
	Thu, 23 Oct 2025 07:20:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53C8E102F2429;
	Thu, 23 Oct 2025 09:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761204006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4roag8RkeTHO2FDEZ6Nr16KR62pxOLQkv39DNg6fV3I=;
	b=mdorGzg2LzGiR0C8GxZXl2UlSgbq9yAfDNeqY/Y4sEAXMkzTrTy0W8Kr2uoVdDfDD9xPFL
	oyXAtASGmQPpdlMBu3alqEE6W5MXKBS/g53aq/vzqyqQvd/Wau6H/EgoW/4QF2brlnxcz8
	J/je+VRBLPtGgC6HQsM65ElhOZHRrSrjAA/h3b3DeNYm8qz5z70Rx0ReayxNC8Vkgl0uvm
	UbxjwwfGeTa8XFj6JAADH+ZmpNnZuFUskfiiUqFVl0kxYv2Pg0kjhzMkwGxqq61zdoJ07W
	QFmJ9IrAIQ6mL5GnMbOolzzriyutWAccNDuyts4XEg1eS9RybRT0SlLBF3y9Kw==
Message-ID: <2fb53c04-17a1-439c-b8dd-ec52aa23808c@bootlin.com>
Date: Thu, 23 Oct 2025 09:19:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
 <ad16837d-6a30-4b3d-ab9a-99e31523867f@bootlin.com>
 <aPkgeuOAX98aT-T7@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aPkgeuOAX98aT-T7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 22/10/2025 20:20, Russell King (Oracle) wrote:
> On Wed, Oct 22, 2025 at 03:43:20PM +0200, Maxime Chevallier wrote:
>> Hi Russell,
>>
>> That's not exactly what's happening, this suggest this is merely a
>> wrapper around device_may_wakeup().
>>
>> I don't think it's worth blocking the series though, but if you need to
>> respin maybe this could be reworded.
>>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> I've updated the description as I think patch 4 needs a repost:
> 
> +/**
> + * phy_may_wakeup() - indicate whether PHY has wakeup enabled
> + * @phydev: The phy_device struct
> + *
> + * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
> + * setting if using the driver model, otherwise the legacy determination.
> + */
> +bool phy_may_wakeup(struct phy_device *phydev);
> +
> 
> Do you want me to still add your r-b?

Yes with this change, that's good for me you can add the tag :)

Thanks Russell,

Maxime


