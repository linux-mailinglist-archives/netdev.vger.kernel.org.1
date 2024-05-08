Return-Path: <netdev+bounces-94456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D248BF875
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566DEB252D9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1404500F;
	Wed,  8 May 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+B222Nh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148B50A6D;
	Wed,  8 May 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156655; cv=none; b=ZQN7NpC4EUAZeNHHOD8hHj+DfqT1sfHbXAUJznB+ha+raMFDr2qDcMJBwBOclUShIyFy8Boxy9C70tJG1IELlGXrNhWGRsBITonYrZv9iTkWAj9GINU0MYifrQpBn+qevGtT3p+HWYmU50PdZ6cfem4zzZTdnK678Gqf7dBAtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156655; c=relaxed/simple;
	bh=XieW1XB6DoWhduZUawaNxBdmIMPqyXa8hYzv98yKvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI0OVdy/fr0eHS8QUSmD/JGgZiFz1B8TNbPbF/VWdq4YNCLllyrSUb0l+RpFiGpMyN/tDIbdKdSNAVd6ktNGllSbeG/oKbGQIX3yt5GrmD5s55/YomzIPx5/szDrOnkxUx8dl+EV4Q8GynI8l1Vio3uAoA8RCZLGLTXViGWBi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+B222Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3BAC113CC;
	Wed,  8 May 2024 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715156655;
	bh=XieW1XB6DoWhduZUawaNxBdmIMPqyXa8hYzv98yKvG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+B222NhYfhflsQf65Hng9jjvTDhRZn0KuYNhgBISCrwcn8B7NGosFC9dd+pgClSX
	 mBAQZ2Jv95Lm/EzIAdGI1ai5Glx7i0DrR4nQxYsnvO8FnoetwyM9g/udRdT3SZ5vYR
	 6Jw59/Hnd0w/BZbAxjGW/uq735txFN2+4rMGnAeskGFYxu9mCLZ+g0PfhMHE1xCfmI
	 y6HnSoRuZKy6+ZjsZnvs3ORrjLaF0k1tLp31FTE+gTEY/iqMwKCmkd2FWaEtP7uzxB
	 USd4p8pHfQLkvKuac9AchR0j8LzI9jSKg1DcVRHAdLrOoYkdxMvXVp2AzDLdZjEfu1
	 1ggb96UzeI6mQ==
Date: Wed, 8 May 2024 09:22:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] gve: Minor cleanups
Message-ID: <20240508082240.GM15955@kernel.org>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
 <20240507152846.30d7c11b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507152846.30d7c11b@kernel.org>

On Tue, May 07, 2024 at 03:28:46PM -0700, Jakub Kicinski wrote:
> On Fri, 03 May 2024 21:31:25 +0100 Simon Horman wrote:
> > This short patchset provides two minor cleanups for the gve driver.
> > 
> > These were found by tooling as mentioned in each patch,
> > and otherwise by inspection.
> > 
> > No change in run time behaviour is intended.
> > Each patch is compile tested only.
> 
> Looks like it conflicts now, please rebase

Thanks, I'll rebase and send a v2.

