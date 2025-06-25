Return-Path: <netdev+bounces-201254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC8AE89F3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3216E1BC551E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52715255E23;
	Wed, 25 Jun 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1uCeWDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225601519B9;
	Wed, 25 Jun 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869304; cv=none; b=H9C+jM+X1lzEERP2krBf5YKDHYTHslfR2CE9UsrgSyGiLr0JJjoAZMDT0psg9VlVxYaiIJUD0mO/c9pPlJDmKdqFAWyJ+KR+J36uL9YKNNQS0rAGiNK47q4VD4qQj0ABSqklpO68Me1ihfVMShipqZ1e+1t9s/nrL18yMtcslOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869304; c=relaxed/simple;
	bh=t/AgadN8uMX4Cd7yqzT2AU8W961H4oHAN2sIoXx/DAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF8NhY4veB34lYjWGiTtf4eL7Zgan0mmUQKn+3vSAy/ZbshihljuIG+euHjZ8RrBHI3NvJl49GRmhKXC0DxTseY+pIhTT66bgXeEFtDs+ol8SHy19EXS3WQIvscHqqWxWdFA0sr/97RTFfEvGh+MpYt58lfCtRwphTES1j5lWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1uCeWDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560CAC4CEEA;
	Wed, 25 Jun 2025 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750869303;
	bh=t/AgadN8uMX4Cd7yqzT2AU8W961H4oHAN2sIoXx/DAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1uCeWDXPm10kCy2w1o/C5S8k3Xg9otCN1jOSmouZUvVLWmZ5BlctOCHlWTemtNM8
	 a5PSis+vaBh1fi+5t4/Q3VXKYxG1i0+GIwFuhV4ivrbLztsa/XIov23Iq43hrzvXwR
	 662CV5Hh4a04vgjQihrG2R86CsLouSFs+Sd35LQTzy9wjJKftLD0e8RYEq7bbUJDcY
	 wXEODdTdx4BGMbKWU0wTzeTN5Pb4Omn3Adr6SehqQQCHem7sVO6tqtJeGgU72JtiMn
	 f7+3yhaBEXCRVyPAidv3Uy1ytJxQNS2oExTq3n0aF2kW1L/wWyrcHQOEu3lIgBYA5N
	 9bK+C6MWFpXvw==
Date: Wed, 25 Jun 2025 17:34:59 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Message-ID: <20250625163459.GD152961@horms.kernel.org>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624181143.6206a518@kernel.org>
 <PAXPR04MB8510EDB597AD25F666C450ED887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510EDB597AD25F666C450ED887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Wed, Jun 25, 2025 at 02:22:54AM +0000, Wei Fang wrote:
> > On Tue, 24 Jun 2025 18:15:45 +0800 Wei Fang wrote:
> > > The port MAC counters of ENETC are 64-bit registers and the statistics
> > > of ethtool are also u64 type, so add enetc_port_rd64() helper function
> > > to read 64-bit statistics from these registers, and also change the
> > > statistics of ring to unsigned long type to be consistent with the
> > > statistics type in struct net_device_stats.
> > 
> > this series adds almost 100 sparse warnings please trying building it with C=1
> > --
> > pw-bot: cr
> 
> Hi Jakub,
> 
> Simon has posted a patch [1] to fix the sparse warnings. Do I need to wait until
> Simon's patch is applied to the net-next tree and then resend this patch set?
> 
> [1] https://lore.kernel.org/imx/20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org/

Yes, I have confirmed that with patch[1] applied this patch-set
does not introduce any Sparse warnings (in my environment).

I noticed the Sparse warnings that are otherwise introduced when reviewing
v1 of this patchset which is why I crated patch[1].

The issue is that there is are long standing Sparse warnings - which
highlight a driver bug, albeit one that doesn't manifest with in tree
users. They is due to an unnecessary call to le64_to_cpu(). The warnings
are:

  .../enetc_hw.h:513:16: warning: cast to restricted __le64
  .../enetc_hw.h:513:16: warning: restricted __le64 degrades to integer
  .../enetc_hw.h:513:16: warning: cast to restricted __le64

Patches 2/3 and 3/3 multiply the incidence of the above 3 warnings because
they increase the callers of the inline function where the problem lies.

But I'd argue that, other than noise, they don't make things worse.
The bug doesn't manifest for in-tree users (and if it did, it would
have been manifesting anyway).

So I'd advocate accepting this series (or not) independent of resolving
the Sparse warnings. Which should disappear when patch[1], or some variant
thereof, is accepted (via net or directly into net-next).

