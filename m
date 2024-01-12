Return-Path: <netdev+bounces-63359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530482C5F4
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987B71F21A30
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45815EBD;
	Fri, 12 Jan 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6dLayxe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482715AFC
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B2C433C7;
	Fri, 12 Jan 2024 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088249;
	bh=zQhKcYqWDb4Yy553Yt1DpGTpWZQnaKuNZEwHHrPE0rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6dLayxeJ0AMuuem9U5kRCFXc29wo1fggzGffsdGulMS6XEuB/sZZ5CVeLQEFBm+H
	 vJ31MG9/Qb0koCq7CVQxAM49HocZFiLASNu6nqVRk0QXuNTsLKd9oghoLI0ANHbJzZ
	 5VXwJVmpauUkmK7ItK/oXJPM3tkel3PWwfWwCJpNNlQGWlR3YdQjtxSYwbF8H2MGrI
	 2QUf4y+A5ArxgUWYOJoz7q3WEL1ca4ziwGQNi9OV2j8WY+n/VGNodM6zTSdY1GIhfd
	 bey59Kg946P6l2B4f3olcm7vs+DrvX77jyfgIuFgygSOmuzTVbxiFjFD43Nwws4Oss
	 2WC7AxyU531AA==
Date: Fri, 12 Jan 2024 19:37:24 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 5/5] mptcp: refine opt_mp_capable determination
Message-ID: <20240112193724.GG392144@kernel.org>
References: <20240111194917.4044654-1-edumazet@google.com>
 <20240111194917.4044654-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111194917.4044654-6-edumazet@google.com>

On Thu, Jan 11, 2024 at 07:49:17PM +0000, Eric Dumazet wrote:
> OPTIONS_MPTCP_MPC is a combination of three flags.
> 
> It would be better to be strict about testing what
> flag is expected, at least for code readability.
> 
> mptcp_parse_option() already makes the distinction.
> 
> - subflow_check_req() should use OPTION_MPTCP_MPC_SYN.
> 
> - mptcp_subflow_init_cookie_req() should use OPTION_MPTCP_MPC_ACK.
> 
> - subflow_finish_connect() should use OPTION_MPTCP_MPC_SYNACK
> 
> - subflow_syn_recv_sock should use OPTION_MPTCP_MPC_ACK
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


