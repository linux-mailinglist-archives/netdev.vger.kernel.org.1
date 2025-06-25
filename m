Return-Path: <netdev+bounces-201264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A0AE8B28
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950567BA9EF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D42D8DC6;
	Wed, 25 Jun 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5MkppXbL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382925BF19;
	Wed, 25 Jun 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870203; cv=none; b=Wl9ofqS0SBM6ZPMR5Czr/rPyYOnKqO3XHIsoFh0qVjgg8ytro2VKue+YTuEExke7uNHVqUOQNNe1t2o0dIOcTtx6HVoztJVydaEItE5MxQkV0XE/G6kouEdaIlKd3a8UppzQzXngMkK7DBZfvX+S++VdDlOpYt+m00H8F+8ylTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870203; c=relaxed/simple;
	bh=kE575MdsHILeZCusTVXtris7HP53OSNFtLoZMjQxwWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4c7tbkGKl8AF4rjvKceMNxPMD1L8S2QeZ7RbGMsvDeoD4dkQ+ra0q4z13gbCkKOKCJB6j/QPh3+NCAbQrLpuhqDDP7hrd+/INgqLhsyt4bXPWTC+GNXlFE5GWS794Yug5MA+XZGaODdchuDOHh5reT1sOjAMZ2Zjnu6unGlH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5MkppXbL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/h6yGJCBzvBOH5rPjp/IaIhZmt2kQn8PlKvkRccmkrU=; b=5M
	kppXbLK8dEeuo+6ZPASDzhHJth6VG5zJ8iVMb3Z1rEcFjXHTG3Yn/S2TboIatvm7lmZlYdE2ovAu8
	7bx2gtp8BAgqSbak1pFSSrTYtWf/zif2hfGPV7s6fqDyhg2qPkqFXjnt5JHGu3d9hLjtgS7NtKGYq
	T+bC5KDePN5Lu9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUTJs-00GxCF-5I; Wed, 25 Jun 2025 18:49:56 +0200
Date: Wed, 25 Jun 2025 18:49:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, robh@kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: bcm54811: Fix the PHY
 initialization
Message-ID: <36cf2f9e-4ed5-4040-ab30-c508b4a3f21e@lunn.ch>
References: <20250625163453.2567869-1-kamilh@axis.com>
 <20250625163453.2567869-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625163453.2567869-4-kamilh@axis.com>

On Wed, Jun 25, 2025 at 06:34:53PM +0200, Kamil Horák - 2N wrote:
> From: Kamil Horák (2N) <kamilh@axis.com>
> 
> Reset the bit 12 in PHY's LRE Control register upon initialization.
> According to the datasheet, this bit must be written to zero after
> every device reset.

This actually sounds like a fix. Why are not you adding a Fixes: tag
and posting it for net, not net-next?

	Andrew

