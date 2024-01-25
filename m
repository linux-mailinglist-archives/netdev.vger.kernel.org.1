Return-Path: <netdev+bounces-65936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481C83C89B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91B1B21FA9
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE413D4E0;
	Thu, 25 Jan 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ssbiBzxr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C413BE93
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201057; cv=none; b=bg2cPKhQd3T4iW/+jbMA6qKylmMvYM1gz1TooHLMXNmmODW4q/dlT8Vj1qCn1Ejq0BL9FfUqCPbNvb7p3a4lRaT5G4vEAT2uQ5iwiE4fOose2BSxvUMF0k0OCNS4DaFm5A9EAkuSBUQ/NunqpgaOEITj1X1OpY/yLDoMI8e0lDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201057; c=relaxed/simple;
	bh=mkmo5lJIGMoUd5ASQ9ZRPxWjOhPPsbPHgsC3TKwfyLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLWZHGemg117rLeN79bMIN6NQhOPV/beCJAPZ1DrJrtGnwNYdZ5WxNZ8/FlV5UIcpu+pw2XV5VGSUt7RmT12HvkEUJQ8kZpupnoHg3JtqVwmElCnLVFl3fhsIDhXkBe62+jVNv1UCBOSZCiAny0FLamv88nsEZOnPz8L+q+FdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ssbiBzxr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+bShwFeCcbkqj53ybVoi5UvSl77tFUWSpFPZ4+dVEek=; b=ssbiBzxrw+GH5dl9CXbrT5qPzT
	TPgQO0i5soOs3nVPwnPLfE1K+PBIcG2LFMD/SUf9sHYC2+U2gwUdpglbVjtLouqrFIo7Yl3TqaMuU
	0TENMXC+vzjzNh22HKOtpXzVf21KRfEbpIizMvQMw0/ZFmXUsmPXLtaUnR38Yu1P0m2I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT2pU-0066JK-HW; Thu, 25 Jan 2024 17:43:52 +0100
Date: Thu, 25 Jan 2024 17:43:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/2] net: txgbe: move interrupt codes to a
 separate file
Message-ID: <b3156b51-bbde-41a0-90d9-8a22d7cfbb1e@lunn.ch>
References: <20240124024525.26652-1-jiawenwu@trustnetic.com>
 <20240124024525.26652-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124024525.26652-2-jiawenwu@trustnetic.com>

On Wed, Jan 24, 2024 at 10:45:24AM +0800, Jiawen Wu wrote:
> In order to change the interrupt response structure, there will be a
> lot of code added next. Move these interrupt codes to a new file, to
> make the codes cleaner.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

