Return-Path: <netdev+bounces-22612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564077684D9
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825191C209C3
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0021361;
	Sun, 30 Jul 2023 10:52:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25747369
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 10:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2324C433C7;
	Sun, 30 Jul 2023 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690714363;
	bh=L0/B2pwlAtd2YgE4g+cGWSdLmLx7xZyE3P9pMCFiAY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5RyfES8dyv7/I1/iF9BsbR+u3+ZLu+hoM4q9wzg6qHiT9Bpq3GeesQntP4blN6tk
	 xO5BmUE5uFSMDPrRC4ebZJONXej1rHSnyoQIm1CN3TvVBTSNF4/owVf3SCfz9sR5AV
	 8l30wAiDcnGU9bSbhb841QHjK8dCEK9TSs2B1B/3hbxVYFU+dxDItM2PvWtBg9zJQP
	 HAnBPzhxYWbsZ/75HnK7bIgV+4wpbTpyNSvN8n5vVChl3LQl9IqFKPP+v3TdBE6pOx
	 fJxuLGl3p9IKjERgbcz6yTurpSRAct+iiCiDZD1rMVHLZfmAkT+p7jeQy5KiGggT10
	 3WgNkesYys1qg==
Date: Sun, 30 Jul 2023 13:52:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <20230730105238.GB94048@unreal>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
 <20230726115500.GV11388@unreal>
 <5be7712f.ead00.1899266e0a1.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be7712f.ead00.1899266e0a1.Coremail.linma@zju.edu.cn>

On Wed, Jul 26, 2023 at 09:32:43PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > This CVE is a joke, you need to be root to execute this attack.
> > 
> 
> Not really, this call routine only checks
> 
>   if (!netlink_net_capable(skb, CAP_NET_ADMIN))
>     return -EPERM;
> 
> and any users in most vendor kernel can create a network namespace to
> get such privilege and trigger this bug.

ok, fair enough.

> 
> > Anyway change is ok.
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Regards
> Lin

