Return-Path: <netdev+bounces-63357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D882C5F0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B461C22764
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4E16432;
	Fri, 12 Jan 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPjrcqda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3915AFC
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE221C433C7;
	Fri, 12 Jan 2024 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088209;
	bh=mdfniOLp2qqcQmHI9mExCaFyNER2SyN9ZngMjf7gUAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPjrcqdaXF1u7flXsAGqjJIgYDapenTLyDIGvjvYOPMsBggZtdfr4VhZHHubieZ0y
	 ZQcjljClbRmbG7qUXdPZ2CEgJ0b7050ZNLwDwEGX7UCIekaa8Z2xbNk7m4UNuj0fIR
	 lAuM0RpC4itsURBRHIpBvV/00JJE7+0pj67UYnTo+N+Vj+zIfL+nszoU41OBd/lQQP
	 flo5MAPUJsy1OJHP8RPhSIp1/BWeeCTyuAULkJpWQMTdV1mCCKu60yqtXI52sRAvus
	 ZitwMXTEk1jpigmslGzN2WuB3H19G+/jBCmplCfus4sJNWjcLXd5XymS+0NiU8DEyr
	 Jr6LZJprWIPNw==
Date: Fri, 12 Jan 2024 19:36:44 +0000
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
Subject: Re: [PATCH net 3/5] mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <20240112193644.GE392144@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
 <20240111194917.4044654-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111194917.4044654-4-edumazet@google.com>

On Thu, Jan 11, 2024 at 07:49:15PM +0000, Eric Dumazet wrote:
> subflow_finish_connect() uses four fields (backup, join_id, thmac, none)
> that may contain garbage unless OPTION_MPTCP_MPJ_SYNACK has been set
> in mptcp_parse_option()
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


