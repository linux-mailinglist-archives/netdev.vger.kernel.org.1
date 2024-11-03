Return-Path: <netdev+bounces-141345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243D9BA841
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446881F215D7
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9E18BC15;
	Sun,  3 Nov 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cBq/u85e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077EC2FB;
	Sun,  3 Nov 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730668376; cv=none; b=lsiQhqlEXKKeMrcBxGSci7B+SVu781X+9qQsjJkvAw0OWaAAHo9+q6T7IsXJ1srf/WyLHCNRKYdLaJmgDXy8Wnda+jvJZ6HS0+9vmdR+gU6ewp2SGqpx2d5ukGPbDwKwRB3QUBBpZ+QIRzX6TF+PiFm4R8Pq4i2pmEpdA2P/19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730668376; c=relaxed/simple;
	bh=OrHP/C87GXayQ8LpWYy6cpovSsIWwKGIklS+Y06lGjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtJ0D6BuCseM0dX1JFvTGlwd+gPyxW0Z4w2Sbh1tenZCq9O+eXm/PhrBm4K0LJnyaT1Eg1TVJnfU8cwWHSLZljJ+6N7QJHAOrEqi/TpVAxAOaGYPoSIzmdlXHkB8tZsJfM+MzC3E0SEdXcjHw0LjZKwVZ1kKPiY/tW7rG7btoP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cBq/u85e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u9af+63g91MWH5Q/sekGcHeUCPlXa1HKblO1SD+KLHc=; b=cBq/u85eBFBcZQxZW3iMjFG89x
	MOvzGmp6iA0/Szv7H0wdqO9yPD6o3Xa1lXfNa4APn62DC1lN4A5QvBpb8KmPnADrZ420esdgtkjbN
	9vn4THTjgiRxRlWYDXVIWJ0P1Scb1sMfczEIfmRoHPhAt0xCgnPYNOwO6a2HB5yYHShs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7htg-00C2V9-8S; Sun, 03 Nov 2024 22:12:32 +0100
Date: Sun, 3 Nov 2024 22:12:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	olteanv@gmail.com, akpm@linux-foundation.org, kuba@kernel.org,
	krzysztof.kozlowski@linaro.org, arnd@arndb.de, bhelgaas@google.com,
	bagasdotme@gmail.com, mpe@ellerman.id.au, yosryahmed@google.com,
	vbabka@suse.cz, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
Message-ID: <769445b8-e9e3-4e18-93dd-983240ba0bf9@lunn.ch>
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
 <173066763074.3253460.18226765088399170074.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173066763074.3253460.18226765088399170074.git-patchwork-notify@kernel.org>

On Sun, Nov 03, 2024 at 09:00:30PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 31 Oct 2024 10:33:29 -0700 you wrote:
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Changes in v2:
> > 
> > - add self to CREDITS
> > 
> >  CREDITS     | 4 ++++
> >  MAINTAINERS | 1 -
> >  2 files changed, 4 insertions(+), 1 deletion(-)

Hi Jakub

I could be wrong, but i thought Andrew Morten already applied this?

	Andrew

