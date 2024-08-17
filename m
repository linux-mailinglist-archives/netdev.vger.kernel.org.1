Return-Path: <netdev+bounces-119436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34752955950
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08BEB21390
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17974154BEC;
	Sat, 17 Aug 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0/24WDmG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7B225A2;
	Sat, 17 Aug 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723920297; cv=none; b=IsK7+MdvP+fXSLVLRoUAVpMshqS+Vq+e+KfRdvo9J7LislG9XNZikqcV33N+25tEsl/Ghbr4wm4aP5T/FaOHQEwTbxg8fBSsuVUQFdffWyZ3khVv0Vv3MNVMWgs3C82CuW7T+Waqa8a1gBVR98i5sFrrkURTgaMYcsqpnppInec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723920297; c=relaxed/simple;
	bh=KyGdqPdKMIpOkpLU3wQ5JkW2ofBPLC4CdJmx9gkqBBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlvXGXoEc4OShxZbu20+LFdUb9NMAc00Q8Y25UIUni9D+z/j8WDNKUqPaY6CnErH+NSfp44nRyd5kaJdXWD36BMLUfPAUY1fsiE+ToO94xxE0y5ER8jkx9w8v9PQU4JhHAPYAPeV72bKv7kuZ+mtdC2/WuI8+u+rITMyqkOby+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0/24WDmG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v6Kgz21PcaR4vxrTnVE0sF1GvbC9SvmAd7YQLV4V5S4=; b=0/24WDmGDBmk8Z0japa9BNXJjC
	ng7Gn1JJiNF6zeNJHvCvqFcMmKPZJQpdvcM2dGXIhfxbtVNNZWoHN+VbuiRClv5Dm/hy1YyUKvEw0
	HtaBueHXtDjsdOh+oPhik9WE9JaTqrhzd5qpiN/Rr2uqr0i10IhRHnBwYlvnSCSqiprc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfOQ1-0050fC-9N; Sat, 17 Aug 2024 20:44:53 +0200
Date: Sat, 17 Aug 2024 20:44:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 5/6] rust: net::phy unified
 genphy_read_status function for C22 and C45 registers
Message-ID: <45f894b6-86aa-4421-92b5-e423325ba802@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817051939.77735-6-fujita.tomonori@gmail.com>

On Sat, Aug 17, 2024 at 05:19:38AM +0000, FUJITA Tomonori wrote:
> Add unified genphy_read_status function for C22 and C45
> registers. Instead of having genphy_c22 and genphy_c45 methods, this
> unifies genphy_read_status functions for C22 and C45.
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

