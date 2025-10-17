Return-Path: <netdev+bounces-230481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D6BE8A29
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1135E13D4
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEE32D0EA;
	Fri, 17 Oct 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eaCyIulF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340732ABFF;
	Fri, 17 Oct 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705087; cv=none; b=Il2+NdpVXKUce4hPCLy3okGZmZWHbba4FyrJ5Pe0DNOgLuzxcwdM81w2J53eekgf4ELuE5v2fT77/gmBzcNCEXdpLf3uNbgcy7UX05Qx9drBrl6umkIn6e9nyWGLxYdE0RO/k+XU/zt1gZgiZgR4KhmiMdAnnUkOttHJFZ2BsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705087; c=relaxed/simple;
	bh=0QgbZU9irSNV/N076JQZk6AJrYALmk3Md2UhCibShyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4tZmfq+9WV8YH0qwKEHcqthW1sSFbafY0hVBTXzZCyYccAO2U/fzXguRV28wUjVaio29hO49u9HP4qwLkb28YDRNzOPLUCDeRcn3zBNyYpX/dgTE9H6Bwiy+FYyqp0XOKxjL3gNPUWh2TFdhVsdR/wwRI0NWFgZD+6EiXznhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eaCyIulF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iMaunYaTiHBvajS7Akr5txw8OUSAxQkTAc82E7olhqA=; b=eaCyIulFQ6xXo3jsBkivsFl4D/
	eX2T8893dgSWPXh0cB9jACnVhOKEftIlnkvKdgnTBqdyc5p81MVz6fbyELEM3BxWyq6MkccMQBaRe
	u58byjoq7OPLCF3H5LTWYkPJx7qu0a/yUatYpBiWM7NoDtVEbCzIHayP22SbhtnHvdkeeG1g8cro3
	eYu93lp8g+6CLI6mvoLnmagZtbsA2h+fpTOa//ygkATewPSSWzSHBwzR0ObROGZPTRZxXX1WaqMQf
	zfbONHfMmySV7TT5o21EKlk6UP0k9p2He0SK4PXGt7oPhbylRTUmdNUQLofl/7pJ1c7MRzntD6eHk
	SOcZZeEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9jox-000000007tY-2bB3;
	Fri, 17 Oct 2025 13:44:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9jov-000000004Jy-0MNd;
	Fri, 17 Oct 2025 13:44:33 +0100
Date: Fri, 17 Oct 2025 13:44:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <aPI6MEVp9WBR3nRo@shell.armlinux.org.uk>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 17, 2025 at 02:11:20PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> On hardware with Tx VLAN offload enabled, add the VLAN tag length to
> the skb length before checking the Qbv maxSDU if Tx VLAN offload is
> requested for the packet. Add 4 bytes for 802.1Q tag.

This needs to say _why_. Please describe the problem that the current
code suffers from. (e.g. the packet becomes too long for the queue to
handle, which causes it to be dropped - which is my guess.)

We shouldn't be guessing the reasons behind changes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

