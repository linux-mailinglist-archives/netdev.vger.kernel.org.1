Return-Path: <netdev+bounces-175290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F043CA64EC6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53B93A958F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7A3239567;
	Mon, 17 Mar 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hCyhLvlE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04BEED6;
	Mon, 17 Mar 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214586; cv=none; b=d1//CrvaBLQq+7F7wwVsFd01TvUAmV+F9g59md2n4jsdszMk/oRhvMJnAOjiuj0c1586euxGm9dYIntds+Qev6BTCE30XHcVTjcYbfga+zOTZ21bRlb+zIx19FQ0FzhfYPq+ixx1IZvTH22/tMYzjsSZ6WnKgWATejSs5xaK2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214586; c=relaxed/simple;
	bh=+1HgWneUir9oAW2wx2FvdagCc/zv/MiZsY1oSlWid+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVoPlffQFUxCLFuLkIA62tUinQJcBqlCM3vC5Jahb0z0eg/tLfgmr6ByXI209Vv/oeb/Xn57Way9lkglI+kzmdkCec2oNF37bj5K5RKZnnBZC76Iqjx7URELF0KBTv9/AdEskddXH4WJnc2bXp+6/V7AHtXMKv7HqW5/rA4rrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hCyhLvlE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P1dBz2YuyBHC8T2qTW9L8ghLPlptZC6vp30xXULHXCI=; b=hCyhLvlEWNz9VGtSlIDa1oIDmD
	nM4Cer9otXl6OsP5baPY8dHmEVyHbUqUIzL07EBxWqzT6wf7bNlpFZy+iXai64T7SkwcCgNBx5Dq0
	Y8acVwFUC4guPv6b2w9fn1lia4L4bTdRn+GbpqMhnRuwyWWBQsTLFxBslx7gwCGcyn/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9b1-0067jh-Hz; Mon, 17 Mar 2025 13:29:31 +0100
Date: Mon, 17 Mar 2025 13:29:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] net: phy: fixed_phy: transition to the faux device
 interface
Message-ID: <ea159cab-e09f-4afc-b0da-807d22d272c8@lunn.ch>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com>

On Mon, Mar 17, 2025 at 10:13:19AM +0000, Sudeep Holla wrote:
> The net fixed phy driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/net/phy/fixed_phy.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

8 insertions, 8 deletions. How does this reduce its footprint?

Seems like pointless churn to me. Unless there is a real advantage to
faux bus you are not enumerating in your commit message.

	Andrew

