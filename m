Return-Path: <netdev+bounces-52621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 331907FF7DB
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BA9B20EA6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325855C34;
	Thu, 30 Nov 2023 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VZV9bvbd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE110D4
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7WmXmex1/97Iz61kMUCUoPEJzhUBEGakNkNFYWzvDR4=; b=VZV9bvbdzVb3KNqSSu9Lp335pZ
	IDyGVMLiXpsPvHWDXj61TA4dbIR6r6kvn7HeUP7Yq5WcruhNPJzvLIAYKbMOnPi5ubodG7SybNPcN
	0fmIFEugW8Kra9za+sAt6JSypKM5IXqk7gS5ZcxLGWVXiio7eN6WUQ8iF3dK34uOAm/s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8kct-001gcy-6k; Thu, 30 Nov 2023 18:14:59 +0100
Date: Thu, 30 Nov 2023 18:14:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	thomas.petazzoni@bootlin.com, netdev <netdev@vger.kernel.org>
Subject: Re: mvneta crash in page pool code
Message-ID: <f3882569-a8d7-41b8-81d1-90bf2aede99c@lunn.ch>
References: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
 <20231130090201.326c479e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130090201.326c479e@kernel.org>

On Thu, Nov 30, 2023 at 09:02:01AM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 17:53:39 +0100 Andrew Lunn wrote:
> > Hi Folks
> > 
> > I just booted net-next/main on a Marvell RDK with an mvneta. It throws
> > an Opps and dies.
> 
> Sorry about that, you need this:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231130092259.3797753-1-edumazet@google.com/
> 
> I'll apply it and push it out in a sec, seems like multiple people 
> are hitting the problem.

Hi Jakub

Yes, that fixes it for me.

I will go add a Tested-by:

     Andrew

