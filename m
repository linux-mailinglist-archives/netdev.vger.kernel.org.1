Return-Path: <netdev+bounces-221442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59EB5082D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7521C223C9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954DC22157F;
	Tue,  9 Sep 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jc92fKtY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6711187;
	Tue,  9 Sep 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453448; cv=none; b=Mbor55XbZkpUh61sOsw3P/yxOoi/WckVSTRVuapKX/9KMQNyyAGK0CQhj6rSL5wvY6//FtyPwkeBbVHtJ2lrUD1zasbf+f+Z5JRWlciSUkQnd6mUNQzev1/hN/LLuiaYExyzpidysHi1B9GdXxxwJvleoRg/Ee+ga/rqoCekWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453448; c=relaxed/simple;
	bh=X66zpNqcVp3Dpe4I1T4p1xNTIMIkKTDf1E9RFVINIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkcTIzIglG4ARcQeYBSyQfVbcGbi3kgxN5KPb6rfKc0M3pHBPspNmFpbUZUIui/RKJD4ra98k127Vgc1+GurBiK7SEJC4oF7X0Qpv1govAIW/M/QxVbC5SIQdXjAUfmbUUAd95asOfYC+IPVWZRlMz17I8OMZuj9oSInPLT80eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jc92fKtY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KPNTVYFP518WKuLEN3f5jPTUH03s3xlToCw/Y4Ctuvc=; b=jc92fKtYCUg1Pjgt822+/Z2xa+
	lMPnnnjUDsB2cPdUFlcnPhIPqCNfhwWl0ChZkPN0JMP1oKbm4nIWuwv9cpSWURORgnfzuTbNXL9mE
	TDObJl7Tq2PWTv/yHvp5YIjpNTw4T/uUpBs/6EFU2HeWUak1Q5/0Bmle5zrbVK+62n2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw5vD-007rXT-4h; Tue, 09 Sep 2025 23:30:39 +0200
Date: Tue, 9 Sep 2025 23:30:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: phy: broadcom: Convert to
 phy_id_compare_model()
Message-ID: <d608ea3d-02e7-4887-9cba-343e4999cc5a@lunn.ch>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
 <20250909202818.26479-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909202818.26479-2-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 10:28:11PM +0200, Christian Marangi wrote:
> Convert driver to phy_id_compare_model() helper instead of the custom
> BRCM_PHY_MODEL macro.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

