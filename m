Return-Path: <netdev+bounces-38223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C727B9CE1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 94CE91C20953
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB3134C4;
	Thu,  5 Oct 2023 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDED9GEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B411CA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBA4C32794;
	Thu,  5 Oct 2023 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696507541;
	bh=21DU9NkFRau8ny/K7aiOHAf5EcwkJjtrZoWyPsYUaBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDED9GEuWMzlFfhjz30LEN2+yub5TUYRifESFidBFaw/a5PTAjdkTO8RyTX00uAJS
	 QdMfD0m7IB7yUJ08HTDLssVi4RIfo3WFhtKsoHFpWUGrf81mtNjSWa4iBaLagSZWWu
	 b4Zd8t4TyeQ0xTkbZ4n17UmkOfqVBsD/wHwL0sDo3fL+iELa2mgyDsXCZ3rdbwC62+
	 AqtLBfVtLEtriX1WzSgt/Q/U5qLS0zqXoGgRbbhgWq/oBKp3cCAHoI3VOFFdZfQyNn
	 mI9Ebw3llozZgRBwlI4SCTXuaGCYMHEWGpMwLyNv5j3Fcb2eZCJHm38MyMSunRlk7/
	 HKXASpOpzKZnw==
Date: Thu, 5 Oct 2023 14:05:38 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH ipsec-next v3 1/3] xfrm: pass struct net to
 xfrm_decode_session wrappers
Message-ID: <ZR6mklT6iaX3HPJA@kernel.org>
References: <20231004161002.10843-1-fw@strlen.de>
 <20231004161002.10843-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161002.10843-2-fw@strlen.de>

On Wed, Oct 04, 2023 at 06:09:51PM +0200, Florian Westphal wrote:
> Preparation patch, extra arg is not used.
> No functional changes intended.
> 
> This is needed to replace the xfrm session decode functions with
> the flow dissector.
> 
> skb_flow_dissect() cannot be used as-is, because it attempts to deduce the
> 'struct net' to use for bpf program fetch from skb->sk or skb->dev, but
> xfrm code path can see skbs that have neither sk or dev filled in.
> 
> So either flow dissector needs to try harder, e.g. by also trying
> skb->dst->dev, or we have to pass the struct net explicitly.
> 
> Passing the struct net doesn't look too bad to me, most places
> already have it available or can derive it from the output device.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/netdev/202309271628.27fd2187-oliver.sang@intel.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Simon Horman <horms@kernel.org>


