Return-Path: <netdev+bounces-92831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00A8B906F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6A1F242E7
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C861635A0;
	Wed,  1 May 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2R7z7hy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BA42A96
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594311; cv=none; b=QmEva3rmZ2ySnHjpjNM2fnurX09R/cRAZSj+mJwGN14Lm0WIhKlgtCOjYu16sXC3PZCmfAn6H7WeSK/OUsCnMOzyXf/7zvGED5lu36En25W2q/BjRzeM8P+rkd10Z8fhyQeFLg6qWhlDLPWBZcV/kwPQQ2dedjZxV0i0DmuFNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594311; c=relaxed/simple;
	bh=9HkO6K4zhAeA8R/6hggoaoYhV6LzosXTJ9Z7joq7KZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+3kR5axot5CwdoTLcHUXVeRbWhzUp3x/Jlpeo7sJ93jRaibTnogN31XBJSvjgR4oU3zCMBArA5K4Ym3AwCiMfQXKMOPu+TL7YENNM+k5ro5yNa4MkDE61pnNE31y42rGokEF+XzwvJVfiQyhEM0gJw+pK+aa3CnfalZAxS2kDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2R7z7hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53340C072AA;
	Wed,  1 May 2024 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594310;
	bh=9HkO6K4zhAeA8R/6hggoaoYhV6LzosXTJ9Z7joq7KZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2R7z7hyWfvkrkQmCxeAQfBiMbcHeAClBlfyDHFvFpiWLr8lBaEa+4+pBYrozaezF
	 +n2gtWbamm9abzjqVC/DsOoUuq+nqDQUks+L15JdX+1iEodJcAPpYySOTDAl3rJwp3
	 62Jnoa/kTktjvdbttifIeZr+AQch7JKxuxAKgx/iG7XWrgmPgnR0m3Kkz+K6XQ+Xjf
	 4I9g1sVWYjohTXcIwJvCDfTrWRf/tmZRZQx2s4vcoGVTv1YQf2cE/LmYt9mbW1OVKY
	 0+rN6PlgfAXInrFTPAw4U9xthD7A94gLR187Lm94UbyoRDqjv2cVFHUQvtRZjy0cUU
	 HSidYOyxkJjSQ==
Date: Wed, 1 May 2024 21:11:46 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-pf: Treat truncation of IRQ name as
 an error
Message-ID: <20240501201146.GM516117@kernel.org>
References: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
 <e2578f7a-7020-4ae4-94d7-69e828a523d5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2578f7a-7020-4ae4-94d7-69e828a523d5@lunn.ch>

On Wed, May 01, 2024 at 09:46:15PM +0200, Andrew Lunn wrote:
> On Wed, May 01, 2024 at 07:27:09PM +0100, Simon Horman wrote:
> > According to GCC, the constriction of irq_name in otx2_open()
> > may, theoretically, be truncated.
> > 
> > This patch takes the approach of treating such a situation as an error
> > which it detects by making use of the return value of snprintf, which is
> > the total number of bytes, including the trailing '\0', that would have
> > been written.
> > +		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
> > +				    pf->netdev->name, qidx);
> > +		if (name_len >= NAME_SIZE) {
> 
> You say name_len includes the trailing \0. So you should be able to
> get NAME_SIZE bytes into an NAME_SIZE length array? So i think this
> can be >, not >= ?

Sorry, I misspoke.
name_len excludes the trailing \0.

-- 
pw-bot: changes-requested

