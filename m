Return-Path: <netdev+bounces-20995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84665762197
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B211C20F86
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F772592B;
	Tue, 25 Jul 2023 18:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB425916;
	Tue, 25 Jul 2023 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0433C433C7;
	Tue, 25 Jul 2023 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690310370;
	bh=Uw9m574mjK/0Ei7oniQtpFxXW1q8JHO3VH8+PxQI2CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGEFUCNKwoWqycpQvYWdIGzZh32HEIaGW1D7SsOrwMl7znohLPf0anaUfTGuEL3oW
	 lbmWtvgJEhkOzQzYi366/Es5uRaKMNAG5VKUayKej66M7pGLX+kJzgfVbr5i5LWxdn
	 qVMrLNH6DDoKKtXEZePe8t1Hx3jHGJG9o7h0DGUE=
Date: Tue, 25 Jul 2023 20:39:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
Message-ID: <2023072521-surfboard-starry-fbe8@gregkh>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
 <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>

On Tue, Jul 25, 2023 at 11:34:55AM -0700, Mat Martineau wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
> used instead of 'ip6tables'. So no need to look if 'ip6tables' is
> available in this case.
> 
> Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e6c9d5451c5b..3c2096ac97ef 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -162,9 +162,7 @@ check_tools()
>  	elif ! iptables -V &> /dev/null; then
>  		echo "SKIP: Could not run all tests without iptables tool"
>  		exit $ksft_skip
> -	fi
> -
> -	if ! ip6tables -V &> /dev/null; then
> +	elif ! ip6tables -V &> /dev/null; then
>  		echo "SKIP: Could not run all tests without ip6tables tool"
>  		exit $ksft_skip
>  	fi
> 
> -- 
> 2.41.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

