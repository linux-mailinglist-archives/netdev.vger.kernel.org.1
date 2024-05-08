Return-Path: <netdev+bounces-94357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE178BF453
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC52B22E31
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9D8F68;
	Wed,  8 May 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF75b589"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B68BE7;
	Wed,  8 May 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133830; cv=none; b=tlRwciTYdwfIb4EzVqSe00NG+/HTMiQUd8ioJ29uwbYVZEZ9gdEz6D2FvWr3+nYm+GXCGQBsllvbRlr/oX2qO+3Cq/De+grNMB0LXZRfzycCQV5+2FibzCkHO6MK7/h8nf4bhjVwmyPOVeU/NU3Pia6QoI1/rK94hXJE3jC5JHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133830; c=relaxed/simple;
	bh=u1HK3lKrCXfmSNN4df0DTFJ09j4yFFS2SW0WGxuOVdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABGXkD89V0FkYTQcYiyawRyqK4FaMu782lN9brWLcNqXFnQs578iPof/LxLHIzxEL+/0UVOGmvPjLCp3KAKtI9KqWHENo3ul58RObA7CeCG9etL3aDwzeETuXg33iUbUedQbl1FSJnpm9R8VrKp0SRjRVVctyBop++wwUpS+/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF75b589; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE7BC2BBFC;
	Wed,  8 May 2024 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715133830;
	bh=u1HK3lKrCXfmSNN4df0DTFJ09j4yFFS2SW0WGxuOVdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KF75b58955oCdvUbr9+ISjBQ18eL34qjS/7cgPiVTdi6Ql/Zv5RMim9LBcEfrm+Lw
	 h+CCTwtOfMzJBjZIGWan1Svk5EKw4S0eDak0tro++DbpNp6wOXt7/V22/g+uPUZjFJ
	 GLL1rGehmFejgBgJsXivUHGHHsvPb7mJNH/V96H68WYm+tE1zz01TVvZko9XUnzRFl
	 5omX7obcfzzsmgek2LbFyrAecZkd+TpyYU8PqeZJ7H1DalbrmsuuiyTrSfEeirvX3C
	 PeAi7jdkWV2ji3YbR8nu0sFf6xNrG0YNuDTDlzG05QGaz1n0GEpK4Ak04EjTf+TcwP
	 43c6gWN+dn8SQ==
Date: Tue, 7 May 2024 19:03:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Initialize the other members except the
 est->lock
Message-ID: <20240507190348.1bd1c446@kernel.org>
In-Reply-To: <20240503231804.2323666-1-xiaolei.wang@windriver.com>
References: <20240503231804.2323666-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 May 2024 07:18:04 +0800 Xiaolei Wang wrote:
> Reinitialize the whole est structure would also reset the mutex lock
> which is embedded in the est structure, and then trigger the following
> warning. To address this, define all the other members except mutex lock
> as a struct group and use that for the reinitialization. We also need
> to require the mutex lock when doing this initialization.

Seems better to move the lock outside of the struct to 
struct plat_stmmacenet_data. 

