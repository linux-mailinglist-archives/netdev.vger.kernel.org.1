Return-Path: <netdev+bounces-166461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DADACA360CE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148657A4369
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E1265CA9;
	Fri, 14 Feb 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n54Ceqty"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42F264FB0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544797; cv=none; b=ISX0Cg+hClRe6F4YhzAIyoN9mpDhty0/tJvUYHAGJ8CRBLoELv4ujWBZUpjMDYa43zwDH2aWHmL7EzK2dqkSgKZNqSNfN3MAZd7uXJN0VMentyQ0ZHn7lN3NirCP8Ib+UAhT9B0UAO63Umf2H8Qgai+jtEby+E6CZj3gOewroqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544797; c=relaxed/simple;
	bh=F67PO+g+HUrH66nUPNiF/ES3lpagQYoYzSI+01zUKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtqZ/hyjge0pXymFQyMk/znw+5El+QltaWbH2JAN+DMi3+b0r5D5Ly0eMmQEjiBUF2PJY4wALfB21gUsrt/TrETtwteqJ4aRp5gV2sXum25M3jvSxzgzpg4a1VPYMfkiMxkAbXtGyVrsNe+lZhGjQp1CfzAhsd9mHW0zDJq8UOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n54Ceqty; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h5MkF7NTx69CRKfN/ZZjsBrCJnr1CvYWWgTJOmZXMic=; b=n54CeqtyULI+k2b1IaP+nJSz5N
	IWp+I2UBZywL5mY2P0hfRmNwiWszOaV4TrySJ2W79LmsFcFL2FKMZ+87zuzdaxn44UngQyKsYskPj
	M8C176oI7FoKm9njAEIAoF4vLKxsbsWoEIzF0OToG01IthhMLfs9i28Q0o2GXnQoFT+7u/snwSvtj
	qJvBgLrdTkyyIanMiM1aplCgnj8HUi9uwbDxwPdbeH0aiPV9i0X6inmF+/tMuqmF2ulEQw7HB//1X
	8dQVOflDRtcrrDo+VCJoavNGHVbTCb2ZdpbTDEwWrWUoC9Ar/etHhQ5VpNbDH1ReaHGXgMjpfzwvl
	o2qWAlmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tix43-0005Tt-1m;
	Fri, 14 Feb 2025 14:53:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tix42-0003Fp-1F;
	Fri, 14 Feb 2025 14:53:10 +0000
Date: Fri, 14 Feb 2025 14:53:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] net: phy: stop exporting
 phy_queue_state_machine
Message-ID: <Z69Y1qHqKW04LHCl@shell.armlinux.org.uk>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <16986d3d-7baf-4b02-a641-e2916d491264@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16986d3d-7baf-4b02-a641-e2916d491264@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 10:50:02PM +0100, Heiner Kallweit wrote:
> phy_queue_state_machine() isn't used outside phy.c,
> so stop exporting it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

My grep confirms.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

