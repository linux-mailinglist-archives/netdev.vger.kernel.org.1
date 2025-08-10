Return-Path: <netdev+bounces-212362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3438B1FAB2
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD13116EB90
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BD1993B9;
	Sun, 10 Aug 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L4H2zlPi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD2FC0B;
	Sun, 10 Aug 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838983; cv=none; b=izL2udw1RUxa4RKkk3G4CRijXyplOSbkqrUwefV6Ty7AeMIEeh9/AYIupqhDd99Ul91yhsexl816R2Q3/qMfAkg4aD39ecVFktb+01m1EhgeC7Ozpoeyf9k0nD9Px4j+ShQT5c+rPZXwQEPY3AhUWx7K+GQy6Civm70L4zAAyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838983; c=relaxed/simple;
	bh=TIjMptdrVJFNzpbDrRowzFsMR9yAEgJ54QdseOUYEyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs+DYutByENiQ5IY7miveIrI49kg6w8LHPs4m+9NdQwM1rxKuAvcbQebSheRH2MwtEQ5Djjzg8mFXYz+FlMlu/l+pbZ5A2VPA/kySnBg2IBIRqDR6eBJ2eRDGCftynvOGCjNi/KxItUUpAEgolT/+/8P5AwysDeCy6SX8HhHxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L4H2zlPi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EUPUnoEBAZfqIDY+8Nh2cj2EKAuWKbwsRCUV0UW5AoQ=; b=L4H2zlPio+LxDuUxZereeQXnZc
	B3QZXrgzoFR6bTsfCEYwckhqPmrMjg300hzGQ1dt3EkhCvNjJ9gkPQB0uEJPsgSBArk7SLOcw6ZX5
	7ZxsRaveVC/PBTTdiYsJXy6NH7nHMrfQwXZH+O4WQ3nPUYt7HGfePlvQ2YvmlgpX1qyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ul7mB-004EAx-FO; Sun, 10 Aug 2025 17:15:59 +0200
Date: Sun, 10 Aug 2025 17:15:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: jonas@kwiboo.se, alsi@bang-olufsen.dk, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, heiko@sntech.de, krzk+dt@kernel.org,
	kuba@kernel.org, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com, robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
Message-ID: <1f2f8eda-3056-48bd-9c86-3fb699f043f3@lunn.ch>
References: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
 <20250810140115.661635-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810140115.661635-1-amadeus@jmu.edu.cn>

On Sun, Aug 10, 2025 at 10:01:15PM +0800, Chukun Pan wrote:
> Hi,
> 
> > I had only tested on a next-20250722 based kernel and on a vendor 6.1
> > based kernel. And similar to your findings, on 6.1 based kernel there
> > was no issue only on the newer kernel.
> >
> > I will probably drop the use of "/delete-property/ snps,tso" and include
> > a note in commit message about the TSO and RX checksum issue for v2.
> 
> After my test, this problem is caused by commit 041cc86 ("net: stmmac: Enable TSO on VLANs")
> https://github.com/torvalds/linux/commit/041cc86b3653cbcdf6ab96c2f2ae34f3d0a99b0a
> 
> It seems that this commit just exposed the TSO problem (with VLANs).

I'm not sure that is correct. What this patch does is enable TSO for
VLANs by adding the VLAN header to the packet in software before
transmitting it, rather than asking the hardware to insert the VLAN
header as it transmits.

What i don't understand yet, is what has VLANs got to do with DSA?
Does the DSA tagger being used not actually insert a switch specific
header, but is using VLAN overlays? Why is the VLAN path in the stmmac
transmit function being used?

Just a guess, but maybe it is a DSA tagger bug? Maybe the user frame
is a VLAN frame. The tagger is placing the VLAN tag into the DSA
header, so in effect, the frame is no longer a VLAN frame. But it is
not calling __vlan_hwaccel_clear_tag() to indicate the skbuf no longer
needs VLAN processing?

	Andrew


