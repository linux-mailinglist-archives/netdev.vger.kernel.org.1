Return-Path: <netdev+bounces-166808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D859A375F9
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B228188D5AB
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40032450FE;
	Sun, 16 Feb 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mId+bfbv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B327735;
	Sun, 16 Feb 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724476; cv=none; b=MtWjjLxRoDAVuR5S9TeuhXEynPz4P8QFhPk38+RzYvHm4fXR0PVgHnpBKHTqvsdqqk1pNSN66NergMH57DZeigw9hDl25qWLNPH3e/Hda1VuisBF0gHiIrouv40HLzFxBtJTANXh+lQlKVZDhlyh059U3TtwJpXk9MHBngweqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724476; c=relaxed/simple;
	bh=IArlZb5AAFNmcNA8acokFZt6Q5WrRCAl6rU6DHtR3qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc3+u21L/YRYR4Q+goEdU+6JOEaNOUrGV/wOojXiEuZqMDiMjamlVejaFbbEV//4ARAfWW5fQwZS9mgiMpiWIV/hjAQtShAgJAL9krmvI6NHi5ez07ew4AAjfoX5WhBnve5FI24S/hi1MbESgvCuunrkP28Jx9++DTKZpOCv4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mId+bfbv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LEkCAs/Rhm3S6/6tTKrC5dGrEE0/b2vF5aFA3/U0TKE=; b=mId+bfbv+NmHRgGafrz4SFmU6R
	9vxduBhLKI6G+vbPIGyZiya7x+5TdENPiQNHhesNFES2+sx0cvAwMV1iTHmBjXRgQyPh/WTVImjV4
	w26MDDWvmNdbQnfDk3du5xh6pJcdXp65XrIfXuhnHlGOQY3nQJNen7aKPfhy+rEuijmc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhny-00Ehjc-QC; Sun, 16 Feb 2025 17:47:42 +0100
Date: Sun, 16 Feb 2025 17:47:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 2/5] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Message-ID: <8070a622-c6b8-4cf7-9845-ffa8b0478fb4@lunn.ch>
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
 <20250213080553.921434-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213080553.921434-3-SkyLake.Huang@mediatek.com>

On Thu, Feb 13, 2025 at 04:05:50PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> This patch adds TR(token ring) manipulations and adds correct
> macro names for those magic numbers. TR is a way to access
> proprietary registers on page 52b5. Use these helper functions
> so we can see which fields we're going to modify/set/clear.
> 
> TR functions with __* prefix mean that the operations inside
> aren't wrapped by page select/restore functions.
> 
> This patch doesn't really change registers' settings but just
> enhances readability and maintainability.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

This is better, a bit smaller, but still pretty big. If you have made
a typo, and broken it, it is going to take a while to find it, no help
from git bisect.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

