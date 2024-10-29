Return-Path: <netdev+bounces-139772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEA9B409A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56911F228FD
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67127453;
	Tue, 29 Oct 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ld8whNO2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38E4400
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169936; cv=none; b=MrS7JCHQgQPhTxD/gMNBgDjhYP15iVGNgl0xCv7S8tPBc158ZAgjpVBE+gsYCcxn3fNfh+ryZcMcBdnNNIJ5qMd4H90PgPrqH6vqTP68WLolDLp7zBPZXQCQPfZoAtu9Q+J7mFVhbdVhfh/QJ93WTllI6BDVCIzNUds8VOMmems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169936; c=relaxed/simple;
	bh=npF8Z8FQPqyeMR+uv5x47P15wv/ciuZ1hSal9F4AMLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWkAeMPPZAZgr+IA8bjyGF25ZoffpiYnXrmMRQtCD8CrLjtUgzdPe5TVhEs0WDUpC/K5GVh8yluQ7TIW+CoHfUF5RjYTY/25+F6ce/WbuniU6pyYjCE9Ze0MK75NYsmfh/SalGZJnM3Os0EGufHpN8VIcikcxkn9SYX2xfxY/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ld8whNO2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xV97tYLWnfBrWsu7JCgtdCrJV6DEN3bi7Y6yRSEm6BM=; b=ld8whNO2tIFFkv0huIER7yyRbg
	1QThCuNOY0/7B2sjx4WcCI94oUs1c72zqZ5Eaz925UcBR6I7tMdmBU8l0xNaNi7anX+rMajHbR+CK
	Iq1Lbp6AHf+iWo+2VTiFWR0SkQEuI831vi6lyAJhYWOr+1+vA+fLs/GiKbazvwwUKIFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5cEW-00BWFS-9H; Tue, 29 Oct 2024 03:45:24 +0100
Date: Tue, 29 Oct 2024 03:45:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection
 for PHY drivers
Message-ID: <04baac62-ace2-4f44-a32e-640f30b24d96@lunn.ch>
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028203804.41689-2-gerhard@engleder-embedded.com>

> -	int (*set_loopback)(struct phy_device *dev, bool enable);
> +	/**
> +	 * @set_loopback: Set the loopback mode of the PHY
> +	 * enable selects if the loopback mode is enabled or disabled. If the
> +	 * loopback mode is enabled, then the speed of the loopback mode can be
> +	 * requested with the speed argument. If the speed argument is zero,
> +	 * then any speed can be selected. If the speed argument is > 0, then
> +	 * this speed shall be selected for the loopback mode or EOPNOTSUPP
> +	 * shall be returned if speed selection is not supported.
> +	 */

I think we need to take a step back here and think about how this
currently works.

The MAC and the PHY probably need to agree on the speed. Does an RGMII
MAC sending at 10Mbps work against a PHY expecting 1000Mbps? The MAC
is repeating the symbols 100 times to fill the channel, so it might?
But does a PHY expecting 100 repeats work when actually passed a
signal instance of a symbol?  What about an SGMII link, 10Mbps one
side, 1G the other? What about 1000BaseX vs 2500BaseX?

I've never thought about how this actually works today. My _guess_
would be, you first either have the link perform auto-neg, or you
force a speed using ethtool. In both cases, the adjust_link callback
of phylib is called, which for phylink will result in the mac_link_up
callback being called with the current link mode, etc. So the PHY and
the MAC know the properties of the link between themselves.

> +	int (*set_loopback)(struct phy_device *dev, bool enable, int speed);

You say:

> +                                    If the speed argument is zero,
> +	 * then any speed can be selected.

How do the PHY and the MAC agree on the speed? Are you assuming the
adjust_link/mac_link_up will be called? Phylink has the hard
assumption the link will go down before coming up at another speed. Is
that guaranteed here?

What happens when you pass a specific speed? How does the MAC get to
know?

I think we need to keep as close as possible to the current
scheme. The problem is >= 1G, where the core will now enable autoneg
even for forced speeds. If there is a link partner, auto-neg should
succeed and adjust_link/mac_link_up will be called, and so the PHY and
MAC will already be in sync when loopback is enabled. If there is no
link partner, auto-neg will fail. In this case, we need set_loopback
to trigger link up so that the PHY and MAC get in sync. And then it is
disabled, the link needs to go down again.

	Andrew

