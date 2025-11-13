Return-Path: <netdev+bounces-238362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8BC57C35
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B404335A43A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62521C9F9;
	Thu, 13 Nov 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i74f6ftU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7A21CC62;
	Thu, 13 Nov 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041210; cv=none; b=pGVW+pv9ogsQksqml6DPYET2er669SbuyL6mWFRjGEGarhE7/j/4dbvrZDtttCtYT+ZSxHEjqq/0ESARBHJBg98+3rIoNhoJtnBCHqEsy2QBSUHotB/QIHVKUuos/MKcRGhcRO+8Os1g1/cTOe8x78l2Un3N2e72GX9UGisSd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041210; c=relaxed/simple;
	bh=JEh1zkh7hOzw6gi7KEdKjkaIXmlV945hmzkSyTuqegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG8QSNXalXgv7uczRF57g7bNNLhh4pWamLRxrKICv/xlKOJHtXlsqEMoq6B0k+qYJAbw5riRpQ+qlTL/fXfC8I3FqUNUp0k+t8sC1/1Y+qkwSkVZO0pqyBM/fo99BFPaBDK2dIgqcG41McHTXUri+00oKFV8bkLCvELy8SHaUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i74f6ftU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7JDjDnn0/n6b0DrD6JRdrARjLe1CJ2scpDbnmxp5PoQ=; b=i74f6ftUqKMmNRVfeGTBtUMYNP
	tGbpLBRr+rrrf6um/nP2lzGruLVku7sunrQ16asIkKsV34FT3Qxxb5oBRSvJfLz/3AlU5vSMXssIU
	n5lzT8wio8Z3g1JxaGZH39bbvk31YGPmCPGL8EAa6+yUz8wLXbL08JlGfPBkgZzj+ZLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXYM-00DrtJ-Bn; Thu, 13 Nov 2025 14:39:58 +0100
Date: Thu, 13 Nov 2025 14:39:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] Add SQI and SQI+ support for OATC14
 10Base-T1S PHYs and Microchip T1S driver
Message-ID: <7e3ccf4d-f046-427e-8ad8-85cfc850a3cc@lunn.ch>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>

On Thu, Nov 13, 2025 at 05:22:04PM +0530, Parthiban Veerasooran wrote:
> This patch series adds Signal Quality Indicator (SQI) and enhanced SQI+
> support for OATC14 10Base-T1S PHYs, along with integration into the
> Microchip T1S PHY driver. These changes enable higher-layer drivers and
> diagnostic tools to assess link quality more accurately.

Higher-layer drivers? I don't know of any examples at the moment.  Are
you thinking of a new bond mode, where it will do active-backup based
on the best SQI values?

	Andrew

