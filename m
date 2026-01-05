Return-Path: <netdev+bounces-247092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299FCF4830
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EFA33118DF9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939032C316;
	Mon,  5 Jan 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dgMuS7D1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CB32B996;
	Mon,  5 Jan 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627274; cv=none; b=pwfymC90XdTvgB08bERoL0U285jYeBSeYBSID2iJHGwYdl4ma6ORWvD11/5ACEdK3oX/wdnfUmnk9IP1V6rFdelKqhsyHOQJ+Je2trI2q4j1somlxDRMYytpYJPa6jBNl5CFUg7j6LsN7l3vrCaMsE4dWeZZpnIlBewO+A8CweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627274; c=relaxed/simple;
	bh=pFm1oPv5Ep5Yh2FQNd9XHx7ZenUP/jJeBeGNBYKkzis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIaFeiB6H1g5+0xzIt/tP2CTaBf7y2aUZh7oW36G425Ce3XVoTpYVdWeuYZNedUesKeq9Ki8cR5abNlMn21Do+RhOmW+A+ysdfaVtVCTDp5byW3bzQui+rKoUwpPdwm/k2Je6XBGVz7pm4t3MiRGhzO2ZMGbhgrmn7rxuoyMxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dgMuS7D1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ltr0cu+4l4BDSYgyoyIgm92xPRorcWY2W147fXeYKIQ=; b=dgMuS7D1iXIwGlZxFal8AECT9Q
	kg/b+9N7eVxDwqvh+L5RrgTNB4jOtKwXoPsHq1R54nlP8/35IgjHbo+rkoPesOSEEOfEoebTjxLYU
	5Cd+zZmo1S7/6B8ycKB4dHSAkJFVCsBZVTkfuWwTnj5ju8t7v0OMd4izt69cszhfebtg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcmbB-001VBF-Er; Mon, 05 Jan 2026 16:34:25 +0100
Date: Mon, 5 Jan 2026 16:34:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dlink: replace printk() with
 netdev_{info,dbg}() in rio_probe1()
Message-ID: <e56fcc20-bfd9-4b4d-815e-d6c3f9b20b5b@lunn.ch>
References: <20260105130552.8721-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105130552.8721-2-yyyynoom@gmail.com>

On Mon, Jan 05, 2026 at 10:05:53PM +0900, Yeounsu Moon wrote:
> Replace rio_probe1() printk(KERN_INFO) messages with netdev_{info,dbg}().
> 
> Keep one netdev_info() line for device identification; move the rest to
> netdev_dbg() to avoid spamming the kernel log.
> 
> Log rx_timeout on a separate line since netdev_*() prefixes each
> message and the multi-line formatting looks broken otherwise.
> 
> No functional change intended.
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

