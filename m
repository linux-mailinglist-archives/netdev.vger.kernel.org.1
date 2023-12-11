Return-Path: <netdev+bounces-55889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF080CB36
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACD9281E33
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F23F8DD;
	Mon, 11 Dec 2023 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmxK1oMP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4C3F8D7
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A052EC433C9;
	Mon, 11 Dec 2023 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301920;
	bh=lXQP+Rpk061vAAirgqOe0az1+8+a3wmNsNTGqPNPRJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmxK1oMPnLaunXHgUb3mfSXoAaIwBJ0imqSntTQHWJYCZzL9rZVAaUJSMuL7WHY61
	 mbm9wbZbQaFSHy7wYGOVWa+9zIht3dcCbsDpXy9+s4pOo9ordSvh8jdWIbxA6f5djo
	 F22VGfGcDn2qqWdfiuJMN2OInh2h7XeDt+5JGT7yYpGV3AYYI3la0SQHF1vKmrq4rS
	 /zzlAIzulu8Xq2aZDq/0JaJwruaHy2rxLbAsjE0uP4s0xTg5awAR9D7MSR3s847/Cs
	 VLVLB6y4YiuTKy4ChtLgHaMEixnZ6aywYms1XNjqbqQj8nQRm3R1zj6FNWvhMe9XRK
	 H8vlH8NutGpYA==
Date: Mon, 11 Dec 2023 13:38:34 +0000
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 3/3] net: sched: Add initial TC error skb
 drop reasons
Message-ID: <20231211133834.GN5817@kernel.org>
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205205030.3119672-4-victor@mojatatu.com>

On Tue, Dec 05, 2023 at 05:50:30PM -0300, Victor Nogueira wrote:
> Continue expanding Daniel's patch by adding new skb drop reasons that
> are idiosyncratic to TC.
> 
> More specifically:
> 
> - SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up using
>   ext, but was not found.
> 
> - SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was looked up using cookie
>   and either was not found or different from expected.
> 
> - SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.
> 
> - SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
>   iterations
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


