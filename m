Return-Path: <netdev+bounces-147865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF819DE8F8
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C186B224A2
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD482D66;
	Fri, 29 Nov 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N0TneUbi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA11FAA
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892081; cv=none; b=L7xNo6xZEMjdaZTxUNo21xdZt+tX+k7F8uKm0xZ80Vthn4P0i4ddyQ7nDFzHlwmIe3E5aUSU9sU/11WBii8u5OTx7oG0jpfAeLkMBJs8GcWZ0XnsOIqxTp4bYsMur1Seze5tkKJTmUeYD8BexA9IsD22u9/dEyc0sFR3xe5hNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892081; c=relaxed/simple;
	bh=vmM5FNC7OoSupWNIMdUVamjOQJ4EW5nW8exgNEeqK7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otkWtrEEbt0LfckDLa8WxbIAxasuPnwIcBu3JTeqy95J2eZvpnUgXNflZ/RZwjsKTyiMYlD/OMgtx1ghbba+auroGwM82Imq1LJLTO3zpIblKB4Zp6ZHGXYs9wqNggf5onC0eA81SnAWDQZ9Tsuda1HrR9f7zLheDZW+jO8pbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N0TneUbi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SV4VFS3IzGAJRdTCahRBNSeCDsylKQ7e8EXZB38iRMo=; b=N0TneUbi3zG6oW5S/AFnCPgAVq
	tmuMUgxBjB4nfawJbM5tQtQpG7tVIFXZWQeg0FBCNcy/mpc09smoUDqdJKf8H0bDmqvZFMxnymNv3
	QyP1NFwMLZGyxWqGqF38+8XkvQPcyTrJSRt1MpxbhxvkV8Bzdw+UIM2IrnuoMJdVR7A0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tH2O9-00EmFO-Uz; Fri, 29 Nov 2024 15:54:33 +0100
Date: Fri, 29 Nov 2024 15:54:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Make MDIO bus name
 unique
Message-ID: <c3a018e5-01f9-4150-817d-ac37ed09a06f@lunn.ch>
References: <20241128212509.34684-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128212509.34684-1-jesse.vangavere@scioteq.com>

On Thu, Nov 28, 2024 at 10:25:09PM +0100, Jesse Van Gavere wrote:
> In configurations with 2 or more DSA clusters it will fail to allocate
> unique MDIO bus names as only the switch ID is used, fix this by using
> a combination of the tree ID and switch ID
> 
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
> ---
> Changes v2: target net-next, probably an improvement rather than a true bug

net-next is closed at the moment due to the merge window. Please
repost once it opens.

This change is probably O.K, but we have to be a little bit careful
with the ABI. This name is visible in /sys/bus and udev events. In
theory somebody could have scripts which depend on this name. I doubt
such scripts actually exist, and if somebody reports a regression we
will need to revert this change, and do something different. You could
for example look at dst->index and use the two part name when it is
not zero, one part name when it is zero.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

