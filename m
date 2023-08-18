Return-Path: <netdev+bounces-28775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062E780A8B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7634D1C21606
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBD18038;
	Fri, 18 Aug 2023 10:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C34A52
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15DDC433C9;
	Fri, 18 Aug 2023 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692356147;
	bh=XlqY4Yic3Gv96y4bEhrFTLtlSIDPkxSaGRYN+jEJlzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdPXqSQjoLVu1gKJQtyECWmkj/FcL6oLBFvDMUqcuRmfHLw4WEgMjx35bbvbNniOx
	 nIcaLRIZpqbpcr7WQQqMcN3DzfSDzqekEnNfuIIFpOxfHL1rGangI8pth8l9r4dxkn
	 M+ik5UN0CjjTyG+tPEhqz3Wpf4apej9eMZXw5W/Wj5plLHmz1bxUZBPU9CfjGiasrT
	 8EbFX7E9ci9sZg3GwxrALjrEE3o4twOgeH76bP73+pxkdCSMy3qBudOWstP98snlgT
	 i4x2eCd2VZpFg8mu7C3G/jn5RVGEhCQpwuXbLIY01L8nfX9GvhBfPdyPouWn4TQKN7
	 GRkP5Nfe7cXzw==
Date: Fri, 18 Aug 2023 12:55:42 +0200
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net-next Patch 0/5] octeontx2-af: misc MAC block changes
Message-ID: <ZN9OLltBUdKK+3tH@vergenet.net>
References: <20230817112357.25874-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>

On Thu, Aug 17, 2023 at 04:53:52PM +0530, Hariprasad Kelam wrote:
> This series of patches adds recent changes added in MAC (CGX/RPM) block.
> 
> Patch1: Adds new LMAC mode supported by CN10KB silicon
> 
> Patch2: In a scenario where system boots with no cgx devices, currently
>         AF driver treats this as error as a result no interfaces will work.
>         This patch relaxes this check, such that non cgx mapped netdev
>         devices will work.
> 
> Patch3: This patch adds required lmac validation in MAC block APIs.
> 
> Patch4: This patch replaces generic error codes with driver specific error
>         codes for better debugging.
> 
> Patch5: Prints error message incase, no netdev is mapped with given
>         cgx,lmac pair.
> 
> 
> Hariprasad Kelam (4):
>   octeontx2-af: CN10KB: Add USGMII LMAC mode
>   octeontx2-af: Add validation of lmac
>   octeontx2-af: replace generic error codes
>   octeontx2-af: print error message incase of invalid pf mapping
> 
> Sunil Goutham (1):
>   octeontx2-af: Don't treat lack of CGX interfaces as error

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


