Return-Path: <netdev+bounces-57377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6798E812F6E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22152283128
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C533FE5B;
	Thu, 14 Dec 2023 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lk/oUsE+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E718D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NAiQsMMTJDx40OZRj2WZ8BawBJN7Aee7M/xblb+56Mo=; b=lk/oUsE+pzFkdk8c1Luu0UEJ0x
	bqSzi5ZGEYDLd6S6Z22nMziW0nlKSqjoAndJr8B/TzmRCQ8N1Eiin76GA93/mMPtX8rMas3mDNBz7
	mI1h6Lhs1yZjYHYGM/zeElt9QWdFsigXWSQB5oD5QWcIZwAyqtIHxhrnJ7oAc/4UxltY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDkFf-002vDg-2G; Thu, 14 Dec 2023 12:51:39 +0100
Date: Thu, 14 Dec 2023 12:51:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
Message-ID: <e2b302f3-132f-44b0-885c-431791f06f09@lunn.ch>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-7-tobias@waldekranz.com>

On Mon, Dec 11, 2023 at 11:33:44PM +0100, Tobias Waldekranz wrote:
> Chips in this family only has one set of histogram counters, which can
> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
> up until this point, kept the hardware default of counting both
> directions.
> 
> In the mean time, standard counter group support has been added to
> ethtool. Via that interface, drivers may report ingress-only and
> egress-only histograms separately - but not combined.
> 
> In order for mv88e6xxx to maximalize amount of diagnostic information
> that can be exported via standard interfaces, we opt to limit the
> histogram counters to ingress traffic only. Which will allow us to
> export them via the standard "rmon" group in an upcoming commit.
> 
> The reason for choosing ingress-only over egress-only, is to be
> compatible with RFC2819 (RMON MIB).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Keeping the hardware defaults is pretty arbitrary. So i don't see why
we cannot change it to fulfil standard RMON.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

