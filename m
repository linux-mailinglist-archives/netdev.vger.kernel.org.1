Return-Path: <netdev+bounces-100986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06748FCE9F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEBC1C20FBB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E71BF8E3;
	Wed,  5 Jun 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pek2bJcX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4319CD0F;
	Wed,  5 Jun 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590470; cv=none; b=giqijUleLTkYrpbXckljNbnpQp/AM7utuZP8xeigBkjff71A0Qz/NSCBYhxetIlXYn2BGNk6ekPrT2rACK2ghJz4FfYTJODL3fZjg75xgIIv8N/B298mKTgXnLwkiGSvhjKSz59snMuXmpml0AkGFI2/9bRfpdo6/Q3pIPMVlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590470; c=relaxed/simple;
	bh=vAfBbs/RE3A6rRHJDVOYFTEdlEOETIb1vUNfnhuTtSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e12kXUglU0wvjmRXDmA9/Q7N50AnXdOMKDxCmr7Qd+TsxlwopPPbneoaBg6pJ79+loMDPUj6hLNgZxKZmqA6AAvsHBeGIbIBXFEjLHNy2y4pAkAB6sSyD5yvv6scVe/DPsH+92jC0oWTv8AtjN6BU71p3zjX4SlJPrGu/XscYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pek2bJcX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f+3E3BzuIwy3nzt7rPCLz2ZJt8+Iri1AkQe8yvM0D7Y=; b=Pek2bJcXAetLeba80NpZqCB3WZ
	SwAmst1EdTciAd7vJLkCoF5TRBk+/RvfDUnxuI7PxjNmThA/UiaGnff6wEkeJiWfERCvhAWBXG7gh
	EMnm03V7gsaHnwLGlv+Zc5CT+7XmKgQ2O+pHhe6E026CjZXIvuHEF5Zpyi2x91BLxwz8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEpjp-00GuN0-Ln; Wed, 05 Jun 2024 14:27:33 +0200
Date: Wed, 5 Jun 2024 14:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	kernel test robot <lkp@intel.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH net-next] net: ethernet: ti: Makefile: Add icssg_queues.o
 in TI_ICSSG_PRUETH_SR1
Message-ID: <28803aee-e3fe-4e9d-8410-4ac957d77dd6@lunn.ch>
References: <20240605035617.2189393-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605035617.2189393-1-danishanwar@ti.com>

On Wed, Jun 05, 2024 at 09:26:17AM +0530, MD Danish Anwar wrote:
> icssg_config.c uses some APIs that are defined in icssg_queue.c.
> TI_ICSSG_PRUETH_SR1 uses icssg_config.o but not icssg_queues.o as a
> result the below build error is seen
> 
> ERROR: modpost: "icssg_queue_pop"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> ERROR: modpost: "icssg_queue_push"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> 
> Fix this by adding icssg_queues.o in TI_ICSSG_PRUETH_SR1

Please take a look at
https://patchwork.kernel.org/project/netdevbpf/patch/20240528161603.2443125-1-arnd@kernel.org/


    Andrew

---
pw-bot: cr

