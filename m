Return-Path: <netdev+bounces-102331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71431902743
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197111F21D20
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1A14659A;
	Mon, 10 Jun 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dt9QZOjY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FE14658E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037968; cv=none; b=kTMMHeAAmGTHfdevlYBq7muFZ9JD0UHoEEE80sfF0WfeFJAyVd47l4zcK/kel0WW7yqwfibUv2u6UiffpN3ZRXDVHFUrpIpIN3aXOI7sbXq1ddIsRyJdWREOipWs+SncFbxZMpIfu/Tzc+L9Kv9/QBtevKt9MDz8W3RBoWs4NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037968; c=relaxed/simple;
	bh=ESs62czlTO71saDq9KAL/nv/U0Zupsg0sy7QXam56m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soeKPw+t1OByD1wvaHLc61FnP/acey9sA7qNP5uSs79TrT/pL0jd+CdW7RMCrYDONQexlwJ3q1aPYmLJJNjGZ0ySw6qZpTd3EkDHLSvtHW1ucxkQtNdcb8l6Yp2cxiPxGaOeDEraA+WosTcfc8z+uQ8Nl+//PSYBvBkJyGDa2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dt9QZOjY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jCO490GsRS5pdqSjBT2xBDAyCAiCPU8iLpgtl2Y2mB0=; b=Dt9QZOjY7DAUtoYT1qkAyalGwu
	lug0oPQuQp8Yy6HOdWEJ2NDN077XTzsoxCW4VGPxUJlGEw5EHEorEGguAVkUjVNLexHmFjMnLIdmX
	lOKGa1EGb41Mpbg1+1iGvIyMjfJ9w2iTiAA2BFrTGARB5v5K56vjjePlkQOEVVw/WCf4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGi9i-00HJgn-Rd; Mon, 10 Jun 2024 18:46:02 +0200
Date: Mon, 10 Jun 2024 18:46:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yangfeng <yangfeng59949@163.com>
Cc: netdev@vger.kernel.org
Subject: Re: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Message-ID: <c5fe08f6-6aad-4b64-8925-8f8ae1b26482@lunn.ch>
References: <e43bacfc-0143-4291-97a6-34c02b92d059@lunn.ch>
 <20240610163855.6877-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610163855.6877-1-yangfeng59949@163.com>

On Tue, Jun 11, 2024 at 12:38:55AM +0800, yangfeng wrote:
> And use the PMEB mode magic package for wol, however INTB mode can't
> be specified this way.

Please explain in detail what you mean. Why cannot INTB be used?

> Also, the PMEB mode register is not set in this code, the board is
> set to PMEB mode via bios.

Linux should not trust external code. What happens when somebody else
uses this PHY, say on an ARM system, and uboot does not set PMEB? If
your board only works with PMEB, then set it to PMEB. That makes it
clear to other developers that want to use INTB they need to be
careful not to break your code which then explicitly sets it to PMEB.

     Andrew

