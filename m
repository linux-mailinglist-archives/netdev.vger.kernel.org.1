Return-Path: <netdev+bounces-218497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FCBB3CB7B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090E51B22DB7
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4921859A;
	Sat, 30 Aug 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RCGi5lHX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC21A3167;
	Sat, 30 Aug 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565150; cv=none; b=LUP0P0iHIEVIEqTAcPPGSI9BxI95ekw0s7nLn9UICKwd+i4NJMdMbujMUF9DD7l+cc/B5lO/ZvS/77JZmCv+mLSSDifWaMSVIV3yynOKpDrMZAH4A8QplwG3mnh39nY0jpjgFXFM1iPCDv6IIStwsQgsemyakUckFQBdDTth9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565150; c=relaxed/simple;
	bh=77N9eaiUbR2saKPLxZiZ+DnnhTTOPxfI8shg60z7wcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1BmFmocf3dciuwig1lOCdvbj/khJO3MOH60shO5FRBxPZNhO+RG8l80ZmFkHiKC0YHB0gv+nrXTJFnD3jCjtAPF+iI9eSgOqwyTrygWDEM+2B17dB8BNQqiBiW6oI/zpk0j9WoYoL4zxW3hmKTUa5eZeo7d6Sdojl6o+Iaf6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RCGi5lHX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f6xpMT0Jc9ifhcsoo3+k+bCiHGLgspG/a+V5Xz3cEDc=; b=RCGi5lHXfUtxZIQ6lj+yUZKVoU
	wDPpTNNEs14lbkbpuI8XBpOJd20CUQq+HgaqlZJo1Rw5Y5IKpYZ5I2dtUue/6PF6Hylpxg4/gneh3
	y7kaCmnNVKbzcjJIulEuOmlfTHyQxVpw0VntoMvUOX+FKZODLAlZEPL8q6BN8E4FWCyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usMpb-006aJV-KL; Sat, 30 Aug 2025 16:45:27 +0200
Date: Sat, 30 Aug 2025 16:45:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conley Lee <conleylee@foxmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, wens@csie.org, mripard@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ethernet: sun4i-emac: enable dma rx in sun4i
Message-ID: <195b5dcc-a81e-4f62-854f-5446daaf312f@lunn.ch>
References: <tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com>

On Sat, Aug 30, 2025 at 03:50:00PM +0800, Conley Lee wrote:
> The current sun4i-emac driver supports receiving data packets using DMA,
> but this feature is not enabled in the device tree (dts) configuration.
> This patch enables the DMA receive option in the dts file.

Nitpick: It is actually a dtsi file...

	 Andrew

