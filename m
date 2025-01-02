Return-Path: <netdev+bounces-154692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343869FF78A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F74318823DE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF6F192D98;
	Thu,  2 Jan 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G53OiJWa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD41799B;
	Thu,  2 Jan 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810825; cv=none; b=G9vhnfDP8bhwAjcHKzbNHcyrVQUw+z55EDN3pUOKSqZkntmg/azyCH5vePhhd5ZUsAR2m9ZehhEtDkVh0cbZHDDvi95dROk78YqKSGzUYmXnJVv4mSfnbVkVKAujl/DRrjqLNMYN1Gdu/SQ7Okda/gMhU5EF8aPEREvDVe6zlbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810825; c=relaxed/simple;
	bh=Ak0oZch98TKGi+IQoRb3IrXskE4FYCAcdWJhtipzk0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2PzNsSZgejDVLj5QR3oAEc3B+O5/lI7EFxQRuO118LqLiJAhY7xvwwYVMhi/CZdNOfchVfqrqeMMx93wwJ6qJ/yWIJ9oO4i0cPr8YZM36JJOvrfNO4URszSnmKt40Ve0gnlKeKTPiFwFSjUQprsTSBwmgy/Q5WQlMVvWc16Ojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G53OiJWa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jR56E1dHEnAiWTO++f+VHBMrVMh2JggszBAmTWsKimg=; b=G53OiJWan994izEORyy49NXI5O
	9+vhSwApqo2gWZkzd0iqtClXxZ1CrAGVaw+s9CLkQb0EKwwpa+me8yEVVwVksJfys6VezCMhf1E2W
	qAs7nTmrPktslPGvq1URFl3QS4/YCHCJWfalctBE3RecXPsrLgmQPAX67E0rcFfJO1LlfUlK2Finz
	GTdcaU4LC/47z0Cfj60wQ2ZBVg0PHEzQ/mI3KUWXRwxOI63yb02iCw9pGYFnNjRbvX7lLe4mAaXaG
	nHLVRIHU5GOs21y9leCfoRi17rHTbtF2BvZAVazBSP6XhTjcOgr+SrVRWpyWTpzSeL39XX2ubrm08
	rW3ylGMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57002)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTHgi-0001pZ-0g;
	Thu, 02 Jan 2025 09:40:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTHgg-0000Av-2N;
	Thu, 02 Jan 2025 09:40:18 +0000
Date: Thu, 2 Jan 2025 09:40:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio_bus: change the bus name to mdio
Message-ID: <Z3ZfAvjQAglkN1_W@shell.armlinux.org.uk>
References: <20241219065855.1377069-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219065855.1377069-1-yajun.deng@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 19, 2024 at 02:58:55PM +0800, Yajun Deng wrote:
> Since all directories under the /sys/bus are bus, we don't need to add a
> bus suffix to mdio.
> 
> Change the bus name to mdio.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

No. Just no. This is a user ABI breaking change. There needs to be
_very_ good reasons to make this change, and there needs to have been
research into whether anything in userspace breaks - and all that needs
to be documented in the commit message.

I think you sent a v2, which received similar feedback (I'm catching up)
but if not, I've stated my position on this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

