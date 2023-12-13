Return-Path: <netdev+bounces-57044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E1811BE6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CDC1C20F1E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06159521;
	Wed, 13 Dec 2023 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOJySq3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6215787A;
	Wed, 13 Dec 2023 18:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E5EC433CC;
	Wed, 13 Dec 2023 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702490508;
	bh=Px4OFBsxv34ik1fxQ51zGjslqKe47/E/DOZoBMb9bbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOJySq3PXnRM3HEhEOr4BCYSmcHVwdE8bfmaqlqM+6PZD20MhUN2Z3eO3Nn2Ti0PA
	 qV3pG9I5iucd5rrQsezVIx9/7cz3hixn1xYf+qBqQo2TMRgzr/IbalbNinf66M3RDf
	 cefVBSGI8p35Zj1bda5TfIZASnDb4q1szAIKPVHRqzNao11NFq3t0wkh6ybObXe+hd
	 XMFRApzL5J+XpE2yrx7BYxx6rboQ0epN9ejnEg5KpfRHCLmvsLHvwoQXbrKpUVGv72
	 G0868jLwMrdy8hkZt9u469cxKUfYCN5721414T2n3ta8L6RK2zQYKBy6SwUqdAuxnj
	 naUGoTx+WEuFg==
Date: Wed, 13 Dec 2023 10:01:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
Message-ID: <20231213100147.6d9cdb3c@kernel.org>
In-Reply-To: <CAD4GDZztgSHGsYQkK3jZSrwgS1FKrGmGw7AnGe7vqz40zE9JFA@mail.gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-10-donald.hunter@gmail.com>
	<ZXjuEUmXWRLMbj15@gmail.com>
	<m21qbq780z.fsf@gmail.com>
	<20231213083931.2235ca18@kernel.org>
	<CAD4GDZztgSHGsYQkK3jZSrwgS1FKrGmGw7AnGe7vqz40zE9JFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 17:04:11 +0000 Donald Hunter wrote:
> > I can drop patch 9 when applying if that's what you mean.
> > No need to repost the sub-message support.  
> 
> No, it's one line of patch 9 that needs to be dropped.
> 
> > +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)  
> 
> The other three lines should remain.
> 
> I'll respin if you prefer.

Yeah, nah, I'm not editing the patch itself :)

