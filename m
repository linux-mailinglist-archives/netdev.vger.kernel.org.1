Return-Path: <netdev+bounces-162071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8816A25ADF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7068B1884D7F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41C204F92;
	Mon,  3 Feb 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2yGuMu/H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C01FFC55
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589372; cv=none; b=NYxDxvmMqVQ5Jrkagp5G5Hzch0UoYlnjCtcOOtvG21ChktrAUgnGgPW77HyW1HjtfShrpbl42EWVGAx1j2QP64skyzZ03MoveOewSi7jEi7mPM2o4m44ypX9dfdh/dUE/2cV9/4M+fmEA1QmKv1vILM1jgg5LYtM41D4h3gR6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589372; c=relaxed/simple;
	bh=0dIoHeYAb91XrmBhaJbibyq1jqsIK7uqMVx4WiU/JJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfAdoBeoDK+yfBP/2PH/UorLFrWbLEVvyUnB/YsZvhzr7HISrs2m/E9sqkQ9FiGwZFkFmU8S9WVmcosZRywMWhRoTaffI1Q04/Phoy57Lo+SlDuFCkgHMv710VqUmBcLQG2B0yEcGVEaC1vAH+kqovOuJZDYuusfbzESfoQh2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2yGuMu/H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sF8hLZSirL52B5+nEtwimjobmj4GY8eaORQupXGOCT0=; b=2yGuMu/Hvp37AS0dGNsfBaRROu
	26IHIZhsN8fGevOcxgbF4GzZIqiJho0BR0xoV0W+y1dWETXFKKlKAF12jLsDNSD+SHYnVpkZtUf0x
	pJg4otRBKqTI3pUCMMgDlqywftn2KMdM6NJQkUx+cwrPVKVi9Tg9xnooJGA2oRNmVXho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tewVv-00AXNy-No; Mon, 03 Feb 2025 14:29:23 +0100
Date: Mon, 3 Feb 2025 14:29:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <9f6c2d87-bb45-4c95-af93-7d2ca5f1dcc3@lunn.ch>
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
 <20250203105647.GG234677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203105647.GG234677@kernel.org>

On Mon, Feb 03, 2025 at 10:56:47AM +0000, Simon Horman wrote:
> On Sat, Feb 01, 2025 at 06:11:55PM -0800, Jakub Kicinski wrote:
> > I feel like we don't do a good enough keeping authors of driver
> > APIs around. The ethtool code base was very nicely compartmentalized
> > by Michal. Establish a precedent of creating MAINTAINERS entries
> > for "sections" of the ethtool API. Use Andrew and cable test as
> > a sample entry. The entry should ideally cover 3 elements:
> > a core file, test(s), and keywords. The last one is important
> > because we intend the entries to cover core code *and* reviews
> > of drivers implementing given API!
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > This patch is a nop from process perspective, since Andrew already
> > is a maintainer and reviews all this code. Let's focus on discussing
> > merits of the "section entries" in abstract?
> 
> In the first instance this seems like a good direction to go in to me.
> My only slight concern is that we might see an explosion in entries.

I don't think that will happen. I don't think we really have many
sections of ethtool which people personally care about, always try to
review across all drivers.

Even if it does explode, so what. Is ./scripts/get_maintainer.pl the
bottleneck in any workflows?

	Andrew

