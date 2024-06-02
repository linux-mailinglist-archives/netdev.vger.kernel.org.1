Return-Path: <netdev+bounces-100018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976E38D775A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1922813F3
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861795B1FB;
	Sun,  2 Jun 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O8w7g2UM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9165BAD7;
	Sun,  2 Jun 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717350581; cv=none; b=P/FzOQvPkG/NwBA/mAjyWBI4X+WDfD6SC1J26kNfuE9TdiTBFr1CwQuM6cM7dpbjkt8ofyQ/mxwodnPchYR7R+ashihw0SwmqMg9AsDdEVMVJE20Zyc3Pz2TwFjlfgODCRTAkawb31iRlyUSedvSjdcaUMtOIl61H7epAwjFcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717350581; c=relaxed/simple;
	bh=BMaJyUYyFlrCDiq6D+RqsBfR4PTgy9fHEvtBj32ZTIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1rTWMJ1IeOEYCBohV3xBfkNq4L71Rul7fCaiT/whIBB+4768g28drwPQv8hlYAF1vX7WPOK9p2AFITs3KlU+D/ar98sUoM0E1sKlICS0IDFcFUggACWxUPV6/JtZW8KmqtXEaGWOuMpLKWcs2kWVRwOG0T8PzoDctdnNBCiOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O8w7g2UM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=byCtsjLVsR8MNvcIFo06ZFMO7iciMwZyIraJ52in2x4=; b=O8w7g2UMnZTu/PRptTEnTo+W7K
	RxPLdBaW7k1UH7E3iVk1CktgE2aobT6hFnfgcHiMqQWh2XbQjBQLEkg6WNkPzXC+P21EOENF75+uN
	x+dTQOae1KifMHVfaMdWq6Oym/gMB9ovvP6RaHXYu3qydEGKtZnXljsvK3C82K/y8Ymw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDpKj-00GeK2-BY; Sun, 02 Jun 2024 19:49:29 +0200
Date: Sun, 2 Jun 2024 19:49:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 2/3] arm64: dts: airoha: Add EN7581 ethernet node
Message-ID: <1ffe4a56-c3fc-4553-aa32-c7a0d9780b5c@lunn.ch>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>
 <e79b7180-74ef-4306-9f73-47ee54c91660@lunn.ch>
 <ZlyuCeh9vOaZJsGy@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlyuCeh9vOaZJsGy@lore-desk>

On Sun, Jun 02, 2024 at 07:38:17PM +0200, Lorenzo Bianconi wrote:
> > On Fri, May 31, 2024 at 12:22:19PM +0200, Lorenzo Bianconi wrote:
> > > Introduce the Airoha EN7581 ethernet node in Airoha EN7581 dtsi
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/airoha/en7581-evb.dts |  4 +++
> > >  arch/arm64/boot/dts/airoha/en7581.dtsi    | 31 +++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/airoha/en7581-evb.dts b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > > index cf58e43dd5b2..82da86ae00b0 100644
> > > --- a/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > > +++ b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> > > @@ -24,3 +24,7 @@ memory@80000000 {
> > >  		reg = <0x0 0x80000000 0x2 0x00000000>;
> > >  	};
> > >  };
> > > +
> > > +&eth0 {
> > > +	status = "okay";
> > > +};
> > 
> > Is that enough to make it useful? Don't you need a phy-handle, or
> > phy-mode?
> 
> This changes is actually in a subsequent patch (not posted yet) where I will
> add support for the mt7530 dsa switch. Do you prefer to add it here?

I would prefer you move this later when you add the switch.

	Andrew

