Return-Path: <netdev+bounces-172938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D44A568E1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E473F16FAAC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338F21A425;
	Fri,  7 Mar 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JGPn4/aV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B520E00D;
	Fri,  7 Mar 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353976; cv=none; b=OCMQbFCtdDwDNurTi7uehEVBN8PvgD2V8nu5yN9rV18597YsNA1kyTbYxLgwMsSXQNjBa8nIA2FlrC9W14JPEBl8b8DZ3jUDdtoRjYzRjeOpxn/3hip0lB7CpjqGsq14T3pZ5CToH4ILGBSOQHmGxkuP3w2g0LfZQnHWMmzbFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353976; c=relaxed/simple;
	bh=I1DgXJAugaRvo5oHawhY6fpJ1+WEdBWElcFLSX6rCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjqtwteRoH824yDY8ZahDkPAALQIHfAnm9svTbPpDT6qgPt5ujJnowfKgPL8OFOvpZXW586dkMdGRyPSHVd8TRr4K/Ku7mJ9PP3u9nkuMrsWcDq08vUdXTTdPKHeEht7o7ZFCHbi98H04n22p2WmAU+TftrkfJ1DIah4P82wa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JGPn4/aV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1yXC3Xb/MwcJsrS6HKxPIosX6qAp8S61W2EzWPVkdLs=; b=JGPn4/aVIXPXE7o/ElfV+U26Co
	UETfL8Rcs2Wq+/+AgkMbywLJM/iE9EIiTTj34gqwImUs3UE1zT/XZeEMzktenZwlNEvt1J4v4hOUT
	AzI2q/m+ksf9wvg9aGH026Z0T1LP+nR46y9kMHn7QV3nq3rygJ2JVVOOkIZ3WG7w9Lv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqXiA-0039Aa-GR; Fri, 07 Mar 2025 14:25:58 +0100
Date: Fri, 7 Mar 2025 14:25:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable Ethernet controller on
 Radxa E20C
Message-ID: <c7fe0371-76bc-4cb4-ade8-e22112c1475d@lunn.ch>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-5-jonas@kwiboo.se>
 <e0e8fa5e-07a2-4f4f-80b9-ddb2332c27ea@lunn.ch>
 <cbd6d3ee-8ad1-443f-9506-e28240ffb09e@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd6d3ee-8ad1-443f-9506-e28240ffb09e@kwiboo.se>

On Fri, Mar 07, 2025 at 10:16:08AM +0100, Jonas Karlman wrote:
> Hi Andrew,
> 
> On 2025-03-06 23:49, Andrew Lunn wrote:
> >> +&mdio1 {
> >> +	rgmii_phy: ethernet-phy@1 {
> >> +		compatible = "ethernet-phy-ieee802.3-c22";
> > 
> > The compatible is not needed. That is the default.
> 
> Interesting, however I rather be explicit to not cause any issue for
> U-Boot or any other user of the device trees beside Linux kernel.

O.K.  But any system using Linux .dts files should be happy with no
compatible, since that is how the majority are. Because PHYs have ID
registers, generally there is no need for a compatible. The only time
you do need a compatible is:

* The ID registers are wrong
* The ID registers cannot be read, chicken/egg problems the driver needs to solve
* The Clause 22 address space is not implemented and you need to indicate C45
  should be used to get the ID registers.

None of this is specific to Linux.

	Andrew

