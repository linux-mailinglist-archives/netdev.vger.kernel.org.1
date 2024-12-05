Return-Path: <netdev+bounces-149366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4F9E5483
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E5284556
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF8212B09;
	Thu,  5 Dec 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y35RZ1fO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB47211708;
	Thu,  5 Dec 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399349; cv=none; b=asbq41m8ymX0Bl9lR28fuyuJ2j3m0kjFKZ5cDA+QI0kmx6BhinoqhRrD0LtJoZfrtM2ONGxn4wuHPQzc3rQBzH9blDTZLLNqCq9X5Hl+cGFHZDxUUkKmTAP8/vIpuf6VoZD/TpPxHnQhNg5Pf2xrWwbjm9Q+cuOt9/fhvfFyZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399349; c=relaxed/simple;
	bh=Z4JL1webB+69PbgcxxMGGKD01phObGvLqmAxQXX9u3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP0qFZsp6E3wT8rh4/we/Zy3G2/GTL1tc2Q9Wh7emsS8ItpFrxZQtCxgRVDKOOr686wZprU3YdgL4o4RqDma2uT5RBNekMOvvOSKmrpZKYCeaUsW/nUE4I1PTu7v9TTunCojcCpElpSl2xMto70p8dgiOFwUJmpjP8M+Dier2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y35RZ1fO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3T8BUKTv180szcs7l3+S4vFllRzpSSChW5a3YmubLiA=; b=Y35RZ1fOoYQ4mOCGq1tJbYcbR7
	SFuKukyxOAoUNNrFttRpak1ussId3VjrUgrNmOxINSxSNAVF6wVKx4nzpsKu+J1T5vlojA330qcpk
	vtksHygLYz06ZWUVk7oIB6j/b1Xe1vbAX4f7rs2RHSxZyB9W79aOAI8buRXWEJ6FOHceKtxO1PeeH
	9JjM79FRxDNZ0w+KgDmOHGsDSd4urCgcz0trAQWSzyJzX3Lomo+K2NXVQpony/nvU/u/5dbILPB7m
	PmuD8cAAzyNrFxCLdWI/RtBsGYOXRkyXdk+aMFkSXZEDZbwvgw3hy4zChDB2eeTOBHSuJKKXMbUh4
	BGKCGlpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJALn-0004gT-2M;
	Thu, 05 Dec 2024 11:48:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJALi-0006W6-2d;
	Thu, 05 Dec 2024 11:48:50 +0000
Date: Thu, 5 Dec 2024 11:48:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/7] Introduce unified and structured PHY
Message-ID: <Z1GTIlVOiQk8tG1t@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Oleksij,

As this comment applies to several of your patches, I'm replying to the
series.

Please use the prefix "net: phy: " for phylib patches to disambiguate
them from phy (drivers/phy) patches in the kernel change log.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

