Return-Path: <netdev+bounces-165346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B1A31B91
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E66B3A2215
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF06F30C;
	Wed, 12 Feb 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jHvmNS4C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499B1CA9C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325226; cv=none; b=e7oowwPUmAX+fFjfbCSBJmyHVNlCZi/Vww4Px5U0mfqkjeenAl9uNtbDSzEXxo5GdOIiqCAzJh2R7lI5fV7pb+OuOu71+lU8v7vsgogqWNc4hvBcXavksyyn2tN8gNuQ41rSnOTHhqJTsVPW4tYa0nqXYew68nwyJ7bosOZG5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325226; c=relaxed/simple;
	bh=lQGjHrKIagsrZsHgWS0SnXaFuP1M30nhcQHS2f2En1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmDZB38xTNaRYSk4nolf8uLH+YQlqRR1XE6MtvZD7TVkFgYjmRKhDq012Wmc2Ylbv3kP7/AFjkgG7HEQIY0u7MVIMSQXC/KGu2WKw1yieXb5yAQToswRCcrr3pDbKpYFQrgR1KkkL+ySPyT0NSeRXevGOk0Yv35m+Lsag1c3La4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jHvmNS4C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mMAoJp+vsLQj6Yjhz+4W6yPgC5zUZHnnDxJw3JSlcnM=; b=jHvmNS4CWDHNs5v1qH3SXJJHLq
	bmoC4Bo06s6/JNLxbOE4mwrfIXP9YM6cL+WTyh+hwXI3sdlwQLS6XjGnfBVDCIWwOJdRvZP65JCUk
	6+PgufJ/edrZPuDJzisd/qovLHa9yYdkL2tnJew5+5lkyKBiqvnlt5YNlONsJbdQMipM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti1wX-00DF8f-7J; Wed, 12 Feb 2025 02:53:37 +0100
Date: Wed, 12 Feb 2025 02:53:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/7] net: phy: marvell: Align set_loopback()
 implementation
Message-ID: <f48fec27-e268-4102-9e48-159645084ce8@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-5-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-5-gerhard@engleder-embedded.com>

On Sun, Feb 09, 2025 at 08:08:24PM +0100, Gerhard Engleder wrote:
> Use genphy_loopback() to disable loopback like ksz9031_set_loopback().
> This way disable loopback is implemented only once within
> genphy_loopback() and the set_loopback() implementations look similar.
> 
> Also fix comment about msleep() in the out-of loopback case which is not
> executed in the out-of loopback case.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

