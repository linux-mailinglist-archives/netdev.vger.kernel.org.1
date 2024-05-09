Return-Path: <netdev+bounces-94931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB068C1075
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAA1F22C79
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11E1527A2;
	Thu,  9 May 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="euwM0qc5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9B1527B9
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261880; cv=none; b=oXpb82a9Kiy+Dj76Qqh/8pO3H8oCd+SQIWxzjTDdGF2eWoypr2mazO4rlFpKWB2Lxdnqf0aBygL3oDD4ilS+Mlr6LiUpneyki7gU/0480OnVLIN1vb1GYuHEhmpQXkp1cmmymKRF2fvcZnMFhXy7VfyWxc0QTyGSRiRmCFdYBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261880; c=relaxed/simple;
	bh=8UkBkwNc8lbDk0ADX32izqNyxF0iIg2P/xWQp1aWto4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaD0EyALz2rF2N2EGtYhw8JMqs2BsozdGY1fKTRPPmwVN3GFpcwAJDEEj1dg6W3T0W/ipzPkaDfqYVne5Um0IIeHlHmmB7xzOaOwZ/GGvCxFuh/ymHr7sRBMZLbmPaJUTRqGgnGymcUrACubJp4NYe2PNMpAI4ubtz/W6cGjCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=euwM0qc5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DIJqFifCkdgc1FQ8s9IU/MACGPqNXYZlj7w9tfFe1Dk=; b=euwM0qc5EU7iN6ermxBIaaSvY3
	pAR5GKQ1npCEqbaUhten2iOawAQOcg3koTuNvxxTkMvEx97SFmEU+qc0zJx3ZBtAic6gxXLBdXDxV
	yNB3xvF6QHqDgchxY2mMe8eJvSQcCaT6Ua8fSDK9iPbCKrWmReT/SNEJaCsv0b9o+/Vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s53y7-00F31n-Tc; Thu, 09 May 2024 15:37:55 +0200
Date: Thu, 9 May 2024 15:37:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
	horms@kernel.org
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
Message-ID: <a7c9f272-9c5c-4aba-b7db-ae62e9cc8d0a@lunn.ch>
References: <20240501230552.53185-7-fujita.tomonori@gmail.com>
 <7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
 <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
 <20240509.132341.474491799593158015.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509.132341.474491799593158015.fujita.tomonori@gmail.com>

On Thu, May 09, 2024 at 01:23:41PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Wed, 08 May 2024 22:18:51 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
> >>>  		priv->link = 0;
> >>>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
> >>>  			/* MAC reset */
> >>>  			tn40_set_link_speed(priv, 0);
> >>> +			tn40_set_link_speed(priv, priv->speed);
> >>>  			priv->link_loop_cnt = 0;
> >> 
> >> This should move into the link_down callback.
> > 
> > I'll try phylink callbacks to see if they would work. 
> 
> I found that the link_down callback doesn't work well for the MAC
> reset above.
> 
> Currently, when TN40_REG_MAC_LNK_STAT register tells that the link is
> off, the driver configures the MAC to generate an interrupt
> periodically; tn40_write_reg(priv, 0x5150, 1000000) is called in
> tn40_link_changed().
> 
> Eventually, the counter is over TN40_LINK_LOOP_MAX and then the driver
> executes the MAC reset. Without the MAC reset, the NIC will not work.
> 
> The link_down callback is called only when the link becomes down so it
> can't be used to trigger the MAC reset.

So this sounds like a hardware bug workaround.

But it might also be to do with auto-neg. The MAC PCS/SERDES and the
PHY PCS/SERDES, depending on the mode, should be performing auto-neg,
to indicate things like pause. For some hardware, you need to restart
autoneg when the line sides gets link. It could be this hardware has
no way to do that, other than hit the whole thing with a reset?

Take a look at struct phylink_pcs_ops and see if you can map bits of
the driver to this structure. It might be you can implement a PCS, and
have the pcs_an_restart do the MAC reset.

     Andrew

