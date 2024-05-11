Return-Path: <netdev+bounces-95740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40768C3387
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EEC281BDF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584331CF96;
	Sat, 11 May 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dF1iqCJ1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B01CFB5;
	Sat, 11 May 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456109; cv=none; b=QhgffjpeaZxlDsJ4VxbNPl8OLXqNS5v/CwJzn/2sPvPr0Yt07ozdyu7iYoTHss7ce7ZP5rTXj+Dm+o44YPhHLxdsHN+vfg/2QBCUArVbIop0w+LM+eWg9nO1ckECNytoC/xlGZzfgVPKaX5tqLacWrmGSTrNmswDlcAFGQURt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456109; c=relaxed/simple;
	bh=gWR3NUqVImhVA1c7WERiqx3MtzbVWXnl5qB8lrW7Nt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfAYWdkvYGLMxKm1BlipgoCnIzgccmyIPze4wZEknk0xnQjNTN44qkX0IFeuNCv9GLcUWQ9yI4ThzEv3zLFXbbdoArVnMl8NtNQyvTjQlExPLBchC2lVww5lWVy0yERpzE7mv4ZOTa6tFi8d1Ui8MYs8gMICGNa0OwSOadoOidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dF1iqCJ1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lsQ8EpucrahipxmgY9adADlLATQwl/fTTCozc+pV+Mc=; b=dF1iqCJ1xq3Hf/aoU+Cx4L1fDX
	ht2/fkiW9ktP0BLH54c3SotDfOGyC7Hf2Cm91OaW8EMW5wkkio3pCcj1FMhaUXTLGwtZBHszRF58J
	1921BIsQi5KXuzDb7d2wcQZ2Yh2WLAA66JGBOTzxEWDGM9fvrCGbZCRAKV3WX7vyCZdg1sdPODPkT
	89U2aSmOpILc0TNg7fZJ4/4iyG232WVwybvim4WqDzk32neRoUop0TSTVqSmVb1VyNG0BFIv8cuY1
	BMeV/TDEc/YYQOCRuViGlnoXKRaUt/l9pYAN7gISbtKAUs+WY6NFeFJVKhDJHdrLbuvXkuAVMuoC2
	A9KhGZUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39530)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s5sUn-0000BS-2T;
	Sat, 11 May 2024 20:35:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s5sUo-0004VS-E4; Sat, 11 May 2024 20:35:02 +0100
Date: Sat, 11 May 2024 20:35:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <Zj/IZkGRXhFCyMBM@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
 <63c3efa6-94a2-40c7-b47d-876ff330d261@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c3efa6-94a2-40c7-b47d-876ff330d261@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 11, 2024 at 07:19:07PM +0200, Andrew Lunn wrote:
> It might be because it is a PCI device, and they are trying to avoid
> DT? Maybe because they have not figured out how to add DT properties
> to a PCI device. It is possible.

swnodes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

