Return-Path: <netdev+bounces-185214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E172EA99518
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDA921294
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7927F73E;
	Wed, 23 Apr 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOL0aXFz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAD242D64;
	Wed, 23 Apr 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425023; cv=none; b=ppcHA3rGo07rcR3CsJwOyUc4vG96d2uhmnrhAz3CjMLdjal9bz5SNwlrqdPP8+GQQQEsDsBf0hjD59ctz/PjXNnqnDdShhsJTsvokeW+72dbWodSyfDA+BK1NOsWAYPHdHoph6NagPgIxGRx6qjGccv1bX0dlr/gjvUWK3/nAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425023; c=relaxed/simple;
	bh=wKluyXSVCGMs1uHzOLDesIs6Jy0lLRWqIZf87RypGqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azHffgL3mzoLzdPBefUOwCIpbpihHkkurEm2teKPSNFTaL4WesKBFkBYtXD/ZG8rgbyDLsE8Sm7hK49HjU5uMIAS1nJl6ZYJ7EtKzGMue9NYgLJxICkzapPrNIfV838j0UpC+IAUJVTJeHEL+tArofa044vP9oDhqPdhrZYytoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOL0aXFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8860C4CEE2;
	Wed, 23 Apr 2025 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425022;
	bh=wKluyXSVCGMs1uHzOLDesIs6Jy0lLRWqIZf87RypGqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOL0aXFzmP5sU0oV3s7pagYBfN4DZ5R+8+TKmpnEPCTFYX7zsrGJVit7dXr7HQ4lu
	 U+Y3UZpLbf3MY6LalWrr5UrUgpF/+wyGYB/5AKPQmG7/kYpxh3xFrA+Y8zV/YirOUI
	 xlkkmgLY5eEk5gQzIM9xO9Yj9vzHYtmYZssjtlzQZqpLlRZDiRi7QrKdhydRAXEGmG
	 u23b2p6rVTSHCt3AJccBYe/SnczCICTW07jtHnZYvu4egdTtHy9/2Z71quouikZuaB
	 s1VNVGq4pc6hmOixwTBaqO6gNhMLJwnEp6D+6Pme20K/QxJN9T4y1R8BSTswt9mN97
	 ydJITMmZF1uGQ==
Date: Wed, 23 Apr 2025 17:16:58 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v3 2/3] rtase: Increase the size of ivec->name
Message-ID: <20250423161658.GC2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-3-justinlai0215@realtek.com>
 <20250422125546.GF2843373@horms.kernel.org>
 <01039f49e5104f31975999590e6c0a7e@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01039f49e5104f31975999590e6c0a7e@realtek.com>

On Wed, Apr 23, 2025 at 11:53:12AM +0000, Justin Lai wrote:
> > On Thu, Apr 17, 2025 at 04:56:58PM +0800, Justin Lai wrote:
> > > Fix the following compile warning reported by the kernel test robot by
> > > increasing the size of ivec->name.
> > >
> > > drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
> > > >> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning:
> > > '%i' directive output may be truncated writing between 1 and 10 bytes
> > > into a region of size between 7 and 22 [-Wformat-truncation=]
> > >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> > >                                                      ^~
> > >  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note:
> > >  directive argument in the range [0, 2147483647]
> > >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> > >                                               ^~~~~~~~~~
> > >  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note:
> > >  'snprintf' output between 6 and 30 bytes into a destination of  size
> > > 26
> > >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> > >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >        tp->dev->name, i);
> > >        ~~~~~~~~~~~~~~~~~
> > 
> > Hi Justin,
> > 
> > Given that the type of i is u16, it's theoretical range of values is [0, 65536].
> > (I expect that in practice the range is significantly smaller.)
> > 
> > So the string representation of i should fit in the minumum of 7 bytes available
> > (only a maximum of 5 are needed).
> > 
> > And I do notice that newer compilers do not seem to warn about this.
> > 
> > So I don't really think this needs updating.
> > And if so, certainly not as a fix for 'net'.
> > 
> > Also, as an aside, as i is unsigned, the format specifier really ought to be %u
> > instead of %i. Not that it seems to make any difference here given the range of
> > values discussed above.
> > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.
> > > com/
> > > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > > module")
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > 
> > --
> > pw-bot: changes-requested
> 
> Hi Simon,
> 
> Thank you for your reply. I will modify the format specifier to %u.
> Since the warning from the kernel test robot is a false positive, I
> will not address this warning, meaning I will not increase the size
> of ivec->name. This patch will be posted to net-next.

Thanks, sounds good to me.

