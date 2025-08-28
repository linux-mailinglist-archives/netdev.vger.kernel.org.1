Return-Path: <netdev+bounces-217548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A8B39038
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2420F363F87
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30614EC73;
	Thu, 28 Aug 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMz2tHhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1279F5;
	Thu, 28 Aug 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342177; cv=none; b=YpbnpVE1OOjmO+WOh+Z3X5/Z4f8PvMc63pjqjm8bUxHyt8ntbBe3d/WG5WoLhjMt0MXN2Q1ggzYu/GyyL1GbTo8NfEYoy7SqDKtixw7oeUXZlIeu8WGdcLB2ZFFnsh2JGISoEt2DD79A+SCaQ0ZoFs++/UVYysy9IwmsdwTLMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342177; c=relaxed/simple;
	bh=zs5/sgXbC3IH5sN0BBYSEmkniXy5eckrLdJygv/pRn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsGv3sFl6fxGLRoAb4nGln0Xqnx7c2fVd8fdRfttuJ8Oq+TPOg7HZWaLA4qsNBquZSN4kAVJ4XEMkMlwt/SPegoEaWyvSjsUY9GVQpvWuo5L5lwBh5rvo4bg07xm0v9eaUxuzeyJg32v42YbqAhXXHrCYDQpusFajv/XaFuvplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMz2tHhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773FC4CEEB;
	Thu, 28 Aug 2025 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756342176;
	bh=zs5/sgXbC3IH5sN0BBYSEmkniXy5eckrLdJygv/pRn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMz2tHhiPdnmP6UMzBdMxr3P48XV/5d5HMUnQCE0ab+UeDU5gazsjmmYZlQhSwT8c
	 TqMLGnDTB7okDQUnXrsj/wPWK1yq4pyArsI+I1D5tRCUNBOGkGlwvshoJF2oyjWU1j
	 lupJyW6C5NnyubnTbbkvqr4VSaqeK0E96cKGNVvEU+qWMVJyct0nFXIIUXMOh0oaXC
	 r6hNS7QB5TE3EmHn/pgGFGDBIjPWqTviFKoxhTZmsbVU7jdAMRCvEH3m90SlD4qfgv
	 85Y1eoMcAuTaCz+wGNS0APzFpQF00nl2KSWrYca+CErf/Hg6LZCQb1ObEkkVW1lIYd
	 8uBXdrS2CThZA==
Date: Wed, 27 Aug 2025 17:49:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <Parthiban.Veerasooran@microchip.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: phy: micrel: Introduce function
 __lan8814_ptp_probe_once
Message-ID: <20250827174935.042bb768@kernel.org>
In-Reply-To: <20250826071100.334375-2-horatiu.vultur@microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
	<20250826071100.334375-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 09:10:59 +0200 Horatiu Vultur wrote:
> -static int lan8814_ptp_probe_once(struct phy_device *phydev)
> +static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
> +				    size_t gpios)

nit: size_t for gpios seems excessive, n_pins is an int. I'm guessing
you chose it based on kmalloc_array() arg type but, yeah, not sure it
makes sense within this context..

