Return-Path: <netdev+bounces-50419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466BD7F5B98
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD34B20E6C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA22111F;
	Thu, 23 Nov 2023 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWEgfPpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E721119
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 09:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3546C433C8;
	Thu, 23 Nov 2023 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700732795;
	bh=2l0/Ev7FSIGz1Ko2iOPlx8+jTmBCUrIpJOZuuECMMWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWEgfPproWd+Bw30XkqC6qYT5sQ2f/IvQEXSGPCUgG6MKyWvK6m4++6p+CO4FAxoC
	 w3IRyKvlmwdWHbC1lpJe9Wl/ArDiN4QxiGzFdDQS4YN9Vh6ubgT+hRThFKPq8iLfUB
	 DPlkOiXdZVzYqTi3v1rMrewYgEwbFn51/CzU53WteZ4uyCAHfaUck6uvJ1B5wqy8/b
	 MM0GPsVHuGfBu6xyCBvndkPvkc78Cyh5uskHK8jmxWqJBT171QjLWmZSpPeyjjD3L2
	 4VQqyeh23FUodjSPcZ5pgRWi+uQkeUgh7jTsbQpXNraroxSL+wfGcRY22C0uhFdnY6
	 LdFYWlAJSqGmg==
Date: Thu, 23 Nov 2023 09:46:29 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, wojciech.drewek@intel.com
Subject: Re: [net PATCH v2] octeontx2-pf: Fix ntuple rule creation to direct
 packet to VF with higher Rx queue than its PF
Message-ID: <20231123094629.GB46439@kernel.org>
References: <20231121165624.3664182-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121165624.3664182-1-sumang@marvell.com>

On Tue, Nov 21, 2023 at 10:26:24PM +0530, Suman Ghosh wrote:
> It is possible to add a ntuple rule which would like to direct packet to
> a VF whose number of queues are greater/less than its PF's queue numbers.
> For example a PF can have 2 Rx queues but a VF created on that PF can have
> 8 Rx queues. As of today, ntuple rule will reject rule because it is
> checking the requested queue number against PF's number of Rx queues.
> As a part of this fix if the action of a ntuple rule is to move a packet
> to a VF's queue then the check is removed. Also, a debug information is
> printed to aware user that it is user's responsibility to cross check if
> the requested queue number on that VF is a valid one.
> 
> Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Removed 'goto' and added the new condition to existing if check.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


