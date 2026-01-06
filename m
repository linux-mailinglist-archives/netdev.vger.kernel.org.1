Return-Path: <netdev+bounces-247327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C754CF7633
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE012301986E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0E28CF6F;
	Tue,  6 Jan 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ieYFmztc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12A1E50E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690246; cv=none; b=aos9tbCHgvQUL5mxRBKFNf5niWEFvTe5fj1GfKLe5zvCB+3U1dH76q2F265FlIyulcIa5QyRCpV5UNGHiZrXCSg5hN8ta37gBR8ZBSEPMHnkyEOGHv7L9NEFEh/v8T5wTv/UVGbW27kBevj2su0VkBpQ8j3pmUbdRq5CvCObgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690246; c=relaxed/simple;
	bh=dFQgB89Pz8WG7OQl524X15tPn4ydLchrwFvkgLAA35k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yn1n+KukVOaGrGLmVmvcMIhFylI7X349YIeFaoydvtqMDLq2azUFgrtFmR3Llymjd414mP51X7Q012GuRQPKH/104xtw2NgZDlKRQOqM026yqCblXFI6chubGvFZhT+SPwhbbnNd3CwfRLakYQERwu6Egi1C6053J2S6pOQIdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ieYFmztc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 696941A2678;
	Tue,  6 Jan 2026 09:04:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3975460739;
	Tue,  6 Jan 2026 09:04:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A44F103C85E9;
	Tue,  6 Jan 2026 10:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767690239; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DZNOdJbxIgwwRa1m7oG0D5bgyhSt5x/PF6SFyJI/99Q=;
	b=ieYFmztcgrKgnFTIHrL/65qr3DK1qAnxCjNpT7mdHk+lz+szVcHpPzhBFf28tI8Gdpyk/W
	jk89Lzc4AGUK0wGM1Q+ombfYAXrZ3PrZm1YozRsvwwyihyxlxNQWH1wXD21+GNet3Al1kM
	R8CKbu2DLWVroqVPq7TkbmrQ3CLHPFfAJSQbn8/L/D93MXHmG9DG/HiEVYgf+KfGVcMuBG
	nUOUb8hoqfPT+rZEZv9uoYnV5l8VVl031vWYOaIR9gDkMKEVySWQ66PqL/JE+mlfkQULKk
	qI0EdXHvGCuDPzcbpOa62f4MN30S/9Rm/llY6VGykbU5cOGsben8f3J9C9pEUA==
Message-ID: <5bfe6271-1859-4700-8b70-4b3d8db4cef4@bootlin.com>
Date: Tue, 6 Jan 2026 10:03:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1767630451.git.daniel@makrotopia.org>
 <25aab7f02dac7c6022171455523e3db1435b0881.1767630451.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <25aab7f02dac7c6022171455523e3db1435b0881.1767630451.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On 05/01/2026 17:38, Daniel Golle wrote:
> RTL822x cannot access MDIO_MMD_VEND2 via MII_MMD_CTRL/MII_MMD_DATA. A
> mapping to use paged access needs to be used instead. All other MMD
> devices can be accessed as usual.
> 
> Implement phy_read_mmd and phy_write_mmd using paged access for
> MDIO_MMD_VEND2 in Clause-22 mode instead of relying on
> MII_MMD_CTRL/MII_MMD_DATA. This allows eg. rtl822x_config_aneg to work
> as expected in case the MDIO bus doesn't support Clause-45 access.
> 
> Suggested-by: Bevan Weiss <bevan.weiss@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

This looks good to me

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


