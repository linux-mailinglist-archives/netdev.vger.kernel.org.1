Return-Path: <netdev+bounces-175481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9023A660DD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D2E3AFA62
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF42036F5;
	Mon, 17 Mar 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lOm4grbO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD2AD4B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247797; cv=none; b=a3ZR3Q5p0fMqbaYCzWrMLfNbuQpa64kdLTw3nPWhvt6TUQbT+iQ5ceODAO4/ciK5vAYvCVmzDL4B6mYLABl6LtkZ6K3CdqSSTm53ojNd0voeQ5w/QH9VQAeA1d2SzBLZVpKAPM2MvPwyyaV7/mSqkpot4f1XqihiAqRmsUAzCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247797; c=relaxed/simple;
	bh=jSrSPNYJOBLtpLd+7G8jbC0R3b6cPHmq1TjHjGJmjxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRmbLAz7MYL0qat2uHWZzD51SbpoMtWMd/W6ySIfgmgtGWK+XicQEcjTxW9A/fino/JTDxAS1z7ud5tE7/WyPGE6jXE8CQZoAVP016FwhbylaV3hWY6cspKmoKUdALPNmK3nIoFs0D8emKtCIE5wqq3jxz8J8XmFa8rGWuPBuc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lOm4grbO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5Tb0PqVi7SgIfAnZpi4F2Yx7sJcqf8v1itCZDOfejhw=; b=lO
	m4grbO0X9IpWnx2Y5LapMb5mWcdgBT/Z9t+2TzLUN33UCADyXvmD8lqVcUvKM8NlvQYcSt86rjCzC
	fJWRVZHxnQKgqjROFwOUvApj09IRraDM2Tk/qlog3UEfsmnEen0zb/pthmPmNipplYy5c3aB94vjh
	rCBVtlElj5AGTzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIEo-006BVa-Sv; Mon, 17 Mar 2025 22:43:10 +0100
Date: Mon, 17 Mar 2025 22:43:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net v2 3/7] net: dsa: mv88e6xxx: enable PVT for 6321
 switch
Message-ID: <b0a69ea8-6d28-43c7-b4c7-1ac5fbac4195@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-4-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:46PM +0100, Marek Behún wrote:
> Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
> info") did not enable PVT for 6321 switch. Fix it.
> 
> Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

