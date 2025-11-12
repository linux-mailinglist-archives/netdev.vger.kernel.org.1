Return-Path: <netdev+bounces-238128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B82C54769
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10A24E2595
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566D2D8799;
	Wed, 12 Nov 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="27gLFXFC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A952D5946;
	Wed, 12 Nov 2025 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979112; cv=none; b=gxnUPH4A6IPb8s1zsuiN+28U/SaQonX9RhyN4c3g1sao5bKgSrn390T5klgkzXJcpKD7JYm7g9QNegUETVhFlZCFSKcmv4wlQemEruJ06Q/Ifs7bYtsZHoFVDy15GJHtcliAL89AnZlyZ9QvSxOcDkicGmQpP2FVzny+zRBLybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979112; c=relaxed/simple;
	bh=6KfXkUqVjY+RCtK09kzENlQ2r8qM4kOq6ZPOrS3cBkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEguuCqcKwqDoLMyb2iK7xQspXJVpizjSuhum5aJpkcL06P13/Saw8OfPm8g/oyWh9LO73QcaF73XfPf7jIi/O5MSf7hejkS7ssl5ARF2zOPRmgJKCmhDdHQm63WWhR2XCNmO90Jv5aqCdtlE53X9RQWkEGKAC9FWVrLhqXFc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=27gLFXFC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eG1+Z2nINsuHIGlm0g60wcqdI+VY4P5X3ca5A1mTeYE=; b=27gLFXFCSebaEeA2qySyyWyJ/7
	u8s4mJAHk9vINJ/l1f2otICgKOsRu0OwD0UmZf76VRGer0K4ILgSnaIn1QpDgIJJEpaMNUt41U1r+
	8hY+oUPXsVXI91FD5e7AC0PGLy3XkCCm3bUfFhQ9C/vlOcUCZc8r+bmq7Ow/8vvgVptU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJHOn-00DmlJ-O7; Wed, 12 Nov 2025 21:25:01 +0100
Date: Wed, 12 Nov 2025 21:25:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Message-ID: <116fd5af-048d-48e1-b2b8-3a42a061e02f@lunn.ch>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-5-wei.fang@nxp.com>

On Tue, Nov 11, 2025 at 06:00:56PM +0800, Wei Fang wrote:
> The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: change
> FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
> requires RX buffer must be 64 bytes alignment.
> 
> Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
> buffers"), the address of the RX buffer is always the page address plus
> 128 bytes, so RX buffer is always 64-byte aligned.

It is not obvious to me where this 128 bytes is added.

	Andrew

