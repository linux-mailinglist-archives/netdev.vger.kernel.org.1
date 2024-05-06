Return-Path: <netdev+bounces-93831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE58BD540
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7BE2831CD
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48715821F;
	Mon,  6 May 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4mtImxl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960741C73;
	Mon,  6 May 2024 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022851; cv=none; b=u+qO7Ahco3NWcF58dLOZzycNykPMMhTg1D9PKLcRQJiUJIcnlS7UtQReM2udyj5V3HNDsPAOWDjO5zSpfwZRCdU+UwegtOyDCLKbJuKVDXTDcXInB6Zo2haTvOaF9E9xHDPrA6YLwwJsil6E5vFd9BM/NISkYj2OGGLKSJTplB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022851; c=relaxed/simple;
	bh=0Soa7mK2FI4eg37nhVqhYOgXnmVB2GfFZz1xbfp9hBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul+qcGpIlLCQGbVNvaOF33+4IXFO5/vVUUtmgXgtsn2dcrXgmMFnhXZR0epEOvz1vwA8BVcQqkx7bCAnDb7dtK4BwI5VlTzhQPQfCAOGGulV/gfGb86riHC9RO5HB6hf5ME6EBIDxkVeRliSFKllcjePYVoVjwFIAAFzD1xkKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R4mtImxl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NQkm4zrvTG8w92cPIcnyxF5xsMLdgcY8QlK+K/AlrL0=; b=R4
	mtImxlVp8dPABDHZLz4OZDKW0hN9tJXZ892K4PYfQLTxEiQLGVDcKsnMnIGLepc7E4VcExPe1ATFV
	fTASwwOG+S1yyIIr6siKlRbfURSVbeib+b8E7+UfEq+3v+n7deJtenszOktrj7XuAi/H2Eh1YsoLv
	Gsjcm717JuaXchs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s43mj-00En79-8J; Mon, 06 May 2024 21:14:01 +0200
Date: Mon, 6 May 2024 21:14:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506144015.2409715-2-kamilh@axis.com>

On Mon, May 06, 2024 at 04:40:13PM +0200, Kamil Horák - 2N wrote:
> Introduce new link modes necessary for the BroadR-Reach mode on
> bcm5481x PHY by Broadcom and new PHY tunable to choose between
> normal (IEEE) ethernet and BroadR-Reach modes of the PHY.

I would of split this into two patches. The reason being, we need the
new link mode. But do we need the tunable? Why don't i just use the
link mode to select it?

ethtool -s eth42 advertise 1BR10

Once you have split this up, you can explain the link mode patch in a
bit more detail. That because the name does not fit 802.3, the normal
macros cannot be used, so everything needs to be hand crafted.

    Andrew

---
pw-bot: cr

