Return-Path: <netdev+bounces-63355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC082C5EE
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBD5286C22
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564916435;
	Fri, 12 Jan 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwK/V+d5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B2EBB
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7BBC433C7;
	Fri, 12 Jan 2024 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088148;
	bh=eLYeHhnRkNOZIBWhYkTqwDYfu4//8zPblogLksvi6oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwK/V+d5IgSBy62tRou6IsXcIXk9QBph0WNO9eKFUr8HDvd441BlxJWxHjjqriUrm
	 sqbtaV0h65oisseZGWnSvT4K3jFeAl9eOgFhwUVCVbNzG8zQ/Engsu9jtVaqLcnrgy
	 bVSWf00QWWfqsXDJ7W+AOgDDxK7pEtlRn+sbcaXUHOjFzpa3RH4X96YxI+N4WO6M5I
	 8WnEvw1cJsRMwd8yTyAHeGdXaMDvo+lmld8B2DKkMTmnSQaZ/JrkDl1PmBZ4sesoUB
	 zuX3Tzou6rx4SllbPUrhKSSYbZjbuEVMEBR8ibfTiXQIwNxLbqHBMhpxqyFke3PQvh
	 1f7T6Uu27Wlvw==
Date: Fri, 12 Jan 2024 19:35:43 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Peter Krystad <peter.krystad@linux.intel.com>
Subject: Re: [PATCH net 1/5] mptcp: mptcp_parse_option() fix for
 MPTCPOPT_MP_JOIN
Message-ID: <20240112193543.GC392144@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
 <20240111194917.4044654-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111194917.4044654-2-edumazet@google.com>

On Thu, Jan 11, 2024 at 07:49:13PM +0000, Eric Dumazet wrote:
> mptcp_parse_option() currently sets OPTIONS_MPTCP_MPJ, for the three
> possible cases handled for MPTCPOPT_MP_JOIN option.
> 
> OPTIONS_MPTCP_MPJ is the combination of three flags:
> - OPTION_MPTCP_MPJ_SYN
> - OPTION_MPTCP_MPJ_SYNACK
> - OPTION_MPTCP_MPJ_ACK
> 
> This is a problem, because backup, join_id, token, nonce and/or hmac fields
> could be left uninitialized in some cases.
> 
> Distinguish the three cases, as following patches will need this step.
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


