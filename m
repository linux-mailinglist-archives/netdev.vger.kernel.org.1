Return-Path: <netdev+bounces-240077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 967BEC701C0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7E2B02F19D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92536C5AF;
	Wed, 19 Nov 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY2sAWIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD73538BF;
	Wed, 19 Nov 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569835; cv=none; b=i/kWVxEKCvCuvTsualJ+83Nj/aA5mg14gNLwJJhakG0l6p9c+IWdTVzlUFMoHhyjsNPd0+WaLA50ToiE7ZXytU17D9Vl79BFaPQm3d2hRviRbIVFfup2hwV6f2Uh5U56rBwWjNO+/HEf8sBrpGLNgmQDE3VFcu7j8xtt8w9ilp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569835; c=relaxed/simple;
	bh=FpZOJeYflTW8rwLZyA92ajlUDALogMVssxvbPbQomU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFwtYbrN1VT0CZXwjsCe/ba+gu3HqJUL5ATs50eP37b5LvCn416OhW5AEGWoTKafE+LdlA7L+tkUwg7DX3rLIhr0yHWl0H+LnLG/2qmVQNkWuCPa6Q/T/dQeZ6+2v1lgB8nV2lxCwXmFKYRGVGeLsOfEJ0E9kDe/tYozaNl8IJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY2sAWIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709DCC4CEF5;
	Wed, 19 Nov 2025 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763569834;
	bh=FpZOJeYflTW8rwLZyA92ajlUDALogMVssxvbPbQomU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bY2sAWINnk8EB7ymmKSXH1OKyQuX+cYgOUUR2I2ZKIHWQ4Wi7Xb2uSH+JhnZp2LrF
	 V8s2wW/e8ZCd3pjK0+6e+pG+cVYBuOxJkVW0ghLzW48KvI3gfMXY9MV7g80kEGh7Ui
	 VOz1mm8itzwWul8m/LORTJhDHFjXCOS+X0kJI8efOXRUq7Ia/9H5LPzZ8dCBJT2C2i
	 TRKdBOqUUV7a3i4Scs7A3mJjDxkAFD/5hnS0hSBJSYu0IpUec2e1d1diRxFE/jAdOU
	 KxZz8e2jREmDYgdg26TyPeIuVFuPlD893jFQHoyig3pFwLdPdc+oMJvBwBbOH4iTMQ
	 zSloGnsON9Mgg==
Date: Wed, 19 Nov 2025 08:30:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
 <eric@nelint.com>, "maxime.chevallier@bootlin.com"
 <maxime.chevallier@bootlin.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Message-ID: <20251119083033.6a4d3ed4@kernel.org>
In-Reply-To: <aR3q6_CS2A1VH236@shell.armlinux.org.uk>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
	<aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
	<PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
	<aRx8Zh-7MWeY0iJd@shell.armlinux.org.uk>
	<PAXPR04MB8510BA569EB34E26E1A499BB88D7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<aR3q6_CS2A1VH236@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 16:06:03 +0000 Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 01:22:17AM +0000, Wei Fang wrote:
> > I'm sorry, I was in a rush to send out the v3 patch, and I hadn't received
> > your Reviewed-by tag at that time, so the tag was not added. When I saw
> > that you gave the Review-by in v2, I realized that I could no longer add it
> > to v3, so I replied that I had sent v3, hoping that you could resend your
> > Reviewed-by tag.
> > 
> > If you don't mind, I will refine the commit message as Andrew suggested
> > and add your Revived-by tag from v2 to v4. I apologize again.  
> 
> I also question the need to refine the commit message this much. One
> of the points of lore.kernel.org is that it provides a stable source
> for mailing list archives. We use URLs to that site extensively in
> the kernel development process - e.g. it's recommended to use it in
> Closes: tags, and to reference discussion from commit messages. If
> I look at the number of times lore.kernel.org has been mentioned in
> commit messages since 6.17, it comes out at around 5700 to date.
> Looking back to 6.16, it's about 13000.
> 
> So, lore.kernel.org is already an insanely valuable resource to the
> kernel community, and the loss of it would result in a lot of
> context being lost.
> 
> We have had problems with other sites - lkml.org used to be the
> popular site, but that became unreliable and stuff broke. However,
> the difference is that lore.kernel.org is maintained by the same
> people who look after the rest of the kernel.org infrastructure.
> 
> Moreover, using lore.kernel.org is encouraged when one wishes to
> link to discussion. See "Linking to list discussions from commits"
> at the bottom of https://www.kernel.org/lore.html
> 
> So, I think there was no need to go through v3, inflating the commit
> message, and end up in this situation.
> 
> Every time a patch gets reposted, the netdev cycle (as far as the
> netdev maintainers are concerned) restarts, and it means a multi-day
> delay before the change gets committed. As things stand, this is
> likely to miss tomorrow's linux-net tree submission, which is
> highly likely to be the last one before 6.18 is released. So we're
> not going to get this fixed before the final 6.18 now. And for
> what value? None as far as I can see. The patch was ready at v2.

We would have also avoided a lot of wasted time here if the authors
just mentioned in the discussion on v2 that v3 is out :|

Let me fix up the Link tag here and apply this so we can move on.

