Return-Path: <netdev+bounces-116760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3C94B9E1
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853A81C212C0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B3189B9A;
	Thu,  8 Aug 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE9E8YkR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2444D189B81;
	Thu,  8 Aug 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110082; cv=none; b=UtdreJxn4YCNsgfNNITtZQSMFfU+yXGP3sarwPqeKMB+/+x2plI0WR3qzGqQqfRw7yEkMblekvax4B6eq5H5oBZs+3Y8ekwo3gTKAIn83/hKpzkUyO/cAjiFWfgiSHupymEsC3ydBFWufz3ZIz/bqbW28QAMXOrEXX8Bq+5FC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110082; c=relaxed/simple;
	bh=rB9e9tFr5Sdf/wZFMak2EKkuk5mC++XV4YNxs0/HL/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeRgFWS3R+aBaDpSPA5TtMtO+ouErFf3HRtCoiroKXoAhAEEuCKM0qonmQmHnijiDqMgrSkTVuS+cUYbrlfv22Akq4t8X45B9n10KBIT02hvrzRGz481xqjRIaBKRIhbrja9HEAYeqK7ukDGVidOQz2MTrhdfsmgzhoM9tt79Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE9E8YkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C1C32782;
	Thu,  8 Aug 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723110081;
	bh=rB9e9tFr5Sdf/wZFMak2EKkuk5mC++XV4YNxs0/HL/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sE9E8YkR47JdhW94nNoGNC6NDth2CLXuYKOg+hhAU7bhjjQepyVKOpX5pDjabGYwl
	 5axXNYJfbTY20iFA//2GjxVUmn9Dj9Bmdwtr2K2e1mOsGlt/eIfDCSaML2O2zq9mKb
	 vk3BGPvgYhnmTR6i8/LgBvWBqarlUPN5VWKVvBGNa1J1EK6CRlljO73meopvpon47m
	 h5THYAmasp9KDB15VxWF6nWUcet/WEaV42xIuZ1UKRDtd8xB0hdpdsKyW6qq6ofV6d
	 B25Hs0lDMRWTcPMF5k3ET9hgq5VV8m70qLV8BFR5cP8BOTWkIItU0gPapf94m3dZlv
	 rSr93YXPm6IHw==
Date: Thu, 8 Aug 2024 10:41:16 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>,
	Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
Message-ID: <20240808094116.GG3006561@kernel.org>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
 <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>

On Wed, Aug 07, 2024 at 03:53:17PM +0200, Andrew Lunn wrote:
> On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
> > This function is used in `fec_ptp_enable_pps()` through
> > struct cyclecounter read(). Forward declarations make
> > it clearer, what's happening.
> 
> In general, forward declarations are not liked. It is better to move
> the code to before it is used.
> 
> Since this is a minimal fix for stable, lets allow it. But please wait
> for net to be merged into net-next, and submit a cleanup patch which
> does move fec_ptp_read() earlier and remove the forward declaration.

That makes sense.

However, is this a fix?
It's not clear to me that it is.

And if it is a pre-requisite for patch 2/2,
well that doesn't seem to be a fix.

So in all, I'm somewhat confused.
And wonder if all changes can go via net-next.

