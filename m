Return-Path: <netdev+bounces-145528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D839CFBC5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D0AB27AE8
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2A522F;
	Sat, 16 Nov 2024 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6AdUKqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF22F2D;
	Sat, 16 Nov 2024 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717432; cv=none; b=iNhStFrjCyOeIBKTqF1fn4cnduaIuIvfYcueWcNm5DXPQY++6rc7n1JPD/oNznb7TTi/arrCs2CeGFG4a4pfNqxQWVy04Wef7aY16fjFPCMGQZ4y8YtEidhXicNjUw0GDf45XhaRxIyADaJkUUh/Cc3L90AzCJwWKS8V5fFoGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717432; c=relaxed/simple;
	bh=7qIvOlMwtalmWJriz73Uz9i8/rNktbB70fgQBDFwrO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl45ArKllv1GBIrkmZnITvl/HKHueAPEe0kvu9o5ZrXBzj2erOou3NHQrmz7kW75uN2ra5Pwz8wKwJ6ZHPEz7U38irrH0Lx7YT6DJdpqNMSp5O56GF2yUvwnS5t2cQTjECYeP/M9ZfAycc5rXySDpRVYBr17zDbdth6/uawGeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6AdUKqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0128AC4CECF;
	Sat, 16 Nov 2024 00:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731717432;
	bh=7qIvOlMwtalmWJriz73Uz9i8/rNktbB70fgQBDFwrO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6AdUKqCd19M6jzxcIJwrZE5z/kJNHzaV9y9/lSXgGAs4uOaNyj104VfY5iAJixNh
	 +1PNScZR8UDdWR1uDTM97+VDILhy1l/c2tzcIEU8yxg8+0Wf0umh/eCQP2OTIP2mk6
	 ajBClORPJ2Lm79XL6XOTG+lHynCZVBgCe3z5EjnqyEWWFEoAQhPrsgY8aOjWxb+mwu
	 mmyz2ipKmsj1Qjj1lHvK3WJJ6Umf8Yxz5L5ZOyHlBxgFsug2tYipchqyiP82TK1QI2
	 ug9H9fxT5U5o9LLTKGQkY5In3FGAeH3wQkHGVMUw9ztrr5jZ4okLEE2cPc081XKb01
	 cMuGRqPAgc7kA==
Date: Fri, 15 Nov 2024 16:37:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v4 1/5] net: phy: microchip_ptp : Add header
 file for Microchip ptp library
Message-ID: <20241115163711.18d8440e@kernel.org>
In-Reply-To: <20241114120455.5413-2-divya.koppera@microchip.com>
References: <20241114120455.5413-1-divya.koppera@microchip.com>
	<20241114120455.5413-2-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 17:34:51 +0530 Divya Koppera wrote:
> +#if IS_ENABLED(CONFIG_MICROCHIP_PHYPTP)

Try to limit the amount of code you wrap with the #if
hiding definitions and includes under CONFIG flags makes
build testing harder.

