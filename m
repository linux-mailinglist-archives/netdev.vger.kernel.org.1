Return-Path: <netdev+bounces-62712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5D828A88
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D64B24E3F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A353A8E2;
	Tue,  9 Jan 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SyCrUUmR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BA374FD
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f7spsEGigmmxOLMJGF+VZO4qNQxG/FbM/j+LPv5MMaw=; b=SyCrUUmRj+dFa6ggH9xsuKtmYC
	bDpyiJDgAPcCFiQ94J7gtVzUOERTP7ISOkvY+kdcSpCjemXub9GhYe7J1He0J9/HWWQL+5DRmlBFH
	HOuUxOLqeEQqhH3VcE2F0br5HrJj5fcm2pSg82kzympV7ipdTYvnllFZPOtLt01f5MNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNFNo-004qpd-MS; Tue, 09 Jan 2024 17:55:20 +0100
Date: Tue, 9 Jan 2024 17:55:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
Message-ID: <58364a9e-a191-4406-a186-ccd698b8df4b@lunn.ch>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164517.3063131-4-kuba@kernel.org>

Hi Russell

On Tue, Jan 09, 2024 at 08:45:13AM -0800, Jakub Kicinski wrote:
> Thomas is still active in other bits of the kernel and beyond
> but not as much on the Marvell Ethernet devices.
> Our scripts report:
> 
> Subsystem MARVELL MVNETA ETHERNET DRIVER
>   Changes 54 / 176 (30%)
>   (No activity)
>   Top reviewers:
>     [12]: hawk@kernel.org
>     [9]: toke@redhat.com
>     [9]: john.fastabend@gmail.com
>   INACTIVE MAINTAINER Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 

>  MARVELL MVNETA ETHERNET DRIVER
> -M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>  L:	netdev@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/net/ethernet/marvell/mvneta.*
  
Do you want to take over?

	Andrew

