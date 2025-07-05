Return-Path: <netdev+bounces-204312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63560AFA0C5
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D681B3A3E67
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41113AF2;
	Sat,  5 Jul 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMXBtLL6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8781C84CB;
	Sat,  5 Jul 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751730808; cv=none; b=UrWbAvuSnpaY1VqtE06UCGVns8b3zCdnkU3sXkuVtrMoUs6SrSbOkhDxAx5sXH9NAmdkykLL4iO66d4sp09p0t0yU8NJgKQOd2VsAy/B8s90tEDDMjSrc7dqccfQPwGBRdJf0ysiME2spcYk7sIdNtBdDcyaPWuouDtchG4iKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751730808; c=relaxed/simple;
	bh=oX1VNYEe3lbKU3FygZPrdvbR4tQOPho84IndQvzwPsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXRTJSKOASJq+u8hUebQEneMQFgw6boPiknhW5Uny2WT5kz6hqJAO6BPPa2SjOgv9iSIcQTumpLCwHm/NIamZf35JZvbr191NxSF+4V6ZkQ2BZQFRWS22ncpxW0VBGsKNCdwU13Azmfs4crXgHXXVyUnCtJ4HFH7qP5y4+Eg7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMXBtLL6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C9DdcRnfhBPVW8W/FOonIsGDCqFd6aCoYB1it47q3jI=; b=oMXBtLL69nrFLRPhn8plV4StT+
	zuaDIJP3Dv1xML9osG1Blf2kQE9PLJdZwDHY0o11qQ3A/S7QYfM8xl/MiYCUKDz1MTVPbFmxf791f
	YNxhkwwi+9lynapFkvITxXGOzjZdWZbfoyL2jMOVCtSdnvi9QZNl3Vhcu1Pzubhnp6Dw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uY5CX-000Qaj-UY; Sat, 05 Jul 2025 17:53:17 +0200
Date: Sat, 5 Jul 2025 17:53:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Message-ID: <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
References: <20250628054438.2864220-1-wens@kernel.org>
 <20250705083600.2916bf0c@minigeek.lan>
 <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>

> So it's really whatever Allwinner wants to call it. I would rather have
> the names follow the datasheet than us making some scheme up.

Are the datasheets publicly available?

	Andrew

