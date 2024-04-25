Return-Path: <netdev+bounces-91419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B268B2821
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA6DB20F2B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A314EC5F;
	Thu, 25 Apr 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3ILooPiY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005B146A74
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069361; cv=none; b=pi07f74osGViiilOUR2wkblSDielKbEd5VM8EHJ7sqluaz0oQYTrHnwDJqI0GjOlHe0six8V17aG5ZQOrgJ7sUgn8FMj9Rl2GPOMZPUEAyPvyAP2kkOyJaMWxRb4yfPHcTBCzQ6iY/j1k6G5Ust5SmAd4iWXZGw+X0n+UvwEaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069361; c=relaxed/simple;
	bh=wrX6JECkYQF0YS+9dQTr8HvQoKSCzrwxvFn5psgaBrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgtK2osuGLiZn33mduegFShAMsKfFSI5LFFNlTj+R7mT16nnzL8+7gbt8E+VbeV+T8rN5VAr+ronBtsc79cQnoSqBE6Y3no1FzJhHWaOgS0Q5KuQ3sT2hcge9sDAVOp+l67lRBgFqixR5x+gPCSgOElnTefX9YYcWe6irv1Y8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3ILooPiY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Et44C1sQ7SlP0HPaD4v0FaOwx5CwaOxOF08xmqrjzU0=; b=3I
	LooPiY0u8n+Mle/KP/e1Qv0L19izvYoBz3435MRJS7O5Bzh7d9svxN2tKEk/pHXaMAJ2irfcKO+ex
	LN+NHzAd3qP63gOhe+sNogSdY9A5uQNYMeHweSnd/MGydV98tDIHmBRaenm3bcEn6aNOF5cMWk2ad
	2ZugfaHNCC6HejQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s03ju-00E0lx-Ir; Thu, 25 Apr 2024 20:22:34 +0200
Date: Thu, 25 Apr 2024 20:22:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: ping test with DSA ports failing
Message-ID: <05b24725-f266-4360-b8af-fd299fbff5be@lunn.ch>
References: <CAEFUPH1q9MPNBrfzhSmCawM4y+A6SKe47Pc1PjqShy-0Oo4-2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH1q9MPNBrfzhSmCawM4y+A6SKe47Pc1PjqShy-0Oo4-2w@mail.gmail.com>

On Thu, Apr 25, 2024 at 10:37:38AM -0700, SIMON BABY wrote:
> Hello team,
> 
> 
> My test setup with DSA ports is below. Please confirm if it is a valid test
> case for ping. 
> 
> Ping is failing most of the time but succeeds sometimes. Attached is the
> Wireshark capture from my laptop and the tcpdump from sama7 processor. 
> 
>  
> 
> __________                                                     
> _______________   192.168.0.119/24                  192.168.0.155/24  _________
> 
> |                    |                                                    |
>                                 |____________lan1__________________ ____|
>                    |
> 
> |  SAMA7     |  eth0 (RGMII)                           |  marvel 88e6390 |
> ___________  lan2                                                  |
> laptop      |
> 
> |        gmac0|---------------------------------------|port0 (RGMII)       |
> ___________  lan3                                                  |________ |
> 
> |_________|                                                    |
>                                 |___________  lan4      
> 
>                                                                             |
>                                 |___________  lan5
> 
>                                                                             |
>                                 |___________  lan6
> 
>                                                                             |
> ______________ |
> 

You ASCII art is all messed up and unreadable.

> Ping is failing most of the times. Interestingly it is passing sometime. Below
> are the logs.

As i've said before, RGMII delays are often the cause of the problem.

   Andrew

