Return-Path: <netdev+bounces-233505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A8C14890
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8B8480622
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE930596F;
	Tue, 28 Oct 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t8YAuRVS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A68302178;
	Tue, 28 Oct 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653089; cv=none; b=TvBcF+0iLlaoyuLF46+c/b2UKjkwzLQTSIxfp5lm6/i0LanZSXZ5hnD/MPeTV9/JBCzc6ZaHO3nOlM0hgLFNEIp7ssQ+DpfQZVMhcFj5lnWaUe3EtaIA1uFV/ZoiQRApCpwN8gzTCOJBXc40R0p0/cTu2X0Hia04e0xmyjYlAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653089; c=relaxed/simple;
	bh=Hyvkq2EXoQ5wgFjIXtkqyhoA7AzY70qYK0/S/ucP78U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIKuCvqbEMFYle1aulEmtuG6oPDmOIncHV92aNkSmoawwdN4eXS1u8Hjp/pGskqUMVnXTVg63cPEgGMOdyFBcQLxf5HNhH/PVg58ikuPKNiCmn9bNAxNTW11sEnboRTk6Q2x9agDBZSZHcp2xduLSah5G7BDeL7F7PCAYI/jb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t8YAuRVS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DSY2Q74ssn6ovblRz78TrpaRvJmpAdTlQqQBuBEykFc=; b=t8YAuRVSS0ItPRShf3J5WoDyqa
	rtz9PLZJKiJxOADsKuZRRrBAOqiWJdnZsDHneoACpagwT6S2pwNG96rNfAfRGeLmBZ2YVwnd3NCW9
	5FRGXUr3yERNqGi6zuzJZ1P29fOJmsNYH0cNQQ95M7L3GuJ5aW/hMzWKem6cUIMrkDhs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDiRD-00CIAc-Ok; Tue, 28 Oct 2025 13:04:31 +0100
Date: Tue, 28 Oct 2025 13:04:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy:  micrel: lan8842 erratas
Message-ID: <8b14b2b8-709e-4c83-8028-19ab2df1bac2@lunn.ch>
References: <20251027124026.64232-1-horatiu.vultur@microchip.com>
 <4eefecbe-fa8f-41de-aeae-4d261cce5c1f@lunn.ch>
 <20251028073354.7r5pgrbrcqtqxcjt@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028073354.7r5pgrbrcqtqxcjt@DEN-DL-M31836.microchip.com>

> > I notice there is no Fixes: tag. So you don't think these are worth
> > back porting?
> 
> Definetly I would like to be ported but the issue was there from
> beginning when the lan8842 was added, so I was not sure if it is OK to
> send it to net.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

says:

It must either fix a real bug that bothers people or just add a device ID.

Does this bother people?

	Andrew

