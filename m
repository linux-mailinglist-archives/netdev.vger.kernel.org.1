Return-Path: <netdev+bounces-179944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783AA7EF6F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C033A6EA7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718931FAC59;
	Mon,  7 Apr 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AMOhotvM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93988158553;
	Mon,  7 Apr 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744058890; cv=none; b=rjxbw71BXtqS5/Iv88GDyqDStUIuyKdATB9qYr9bMOWXHE+70RHQHi4G7qzdBjRv3UYtUBrwimILdxy/8rJTjnuh3dksjNT/ZSsi0l/hXSKb2xawh1A3JTJffXaSi4J+Q/GH+isTmZnuAki5bf13VJPZSxeWzN5WY6FrmTaDZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744058890; c=relaxed/simple;
	bh=YbD2zGr3oTl7GCC5GZZTiIq8brvmJyMYRBncNLenDXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoEwLqBF6Z1C0JXgYpUI0OK6SickW9OMmUW3C/8PePOENYWpXHPSc+naO0JpKXZILy6oxSvRNuml2vBpeMplCatxSG15r31TZ6zvtA69NL39iVeI4njL2G16MoQ9VHeca3JYR1/zqavdpP1PlPVlXLhD+sv9KBkmpU+gXpVFWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AMOhotvM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i0OLWtcawuW+JGMhWAwnpZnfP3eNBnJgt9e+MtCZNmI=; b=AMOhotvM+QLD1t3vfzZeWzTKpW
	am4upSp1EO0eWTzsbneLIQBxY0fTC77zoH01+XmLDdYVlNJjukZyUDVr8MakJ0hPVc4xz0WYxBBu6
	CRS18rxYD5X6BBiF9978Rxp82eW4i/+vaI1Q4++2bUzTKD0fIfowLElYzH20np4gpIfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tNx-008Iv0-Fl; Mon, 07 Apr 2025 22:48:01 +0200
Date: Mon, 7 Apr 2025 22:48:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <86ac7c66-66da-458f-960a-3b27ba5e893f@lunn.ch>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407134930.124307-1-yyyynoom@gmail.com>


> Additionally, the previous code did not manage statistics
> in a structured manner, so this patch:
> 
> 1. Added `u64` type stat counters to the `netdev_private` struct.
> 2. Defined a `dlink_stats` struct for managing statistics.
> 3. Registered standard statistics and driver-specific statistics
> separately.
> 4. Compressing repetitive tasks through loops.
> 
> The code previously blocked by the `#ifdef MEM_MAPPING` preprocessor
> directive has been enabled. This section relates to RMON statistics and
> does not cause issues when activated. Removing unnecessary preprocessor
> directives simplifies the code path and makes it more intuitive.

When i see a list like this, it makes me think this should be broken
up into multiple patches. Ideally you want lots of simple patches
which are obviously correct.

	Andrew

