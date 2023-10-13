Return-Path: <netdev+bounces-40708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF787C85DB
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9CD1C210C1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57B63CE;
	Fri, 13 Oct 2023 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2QrR7x8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8E15E8E
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92344C433C8;
	Fri, 13 Oct 2023 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697200481;
	bh=TvaszAa1RVva07RsdzVcq3JaOcKMz7c1edgzZZ1dueA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2QrR7x8DjDdi3eZfOOEmzZCHQfw/uXf4rmdALLzwAXUAHlYGdTzrrlZg9AZlgtvz
	 U7/z/4n8J9hxcySByWivnR0BZYOzct8yzGmWbRUIwFy0XXqAPNj6xYzpdzsiO2DGQ2
	 BqX7XBlldwH0h76xXG67B4+9RoYLsSZmDAg7vy9EbBnbJUjBbfwmD9MdtuczV3cvad
	 7bOMKH6+/a27wTRrSoOPtm+LkupyGkRFh8Yy1Wgf1BgAU8+gyF/3T9zg68fh1Vis6H
	 kJ+XbJl6N+gHSdp7XnwlBSTnyTwZhXFHU6VzWIoK7/g4GUpQXOC2x2bDeMaDhVpUuw
	 0W+8yoXKALA4A==
Date: Fri, 13 Oct 2023 14:34:35 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it
 was
Message-ID: <20231013123435.GK29570@kernel.org>
References: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>

On Wed, Oct 11, 2023 at 11:00:22AM +0300, Dan Carpenter wrote:
> This IS_ERR() check was deleted during in a cleanup because, at the time,
> the rpcb_call_async() function could not return an error pointer.  That
> changed in commit 25cf32ad5dba ("SUNRPC: Handle allocation failure in
> rpc_new_task()") and now it can return an error pointer.  Put the check
> back.
> 
> A related revert was done in commit 13bd90141804 ("Revert "SUNRPC:
> Remove unreachable error condition"").
> 
> Fixes: 037e910b52b0 ("SUNRPC: Remove unreachable error condition in rpcb_getport_async()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks,

I've reviewed the logic of this commit along with the description
and it matches up in my mind.

Reviewed-by: Simon Horman <horms@kernel.org>

