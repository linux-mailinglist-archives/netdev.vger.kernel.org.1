Return-Path: <netdev+bounces-155039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7751DA00C0D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF47A030D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420B1FAC38;
	Fri,  3 Jan 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bmdwkbJ+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EC17F4F6;
	Fri,  3 Jan 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921672; cv=none; b=OvHDHA0X6YfCC71VRfno8J1/g/F6ZBF8Py2P1v+hJMo9UxwrwY3Yn1DZRrJ+F9VbaVCkZba4inX4ujeTOaKqJL0mAB6ak4Fn7piyKOqdZNFGHF7QnxI7oIorqFuFscjh66SS70btPV/3CMSC2h8XefhVrzn6J0jke2qvoLmvohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921672; c=relaxed/simple;
	bh=W0YywcOJRkK2XQOC8I6IQqsM1cpkY3+VEnxvj3KRao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pePY13QlttdOVADfyLXu/QCXN0wjHOCYEqsIja+NQ1RtU15n3cMOu3/trlYKxhow9Coy/Om0V3/Wb3anUA1nY6kOqD2qT2LYkjAGG41DxDMy9PFdxTT08tm3gCYz/yIoT9tfRbkyvCdS10p+TeMKEOW5CxOJiFWbybL7a4O07cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bmdwkbJ+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bhv0V3Xq90p2Zx9s6tdiOx4Xuhn7HTGGCsvmN7JlFWU=; b=bmdwkbJ+2QGX1R+x5t1PluRNym
	uGqLLBBuClRCbtveL23IFNyT307MRDjD40jvDm5eVegSIGVV5yRBtFj6tGnxZ+oPVBlxdUEJabV+5
	ws/8M+DN7ceC6kF88GSteaFNW8V4BJMibPIJK202W4FNlKSxN/mnqdVdfTHqdjmkeM6w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTkWN-0015Oq-11; Fri, 03 Jan 2025 17:27:35 +0100
Date: Fri, 3 Jan 2025 17:27:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <4a6cd601-1926-47c9-ad04-9b77c5b8a501@lunn.ch>
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250103063241.2306312-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103063241.2306312-4-a0987203069@gmail.com>

On Fri, Jan 03, 2025 at 02:32:41PM +0800, Joey Lu wrote:
> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac driver.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

