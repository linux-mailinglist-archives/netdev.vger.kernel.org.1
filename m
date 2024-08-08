Return-Path: <netdev+bounces-116808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2494BC5A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E0D1F221A1
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B018B46F;
	Thu,  8 Aug 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn21DPX4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A518A93E;
	Thu,  8 Aug 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117067; cv=none; b=X91nt1VLCmJmtf+yxbiTzdfznUjYSptVRkSfSgFr2KJiii5vaYiDT42AQsXOUt5QSrfgVAB7Gt1bvuWR8zSshptBZ9W21sxp2tlckvIdXQxzZqySso3r6EsewaqPReN/RAH95MliX0PGkyYuUsl//DObtYfxyGWys02h5b24bZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117067; c=relaxed/simple;
	bh=FrQApXPVmrdPa5fVSbNwQe+t8ZUO+Ix0gSxKCqrXorM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuQMl2g+vTcDMoEu6cJtZaPvviEiuuPsamnu41JQSw9egWjyRpMscsuKoeYFFEfQTZEg45HuGvI57FPf6KZZz1VwjJ+SJy0id2lOSyU2/83qZMCm1UXUTRdfUQWQKex1FLPqLTgLMo32LL6D3qkaNYOTNxbHwt7w+HEEuUiIrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn21DPX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F7C32782;
	Thu,  8 Aug 2024 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723117066;
	bh=FrQApXPVmrdPa5fVSbNwQe+t8ZUO+Ix0gSxKCqrXorM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bn21DPX40uXcqizPqNw2FpJ7A0FclBqYBPLlgy6RwEOhGx1VbqwDNPtKHLY8QjdSM
	 jodX1UQvjfKHXXYPHBT7Q6qDHQAO+dpqzGsUjEdIpJbWVqlLUO1hTm78OHm7vPre6t
	 XWr0AFb9LT2FZgfyFbxnRzcIrTC9oIDGQbGVn+Cd5OwaUWSPBNe5t/DBDBQrdjxeZz
	 SFrxjzOVCP9kbpLg/GL0HMjwgoFwRHE8YA4fUAi2b3+R+WNzeZBPv2juScpg5mWu++
	 cBO91Ts+zVy1YlKDHvdKyWuGVsQ7F/himMQPznF9zcbWKqBxvTOoC0zpu3Fg0NslS9
	 pLtxHI3Ql1MfA==
Date: Thu, 8 Aug 2024 12:37:41 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.li@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
Message-ID: <20240808113741.GH3006561@kernel.org>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
 <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>
 <20240808094116.GG3006561@kernel.org>
 <449a855a-e3e2-4eed-b8bd-ce64d6f66788@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <449a855a-e3e2-4eed-b8bd-ce64d6f66788@prolan.hu>

On Thu, Aug 08, 2024 at 11:49:29AM +0200, Csókás Bence wrote:
> On 8/8/24 11:41, Simon Horman wrote:
> > On Wed, Aug 07, 2024 at 03:53:17PM +0200, Andrew Lunn wrote:
> > > On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
> > > > This function is used in `fec_ptp_enable_pps()` through
> > > > struct cyclecounter read(). Forward declarations make
> > > > it clearer, what's happening.
> > > 
> > > In general, forward declarations are not liked. It is better to move
> > > the code to before it is used.
> > > 
> > > Since this is a minimal fix for stable, lets allow it. But please wait
> > > for net to be merged into net-next, and submit a cleanup patch which
> > > does move fec_ptp_read() earlier and remove the forward declaration.
> > 
> > That makes sense.
> > 
> > However, is this a fix?
> > It's not clear to me that it is.
> 
> Well, it's not clear to me either what constitutes as a "fix" versus "just a
> cleanup". But, whatever floats Andrew's boat...

Let me state my rule of thumb: a fix addresses a user-visible bug.

> > And if it is a pre-requisite for patch 2/2,
> > well that doesn't seem to be a fix.
> 
> It indeed is.
> 
> > So in all, I'm somewhat confused.
> > And wonder if all changes can go via net-next.
> 
> That's probably what will be happening.

It does seem like the cleanest, and coincidently easiest, path.

