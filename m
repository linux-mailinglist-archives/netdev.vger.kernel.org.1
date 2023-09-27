Return-Path: <netdev+bounces-36416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A77AFA5C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5DCD21C203DB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D311CBC;
	Wed, 27 Sep 2023 05:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700633C8
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE0C433C7;
	Wed, 27 Sep 2023 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695793893;
	bh=iSvRaoQsvHcID1e7FqP/42c2VfE0oDMv4a1u0al4HRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMBkQUo6bI9y/v66lscpD/mJL6taRxZetEj8yut0jY+XbK+RnRwPU1ewS9YrHKJcV
	 xt58K+uMH/iDmHUSvfd2w/S33qAZczL19om/ymZThHpunQBqKC96HOk8eFEaHjR3yd
	 vVRAE5XmaKLtmS2FVkIsAgkDdacnLdxRPX7ZnRVceTq67EH8J2hQ8oHZd7qUPYEA5+
	 kzaTOO70aECdC5S/0zzb+yW3D+6cWmYEKsO6cWIAMEr2bSwzDvr640VjhgD9Squ0s2
	 U37OpSW4iMoQ1JvZZpzpYxyip6LNSK17FhuVusbDM9ZlZlOA1lDBXcKUwk4rRZWG6n
	 VVqULe07KPZlA==
Date: Wed, 27 Sep 2023 07:51:26 +0200
From: Simon Horman <horms@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
	ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 3/3] net: prevent address rewrite in kernel_bind()
Message-ID: <20230927055126.GD224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
 <20230921234642.1111903-3-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-3-jrife@google.com>

On Thu, Sep 21, 2023 at 06:46:42PM -0500, Jordan Rife wrote:
> Similar to the change in commit 0bdf399342c5("net: Avoid address
> overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> address passed to kernel_bind(). This change
> 
> 1) Makes a copy of the bind address in kernel_bind() to insulate
>    callers.
> 2) Replaces direct calls to sock->ops->bind() in net with kernel_bind()
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


