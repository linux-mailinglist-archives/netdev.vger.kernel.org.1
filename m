Return-Path: <netdev+bounces-82489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAA88E5E9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEA528B670
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008412F378;
	Wed, 27 Mar 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UojXrXQO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21A37711
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543677; cv=none; b=qzdnxNLZyuCg+eRYAoIgc23Bu5bLE+Osy1mHhzs3EjwRSNKgEYzklmYUXz7fDhGFFq+KfrB2PHZgGn5VO6hrRMh7Ha0Q8KToYONA6C6QYBzAWNNnowotvC+4BXjCrHeWYO41r/nHeMTuGyWi+MdjMtvpzmgjH8JAEdPWGTlIemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543677; c=relaxed/simple;
	bh=ycXO8RaqLOO260i8Qen21R213eBB3AqbVjSglqCRQ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJUvIgy2hHUPdtoy/Z0F5Hfw2jqOtMA3Ny9l9gOx5YtPAW0nItULr7VkySj3RDWeKTJhpaAQwPaxa2zX9cM2a1qxBtY22M8I/jlw1YHCXcvcULo7EfOp1b1WFno4qVYqJd324E2ZlcpyjHs24rZb0dZzUb/NJoh6xPV1zcAD+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UojXrXQO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=R3HTWNASLWmTMH76FL3kCLA26idudbGRSg6DVKbF+Nc=; b=Uo
	jXrXQOoFikZJ7LjrtK8yTUy/EdV5vHXbBQVj0ttRJFKzgUZywwOc0BuNiKIPG0zbu2IBkddFSWCIn
	Rz3VmNmkuTVSU0/533wKv1G+fRK9DCuXaFiuFSwh1nPtsS0wvZ5HGHj1IjHALdKDaDeyDr2piYVYg
	u3qZfw7//GAGCU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpSgy-00BOMN-H0; Wed, 27 Mar 2024 13:47:44 +0100
Date: Wed, 27 Mar 2024 13:47:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <234e3ee5-ff39-4691-943d-c46dbdfde73b@lunn.ch>
References: <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
 <5aad4eea-e509-4a29-be0a-0ae1beb58a86@loongson.cn>
 <593adab6-7ecf-4d8f-aefb-3f5eea24f3fc@lunn.ch>
 <8d6eed68-0719-4a30-9278-6faea3174d23@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d6eed68-0719-4a30-9278-6faea3174d23@loongson.cn>

On Wed, Mar 27, 2024 at 10:41:57AM +0800, Yanteng Si wrote:
> 
> 在 2024/3/26 20:21, Andrew Lunn 写道:
> > On Tue, Mar 26, 2024 at 08:02:55PM +0800, Yanteng Si wrote:
> > > 在 2024/3/21 23:02, Andrew Lunn 写道:
> > > > > When switching speeds (from 100M to 1000M), the phy cannot output clocks,
> > > > > 
> > > > > resulting in the unavailability of the network card.  At this time, a reset
> > > > > of the
> > > > > 
> > > > > phy is required.
> > > > reset, or restart of autoneg?
> > > reset.
> > If you need a reset, why are you asking it to restart auto-neg?
> Autoneg was discussed in patch v1, but we may have misunderstood the
> description from our hardware engineers at the time. The root cause is that
> there is an error in the connection between the MAC and PHY. After repeated
> tests, we have found that
> 
> auto-negcannot solve all problems and can only be reset. Thanks, Yanteng
 
So calling phylink_ethtool_nway_reset() does not fix your problem, and
you need some other fix.

    Andrew

---
pw-bot: cr

