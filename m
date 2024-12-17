Return-Path: <netdev+bounces-152628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5E9F4EC9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD16161B2C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA81F666B;
	Tue, 17 Dec 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hwNdFvWz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF771F666A;
	Tue, 17 Dec 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447958; cv=none; b=lrOI4pLFlUNHwDsZtrZR7NpI99Eh3/RKzCPP67YEBRa1XXh/tPfvOgmVBkiqUophKuwXfjlHZW7+DGelB138jSrLup8geVWUUqYhlRVF9GmGtk7S6XiwOuh8R540mMMuDtXXSF6jUS0qeNfEMsQ5iPRySIe+GQaH3h14FGaJkgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447958; c=relaxed/simple;
	bh=5twiOGTkheyu1dUYg0+/TcffosoK5sVXeM9jMTsr1/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxTPETea/zuPE07OWDhoik091MKfSPZodNoEvJNXsHaak0WkoIdzgcvpMcOQLs00TDnQupj0wFI5HjAW2qYxbJaqdTxD5KbsddD6tdcTSjoG9TQ4ZZf/3+DM4SKA3Up9FmNnUGEde6PrwJ/DOHsVfLZWIQZGPOf2t1TEj/Q2qvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hwNdFvWz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+RrieuU4peLUjiUep6KjefwzR3YUiQIS4fAQzKlLyuM=; b=hwNdFvWzKmDccpSOGegMsjad7j
	lDyetUMfA11ONekRasNA91O0W5ECYmNPXoIU8RZmLhAbNmLTojeE3vnhwAcr9ec7VopQ9KiHZb2qi
	85XnrtmCiycgZa35gNXbvvXbjpTFIYpAF700mvGPGzEsItyK2sOCO98TQMrDfimut0gQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZ8s-000yyW-O5; Tue, 17 Dec 2024 16:05:46 +0100
Date: Tue, 17 Dec 2024 16:05:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 1/5] net: phy: microchip_rds_ptp: Add header
 file for Microchip rds ptp library
Message-ID: <b0e30631-c1a8-40a5-8a37-816c2809dfcb@lunn.ch>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-2-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213121403.29687-2-divya.koppera@microchip.com>

On Fri, Dec 13, 2024 at 05:43:59PM +0530, Divya Koppera wrote:
> This rds ptp header file will cover ptp macros for future phys in
> Microchip where addresses will be same but base offset and mmd address
> may changes.
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

