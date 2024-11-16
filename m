Return-Path: <netdev+bounces-145527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2939CFBC3
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79D7B27796
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B8567D;
	Sat, 16 Nov 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlxnsZQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFF4A2D;
	Sat, 16 Nov 2024 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717393; cv=none; b=MzR54z5iJXLId22s4UQIqoSiFVwc9uzdVwCikGJ6fwRMuzGH0GbXwoaesGkoMqLOUgTJkpuJeSkntFNIWEF+DcDSpH8OaSeGRHX9hBNnu33fy/cRUF76z3fnLswnHPR19BmvznrQttW54iXPXKKeRkbqpHBYMrUwxc0TYK4MC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717393; c=relaxed/simple;
	bh=JgNf+mN+2k06qc4q3wA6mwGvTy2iwaXR8wILdflZBXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+r3CwpJsSgZN+a9w9IfiFImxa/4sAtws5K2j0MiIAvWlP2+iGrTRLwXHaeJVB10syrZkOdHGBT4CZCaf1FGERrpX7JvlpesHn8Aq8SEKZYsgwBTNGlXu8HBuB2KnPJkOCna2+SBRD83Yq7rBRXkUmjozyZdrTRrpUpVnR/Z1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlxnsZQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B3C4CECF;
	Sat, 16 Nov 2024 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731717392;
	bh=JgNf+mN+2k06qc4q3wA6mwGvTy2iwaXR8wILdflZBXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZlxnsZQVcJF01pZ5jwRzyQeZ6ohSJOul6Sum7k4lBnRbUheJF+djwktdY1Z3U0l7p
	 BevpJRgqtREE0zd9zOBm279Umr18HVBYg2FQVnfsOGwoyhxab0Jb6gIwHj3NlVfAPq
	 j60uWc1+RgfEasiOLJ2N/8lhSLKBSU1Oik1POzVbfGOV8hVHMHv5XOVRnIX7pC3sSc
	 4jQtwapSBiKXCYWgsxM3I7tfONzF2JQohSiVe5+GJclmVbZ1Ni2fcXLGao1NcSpohZ
	 DBTCpn1BTOygqoZ2C4Q5AJFxJp6FnHgh1v8La7EDJU6Vi1iTOzzQX2n5POJLeNIRBg
	 MBS3yNKbCD7vw==
Date: Fri, 15 Nov 2024 16:36:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <20241115163631.636927b0@kernel.org>
In-Reply-To: <20241114120455.5413-4-divya.koppera@microchip.com>
References: <20241114120455.5413-1-divya.koppera@microchip.com>
	<20241114120455.5413-4-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 17:34:53 +0530 Divya Koppera wrote:
>  config MICROCHIP_T1_PHY
>  	tristate "Microchip T1 PHYs"
> +	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING
> +	depends on PTP_1588_CLOCK_OPTIONAL

I presume the dependency is because select doesn't obey
dependencies, but you only select PHYPTP if NETWORK_PHY_TIMESTAMPING.
Maybe it's possible to create a intermediate meta-symbol which is
NETWORK_PHY_TIMESTAMPING && PTP_1588_CLOCK_OPTIONAL
and use that in the select.. if ... clause?

> +	help
> +	  Supports the LAN8XXX PHYs.
> +
> +config MICROCHIP_PHYPTP
> +        tristate "Microchip PHY PTP"
>  	help

nit: tabs vs spaces

> -	  Supports the LAN87XX PHYs.
> +	  Currently supports LAN887X T1 PHY

This Kconfig is likely unsafe.
You have to make sure PHYPTP is not a module when T1_PHY is built in.
-- 
pw-bot: cr

