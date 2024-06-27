Return-Path: <netdev+bounces-107392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00C91AC77
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D21C21F5C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7F15278F;
	Thu, 27 Jun 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QykXZwOj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F44147C8B;
	Thu, 27 Jun 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505264; cv=none; b=S++SVsv6STHV31ruU4QKbfAhBY74EfQclJr3wUm1+PmeJDyzZEucF9KOKFK3D9N4zJfm3coMElCNXKde7ofcvdXZvxVdW56IDz/pB6zvjNYpy9IfrwrlLTTHCwaWYVGwk9YRlMpRpSW2CaQKq5xOZgHosyYy3oZAu666IaKQDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505264; c=relaxed/simple;
	bh=YWStZ0r9RBesaFrsflosq7JyKui10Dc+yTvtFHiuFyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uktqe6vH1JwfiXEULzDJXoOzECF2vMUXWFekZdDK3CkRQZ+PvOlrUFW3/FcHa77cwH+ADDp3iHI9znjO/JnGtU+1sciITbydiPJ2Sn33bNX1UKXqR6W73hL18XF7sTM2M69CbMuhw7bnnfCCZSJx0O62Nil8FwIsZVhbDX2NvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QykXZwOj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Vv1Zvf1TjHKSZqP0cq+r10UvdM11mDu98+/Z6Tnm6M=; b=QykXZwOjPY6PYztzBqzJY0JnIr
	6FJyljkGt0QAVBL6DTjMrZsodpuXzgbsOPcrLm2VKPieiMYigxGoJ5muqlji2AYIs62WCKk1Z6Ved
	hylrvK5Hevyr40cOgfkvqfZ3OBZ6l4fqZbp2F/H1a6r81jVPA2rke2s3D6PRrXXsZHJg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMrrg-001BZr-3h; Thu, 27 Jun 2024 18:20:52 +0200
Date: Thu, 27 Jun 2024 18:20:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 1/3] net: phy: aquantia: rename and export
 aqr107_wait_reset_complete()
Message-ID: <bdb2a420-fbef-414b-9fe5-88a8e7c03794@lunn.ch>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113018.25083-2-brgl@bgdev.pl>

On Thu, Jun 27, 2024 at 01:30:15PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This function is quite generic in this driver and not limited to aqr107.
> We will use it outside its current compilation unit soon so rename it
> and declare it in the header.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

