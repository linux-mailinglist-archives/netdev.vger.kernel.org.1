Return-Path: <netdev+bounces-229181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688BBD8FAF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 528174FF2C0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789E3054F6;
	Tue, 14 Oct 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM89lazW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FD2D3A7C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440833; cv=none; b=cCQQ0X5yroeLcd5yZ4wYCRe4qBTgy7Q5bApTn8gxaS4Ytv8DNysnuzuxiBmQhtiz+zXKGA0oiUgRj80pMJQoFwMkbb8pNJMdEpYXsrGidUpRNjHZSl9N2zCAiA/zFyBXn323gEd+HeJNLIRMqfKz2Qu2W0AMNvX5J44J06A3J3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440833; c=relaxed/simple;
	bh=6ny3Wa7/aLBllOLP1NITz4T9xtn9itUcGVWYQAFzf9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEVOe0Vu3Tn0K37zOr7X9icsAM6A4i4TvWNY0ggaFDGqd4s4SIzvHBpAyKQ8/xUoJ8biPpcxaaeDCHbHwDEL/bulw4fwtG5E30qPDpqbNe1P8mu5oFOsuKV9DullUnrgJy6b4Fdl1gbFIy1Wcj4kQBnhrwS63uQyKkP1Z2A8P60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM89lazW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143BC4CEE7;
	Tue, 14 Oct 2025 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760440833;
	bh=6ny3Wa7/aLBllOLP1NITz4T9xtn9itUcGVWYQAFzf9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XM89lazW7brSMtNEKhsMoVlwM8VPzfxPWSMejRmP4cIw9S7W3MHmCsHHeU6deeQgD
	 f86jPHnXUTwrt/DbBg79OjyILp3dAAIWNvz3xT7VEprBB8y3pntvYc8ZtKXGDGMcRc
	 ma6sN4kyh+z/PUKRNi4tMUql8XS49OOsXTmxyXqgolX4LcztgMPHOfZXdNj7miVcuv
	 dl+/hudiukJj3zoxFDH6ZTQMz1m2Ygz0UbAygCkeoLGQ+nQBo+yykhYLMOU+mHbFRh
	 GMeMFhDnQTPuXzncSg3xHIEtThzA2gbtm2QSPpnPfMCNop40fiULPHZ+E8ao6b4oZy
	 O2oxY5vrs+4mA==
Date: Tue, 14 Oct 2025 12:20:29 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: Shyam-sundar.S-k@amd.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: amd-xgbe: use EOPNOTSUPP instead of ENOTSUPP in
 xgbe_phy_mii_read_c45
Message-ID: <aO4x_fD_g3nMjYnZ@horms.kernel.org>
References: <20251013171933.777061-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013171933.777061-1-alok.a.tiwari@oracle.com>

On Mon, Oct 13, 2025 at 10:19:28AM -0700, Alok Tiwari wrote:
> The MDIO read callback xgbe_phy_mii_read_c45() can propagate its return
> value up through phylink_mii_ioctl() to user space via netdev ioctls such
> as SIOCGMIIREG. Returning ENOTSUPP results in user space seeing
> "Unknown error", since ENOTSUPP is not a standard errno value.
> 
> Replace ENOTSUPP with EOPNOTSUPP to align with the MDIO core’s
> usage and ensure user space receives a proper "Operation not supported"
> error instead of an unknown code.
> 
> Fixes: 070f6186a2f1 ("amd-xgbe: Separate C22 and C45 transactions")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Hi Alok,

I lean somewhat towards this being an enhancement rather than a fix.
But if we want to go down the fixes road, then I think the problem
was introduced in the implementation of xgbe_phy_mii_read() in
commit abf0a1c2b26a ("amd-xgbe: Add support for SFP+ modules").
Although I do see how you could argue for the commit you have cited.

The above aside, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

