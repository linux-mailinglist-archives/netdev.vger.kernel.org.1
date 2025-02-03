Return-Path: <netdev+bounces-162150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BAEA25E22
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240301886B11
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC54209F5C;
	Mon,  3 Feb 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xd9XSCNZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94B20AF99;
	Mon,  3 Feb 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595435; cv=none; b=tzlxZMZkiq8UaWlEeDgoZnQN/hEZVRHqdaPaJp834438ywX/fzl0rbAKDYu0TgyFndvYVIJUyfk/6hk1P0X7Ysr/+L5fy/cKTVpU0mPOHb2c90xWT0LK1MdMpqsRGsOs79Pi2INw4ToYL37pbP0mjG77gpb4YMqQAL/hvttdCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595435; c=relaxed/simple;
	bh=BW01bBlLFUwOpmEo7MJEAWr7ShDovy89BNjIMGmP24s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ/9rq51zMPChAMOWWhkaz+IhnWKjMJzEZZP3NidhdBPU74o/zdp907vOwkgdv5gMrUx6sMKVkjRVOwWcjcqBYODsc3a4jEY/2fyrJO05lvJw1eXfV43lUq3QPC5M9fmOnJiWaDQLxIEkHrD7p/g9HHGoZhVmykvKcnhf1Id9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xd9XSCNZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5hnnaZ2XQa/kJAOoyclTESLCPfK7fCzob11sMwrX3r0=; b=xd9XSCNZtG9QUn9jUe6RSzyxzz
	1PuaLgWb7y/8Xp0Byv5jm0DnGhyhNWsun3RYXkhGwRFMDp8LFgp8cRj2jGxZQgY3yUaD+DExalqMV
	vQP2TalG73wMVatamUyXFHb/sLTYKsSb+Br+25T63J2dRXcJYCa9CiG1Sso1V3exhSFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tey5g-00AYt7-Pw; Mon, 03 Feb 2025 16:10:24 +0100
Date: Mon, 3 Feb 2025 16:10:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <a2ae1cda-8210-4e6c-86ea-0ee864e13b23@lunn.ch>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>

>  Conversely, spelling and grammar fixes are not discouraged.
>  
> +Inline functions
> +----------------
> +
> +The use of static inline functions in .c file is strongly discouraged

I don't think 'static' is relevant here. They probably are static, if
they are inline, and to avoid warnings about missing declarations. But
we just prefer not to have any sort of inline functions without good
justifications within a .c file.

A nit pick, so:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

