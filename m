Return-Path: <netdev+bounces-100560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ADC8FB321
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E60DB253DE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409EB1EA87;
	Tue,  4 Jun 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AL+/aUvu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BC883D;
	Tue,  4 Jun 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506037; cv=none; b=RWars6z1LZEUjxUFP8tXx8tmDFfz8wJ1n4Gh9qbXR7oBTQUsvN+Vkc5Vx5Xea4ZyqeteqIgVzsk1LEr2tb59f6rvUCSI6NGScbGPGKsyRncTGYW8hkqUFQgLMq1OrOV164VT+roy5JG3KFHtnaLIzXwLm3xQFs8Vzh5tQKZw7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506037; c=relaxed/simple;
	bh=G3AFkYKKYY7EUOWjH0ZVjWeFzMlaD3fjnmcDQXWxiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgiT+Kzilp1vox7ukKckulq7m4gO7b5+ApEylWklfby74ZTiMS/QRVQwuk8BIGmUzjs9VtAetQglI18auK26wTbl266FsJ7t3AEj1v58XyeQmeQ9TZYktMKoXaBTquw5zmpfz2TErhZ4su36Wox7RAHQ5/HNP3k4r0dG4CruC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AL+/aUvu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VYGAhEZXo4j05kuFZF8FnMoIkV4KZnSZ9FtBHcoN+Ac=; b=AL+/aUvuWupEyBwdHnY8nzUQ+3
	Cjn5vjwIztEJfLbirR6mbTwBIaQcmQUlSJyhpuSgTC0Z4FDfAWXFN9BBikNp2VOamqPtuwf+4GlxA
	UA1yAGkyBK9Am1v7xEw3iophg79XBiJIi6yKSVaV3RLJnebywhHlHByovpcbOmfqEmFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sETm0-00GnrY-TE; Tue, 04 Jun 2024 15:00:20 +0200
Date: Tue, 4 Jun 2024 15:00:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <bad12a9c-533e-47c3-9aa7-1a4d71eb6d87@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>

> > Also, why SET_MAC_ADDR? It would be good to document where the MAC
> > address are coming from. And what address this is setting.
> > 
> 
> The interface which is controlled by Linux and interacting with the R5 core is
> assigned mac address 00:00:00:00:00:00 by default. To ensure reliable
> communication and compliance with network standards a different MAC address is
> set for this interface using icve_set_mac_address.

So this is the peer telling the Linux machine what MAC address to use?
As i said, it is not clear what direction this message is flowing. Or
even if it can be used the other way around. Can Linux tell the peer
what address it should use?

Also, what is the big picture here. Is this purely a point to point
link? There is no intention that one or both ends could bridge packets
to another network? Does this link always carrier IP? If so, why do
you need the Ethernet header? Why not just do the same as SLIP, PPP,
other point to point network protocols.

	Andrew

