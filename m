Return-Path: <netdev+bounces-101220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF38FDC78
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47F11C2176C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5771401B;
	Thu,  6 Jun 2024 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z1kygmFU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F41373;
	Thu,  6 Jun 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639464; cv=none; b=U5oo9iCkQu9SR2iH6wi2/8pVE2E/4/rVUfoIgJNv6xXERGRYC9o6qH8wBWGDG2PKTfLWqdww19PooiyLSHS+GnE2AaP9C7IvjRlFayzTOT0GqdCTmRFDcZS2Lc1jj1pS1o0c+YI1xOtOO0yeUCzqEr4kGPWPTVjmvguK3PcgKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639464; c=relaxed/simple;
	bh=KchfyRw5yhyXWwSmy9ySHIAwLenL1pYcPWIufZuPhMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLsbXFqae09GXl5Le+hx+ChEed2GDkudCXdV4Wlk86FOCQzAawJeVsKACKe1kAOKczwO8ysMjrz37+vNLkUs1tzHnzswv+hs6iYGEZLHQxHZqnI3YUkOwf2afHW4qStU1Js7nK2/ua5SJPkT86d+aef2dOJ0D/dPuVHrtJXuL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z1kygmFU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jSY0bvOqtELArheckRfbvM1kpjDwefKlvF+Tb6ce0FM=; b=Z1
	kygmFUugkDAgM/z2UdBLJ/wViHTWhRMHHs8zGh8DQMzMlzakXTribvSF1kb4jvv5XfSiGFDVEcd2s
	wqkgdlOLWuwOgs2JH1QC7E/MQdavLaZZlKsE5nSFhp1dLrthIdk01T8UhMfDlvBW+sfrzy7XbsL9F
	TyR+kTH1pMWZzDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2UD-00Gy0R-HX; Thu, 06 Jun 2024 04:04:17 +0200
Date: Thu, 6 Jun 2024 04:04:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <3bd5c993-d763-4191-8a88-fcd56d9bfb4c@lunn.ch>
References: <20240605095646.3924454-1-kamilh@axis.com>
 <20240605095646.3924454-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605095646.3924454-2-kamilh@axis.com>

On Wed, Jun 05, 2024 at 11:56:44AM +0200, Kamil Horák - 2N wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

