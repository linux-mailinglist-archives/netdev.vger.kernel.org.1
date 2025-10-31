Return-Path: <netdev+bounces-234541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E3C22D2D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A936F4E4249
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4B20298D;
	Fri, 31 Oct 2025 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRD/jFol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390991A9FA0;
	Fri, 31 Oct 2025 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871909; cv=none; b=ClqYxmdZWo35DtCRegBmxg4KykoZ/s9oRVn8ntLfulJNiCmtnerOkrwd3lTPUoMsCF5Vh/DyaIeCTtya8t0WQsoD3anjRcrn7qhejkWegL+KfBSiaabJ6YwK9Nxzbu+JqnYNWhUc9EIdr78LTfXT1gsU5wOYHK8WYkxPZABqzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871909; c=relaxed/simple;
	bh=GNQuegq+QUvKww/wuIivXNqWHS8jFR42mFLp4jaB590=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4/3Op52oRfg0aBcr1DtwZHDtDjQyDWpkqbXxJtuJjMMOGMG19LYtlMEAruAgM5vVfnwaqDQxmIbrEO5jYFLsoiJPQRW9yXWUhFTbzjTGjWP3vhi7VEu7PeIG0X3OT+kETlb1uHvw9Yz7udjfu0aT3swW7G/AGNLMPee+UnAHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRD/jFol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B7C4CEF1;
	Fri, 31 Oct 2025 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761871908;
	bh=GNQuegq+QUvKww/wuIivXNqWHS8jFR42mFLp4jaB590=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jRD/jFolxE4tMQ8jFOYuUDToxoSGHypqxhGbIBhXoYf2DLZ0LBBMWjvdxPgs+L+34
	 pwh8/6wQQma2Hfq2ZN1rdOvGxeAG0Nsd9UVJxgmPnVcQdmUlfvuOlPixw5okgMFRWk
	 945IAbO09QjbGhnYQ84cQRN6NHzP8gNlfPNA+0o14jI31xZ7ESshZWHqHKWtSy2Hxd
	 awEQhRaI4mrzttAjnWpoeIixOWlERyuW3Cf7b3XSnB8E3lvtDqOhOHHey32vrDfyDs
	 0LUJl9/q74fv00wiPARFixd4TTAEqy9PZzmd/izfWUET1PxiHklbHYfsATeXZ9xjMk
	 8GPvH2tonh8Iw==
Date: Thu, 30 Oct 2025 17:51:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM
 documentation
Message-ID: <20251030175147.57c6c0d0@kernel.org>
In-Reply-To: <aQP-6eQdFIN1wjNe@archie.me>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
	<20251029082615.39518-7-bagasdotme@gmail.com>
	<aQMd886miv39BEPC@secunet.com>
	<20251030084158.61455ddc@kernel.org>
	<20251030084412.5f4dc096@kernel.org>
	<aQP-6eQdFIN1wjNe@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 07:12:25 +0700 Bagas Sanjaya wrote:
> On Thu, Oct 30, 2025 at 08:44:12AM -0700, Jakub Kicinski wrote:
> > I take back the "Awaiting Upstream" part. This set conflicts with 
> > the big ToC tree reorg patch. Let's either merge this into net-next 
> > or wait for trees to re-sync?  
> 
> You mean this one [1]? If so, I'm happy for this series to go first then
> I can respin the toctree patch.

Works for me.

