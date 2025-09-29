Return-Path: <netdev+bounces-227181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC80BA992F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173E7192094D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0130ACE0;
	Mon, 29 Sep 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StOkOjwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F4307AC6
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155989; cv=none; b=VF0lyCRTt3Gd3xvNx3T/Eetl/DMwH7l+lf6E3i6ZvAkvSlqaIt4mR08OjmhLGvXGNAmIym5reO23kOJrgbMPIQFQm3Qb17EPr/q4Oj/Mp6p9TTLuCL8DzqSFFzMLdbl5gYvzlFiuCQEpxgrSjNTZkwTOow4bshqbXqt2wU8Ghiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155989; c=relaxed/simple;
	bh=bIXX3V4EqawsrnIh6NgGFhOYB1Z5xow0doNYZrb9TTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu5ZjPQ77DWHOn2qCab0z+l9++qXurAHoFNmztQ+NUSW1oFDOCoLjWcDQCPDx5bLMDwmrjiEYFlBnkMMHTpbFoqicSS1ngxJ8T6BD40bBPbrH28fqOWmPEmlRyArtsRgqIoxLOmmV1hNyoKguEJNPBlSfnv2isVQIvVOB2uK5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StOkOjwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E550C4CEF4;
	Mon, 29 Sep 2025 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155989;
	bh=bIXX3V4EqawsrnIh6NgGFhOYB1Z5xow0doNYZrb9TTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StOkOjwDSAb/9c22MCJr7kKtaYjF3Tu5xvA7V2/BZ2XkddeGS+HeIj5OR0Q2rb/tk
	 pydhQ6cJWVCNgynOp19xuMda5fWhTf+wB1HpPuteE9qciYt4uB4tvkUOuyqTsAxNuX
	 eQePF/PY0/UvDbmic/MjfzNAZ25nvzho5hKZda9Psttxc4scevJ2qYQUDYCueon/cr
	 nTIxRHF0uU+caTF5l0H+HOh7dtAg4wxAWCMZwjTFUE1GNa76Mev14P54NEct4KLMdO
	 UzHpJ0zuKWziaom4+jPxKT196yA2IgjrwzgGc1hvmBh4TotV8HzEHBn9d51AxbLTwC
	 CiamY9YwC1buw==
Date: Mon, 29 Sep 2025 15:26:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, kernel test robot <oliver.sang@intel.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] Revert "net: group sk_backlog and
 sk_receive_queue"
Message-ID: <aNqXETgt9pHIsnvx@horms.kernel.org>
References: <20250929140839.79427-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929140839.79427-1-edumazet@google.com>

On Mon, Sep 29, 2025 at 02:08:39PM +0000, Eric Dumazet wrote:
> This reverts commit 4effb335b5dab08cb6e2c38d038910f8b527cfc9.
> 
> This was a benefit for UDP flood case, which was later greatly improved
> with commits 6471658dc66c ("udp: use skb_attempt_defer_free()")
> and b650bf0977d3 ("udp: remove busylock and add per NUMA queues").
> 
> Apparently blamed commit added a regression for RAW sockets, possibly
> because they do not use the dual RX queue strategy that UDP has.
> 
> sock_queue_rcv_skb_reason() and RAW recvmsg() compete for sk_receive_buf
> and sk_rmem_alloc changes, and them being in the same
> cache line reduce performance.
> 
> Fixes: 4effb335b5da ("net: group sk_backlog and sk_receive_queue")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509281326.f605b4eb-lkp@intel.com
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry Eric, but it looks like you forgot your SoB.

...

