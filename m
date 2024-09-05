Return-Path: <netdev+bounces-125704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0996E4E2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937EC1F246BF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CED1B12FB;
	Thu,  5 Sep 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZoEHES1L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA604186E40;
	Thu,  5 Sep 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571020; cv=none; b=tsPUD89I584jerEL3a5Iu5nw57mroM+t5SojrPx2JW+jdByyY8imCFUw52VySpExMjUlyMtXerZOed8FgRtvS7tAIMlV6slroiDraJeaau69uRihbizzvMGSp3AtyS8gwHKQ7nz0vxfdK7IFi9HKA3Fmy3TbMyc9FYvkTT6FCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571020; c=relaxed/simple;
	bh=jjObYHIczgIwhlHmvwOgNPUdriTRDq8bYbAHQSBjqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGFiPxnuYKb9KDidkJbwiFbLs6tmoYQnNDFqbb7Fxx1LXlLTRbaGMJqvP7mHGCCFCPwLjgt9lLMIR0ajwVtfZcEiZ02SUjWcEDSbzGf95JTAfTYk4eQCzinNXBaA21AGFWrwHLrK1rnvlKwZh5TeNi4E9bCHQeslIduKiMD0ikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZoEHES1L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q2gZJwVdp9g7l0r4otTkDbkdvT+IcujuzbsvsMi+KX8=; b=ZoEHES1L94HfBMERZKs2b0lOF2
	FHF5KB1zx3jAGUYpSkgpciELlGaP5HzZkCWDI4jMTfpMOk6oA3fcf/JdCRflcL0ko2GSNp9Mg9g5z
	cFOwIMnXOPZMMedxoQ0FiSVJP6zoAAYxnGXd9dhYEBOyUHO3W2D/epTsGa86e6GJzxeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJqU-006ipk-Mu; Thu, 05 Sep 2024 23:16:50 +0200
Date: Thu, 5 Sep 2024 23:16:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 1/9] net: ibm: emac: use devm for
 alloc_etherdev
Message-ID: <a12236b5-b7a5-4738-9226-ddef37bb3fb6@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-2-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:14:58PM -0700, Rosen Penev wrote:
> Allows to simplify the code slightly. This is safe to do as free_netdev
> gets called last.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

