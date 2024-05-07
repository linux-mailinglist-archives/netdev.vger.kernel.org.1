Return-Path: <netdev+bounces-94209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA418BE9D2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC921C20ECB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD99200D3;
	Tue,  7 May 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKB+rSWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D16747F
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100900; cv=none; b=H4J1QrbfJePj+HShayUeufD2cTuZWmh4iTBqXnm17JI0ntbbu4/hBK8ygtr3Xs4olyL/VxccKzQzcydKC+AS8XMSSgcWgEnD/+oapceZNBFsFWgCCnmXLSUqNCYq1fp/C5wi6gj77pJi9m0KYk859/VIbG83mGZvh+kkdJV5wPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100900; c=relaxed/simple;
	bh=WYsK1PPnmWKmbI+8ac1JekRZ+CNaOmZOvOIEVEUw+wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY2ESJn8MmwN636Vj4Un6hGZ3Wjj16f7QBCTPGpF5mgaY0FpRZ91fUqyD+pWZZ/d75+VvT/FH5cDOhzs2HElpeJkKgFSkJHsadrgsJlrqYykCtNom5P8boFIM8irnOdtilT64GxTPQ5EIdMnPmrE3lml9PciazowjpTNsp0mue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKB+rSWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2A8C2BBFC;
	Tue,  7 May 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100900;
	bh=WYsK1PPnmWKmbI+8ac1JekRZ+CNaOmZOvOIEVEUw+wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKB+rSWPGqRIPGKMAcWDs3WlU7Lt102r3LCjdIf0VBIZxQQyxXJHEpZ/vN4mRCYGi
	 20jGy2KQayHdBrlGBuHcRFnITQh2P4svI0vknHktvQuOlJ/HRVJtvP2IMsyo0tuK3k
	 fK79lOdTe2qjlTq8QwQZr4UNEnjWOvHMOT/nJvJtgw7g343jrsOhqm66ZNKVZsRCzF
	 xwVaaJKxdEi7ojshK0kX0k3XWgzljKoARo0HZqobmfNLZlBy5/ekK96QvZlgqavMeF
	 KLp33xAXrViRX3OWmo6G9DgsYOgT6FKwCoT4GL4PBo+nOlUPSRXziWAvtBFW2GrNoq
	 6c7583i3XKZCQ==
Date: Tue, 7 May 2024 17:54:56 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/5] pull request (net-next): ipsec-next 2024-05-03
Message-ID: <20240507165456.GH15955@kernel.org>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
 <20240504143657.GA2279@kernel.org>
 <Zjntq3jSFL2Uud9i@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjntq3jSFL2Uud9i@gauss3.secunet.de>

On Tue, May 07, 2024 at 11:00:27AM +0200, Steffen Klassert wrote:
> On Sat, May 04, 2024 at 03:36:57PM +0100, Simon Horman wrote:
> > 
> > Hi Steffen, all,
> > 
> > This comment is not strictly related to this pull request
> > and certainly not intended to impede progress of it towards upstream.
> > 
> > However, while looking over it I noticed that Sparse flags a rather
> > large number of warnings in xfrm code, mostly relating to __rcu annotations.
> > I'm wondering if, at some point, these could be addressed somehow.
> 
> Yes, maybe just start to not introduce new ones and then fix
> existing ones over time. I'll have a look on how I can integrate
> Sparse checks in my workflow.

Thanks Steffen,

That would be much appreciated.

