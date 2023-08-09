Return-Path: <netdev+bounces-26077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF2776BAA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338412816D3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69C1DDEC;
	Wed,  9 Aug 2023 22:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244071DA50
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71134C433C7;
	Wed,  9 Aug 2023 22:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691618568;
	bh=0JZWBZyc7Y9wfXoloSzdrw2QgX5w5zayWt9GtZxJQ9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2k/MCrmXLrlwGOwtMvOufID5yN80HZ7vUG6CqnNVeojN/TVxLbQVQzcupTh2+vY3
	 qXw1HAty12qGgegGw3NLPlJ/o3JslNfLQs7YLK3+xvY+9vDJZLgIpr+4Utc4Xjqgai
	 HDilGbnyRQgHykrv9hXwvqxTZZfWLl4rX5AxoHWSqHG+IZe8ZJZLVkeOQBX82cHgLM
	 XeMjem/8yGTISRI8vcj0UCgIadWdXcnPO2t+9ugsG63Cfe7DgblxCrd7tbLkcn+K3p
	 RK4HeGMfCRBYUZ9IyVqOtjcKewXNu/jItz1zKjpFlKFR0a/VmKodot5HXjSM7/IOIR
	 YqBa836GN00gQ==
Date: Wed, 9 Aug 2023 15:02:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
 axboe@kernel.dk, pshelar@ovn.org, jmaloy@redhat.com,
 ying.xue@windriver.com, jacob.e.keller@intel.com,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 dev@openvswitch.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
Message-ID: <20230809150246.4d1c0be6@kernel.org>
In-Reply-To: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-4-kuba@kernel.org>
	<6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Aug 2023 22:59:47 +0200 Johannes Berg wrote:
> On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> > Only three families use info->userhdr and fixed headers
> > are discouraged for new families. So remove the pointer
> > from struct genl_info to save some space. Compute
> > the header pointer at runtime. Saved space will be used
> > for a family pointer in later patches.  
> 
> Seems fine to me, but I'm not sure I buy the rationale that it's for
> saving space - it's a single pointer on the stack? I'd probably argue
> the computation being pointless for basically everyone except for a
> handful users?

Fair, I'll update all the commit messages.

> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks!

