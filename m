Return-Path: <netdev+bounces-164301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA776A2D542
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC5A3AA26B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E81B0F16;
	Sat,  8 Feb 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qz/fNv/I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C01AF0CB;
	Sat,  8 Feb 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007003; cv=none; b=Ru8vItugGRJLPg+sm0e+CK7fRyWB8neCkLmAXXKS9eCbXTlHiWeR0EA7n37CweenhR/90+HRrD/y3qlkoBGs9g3+wA6YMmqQQMxjaqIyFaKmPA2jozhSrb3ghuRZG/OCdWEdYHyqlAv52QF/qGCqMkgf7USKvaimgMGskB/yLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007003; c=relaxed/simple;
	bh=Gr+u2nIVHCsR7pAE46VfOUM9HNOkPW44oxKHJ3l/Y/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9etYOip9pWgMmur8DaYwq28mN6PEnyXcSwxbnY4haHJC9a+YV1WAKBsGzMq/Xwu8qiOapPykVC0yIyO58CbT35A8OEEZhYGA3YNCTcsN2yEwu6P9epqK2zgXcC+gT454DYNLJEIO9qTj83T1s7gXuIUNO3QzvsxO4dMpF1efzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qz/fNv/I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lSvdFS1Tmix55ChwG42rDuM5tBqKbIBiBkAZfphft8I=; b=Qz/fNv/InGvbRTlwHZhErnacK7
	Is73Z5xtxofs9nfUqTQTVi10V0sJcJQD7OmNhryXcpLJzpI2eFGe0KqJZk70BIPUD5vSThVgtSGyb
	kuAadzjdNE1XBWlQWgjKacbRPdybnZ20FwI8n8TV4sAiPyqJ2VEVumjRatcbE+wJU+o8bAe9jnGVA
	MWneI2sxi46JEGkbJj4up5zfJItCt4lcnMfRkD+DKO8DsQ9WtLfq5RsYQJWLHWQ6EcyoFhnIQsRxS
	dMp3n1+gE/9uxSntCbrJFeiZzZLXao/EivWbidVUxQrJCBPWY+V9ldRgYMAwjjsxXoNlmzDKBVt5G
	90ncmAUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgh9p-0000Fa-2S;
	Sat, 08 Feb 2025 09:29:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgh9l-0005ME-39;
	Sat, 08 Feb 2025 09:29:46 +0000
Date: Sat, 8 Feb 2025 09:29:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mediatek: add ethtool EEE
 callbacks
Message-ID: <Z6ckCZpOo1_rvmh6@shell.armlinux.org.uk>
References: <20250208092732.3136629-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208092732.3136629-1-dqfext@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 08, 2025 at 05:27:32PM +0800, Qingfang Deng wrote:
> Allow users to adjust the EEE settings of an attached PHY.

Why do you need to do this? Does the MAC support EEE?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

