Return-Path: <netdev+bounces-119795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C701956FD4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9531C21F6F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EB16C6AD;
	Mon, 19 Aug 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KXKxOMB6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644113B7A6;
	Mon, 19 Aug 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083747; cv=none; b=eW+A5zOwoFUud/cwG4mmsZrn5ktpD97EFUOAyodCy6VSb8E7u5g7TWrmaQM9TIgzKGPQdeRMVWijsTM6S5LoMkL6OxnEbm4ZgHdgdkyYALsffOJtILwT21vW2L8fXOQFntN0yGUQXnSc3jGqk2aGuOmRko8vUg8kmrWbBINqgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083747; c=relaxed/simple;
	bh=OLLT6ZJoTU/vrznCPJL1sfYvkEMnTSZDX4GGWxmhJC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB0NJJQxBwUs9gefr2YkrYwFJDdf7udQ+l+vh5Xwe3woDDieacLSwrIK8JcCSNS/XDkqOTfonQro4Bo8bQqPVr0ABu9gOGfu5Ph40CkxnoBnFMT0GV+KBhDvOQULKHDQu9LB7vrzPtepi+6v+oRe0p7eeTgOsUkU9tkyViWzXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KXKxOMB6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqMYMD+6IUDj4bRlF0R3BSI31xnvIIoFarQCHBVRJ00=; b=KXKxOMB6YST1R3PUtyFRKFS+gt
	Bm5MRoHKpfSN9WWJKEmQhztwnzhdVZvPT9myqNTWCGNivGb0F1nastpZgkXcQqyBUqKSp4x9U9oVp
	y5/267mWZYF2uVaxAK2d15zFu8HhYIb1JHAy3+slxTz4i07uioq3U3HcwIksU0cNRR6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg4w6-0058Ds-UC; Mon, 19 Aug 2024 18:08:50 +0200
Date: Mon, 19 Aug 2024 18:08:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	Bryan.Whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Message-ID: <beeeb1f9-a194-4001-9cd0-f8045fb9e0e6@lunn.ch>
References: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>

> +/**
> + * phylink_set_fixed_link() - set the fixed link
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @state: a pointer to a struct phylink_link_state.
> + *
> + * This function is used when the link parameters are known and do not change,
> + * making it suitable for certain types of network connections.
> + *
> + * Returns zero on success, or negative error code.

kernel doc requires a : after Returns. The tooling is getting more
picky about this and pointing out this error. But there is a lot of
code which gets this wrong, so you probably cut/paste a bad example.

    Andrew

---
pw-bot: cr

