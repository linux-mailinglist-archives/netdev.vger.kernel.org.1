Return-Path: <netdev+bounces-159757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5ECA16BE4
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50A6161163
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C081DF968;
	Mon, 20 Jan 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WnavHpXV"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBE1B87EE;
	Mon, 20 Jan 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374383; cv=none; b=OgSQURJpjdRor7D2YLOTvKsxHGJLCtcfcwN3Fil6PSV6SxYRyCgWf9YcTQqMhbBH85FvMOZBhQzISOp0MOBSbmKqQUDx0nqElZgW7C3QrlnfKt5Bq2NYFt/GaDJv4NLR3n4Jfgpy5pOVtpjRL0CdNmyKclFqVR553SJ5hOQwxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374383; c=relaxed/simple;
	bh=uLP35HYjyxUJmfxIsr8WbVsCugWJ+q5c5LdMFckVr14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKj/3V+vbjufEhCiTNjTHYTZzxCfXd5sIUm1ungdfBDQINagpEtnHG91EC2EbO2gRl2j7C7WRQabFX8kJzKctjwEnTFGQYEuTTEXd9u431xF0EAolhJRIR/yBecumQc5rjbCYe9yIUkm0oI6QIz53xKYcFId28CDjgxRsq9C/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WnavHpXV; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CFA11048B8B3;
	Mon, 20 Jan 2025 12:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737374379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaVApbWgutbNDOTzXtpoaH4BgbdAcxcABv43Cys+15g=;
	b=WnavHpXVlhAqHxcIbNlVk0y2yGjzhvHbh13bGM4+tVJqFJvfkv9/11sNCSDmhPfRSqHuzw
	SAibLxGAurBAD+goocsyOvmGOhho64jKfd3iWqRBATCkxpoXRIJtEAF4Jla+U1a8bJjI3k
	Dv32GzOV6dw3lbyaMzk0PZEPi4SQFqnZ5jI59e7S7s1tZWDxgbQFE2ja5gzeXY5EGEqTPx
	HPwZNr0slqRGFzP6vEPmPArpwSh7Th9XuRg2aYffYHoagCVSa5qz+nzm3KJuY7i43irssX
	X0l4KJkNKl2/zd0e80nouOIHYYbHs5jprF96boE399m1diU9cIWvdhE95A7zFQ==
Message-ID: <19f854b1-f4bc-4912-a605-c2e74e39b4ea@denx.de>
Date: Mon, 20 Jan 2025 12:59:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 1/2] net: dsa: microchip: Add emulated MIIM
 access to switch LED config registers
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha
 <tristram.ha@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, linux-kernel@vger.kernel.org
References: <20250113001543.296510-1-marex@denx.de>
 <ec7861e2-85f5-45bf-bff6-19bc5009cac2@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ec7861e2-85f5-45bf-bff6-19bc5009cac2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/16/25 2:06 PM, Andrew Lunn wrote:
>> This preparatory patch exposes the LED control bits in those Switch Config
>> Registers by mapping them at high addresses in the MIIM space, so the PHY
>> driver can access those registers and surely not collide with the existing
>> MIIM block registers. The two registers which are exposed are the global
>> Register 11 (0x0B): Global Control 9 as MIIM block register 0x0b00 and
>> port specific Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10
>> as MIIM block register 0x0d00 . The access to those registers is further
>> restricted only to the LED configuration bits to prevent the PHY driver
>> or userspace tools like 'phytool' from tampering with any other switch
>> configuration through this interface.
> 
> I do wounder about using register numbers outside of the 0-31
> range. We never have enforced it, but these clearly break 802.3 C22.

Yes, I agree this is completely non-standard.

The registers I need to access from the PHY driver are neither C22 nor 
C45 registers , they are switch registers accessible directly via SPI 
only. I only needed some way to accesses them from the PHY driver to 
flip the LED bits.

> I wounder if it would be better to emulate pages as well. The PHY
> driver already has lanphy_write_page_reg() and
> lanphy_read_page_reg(). Could you emulate what those need?  It adds a
> lot of complexity, but it should be future proof.
> 
> What might be simpler is to expose an emulated C45 register range, and
> put the registers in the vendor section.
What would be the benefit of doing that, compared to the current 
approach? I think in either case, for example phytool could tamper with 
those registers anyway, right ?

Please note that the KSZ9xxx series to my knowledge do not have this PHY 
interface anymore, so that future proofing part is not really applicable 
I think.

