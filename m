Return-Path: <netdev+bounces-243259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77129C9C54F
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 231C0345992
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A829E0E7;
	Tue,  2 Dec 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wGL+W5WA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD13220687;
	Tue,  2 Dec 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695229; cv=none; b=A6M+ugAMcDzoc+bM2ZRO/hInqI+diAHWiDzWvOyVjyYI72dZI9VoYG4uYjEcKOqdXhO8Rh2MTYfsMTWDim1+wCqGISOAK0rKusBbNH3qNYAt8QVu1alX6g0fegcGtVc2mOI5mlV1QgeehDMEL9wLp/mPrQvxVKttqhIo1iv5kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695229; c=relaxed/simple;
	bh=A3e6+30LkJ2IuKKUDZ2rKx4e8x++aInZV6RBgiVN13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1QaQ2lNAkpZ6/ODx7b6/I5GpYCzriWqjGWEkt7r5ZA/Xad9Fsl/RiruS4g/WSh70X6oNsllBPnZp+Whgxea5f6NzbHNvfLxwcewNL73BG3PDTsT8C82AV3Fkmkq6fgfJojst/NclXmSR/w++KPOnnudJJwejX6PzXHX3qDGmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wGL+W5WA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1803B4E419E0;
	Tue,  2 Dec 2025 17:07:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D17E1606D6;
	Tue,  2 Dec 2025 17:07:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93B7411919D70;
	Tue,  2 Dec 2025 18:07:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764695224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mUNwn26nhwJCke2bRYWKHCmVtw4daBaVjxTywqqyjAE=;
	b=wGL+W5WArWvIH0qjuEPIh7lBBWL0xGThHbRSi8PlsOy1Fx9wh5KAPX7185UE9UnXeyatVI
	tB02U6b2VRqZNRD6aIQCYlklOBO5ZI55m9ZlerXwmVyOwCObRjeQg5bUggCVmRVIqRYaIK
	M7z6qgos1oxmkfCkXyK6M6F8+qEBTi74dxHfOyRPLGICON1olLjtd+3ZTISudDfzAuiciq
	HuTdr5NPWMtOpuZ7u9W+w0J/Dn2AIoDlXK53Oml0tt9OvjWgjgYpAZjOvsZ7Nc9uvSoumT
	D602TJrR84hTK8vXtJDgrNLviL+Duo9/sSlpGXwX3njvC4ZRxyGsAfRcoFqisg==
Date: Tue, 2 Dec 2025 18:06:59 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [PATCH 0/4] i3c: switch to use switch to use i3c_xfer from
 i3c_priv_xfer
Message-ID: <176469517228.2676946.6008057547804596817.b4-ty@bootlin.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 28 Oct 2025 10:57:51 -0400, Frank Li wrote:
> This depend on the serise
> https://lore.kernel.org/linux-i3c/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com/T/#t
> 
> Convert all existed i3c consumer to new API.
> 
> The below patch need be applied after other patch applied to avoid build
> break.
>   i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()
> 
> [...]

Applied, thanks!

[1/4] hwmon: (lm75): switch to use i3c_xfer from i3c_priv_xfer
      https://git.kernel.org/abelloni/c/1f08a91cec5f
[2/4] net: mctp i3c: switch to use i3c_xfer from i3c_priv_xfer
      https://git.kernel.org/abelloni/c/57c4011d3637
[3/4] regmap: i3c: switch to use i3c_xfer from i3c_priv_xfer
      https://git.kernel.org/abelloni/c/79c3ae7ada05

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

