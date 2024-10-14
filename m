Return-Path: <netdev+bounces-135336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EF99D8AF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EB7B21D0D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDDD1D14F3;
	Mon, 14 Oct 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GDlyO7sS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981E231C92
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939489; cv=none; b=Acz1XZlakNiXblinJzpFxDRc9T+/VUV9XTwpr6S9DsXQPVRFYqnA/iq9bMWbctMvphmFYllKFNJSAblrhRauOaCkbvEVVsiqPl2+/4PK2yJjQQcZG7Bpk41Lv6RBG0gtLUJGtZ+OEOv1AKy4Eax4pOvkWjpV4fyEB85WPxcajFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939489; c=relaxed/simple;
	bh=EO4/ZUsxzvSzFarDs/Kf2NRDoobHMPPfDDjJXjPUjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFtdAoY95E53mMptUexsX1dgJ4lj5A2Ywegs8cacEBbh4EMTh5RI05E2NGH3SqmhBjOgdfiOujhyo6UvkvLsf+XObk4de8/pr/K1Y6f0TLIxZ8RMWG1y2lnS9sNyDH46dE9QUbVZFaj/TppvntQOsSq/nILXbd7Zf6+uY5TrSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GDlyO7sS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ntL1ryJcCpb9oPJklZ25zyvHz0NkOTEq19RwG8b8YgE=; b=GDlyO7sSeoMTzIV5Ruvnx83WLS
	in3/nq9z1GnlV7/WidcWtkgWr5c55DpJntfSy4R3/SB3WYx4NFY/8RtbOdTO08DehB1GRHSTVVh4Y
	We8pnkxoSgehCdAzmI7tB6FcCAdOro5JO9YwvbY1FWAR+Eg94UyhLCt93P9rBTpw9iBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0S8d-009xrw-Ba; Mon, 14 Oct 2024 22:57:59 +0200
Date: Mon, 14 Oct 2024 22:57:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Fix the max_vid definition
 for the MV88E6361
Message-ID: <bcf3614c-1347-4594-9073-779b45f7bb7f@lunn.ch>
References: <20241014204342.5852-1-peter@rashleigh.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014204342.5852-1-peter@rashleigh.ca>

On Mon, Oct 14, 2024 at 01:43:42PM -0700, Peter Rashleigh wrote:
> According to the Marvell datasheet the 88E6361 has two VTU pages
> (4k VIDs per page) so the max_vid should be 8191, not 4095.
> 
> In the current implementation mv88e6xxx_vtu_walk() gives unexpected
> results because of this error. I verified that mv88e6xxx_vtu_walk()
> works correctly on the MV88E6361 with this patch in place.
> 
> Fixes: 12899f299803 ("net: dsa: mv88e6xxx: enable support for 88E6361 switch")
> Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

