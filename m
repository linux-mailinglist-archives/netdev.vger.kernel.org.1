Return-Path: <netdev+bounces-216551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC67DB3474A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D815E2C3B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2C2FB62A;
	Mon, 25 Aug 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ijFwbM8w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51E2309B2
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139154; cv=none; b=Ob8ZcLY5nTnhw0MaP4KouqOw6RncugWC6Bzp/OR8y6Km8fLU3Y8cRz7eKOU7AvK+RhLEFOUbeakXzFoPfBaQEhcn9y7jVIU83DAEtjT7TWOJZO6EYj0Nn/8Z8yhaLoxZ6sNJZOX+6boetWJ/fpNK1up1Ca28WGSLepuc0K1CiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139154; c=relaxed/simple;
	bh=seLXKxuMtVPGXbPICnJD0p7Ko6Ah5SXmkDms5N6iVXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByVyykB7vCpD2DnYhd5DiKd/g4C8KoQNGKVgi/LvWvoRkOqoh7yP6bQNmE5vl8doV5zUMnerNTEEP42DQ4YzHa1upbCKYKrsP7ee/8CBpeguFE/GjnD7ixYmScSdVIbGJBdZCOFY/1sISdSAU3yYf2mDSehnh7/CpbX1ueFXD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ijFwbM8w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AeeWvFdpDIemSmTZiOgm/d3pjLrN+TLNKaOzwpiLcsg=; b=ijFwbM8weI44ZITKf8wa+eLv9W
	0PiSK/cnrtK55yKhQCur62hsVFCtUhlXj8cG+sem3/rrhSXrn+G99dt1HenUYsb85vY6t5qQHFD6A
	fyBVZEACAywk9mW4KjwHN9jaGaucyf4lttguK7jt+oj5GvMrDfL1IveSfsxa3asPaePA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqa0t-005xtJ-EB; Mon, 25 Aug 2025 18:25:43 +0200
Date: Mon, 25 Aug 2025 18:25:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mheib@redhat.com
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com
Subject: Re: [PATCH net] sfc: remove ASSERT_RTNL() from get_ts_info function
Message-ID: <338a2540-d64c-4d5c-9fa9-fc53e607252d@lunn.ch>
References: <20250825135749.299534-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825135749.299534-1-mheib@redhat.com>

On Mon, Aug 25, 2025 at 04:57:49PM +0300, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The SFC driver currently asserts that the RTNL lock is held in
> efx_ptp_get_ts_info() using ASSERT_RTNL(). While this is correct for
> the ethtool ioctl path, this function can also be called from the
> SO_TIMESTAMPING socket path where RTNL is not held, which triggers
> kernel BUGs in debug builds.
> 
> This patch removes the ASSERT_RTNL() to avoid these assertions in
> kernel logs when called from paths that do not hold RTNL.

What is missing from the commit message is an explanation of why RTNL
does not need to be held in this function. Maybe this is a real bug
and you are just hiding it, rather than fixing it?

    Andrew

