Return-Path: <netdev+bounces-91447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19C8B2981
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A810282011
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67F152DF1;
	Thu, 25 Apr 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CyFE91Rm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F314EC5F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076028; cv=none; b=uFSUdIg1B0vhv5vn1uRQsn+Hufed8YGpHIn/RxvESq4VBU7OTCxG3e/s4sauSdXZp2o+SaD8TYeKLohAW24VupgyNpzvw1UTtsTm5Gn8rx2p+8FMW30ve91TWRVKjD2s3SUg4K53VEJ8PQ18Jag9wmKBwSi+9VmDnmMHgxBazTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076028; c=relaxed/simple;
	bh=f38WUXexBGk2pULVpRYDsxPV+2Sb+bu7HCj9MoOd6hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1N9gotODnPq3eIgjOCa/JPPtl2/yZshtIckW7C59eUQhcUo4sVj5ry3jTQmN46ouOQnS9njIh5DISIyzcMLIrURsyQljR4k7rjvwMkCJLNILQKc+yPqc+VSwR5o7QTZ+FSZ1HpYTYfM1Kf8YtB9BD7ogHwbg9LxSUVtncnqdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CyFE91Rm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=UVN7YbXysOsQP6tXORMHq8vJKYIg/blYjCMhLRxUk7Q=; b=Cy
	FE91Rmg79WTSAPfIenEETv3vHTPqAWMLuuX7aqiEjRxpMxBozprqkCmLLbW7D09M0Wbq/HXkT3snl
	hGNHqI2dwcbBkd8n2Kfy+TctigdcbJROQhruld+pFfii/FtDZBC4tDGrnYNwvDnrHGoMMAWdT1tDl
	Vr6JNmDGEB0x3uc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s05TT-00E1D7-6s; Thu, 25 Apr 2024 22:13:43 +0200
Date: Thu, 25 Apr 2024 22:13:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: ping test with DSA ports failing
Message-ID: <11c3fe04-7aea-44eb-8f02-28bbe0c5ec03@lunn.ch>
References: <CAEFUPH1q9MPNBrfzhSmCawM4y+A6SKe47Pc1PjqShy-0Oo4-2w@mail.gmail.com>
 <05b24725-f266-4360-b8af-fd299fbff5be@lunn.ch>
 <CAEFUPH0KNr=tOTpSX5ZrjiwHNMeZgGWroS7PR5YwX2=W7=1TdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH0KNr=tOTpSX5ZrjiwHNMeZgGWroS7PR5YwX2=W7=1TdA@mail.gmail.com>

On Thu, Apr 25, 2024 at 11:43:48AM -0700, SIMON BABY wrote:
> Thank you so much Andrew. Sorry for the messed up diagram. attached is the
> diagram Can you confirm it is a valid test case? 

Don't use attachments with mailling lists. Just plain ASCII text.

> Note: The testing I am doing is with an actual PHY on the mac side as well. so
> basically it is a PHY to PHY connection for the CPU port. Can it cause any data
> plane issue with DSA ?

So you have a standard patch cable in the middle? Then you can
separate the system and test each half on its own. Is it the SoC side,
or the switch side which is causing the packet less?

      Andrew

