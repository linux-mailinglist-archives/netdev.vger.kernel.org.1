Return-Path: <netdev+bounces-247852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FECFF723
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC76313605C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E09389449;
	Wed,  7 Jan 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UbdrfHYm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605137C10C
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808059; cv=none; b=BGFlDmtG30oN7xCUGyPFhXVXVC5yl1f82cJzyJhVN4f8OApj7edAoxJTj5M4i7bGBAEpBTSyXCt6CmFb/wS1J3lG/VHC+iKRNzT9/k4BP17Yii7TggsxSs9T1yS2sqBTjJ3M/3xFaTj+Ar1wCGGsL+TFKq36rR4kmq3sWtv5ANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808059; c=relaxed/simple;
	bh=HVnBzYd9x9JFFcAlKlRBjbNTlcYleHSN4O6Xy1uT10k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCShisbIto/4EBAKi3hLzB1z1SfBqAVtHc9BvbIP+S4Kpjk9xkjaAx/9Ob1znQi0ri7TS5fwfKwpxJVrbkSw6PdDNzeDO8BEVIMyDeDsDoUj77ERScrgKj5S5KSE5SrH0OSOE3PFRlYkdB6UCh8CGV8LWhPWG2I5+AVjp93XNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UbdrfHYm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CgNRGN5Tx9IcuFsVoWHa9vYTXIBB9v1HT3tZ6FibXBE=; b=UbdrfHYmGWcCkpZ7f1+hbzYIKj
	+6TVSW3AChQCTGYl1Q2fp1faorJleSx6JZYbGwqU3Uul/yNsoTXFsCC2iBT54ABquUKBwGyfzIyOr
	+b0ws+ljwPKf8BRowGtazQHtiJJ8bBpfFvT+PHjrAHA0NgFh1XzGoZEWmwfpDJK67d8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdXd4-001pzn-Pz; Wed, 07 Jan 2026 18:47:30 +0100
Date: Wed, 7 Jan 2026 18:47:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] atp: drop ancient parallel port Ethernet
 driver
Message-ID: <bb532bad-8b3b-44da-868a-5d42b45a45fd@lunn.ch>
References: <20260107072949.37990-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107072949.37990-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:29:49PM -0800, Ethan Nelson-Moore wrote:
> This driver is old and almost certainly entirely unused. The two other
> parallel port Ethernet drivers (de600/de620) were removed by Paul
> Gortmaker in commit 168e06ae26dd327df347e70b7244218ff1766a1f,
> but this driver remained. Drop it - Paul's reasoning applies here as
> well. To quote him:

Hi Ethan

Please slow down. Get one patch correctly merged to learn the
processes. Then move onto the next. All you submissions are broken, so
you are just wasting everybody's time.

	   Andrew

