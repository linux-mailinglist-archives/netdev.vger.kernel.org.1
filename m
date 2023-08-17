Return-Path: <netdev+bounces-28344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C577F191
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0065F281DEF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5852DDBC;
	Thu, 17 Aug 2023 07:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D6AAA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD5C433C7;
	Thu, 17 Aug 2023 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692259081;
	bh=r+ro+CqKpsAgFNKHrNlF2OCrl6EMwVsVdSb3bupxn1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXf6OOPh1GRQOzq0QXfA2v+iTS1wiLjB8lWA7c6azvJbyao2N3mgg938d5Mwi+9Ba
	 FoJjHkGZq3Xe4Rz/REAZ0IPfOKcWv4jrLJlvi2aXAZi+ePcbLmPpsLGgDkXZ3nOjZf
	 wMVKohY7Mj1aLxaJ0gYl7MiAif1WdwAc6PmlgE+yoPmIwLxm4hTBxMJMef4Jgu1W7A
	 WxKVuxy9jQr2mRz4YgbodHP3lIB4hdluqbVcGGtJJYzVxSe8Wb3d3yw/DfLgOHGdD9
	 y3HM47eYmyJhm+YgilEODLGaJnXguGKPolOIjBgRPrv4LUfe8Bu5W7O3Sm5lZTJyL0
	 Vbny0qbB39eFw==
Date: Thu, 17 Aug 2023 10:57:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net Patch] octeontx2-af: SDP: fix receive link config
Message-ID: <20230817075756.GC22185@unreal>
References: <20230817063006.10366-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817063006.10366-1-hkelam@marvell.com>

On Thu, Aug 17, 2023 at 12:00:06PM +0530, Hariprasad Kelam wrote:
> On SDP interfaces, frame oversize and undersize errors are
> observed as driver is not considering packet sizes of all
> subscribers of the link before updating the link config.
> 
> This patch fixes the same.
> 
> Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

