Return-Path: <netdev+bounces-195832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DBAD2643
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA1E188AD74
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBA21CFEC;
	Mon,  9 Jun 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip18YjjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE021C860F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495507; cv=none; b=WV0NEEyAihCjIY6D1H4MHc4AWmMs1GXRF6W/wHJQhnBwzn8wEJQ69RrotvRbjurS+ruPGMWR1GgutpG5SR784yUx/qnbK8YGg9Gyni3bWio9THXQj/rVUdGsF/08RMg/ZJPqk7ZT5TNi0QQw0sBkICpsfCsIPEMX7LjmkiWMeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495507; c=relaxed/simple;
	bh=Us8Wr1EuczRpalCelxKv1+p0juAmi2izRsy2jVKKs1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+k5c4AMG8ITaH3jDk5ZQ91onNQz3S8qw42xZugib4676pRDLSrc/XoHG36SjqYMg3u8zVfp6w9pjejKMQLgemslvoJwIoaY1MXxHeffOlGXQjZSCLkjgALFQ6E7wWJCYcHCnQlVWocW1Yeh9ePpwzEaqrtwz4mrSD8BwaWp1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip18YjjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B6C4CEEB;
	Mon,  9 Jun 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749495506;
	bh=Us8Wr1EuczRpalCelxKv1+p0juAmi2izRsy2jVKKs1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip18YjjUixN+QGM/KoUlmtODJnmWNtv4QtgPaygtUXj9Ot8znPFOd716eXbT6TE5X
	 YXE1kQCIVqDPrSeLSovAv/W0h7OpC25Q3TUSciuC+QYN73e6uwax+vlzNDAYM1Qfr6
	 LQBP78JPTwK/WXATFMWK6/6DF6rfIYaKfBzR/rh3PeBVXVAtt7wM7avwssI1XBCaWY
	 9RNBmdpk6fTSlHVbb4i6LwOXV+4fglkH0HHRAakmieRpVtssOwPLrSx9hM0n7ImPWR
	 5EGdX+/xoUQhN81cQytvVbfCCZei+i7BwROewOaS1ptjFQ05oO+R/YFLSen/So4oNT
	 RgV/bqvtj6R+A==
Date: Mon, 9 Jun 2025 11:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC net-next 0/6] net: ethtool: support including Flow Label
 in the flow hash for RSS
Message-ID: <20250609115825.19deb467@kernel.org>
In-Reply-To: <1eca3a2d-aad2-4aac-854e-1370aba5b225@lunn.ch>
References: <20250609173442.1745856-1-kuba@kernel.org>
	<1eca3a2d-aad2-4aac-854e-1370aba5b225@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 20:26:14 +0200 Andrew Lunn wrote:
> On Mon, Jun 09, 2025 at 10:34:36AM -0700, Jakub Kicinski wrote:
> > Add support for using IPv6 Flow Label in Rx hash computation
> > and therefore RSS queue selection.  
> 
> It took me a while to get there, i wondered why you are extending the
> IOCTL code, rather than netlink. But netlink ethtool does not appear
> to support ops->set_rxnfc() calls.
> 
> Rather than extend the deprecated ioctl i think the first patch in the
> series should add set_rxnfc() to netlink ethtool.

I suppose the fact we added at least 2 features to this API since 
the netlink conversion will not convince you otherwise? (input_xfrm
with all of its options, and GTP flow types and hashing)

