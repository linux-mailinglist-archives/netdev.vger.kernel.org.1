Return-Path: <netdev+bounces-18014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EF7542AE
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA54A2822A1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829C156F1;
	Fri, 14 Jul 2023 18:40:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C7154A0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4511C433C8;
	Fri, 14 Jul 2023 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689360018;
	bh=qHaTl4yRkeaUJ6f/KP5OJUSTQcmrqQslpzQe+gfTY30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXaheJtTBBAWepRARnwP718bg8S0UMWm4fKromRkzOEA6UYYCf3x5/g4kVitZqmfl
	 DnHW1a6fVY5qyWDMzfbB4jbYRLiC9UMqbDv6EcGUf5MvYhQ7je9pBApVOTkOfM8VEV
	 PMxH05dIwNUW6MiWFdmuwok489GVuxnSL1WOPWFd4qZNm1g/OAZu6Hg9X80/F51YkD
	 WbI3WW9o4jrFWUym43tCzlxDrZQP/GUeX13+7HeZ9DiIyVeKfJYokBypvKC6eEeJFO
	 SBN9aUgEoCMiVa3ZLeAlSpEjWI1/FK4y0AmdUHbmrwsQYgDEdLdr1oeo0K3c93Snae
	 0d8No1aI9NG0Q==
Date: Fri, 14 Jul 2023 21:40:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230714184013.GJ41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
 <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
 <20230712173259.4756fe08@kernel.org>
 <20230713063345.GG41919@unreal>
 <20230713100401.5fe0fa77@kernel.org>
 <20230713174317.GH41919@unreal>
 <20230713110556.682d21ba@kernel.org>
 <20230713185833.GI41919@unreal>
 <20230713201727.6dfe7549@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713201727.6dfe7549@kernel.org>

On Thu, Jul 13, 2023 at 08:17:27PM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 21:58:33 +0300 Leon Romanovsky wrote:
> > > TC packet rewrites or IPsec comes first?  
> > 
> > In theory, we support any order, but in real life I don't think that TC
> > before IPsec is really valuable.
> 
> I asked the question poorly. To clearer, you're saying that:
> 
> a)  host <-> TC <-> IPsec <-> "wire"/switch
>   or
> b)  host <-> IPsec <-> TC <-> "wire"/switch
> 
> ?

It depends on configuration order, if user configures TC first, it will
be a), if he/she configures IPsec first, it will be b).

I just think that option b) is really matters.

Thanks

