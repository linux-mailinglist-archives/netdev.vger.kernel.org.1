Return-Path: <netdev+bounces-115361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59836945FA6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AE1C20D0A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E3200114;
	Fri,  2 Aug 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAIHzpPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1F1E4863
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610242; cv=none; b=BNVbAPYAfWpHv4VoBEo2ibgwFnzKUspeHYlTvaBL3ldG8V5W7rOXky1avDd8VJTt99xxv5mNAnmiyczzTUhVHQNSg1Ne+jprxTFWNqCAPgIh4fJWr/6ETTpqc4aPaiFWoWfF20gX7jo4rFN0zhO1FRsW7lxufvwgFXNM0aS/VBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610242; c=relaxed/simple;
	bh=SrfMasohKBgGRho3X5OsiAdbjBLZejn//jpnoaEhPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnGK9dxL4DSawJyI5HwwnNGRIDLdtUzOLdh0rw1yO37+4O03eaw5pWPNv0O8trflJPS/fE5tX9s7pqmwQXW0k9X1H9xENB2/CVktHKtZfwYqdme/e+refu2XEQ19heZ9P1/F5dn9/gwQ9uaEEY0xrLeprPGqsOemYxCwJJ+4qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAIHzpPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13D2C32782;
	Fri,  2 Aug 2024 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610242;
	bh=SrfMasohKBgGRho3X5OsiAdbjBLZejn//jpnoaEhPIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAIHzpPf9xETSJVB1MPqmeIpv7UtPOPIp/x6vqpG0p5UHjjb4UwcBE4c+suithy/b
	 m8K4tdgNrpJaOSC57/1f8VcCkvpMsQ3lRSM6dRYUdXbgwerZQem6hpd4QhWRMdV/bJ
	 KdJfn6/xd7MNFJadJSgAwR1FtzwRQ7KAfR/kZwfMkCQmH43Noslq9hDRMxOy86nVZZ
	 87SyuhDdTGuoy4M7rd9hfca8nqqsgD1+bq88+qEEaNoPqvoiLPweVgX4wU6OB0QpE8
	 7+GbZyWHl3nTDo0fiq7NQQdjpWrScguZM/j3oDuUD/QHDOFaLS6OjNQbadMqXAFY4L
	 VHOlNaDPh0D2w==
Date: Fri, 2 Aug 2024 15:50:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, kernel test robot <lkp@intel.com>,
	alexanderduyck@fb.com
Subject: Re: [PATCH net] eth: fbnic: select devlink
Message-ID: <20240802145038.GE2504122@kernel.org>
References: <20240802015924.624368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802015924.624368-1-kuba@kernel.org>

On Thu, Aug 01, 2024 at 06:59:24PM -0700, Jakub Kicinski wrote:
> Build bot reports undefined references to devlink functions
> in fbnic.ko.
> 
> Fixes: 1a9d48892ea5 ("eth: fbnic: Allocate core device specific structures and devlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408011219.hiPmwwAs-lkp@intel.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, I agree this is needed.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

But while exercising this I noticed that PAGE_POOL is also needed,
which I locally resolved by adding:

	select PAGE_POOL

I can provide a follow-up patch after this one is merged.
Or perhaps you can address this in a v2?
I have no preference either way.

