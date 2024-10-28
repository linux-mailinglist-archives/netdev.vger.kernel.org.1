Return-Path: <netdev+bounces-139720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E19B3E7A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2156B1F23278
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F9201023;
	Mon, 28 Oct 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itL+QjNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D784201014;
	Mon, 28 Oct 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158272; cv=none; b=pOMKhWbVXOCHwmNDE3eR/MrRLYHv3I5/4C61n08zofDM5nOef03kPVPvcf2iJSWXpDqtoAyRpSTeq8JjHOtHp7yX/Yxwa8Gg7YhyHTJTnxY26culL7NHOJzpxU43RV0geuQWm4NaMF/3Xfiq0qDyXkQ2pWrHdTaHlD/FiAn9a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158272; c=relaxed/simple;
	bh=ZekJULxH2QK01D+KA9q5CLX82NrXZ1COQ0EanY2xtGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khxKe1le+Ysc3+RkNDQir7aZlJtqJky2fO2DOYJ55Xaj7TWfyXOCHBty7c0BGV0cFF+02BygQACC3jz+X/T+w+NDXq8cVBp/P3NF6ivS8Niu3LR/OtwpIjuexMQnKxw71cYnjw+zRewj/LyFmtPyjFnf+YSufB6LCmrBF/3sL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itL+QjNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A7EC4CEC3;
	Mon, 28 Oct 2024 23:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158271;
	bh=ZekJULxH2QK01D+KA9q5CLX82NrXZ1COQ0EanY2xtGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itL+QjNzL9DqbYeTlb6ziph/7Br5MPyniA/MUhWtlsXJp0QYAb9sPIxLw4c7FI+Gp
	 PIlACMYYw6nsHCme1gWm5oqu/Bifzx6+pjAjf5QFrNnKSKPMOd7885jhHjxcwqu6Id
	 fRpgwe9dd7kOHt7q26lRSsHBgLGaEfRluQCbbZ+DCACiUr1g5ROdEz9lQhPj6EtdNx
	 ETjleWckyEsZwsDwUyNOKvt8e7RnPVi2Yr/vebxr1O16T41XLFaY/FUienVKdVb5jU
	 6itXc2Mf2kRDi+la2ODLq0esM2mBnNCexN3yeNIVSXV5zK0OmlOKv+YB+z3pP4ONkK
	 bdVc7yCU0IQpQ==
Date: Mon, 28 Oct 2024 16:31:08 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <202410281629.487F7CFE@keescook>
References: <cover.1729802213.git.gustavoars@kernel.org>
 <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
 <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>

On Mon, Oct 28, 2024 at 09:38:46PM +0100, Andrew Lunn wrote:
> > As this new struct will live in UAPI, to avoid breaking user-space code
> > that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
> > introduced. This macro allows us to use either `struct sockaddr` or
> > `struct sockaddr_legacy` depending on the context in which the code is
> > used: kernel-space or user-space.
> 
> Are there cases of userspace API structures where the flexiable array
> appears in the middle? I assume this new compiler flag is not only for
> use in the kernel? When it gets turned on in user space, will the
> kernel headers will again produce warnings? Should we be considering
> allowing user space to opt in to using sockaddr_legacy?

I expect that the userspace usage of -Wflex-array-member-not-at-end will
be driven by the libc projects, as it'll need to happen there before it
can be done anywhere else. We'll be able to coordinate with them at that
time, but I'm not aware of any plans by any libc to use this flag yet.

-- 
Kees Cook

