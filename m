Return-Path: <netdev+bounces-223667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1BB59DF1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E8323E80
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FF31E8AD;
	Tue, 16 Sep 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="22RQ88Lj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789431E89B;
	Tue, 16 Sep 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041007; cv=none; b=b6Z3iVHpsFsQ2nJANPfOugc9PxSxe8n6pA4knlK+0PmzV0GOjdpotrz3LLO7BgG4ZrwICh5hChPsFWhhL/iMUNjKp1WJc8MBgq/JAQkgZ37JZ6MUSkqEgM4GSCO05dq7+/9Q9Lf4NOXkEViAE9Gw15Mk9ucDVYsdhS5mTMP7k+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041007; c=relaxed/simple;
	bh=X+A5QepVxxB/C4oNxZOIEjs1x4Gld77ngaDhdwgfJgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrpK9qLhOow2Q6/q+NQUr/u7rRuKLgDxyOgvZckuRdcNXAGgdzGNwjgpqBPgx6UwcwpRIrj0/0CLLyVelYalVXVHYMivFhBxLloVdY9970t1wb6ehyBlp0RpNKLaxbWCX2l7CzXiLxWySIHBMhjJlWz3qlhDJwWe3RPeZnV4yJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=22RQ88Lj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ujqmExvwfuuSaiII8kWPHE54Lu5K+HYfHMgIwgz3ujA=; b=22RQ88LjeOArVk8mpNe1j9rroF
	RewwsSuOMlgqLrn7G6B+h3ig9x48M9UpRfV3pCCwZWXLAurtqTVLq2zKFKx8BzmrheF10kFLNGZqq
	0ilHdprkMWIV0bvlvgBAchRwQmPVtnvn6DUhk6GhD0uimcEana4WqkwaEIYAmIBKe2Z8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyYm0-008ahz-BY; Tue, 16 Sep 2025 18:43:20 +0200
Date: Tue, 16 Sep 2025 18:43:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: Query regarding Phy loopback support
Message-ID: <3b76cc60-f0c5-478b-b26c-e951a71d3d0b@lunn.ch>
References: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>

On Tue, Sep 16, 2025 at 04:48:56PM +0530, Hariprasad Kelam wrote:
> We're looking for a standard way to configure PHY loopback on a network 
> interface using common Linux tools like ethtool, ip, or devlink.
> 
> Currently, ethtool -k eth0 loopback on enables a generic loopback, but it 
> doesn't specify if it's an internal, external, or PHY loopback. 
> Need suggestions to implement this feature in a standard way.

What actually do you mean by PHY loopback?

88e1118R supports two different loopbacks. It can do the loop at the
PCS, looping packets from the MAC back to the MAC. Or it can do the
loop at the PCS, looping packets from the media back to the media and
also deliver them to the MAC.

The 88e1510 has a slight different loopback. When used with copper, it
can loopback frames from the MAC back to the MAC in the copper
PCS. When used with Fibre is can loopback frames from the MAC to the
MAC in the fibre PCS. Additionally, it can loop back frames from the
MAC in the SERDES layer. And it can loopback frames from the media
back out the media.

From what a know of the aquantia PHY, it can loopback frames from the
MAC at the PCS or the PMA. And frames from the media can be looped
back at the PMA or the PCS.

I expect other vendors have a similar set of different places they can
do loopback, probably with variations.

Or do you simply mean as defined in 802.3, c22.2.4.1.2? And
c45.2.1.1.4, C45.2.1.1.5, taking into account c45.2.1.7.15 and
c45.2.1.12.1? And c45.2.1.18.1, c45.2.1.21.1, c45.2.1.22.1,
c45.2.1.231.6, c45.2.1.232.1, c45.2.1.234.5, c45.2.1.235.1, ...

	Andrew

