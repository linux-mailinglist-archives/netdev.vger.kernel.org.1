Return-Path: <netdev+bounces-119309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55C955211
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F0A1F21D91
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608771BD4EC;
	Fri, 16 Aug 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tzmo23kK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADB44374;
	Fri, 16 Aug 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841790; cv=none; b=rHbL35DesSn1gCllrrmib0pWUlwj+4Od6O5FD5lzofvhihXjRSnlDjZhYla4fB+LKclJqNbBX4N4YlAxpo6YmQdHQTeV1sCGk3axRHonLloAwZMC+3vgo1rQHXoCvxZ8tilH7QikDjjqNWUZw8HPnizqqUV6zdCMyOXMyIUQYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841790; c=relaxed/simple;
	bh=xM7a0sjEn5EU7xMgGaRiT2wnAsyzH3IhZm4MDK7tH+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/jS9QvdMwGEvgMKiD394zqUreyas5+vIXo2Tqjgn68pwxPrMMfDqwczrbtCMxqZ1qPIsSniUe0/1099PBWnYRaGibnTF5Gvwda3CzpRdQczvKYGcVI9CHLjH1npntXaeAH24GMgt0UR4NbaHumRURrMIA6y4/L42OijVud8BIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tzmo23kK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kessJoZEAlIP3wCOgJvS54+BXGLCvL32IvfCD/5qQbM=; b=tzmo23kK1ueDfCkbJcYEZaCLPM
	VC881F5H0/kDP9m0RH69fXgnpVpb18uu4aXPgQOGsyOmKS2gGBlwy0TFsNZyxy7RIxRCY37i6dgSe
	DHLbTB3+k19YN4vhywTA7wwdjT9oaVUEzQl6GaaV9qKRVJiTzxWGOb/VNEMk4sTL+Eeo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf3zc-004xn0-UV; Fri, 16 Aug 2024 22:56:16 +0200
Date: Fri, 16 Aug 2024 22:56:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: microchip_t1: Adds support for
 lan887x phy
Message-ID: <4956ed49-89b4-46fc-a2e8-8debada5a35c@lunn.ch>
References: <20240813181515.863208-1-divya.koppera@microchip.com>
 <20240813181515.863208-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813181515.863208-3-divya.koppera@microchip.com>

On Tue, Aug 13, 2024 at 11:45:15PM +0530, Divya Koppera wrote:
> The LAN887x is a Single-Port Ethernet Physical Layer Transceiver compliant
> with the IEEE 802.3bw (100BASE-T1) and IEEE 802.3bp (1000BASE-T1)
> specifications. The device provides 100/1000 Mbit/s transmit and receive
> capability over a single Unshielded Twisted Pair (UTP) cable. It supports
> communication with an Ethernet MAC via standard RGMII/SGMII interfaces.
> 
> LAN887x supports following features,
> - Events/Interrupts
> - LED/GPIO Operation
> - IEEE 1588 (PTP)
> - SQI
> - Sleep and Wakeup (TC10)
> - Cable Diagnostics
> 
> First patch only supports 100Mbps and 1000Mbps force-mode.
> 
> Signed-off-by: Divya.Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

