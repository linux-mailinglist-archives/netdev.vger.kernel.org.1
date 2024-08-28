Return-Path: <netdev+bounces-122923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B029632E5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA6286B66
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601A1AC448;
	Wed, 28 Aug 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OKQgy4ys"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FF15ADB8;
	Wed, 28 Aug 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877941; cv=none; b=iRJTH9F3Xys0nEDKS2mJubE01/kHptX2vMPRCKs+/1XTdkIAKzR/xVEf4jUaa11+QtI5dxGN++I3TxUF4Gljd8X/bK5iNEjo0lFee7zDTIw6sNPBcNznyv2OqKV+t6NGUNcwyeXz1fq/TB/6Z3Yrww5ypjLrdVSkDS1dPR6B2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877941; c=relaxed/simple;
	bh=SgkVzbZ14XDCKU36J6WIIsAV8YesujpxnFyHSFaz29I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlJIQKs/eri4jxiOjUG/ZS8dapx6GZxt67q0SIPZWFmSZj1v1coPNPefngH1UafusQcRJu0+recOF9bmmRkDEYS37zX04FpIMimbBB0pp7ounfBtUXtjuTG3eGEGm7L+u6+3Up3eTB9BQS6s0Pso0mfAK0nAMxOTxzqm5Yf8DF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OKQgy4ys; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=26bQlRFk72rfSBekGYpkyGTtRJqwYyFZxRzNApkdSOw=; b=OKQgy4ysRnacVUQNcvrpOFp0SO
	LP6MhA9Y051p7GyB8Tp6/9SoSV1bVKBHABXj65p6vM8XvjsX6MG4hLS/hnOQ9RWujM28wSrjNmPrC
	sVXVOx1upE+wWFfv4ZXyIWsmMZwKIOrhflCWBr8H/eywcwgvt8qNeD98pXr5fTpMi8TY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjPXo-005yGF-EH; Wed, 28 Aug 2024 22:45:32 +0200
Date: Wed, 28 Aug 2024 22:45:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <ac794205-ec9a-4e92-aa74-7c0f9ee67823@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
 <20240826093217.3e076b5c@kernel.org>
 <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
 <20240826125719.35f0337c@kernel.org>
 <Zs1bT7xIkFWLyul3@pengutronix.de>
 <20240827113300.08aada20@kernel.org>
 <Zs6spnCAPsTmUfrL@pengutronix.de>
 <20240828133428.4988b44f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828133428.4988b44f@kernel.org>

On Wed, Aug 28, 2024 at 01:34:28PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 06:50:46 +0200 Oleksij Rempel wrote:
> > Considering that you've requested a change to the uAPI, the work has now become
> > more predictable. I can plan for it within the task and update the required
> > time budget accordingly. However, it's worth noting that while this work is
> > manageable, the time spent on this particular task could be seen as somewhat
> > wasted from a budget perspective, as it wasn't part of the original scope.
> 
> I can probably take a stab at the kernel side, since I know the code
> already shouldn't take me more more than an hour. Would that help?
> You'd still need to retest, fix bugs. And go thru review.. so all
> the not-so-fun parts
> 
> > > Especially that we're talking about uAPI, once we go down
> > > the string path I presume they will stick around forever.  
> > 
> > Yes, I agree with it. I just needed this feedback as early as possible.
> 
> Andrew? Do you want to decide? :)

I agree about avoiding free test strings. Something more structures
would be good.

I can definitely help out with review, but i don't have any time at
the moment for writing code.

	Andrew

