Return-Path: <netdev+bounces-166796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977EA37573
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB3B18841DF
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C34194A53;
	Sun, 16 Feb 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ararBzIp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09B9450
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722253; cv=none; b=DyQ2rpt/IzEvCk1ZJE48U/GBpGm5AiXrN7T4szmJFd2PeJHpaymtEtrnmKTybcofv1ggwL46JTrsbYr8au3SkpptAoSZbtMDmuyftMCAN1Wc6kecCm5+Nssklyi5jGLZhFU94AeAI3r9dzGWNNgwWnT/cjNtdZP8vEer9xqPQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722253; c=relaxed/simple;
	bh=jPgjf+O0XI0nsZrbWqi2qN/055FuZ2ExXTOK0J1MWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7kMOHyetvnPKHiw33qDT45xZjCVVekLjTWHmUZWmcfKFeMBBdvaBoekqUro80ijo5lSmo9d0mokh36ivODzeYGavzxJ6qgs2taLgl332IutDScWP8XXdJ2oxXfiPaLGBL8itqQPe52Xe/bbT79YoCxpIFU+4uih/qahHGFvLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ararBzIp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lag2/VJq0rGoZzC3tu2KwCNZdq0Wl20EPkLnjwmHGCc=; b=ararBzIp5CiFitmFTNdvQcLwUO
	rl/1xnhaS7nfvvs7qL1iq0V5K0BD+xMxOp61o8Mr5h1+MQAv7qPajK0mrKOTYotG+SBoNRXmOKW4q
	M5++RBtZ9htArzMUb95/aGwC41v17q3KvkK1eiaDruwqAjEPOUkNiy34x5HOBzQqTeB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhED-00EhDk-Js; Sun, 16 Feb 2025 17:10:45 +0100
Date: Sun, 16 Feb 2025 17:10:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: add helper
 RTL822X_VND2_C22_REG
Message-ID: <6a0ce390-8bca-421a-9956-b287cc9fd8cd@lunn.ch>
References: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>

On Fri, Feb 14, 2025 at 09:31:14PM +0100, Heiner Kallweit wrote:
> C22 register space is mapped to 0xa400 in MMD VEND2 register space.
> Add a helper to access mapped C22 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

