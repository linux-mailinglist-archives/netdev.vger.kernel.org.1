Return-Path: <netdev+bounces-77678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83687299F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5567F1F26B0A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930012B17E;
	Tue,  5 Mar 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eTAavC1v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D312AAD1
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675015; cv=none; b=bwasJDCGoYF2C4m7scwmzC14eXLB7tcm+N9Ab3v9QGZ0hcWmGHkbiIrXkRf03n1GMK1dFFYontAejLyuf97SIaXTfQyMZqLjSoMLVBsAT9iM8pld24sMQLdyK9wWXHMlSeVrOhWCClAq83FDZ8+CDdAU0M76pv/atVzEi8Y4p7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675015; c=relaxed/simple;
	bh=1lFskjlcrr17JOREEH+osNoMc5pWhcRFnDv3z6unICo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HetP8jSM1Z/lsNmMOze3FSSsMKRVgn3BJKUv/cNYKHCnCACv2xm3Uxb+jK6wo7jqFCU7rNhiAnPlI9NM1+ot1HU67hPF9Gly9zlzxdJSuM+snie206Z54UOQqBorEpRHFyz1Zs9y8q8k65ovS3jQjUfDfQPbd0f0zrOsA9WMAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eTAavC1v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Chi/FCKqF9xPPF+4rlamVE5x2mD7uzaptnI0210VjpQ=; b=eTAavC1vjbPf4y7mk7Z1SK4ql2
	KyhZnb97alPHec2Go1ChC8wGTMVgl3LihvkTOZbu1xzpbl9FxCVHvqYTdqwwLvDqowpEAOUX4R3bl
	VXo/SbJTnYKJqpEa1walzirSyAnYCOFtVZ7l2MpXWu/CyDapETzFcSfI7vuSDtsQavVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhcZX-009Sfa-5m; Tue, 05 Mar 2024 22:43:39 +0100
Date: Tue, 5 Mar 2024 22:43:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: remove ethtool_eee_use_linkmodes
Message-ID: <b5cbff29-099e-49df-87cc-9daea20a5327@lunn.ch>
References: <b4ff9b51-092b-4d44-bfce-c95342a05b51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ff9b51-092b-4d44-bfce-c95342a05b51@gmail.com>

On Tue, Mar 05, 2024 at 10:26:10PM +0100, Heiner Kallweit wrote:
> After 292fac464b01 ("net: ethtool: eee: Remove legacy _u32 from keee")
> this function has no user any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

