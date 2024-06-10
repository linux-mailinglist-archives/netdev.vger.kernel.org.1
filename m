Return-Path: <netdev+bounces-102346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734D90293B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5B7282657
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8A144D19;
	Mon, 10 Jun 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rkkQy4Dg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4E14A85;
	Mon, 10 Jun 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047660; cv=none; b=ZpwwBStL8K0sc34gXfOEQPxc7hBOiBy9FtL4QtuUtlnkgPJTKNP3XT1xPHbtS0XM7GJSIyX/CMeiyI6ynr3pPYmC/QPZDPh3SjBuXjZqGNiz5gqH6sdkxUf2OorghNegw2JtZ0w2BA7F1B02lpPrQbL6scoPie1U7HIhrAJNXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047660; c=relaxed/simple;
	bh=yuNOHab/Qh0nJR8QmMywHK9g1cgCBeo/HLsQ/jKVNbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJS6OlNokmmycR8k4OMFMPH5TzKuWV5PLD/kBbYSX5PGB1RMy2ApjWp9CBcWlL1vWvDjNbTJ0EhrwpGSnMnnEecBAkUUJkQVi8AuXl0EX613LjJI8pNUDFwOVBIebvlbQlPQhaIoJcY+Ae7hBwqUDC28T4nPV0LRcTbyL4pS0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rkkQy4Dg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MiZyu8VhPCk0AXuRPnHhqHOvpBJ0fh6/3Mj663IB6kk=; b=rkkQy4DgBiRXuV0GDiC21jNbL+
	+sKzjfXkmyigg916XMHJle6k/JKxg//GmdgAAHq0vw9sjlLS0X+V9I6mjsJytGeZt4hXaqAaI3IUP
	hwcrxGVxlZN3G9Aa//f+OkUhuEq5isbDMQ6LSxUM/U387T4lfW0gZ8cj4lexim+NJNgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGkfs-00HK4x-Qm; Mon, 10 Jun 2024 21:27:24 +0200
Date: Mon, 10 Jun 2024 21:27:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Richard chien <m8809301@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard chien <richard.chien@hpe.com>
Subject: Re: [PATCH] igb: Add support for firmware update
Message-ID: <ef5029dc-baad-49d8-8c95-03ec41df5858@lunn.ch>
References: <20240609081526.5621-1-richard.chien@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609081526.5621-1-richard.chien@hpe.com>

On Sun, Jun 09, 2024 at 04:15:26PM +0800, Richard chien wrote:
> This patch adds support for firmware update to the in-tree igb driver and it is actually a port from the out-of-tree igb driver.
> In-band firmware update is one of the essential system maintenance tasks. To simplify this task, the Intel online firmware update
> utility provides a common interface that works across different Intel NICs running the igb/ixgbe/i40e drivers. Unfortunately, the
> in-tree igb and ixgbe drivers are unable to support this firmware update utility, causing problems for enterprise users who do not
> or cannot use out-of-distro drivers due to security and various other reasons (e.g. commercial Linux distros do not provide technical
> support for out-of-distro drivers). As a result, getting this feature into the in-tree igb driver is highly desirable.

I don't really follow what this code is doing, but it seems to make
ethtool -e and -E dual purpose? Please could you show examples of how
this is used.

Thanks
	Andrew

