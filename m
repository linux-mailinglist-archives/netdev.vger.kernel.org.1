Return-Path: <netdev+bounces-155590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EFA031DA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD3F1884A08
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4111E0090;
	Mon,  6 Jan 2025 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GK9jcoZO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CA1DED6C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197728; cv=none; b=CD4UOLk32NGrrgN9hbZB0MvQN5YLwq+UuLxwKaKGrWg0WfVizaa2vgR8nPpuhwIQj8P4fq9Evxuz7+jNaXIlnVwgUsHMfi6iOsUcFZuEUAviScfK7pi5yNRLocPWyKcC5yvS02hZ1lB/N038pR8u9kcLRN/bcp6RBDuT1Nk6Xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197728; c=relaxed/simple;
	bh=rm8oSb2uiKAUAy5n1L1LoIeT68R6jkSJ29wBjYJu5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZim0hmkdLN7Xa9dR7Ps25dZcxd6hdVjmX+C4tkXYNR9TBvXQV2bZ8q1aVRfm1v4LH9opew25CjfuXdq/aJiBt4uA4bMAtDzkfh5x1sqCo6KyPMf5tNc/rDBXSi0N101VyxD71QVwDtlnErEq+OAlY326zGFka8RjiwKCG4R7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GK9jcoZO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hGYss2LKdPyFwOFct3nky1yWQOlrbqDgzePUoejKddY=; b=GK9jcoZOqt3A302ILnNv4Ci1O0
	f5nuKr1pkJoZG/zkeqY8KwsQR+FfdvT2cyK/wSoJ0GzAMgxyXs+1v8khyGvFT81A2vwXxlgnyZXY4
	2QkmUx+UGJBwSpS2BQvghWi/mk0OZTUG4rdzXFlsVgwFSRAUUQYLdYRV9Ru+e9vLjMq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUuKz-001zbP-H6; Mon, 06 Jan 2025 22:08:37 +0100
Date: Mon, 6 Jan 2025 22:08:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] r8169: prepare for extending hwmon support
Message-ID: <aa27e059-793d-4a43-98ec-97f360e3b772@lunn.ch>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <cf9d1c92-de68-44ea-9dec-ceba17c2aec9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9d1c92-de68-44ea-9dec-ceba17c2aec9@gmail.com>

On Mon, Jan 06, 2025 at 07:01:16PM +0100, Heiner Kallweit wrote:
> This factors out the temperature value calculation and
> prepares for adding further temperature attributes.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

