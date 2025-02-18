Return-Path: <netdev+bounces-167390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AACA3A1E8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0210F7A3C24
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B726E15A;
	Tue, 18 Feb 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gJrndblE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EB26E154;
	Tue, 18 Feb 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894342; cv=none; b=euY3T6khHnC/47fJ+47EPc6T2hSkNr4Rgw1cjTUOmOQmGILyyMN6U6+muMxY8Mv04xMLH4V4zT6NplTvBbB0d5DPZkC7h60+xiAuVfez/neSbMsX1L/GnOJ4JRP+u9LeDZYnskyCU/8JuU3Xit9vW/AISTUXCCQMK5I6CDxGECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894342; c=relaxed/simple;
	bh=X7eg8zG1Rn8nfSgEg6ZOt3R0kKHo7kmQnosblr7yDLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px/BLl8pzal0+xBiasN1HI5i/G3lXJaOg3mLOnRQh4Sam2gqaPAyDADn+wq2AM02phF8sp4iIiOMkA2fnamVVqHPk5A91+Dfa5CS0CVMLPFTSk+4rYYRWt9eIbFj8+7up1PeHVmizFeAxBiAbNpZz7RYIf7FTVPy0fU43jGBr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gJrndblE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1KWanZzzwv0cv77zyEw+IoCClnn8b8jSMI+md0OdX9E=; b=gJrndblEfhslWBricckPayJDbO
	NDc9+D0P9QRD0vdQ0riX5CnY3jZaAH/H7X3X1HT8A0NAtFE7jbAT465gYLcpNjog8UGD1mZmiLtyL
	bEgMBblmnYxHV2NN3An0Grw0COCe/XpR1sNG1PZ5W7TU6L+AlICDCa4flaKbcmQPyLqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkPzs-00FLGv-FY; Tue, 18 Feb 2025 16:58:56 +0100
Date: Tue, 18 Feb 2025 16:58:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Message-ID: <c43c6dec-8b5e-46e5-ad19-e1fdb57cb3a7@lunn.ch>
References: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>

On Tue, Feb 18, 2025 at 09:23:14AM +0000, Russell King (Oracle) wrote:
> Using L: with more than a bare email address causes getmaintainer.pl
> to be unable to parse the entry. Fix this by doing as other entries
> that use this email address and convert it to an R: entry.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Fixes: 6bc6234cbd5e ("MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer")

Probably should go to net, not net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

