Return-Path: <netdev+bounces-36414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DD7AFA5A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AD31C28139A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438714F69;
	Wed, 27 Sep 2023 05:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63C14F67
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5BC433C7;
	Wed, 27 Sep 2023 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695793841;
	bh=ukaVewD6Ow36ozXZyc50lB+Up0oYTVoEBye3cUBjsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFVZM0WaTbX8IzgNfWB/+nnCRvAIuLTuLl92HlRXE08qPst2pLLXEj8YN/Vz6IIQG
	 tOalVEN9Swi/yFXO9dmzIHX6uxLrGEL3dGlqBt9X3uCvX2h/ULr3yDZ0JHZEEidMi3
	 omXSTz5h84MwoWSAijg+eyYyMho88pj5JizQd1JVlYpVBy48MHnygjDIXfUsTuDy9S
	 evjL9rBTHu64QLHm4Rpz8cletGeYTcYVnJ7aSEPN9xAPQSKUa1mXzEKKR1sAB8N/Md
	 /eXHuBsT0uLYxpJ/owZrZWxmyoGW3NvfNRVcrRtpE7dzPNGXWAUtsHNjkHwUAqOSjc
	 BhzzC+aKgKBhQ==
Date: Wed, 27 Sep 2023 07:50:33 +0200
From: Simon Horman <horms@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
	ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
Message-ID: <20230927055033.GB224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>

On Thu, Sep 21, 2023 at 06:46:40PM -0500, Jordan Rife wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces direct calls to sock->ops->connect() in net with kernel_connect()
> to make these call safe.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


