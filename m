Return-Path: <netdev+bounces-121191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363095C182
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41F72852FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE83D17C217;
	Thu, 22 Aug 2024 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5/9mpLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD137C35;
	Thu, 22 Aug 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369492; cv=none; b=KWtEcp2hwc6Fanjb5SHVcB7MkzVI4f7qB6wCejSvSCMmtRA7BB5ygTb038m1eY0usLUt0kEhm4OC7lCP4gcRGzKgnPSSADKF6omPEYvol1e3l3GsT9SeRMBxLRqbgYa+4Rfr6z1tYrgSdNWo+RBBM/MCep8v+taBoXI/K7Pc/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369492; c=relaxed/simple;
	bh=FO9U2Ov2ImeMA85PsKnevWiU5M1lkdOpK5NZi0mxcT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJlhs1j/orMqsb3uxbLqoFaYyL5Isa5JSKZltdjH4UCS3/clAdzr7NvZba7eRpXNI4+oi5swUEVGB6X1XCmez9DBhnHx25eZNIIJh6B3D43GMPoL9gKXjSUmPUKogR70+RV5PNxZ6Babhp5yldkwUybNz+ei/oKljEkuwCnwQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5/9mpLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF6CC32782;
	Thu, 22 Aug 2024 23:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724369491;
	bh=FO9U2Ov2ImeMA85PsKnevWiU5M1lkdOpK5NZi0mxcT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5/9mpLnikwS6/r81+7ruKfnvkNNHZ/NrOpnIoEAqYdYsXaunzVyLH5ldO9/WmNjA
	 cgP7tyrnxVpWkEOgzbc3GXwIs+pCPpS1zRhPHaQ4ETADQ9W8yrTWO606PY6/QWFD4Q
	 /OsiFP7fwPCnjDQx06zWGs3v/yiwv6aHtuzZGNfCfO+OuIzDFEE2dTgwKArHYepnYv
	 zhOmGBF7pbc88jh8GQSXQP1rygQ9ZM4wHCdYGpbCerIrsqTES5/jrZrUMJJrdLyV4h
	 9VZ/QbNaQZZnGnNq4cpTSOwNgZ9lQMBwBifZ9SQdHfRhRuQ4p5nXKbD7CPwOiJ//yO
	 MAbW3fhp5ZGMA==
Date: Thu, 22 Aug 2024 16:31:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
Message-ID: <20240822163129.0982128f@kernel.org>
In-Reply-To: <d080d3a6-3fdd-4edc-ae66-a576243ab3f0@intel.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
	<20240821150700.1760518-3-aleksander.lobakin@intel.com>
	<CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
	<fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
	<CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
	<d080d3a6-3fdd-4edc-ae66-a576243ab3f0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 18:19:24 +0200 Alexander Lobakin wrote:
> > I was simply suggesting to correct the changelog, and make clear we
> > need a recent enough ethtool.  
> 
> Yeah I got it, thanks. Will reword.
> 
> > We can not simply say that ethtool always supported the modern way
> > (ETH_SS_FEATURES)  
> 
> I didn't work with Linux at all back in 2011, so I didn't even know
> there were older ways of handling this :D Always something to learn, nice.

Are we removing the bit definitions just for code cleanliness?
On one hand it may be good to make any potential breakage obvious,
on the other we could avoid regressions if we stick to reserving 
the bits, and reusing them, but the bits we don't delete could remain
at their current position?

