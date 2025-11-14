Return-Path: <netdev+bounces-238689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A6C5DAC3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE0E24E9BB4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E7328B45;
	Fri, 14 Nov 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AnChkPDb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50894328271;
	Fri, 14 Nov 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130773; cv=none; b=KlTj64Q6TKoFtuyohj/G/giQX0H/ANHh87uKL7ims0Fq46rx6E0OoSywWtazR8NUKa0bJwmMWwAGgSAtiMmKf5iRYKY/j2UYw6GEWFoaeoTHRwwCxtrfXaHjB8TzZsGbXBDpnwtvrryNGHowQiavf3/OLMhtQg6kb0wVof6TXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130773; c=relaxed/simple;
	bh=Q0blmjIuOVmZ1uWqzHegccPNOEM4WByfQGUU/TA8TNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoWFWovIb9WeL8iVWoJQwn+KJp5TpnTzslwi3EYunaqGglJkNvay595Inuz8qFAF7Uy7aq6TDGUDNFQ7TzQkcBAGAJRFTMWosWSy6z72GhqqVcA854VYv00VTTicYHvTOQjbWOhVWq85jsbCN7F9NbtT8euflMR3Zbn3IciSt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AnChkPDb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9n6golDYGL0AbMnkiDJo0egqftyXKLLrhDrZyv6hZn8=; b=AnChkPDb4BIef3JpA4cbTNSph0
	M0PZ/t7dtkWGhNwKwst2S6ePumvJvKbaPwDig7gv24qEreMnNH1jsHeama/Ses9E5wnzCXzL8GGNF
	pNpa39uEtYSXB0n0cEdcU2UgOGrlQufubwm+raJXWZ8v2E6vn87EtnLxz6M0NOu5Z3xI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJuqs-00DzHN-1e; Fri, 14 Nov 2025 15:32:38 +0100
Date: Fri, 14 Nov 2025 15:32:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: add SQI and SQI+ support
 for OATC14 10Base-T1S PHYs
Message-ID: <4576bf3a-0945-4745-b7e9-3833cc45027a@lunn.ch>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
 <20251113115206.140339-2-parthiban.veerasooran@microchip.com>
 <f6acd8db-4512-4f5d-a8cc-0cc522573db5@lunn.ch>
 <479bd561-3bc2-44fd-8bab-ecd3e62f9c3e@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479bd561-3bc2-44fd-8bab-ecd3e62f9c3e@microchip.com>

> If I understand correctly, do you mean to store the capability details 
> in the phydev structure when genphy_c45_oatc14_get_sqi_max() is called, 
> and then use them in the genphy_c45_oatc14_get_sqi() function?
> 
> In that case, I may need to introduce new parameters in the phydev 
> structure. Do you think introducing new parameters in the phydev 
> structure is still necessary for this?

I'm not sure it is worth it. Do we expect an SNMP agent polling the
SQI value once per second? Once per minute? One extra read per minute
costs nothing. If it was happening more frequently, then it might be
worth caching the capabilities.

How do you see this being used?

	Andrew

