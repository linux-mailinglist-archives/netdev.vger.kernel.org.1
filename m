Return-Path: <netdev+bounces-121664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5695DF3E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697851C20DE3
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFF42A97;
	Sat, 24 Aug 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTzxkUqM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989B4F8A0;
	Sat, 24 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521427; cv=none; b=h2RxwIU+NYerraQzBx3OeA17rCmWhRwh+tPL3Mc3ioMeszGSDxjfjItdDOrA9PajgbOt+DmB90I5hPxhvGQMVWlTR4eCuUbM/nJ7X/nVaPDvFVGmAzFlsn4tq+CYmFskEF7l+QLDKhmO76u/rrsU+LQTlzRyOYMsTFsfF4N31E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521427; c=relaxed/simple;
	bh=3jN+tm6TRIeXJQ6l99NSaIsAt6ky6FvajSCWbwlyKyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ32CqOeyETYrxdmPJUZ/7+fp1zfaTBXpY+nHhWQZR5Bxrhre7/mfI95SIUsMug8VKIrXW1zUpNnY4r5xgo6HzWJI6/EI8vTtnm5bT9OLYizjv76joJ4H3Kh0BXRK+/F/Lsfi7vZNPfXmIEYNKfcy2dMjezcKE4SPT2vr4UtBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTzxkUqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35BC32781;
	Sat, 24 Aug 2024 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724521426;
	bh=3jN+tm6TRIeXJQ6l99NSaIsAt6ky6FvajSCWbwlyKyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BTzxkUqM34F1jFTGs+EPepSd2f5bf5OvXP/TxXSH8r7jJJ7fEfgNaIR0iy/7U0Oea
	 +HzbEfgHwgc7hdec+mlNDV1mDS6BptKK5/zHIZo1S1vcle8yKSYQgcbFHape9XNMY7
	 Zt//cpyZECrZhOSpCBkhXfaydfdPkff1qsx8vBXRmyu2XcQDEHt+kXk4M+Sbt5z9xI
	 Ro9DaHZTIh6pGy2NSrVGUXXcrzkcW3uuDoWt+QmVbZpDfgNLJFoiXfFxzCVy/0V4zp
	 QuoT4D53qNfsIg3c1FeVurLpkijuSJu44sDR9OTM6ynVTwstnOaqoA9Eb2/UQVZa/+
	 NVpSL+StvVGrw==
Date: Sat, 24 Aug 2024 10:43:45 -0700
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
Message-ID: <20240824104345.196d6564@kernel.org>
In-Reply-To: <6c72dbc6-98a1-4682-97ca-e2f76c81a178@intel.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
	<20240821150700.1760518-3-aleksander.lobakin@intel.com>
	<CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
	<fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
	<CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
	<d080d3a6-3fdd-4edc-ae66-a576243ab3f0@intel.com>
	<20240822163129.0982128f@kernel.org>
	<6c72dbc6-98a1-4682-97ca-e2f76c81a178@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 14:34:13 +0200 Alexander Lobakin wrote:
> > On one hand it may be good to make any potential breakage obvious,
> > on the other we could avoid regressions if we stick to reserving 
> > the bits, and reusing them, but the bits we don't delete could remain
> > at their current position?  
> 
> Hmm, sounds fine. IOW just rename all the bits I remove to
> __UNUSED_NETIF_F_xx?

Yup!

