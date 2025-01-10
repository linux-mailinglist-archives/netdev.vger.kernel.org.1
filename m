Return-Path: <netdev+bounces-157226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664AFA09854
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7167D168FF0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C32135A5;
	Fri, 10 Jan 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qvrlM7UP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99A567D;
	Fri, 10 Jan 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529736; cv=none; b=J07FwZ1smfn2a+pX9JjEwfSiAwkSenepwZyv3MCByt+ACXOILmhLpSt8ubRkgA5pfT1zJCXRkEplRhymIQPphRtYSo23hWJa7JA9dY/J7cyuTIt8iMLbKhv9ghbYTZus2MEHfg6gIrsO7okHqDcVyTrGIXSjXpc1PouPbhBL55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529736; c=relaxed/simple;
	bh=giJbSlXAmaCMDsXMV5xkpZaKRsQRX8KIgAZww5PM08I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PraSBALqf6j1hYMz0iJFu1TCWEFS93815lUEVJuWwNQeVVKV/R9EBP1SQGbrE7QfvMQsLRVCTdYvho260WDqXBk1IucpBQv7YyrsQISqP+6MxcdqaSE6VgLWs+p/F7l8r04Ej5U1U7aDN2hfaXwT0l1597fjIwBTXWFrj++Vyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qvrlM7UP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yp5Y6C3cS/h3XVKNmYT6Nex/Fi8rZ2kh7eVEucPl65A=; b=qvrlM7UP2StsaEaDW80BAEyqkE
	cQz1NJpNYNrjHNnrLqz6R5kVwLfK5214yep3P6l+vBpWcgxgWKOVl+viOgO8MXWMTbC0kOFVqar+p
	3ZdNk6MoMnVYZL/QpWc1a/2tVrme/4hlbPrM7oj3bTPLSq/6Mu6NWjRga84hw6pUl0js=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWIhv-003Io2-U5; Fri, 10 Jan 2025 18:22:03 +0100
Date: Fri, 10 Jan 2025 18:22:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Become the stmmac maintainer
Message-ID: <5e1c9623-30cb-48c8-865b-cbdc2c08f0f3@lunn.ch>
References: <20250110144944.32766-1-si.yanteng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144944.32766-1-si.yanteng@linux.dev>

On Fri, Jan 10, 2025 at 10:49:43PM +0800, Yanteng Si wrote:
> I am the author of dwmac-loongson. The patch set was merged several
> months ago. For a long time hereafter, I don't wish stmmac to remain
> in an orphan state perpetually. Therefore, if no one is willing to
> assume the role of the maintainer, I would like to be responsible for
> the subsequent maintenance of stmmac. Meanwhile, Huacai is willing to
> become a reviewer.
> 
> About myself, I submitted my first kernel patch on January 4th, 2021.
> I was still reviewing new patches last week, and I will remain active
> on the mailing list in the future.
> 
> Co-developed-by: Huacai Chen <chenhuacai@kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
> Signed-off-by: Yanteng Si <si.yanteng@linux.dev>

Hi Yanteng

Thanks for volunteering for this. Your experience adding loongson
support will be useful here. But with a driver of this complexity, and
the number of different vendors using it, i think it would be good if
you first established a good reputation for doing the work before we
add you to the Maintainers. There are a number of stmmac patches on
the list at the moment, please actually do the job of being a
Maintainer and spend some time review them.

A Synopsis engineer has also said he would start doing Maintainer
work. Hopefully in the end we can add you both to MAINTAINERS.

	Andrew

