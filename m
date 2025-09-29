Return-Path: <netdev+bounces-227163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D83BA95C0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A325A4E02F6
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365629BDA5;
	Mon, 29 Sep 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Srzab4mW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167321C167;
	Mon, 29 Sep 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152841; cv=none; b=XTPtPOJy8c8HKZk0vcpI5XJPHW7I3bLsCBv3Cnb/Hd7lfiS9SfU5VLBc4Pbst66kb9Cmcft27xxZC+64Z00EmOLk5S+b3m5NL13EAZ+pqOTXvtqxko4THOPBenoYvlZbaGgCp79SZufY9Wb//qjxvQCglmIA6zNoMQg0/hNBrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152841; c=relaxed/simple;
	bh=fy1uCfRmy0leafZ5ZfsUbYtIokOe0KrM31TsSA7AizY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga5XOTIU8XHWpEQSa4wmkhX1u4U6Czuu761PI7Wbs+xVp5OL8qO7wza+ZRbNrZb4q/JiuECfgzqIPKbxYs7uLTbCANAUf18mS8jOJ0TZWm5ylSAhNHVNhLgw8VLH3iKbf6Fn7nrXfHfGZL1mYcGBO72TRbbPW4zyYnFqpWkftx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Srzab4mW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6+xyV7M49RIPN6A1jpI7ywEM33tLmaK8mcEjuSvtPNs=; b=Srzab4mWj8nZ+7CU+cDY2lxC5C
	PUhkKvfh6TovUXmu90epRusWzl4UouHgCZEkpWr2ivPBbfOFGMB+0+KXU2huTRM1Qnfhl9vDb3mcp
	Pb0YlBc/Vvt+VYWvhjD0QutaaVVFsU07SNXWwUmgsxA7XyH2tosxCGzNazsZq1TdenaLPKNfnK4oE
	VhuwoRkQ795yZbT+JsQKZQHhp50pWhw8JjdQYA2Gmuqpdib4GKsKktDgVqCISVB5MoSnRYiRN6gME
	UqmYSvJtqjN2B/1jWPeOUgdFI2nPsgJDlc2PuPFERvCt+iQp14Tsfjf5MY39Mg0aVfkw6iNF2wV6B
	WKJKnfzg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3E0k-000000006em-0PUS;
	Mon, 29 Sep 2025 14:33:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3E0h-000000003a8-2lz9;
	Mon, 29 Sep 2025 14:33:47 +0100
Date: Mon, 29 Sep 2025 14:33:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, vladimir.oltean@nxp.com,
	vadim.fedorenko@linux.dev, rosenp@gmail.com,
	christophe.jaillet@wanadoo.fr, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <aNqKuzlxWwcANiK7@shell.armlinux.org.uk>
References: <20250929091302.106116-1-horatiu.vultur@microchip.com>
 <20250929091302.106116-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929091302.106116-3-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 29, 2025 at 11:13:02AM +0200, Horatiu Vultur wrote:
> The PTP initialization is two-step. First part are the function
> vsc8584_ptp_probe_once() and vsc8584_ptp_probe() at probe time which
> initialize the locks, queues, creates the PTP device. The second part is
> the function vsc8584_ptp_init() at config_init() time which initialize
> PTP in the HW.

So, to summarise, you register the PTP clock at probe time? At that
point, you get a /dev/ptp* device. Is that device functional without
the config_init() initialisation?

I would hope it is, because one of the fundamental concepts in kernel
programming is... don't publish devices to userspace that are not
completely ready for operation.

Conversely, don't tear down a published device without first
unpublishing it from userspace.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

