Return-Path: <netdev+bounces-94453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8A8BF833
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9741F225B2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA93FBAE;
	Wed,  8 May 2024 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZjFtKFxa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED13DB97;
	Wed,  8 May 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155925; cv=none; b=bMy5fFz8K7vAM8HAp/dBeSEXN9XV8GvjhF03uW0pJnthrNZ8CxF7As3q/UfzXcde38jFM/YRZINTRg33A+uNEXQ3YOt1ZcPtwJgu7VTYpo/HHOzVxoOBHDlY3GLJK/+rH+0q4OkNv8azq+xYeRfcqtxFRxWcXP5hqph7RpvzoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155925; c=relaxed/simple;
	bh=edbSgAp6x5wdS7hhDjQhYQQt1mmbXqGyMLbuEgoFHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfVaKkFWw2OQV3jyJz+bzgWmxsBTU3GxNBuTgg9cH2q18Nld6uzezIaf3q0cxswBPmWRxiSOHbIykFl2uvzy8xjisLKu74/MkAru6ijK5oJdzZ84z4RH/L5vxbkxywX82CNIgcRioxe7gngA/MHX27OGgrp1wcBSt1efzux3xO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZjFtKFxa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uRqGn1bN/Grcd+F1z4WjSaR1kcVdDX8dLEQa2ZSJ9Jc=; b=ZjFtKFxa9wt8DrsHiQAJ0YTvlM
	CB3WxxTkZNQCVro9WRZ3AEWSOU1tKi8PhFSERTQ73pDPXW/I9XhUaicOOayOCFoSYgK/QCe/tuv9w
	PRp/MygDqsMqZkkY3fVuuCy/rVGGs+WjzUNF43KT5omOMrRmU3RHjBoXWMDHrWGPxhdoad6LaLjla
	GQ+4yXoKFwjgTrhmgL4KlZqsoh5p7V63p/58qP3TMKYzBkeQJvRwQI1BlItx67TqMv9dMWYRMVSuT
	uLvFXof9NpGd/2X1bxvRVRFMhXKDHRaB4bhZnn1/I7lwanff5BGu7QOSiAV6ymZkMDv3N1+PCt3Ui
	09/I+DDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55036)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4cOr-0004so-17;
	Wed, 08 May 2024 09:11:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4cOn-0001EY-HV; Wed, 08 May 2024 09:11:37 +0100
Date: Wed, 8 May 2024 09:11:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	bartosz.golaszewski@linaro.org, horms@kernel.org,
	ahalaney@redhat.com, rohan.g.thomas@intel.com,
	j.zink@pengutronix.de, leong.ching.swee@intel.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: move the lock to struct
 plat_stmmacenet_data
Message-ID: <ZjszuWWw8PPxNyKE@shell.armlinux.org.uk>
References: <20240508045257.2470698-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508045257.2470698-1-xiaolei.wang@windriver.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 08, 2024 at 12:52:57PM +0800, Xiaolei Wang wrote:
> Reinitialize the whole est structure would also reset the mutex lock
> which is embedded in the est structure, and then trigger the following
> warning. To address this, move the lock to struct plat_stmmacenet_data.
> We also need to require the mutex lock when doing this initialization.

What is plat->lock protecting exactly? "lock" is opaque and doesn't
hint at its purpose. Does it serialise accesses to plat->est? If so,
consider naming it plat->est_lock to make its purpose and what it's
doing clear.

Please also follow netdev best practice; allow at least 24 hours to
pass _and_ for discussion to finish before posting a new version of
a patch or patch series.

Also see the "How do I indicate which tree" question at:
https://www.kernel.org/doc/html/v5.3/networking/netdev-FAQ.html

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

