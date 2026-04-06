Return-Path: <netdev+bounces-275630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIp5MlXS02nGmgcAu9opvQ
	(envelope-from <netdev+bounces-275630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5523A4C79
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C076301912F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094227702D;
	Mon,  6 Apr 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6efUx+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1F239E9B;
	Mon,  6 Apr 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489514; cv=none; b=g2jcSCQS6xl5zEiUIzBLL7eHxTlxPLsnnXSzSTerUFVLTQ3EtK9ZaLMZIUVeZDlRVWiEgmKJPEkcepjCE0I+Bv3QCETuLm6vKqRFv8mSxatB/ERTtt15BRKfjI86y80xxcm3JtMvY7QcNCt8a9PsGS7Wxhulah6SQFyQBqD6yMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489514; c=relaxed/simple;
	bh=itDLSe0giY70jGJf4kzYlywYfnF9br8CjKCgeeZ16VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GArsugGG9xeGGRT8Uuae47mUfmymnW4ZRVodfWgQhLb0dT62SWse+7DbbGkSsKkw3/g3BSziKZTa0F8iSFLdsXWHu53JqDevBgecvzekk+bZpURgrRKTIndntKMsZ+M1UyMUnNmTQHWAwnIDTvii11i+uyruuj46rpeU4UlrU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6efUx+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBA0C19421;
	Mon,  6 Apr 2026 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489514;
	bh=itDLSe0giY70jGJf4kzYlywYfnF9br8CjKCgeeZ16VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6efUx+r7a/SlGdQCndU2a3Ll60+iodoSVWelWnpTe4hWrqOqzsbnr5rfD7+IjPaY
	 7e2h+Pr/cNOxFp20PExgZV0uGUUgwaHdBa0V7Of0viYQ7qD0KVc83x2om4S2T2FXUK
	 8Ea9NcN/wkJCHV1lie4HScPl4GKnglaXzdzKUkgWvy3P96A4kFtJ25efWiQwGQxq2x
	 nYhpGgsRWdJ7gEzpvlfQeuTBphzDeNh7jZaQi+JSGI1Xt3JBJ/OF+gTIhYZHPJlxU0
	 EcNDPFyGxqPIj4+cJL6AYFK0UYrB1ts4X4/vMihhPuLalshM8gZ9Za6dhcW9CB6IIX
	 8xt+S45CxyU6g==
Date: Mon, 6 Apr 2026 16:31:50 +0100
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: lib: rewrite processing
 of command line arguments
Message-ID: <20260406153150.GI395680@kernel.org>
References: <20260403141912.3825693-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403141912.3825693-1-ioana.ciornei@nxp.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275630-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 4B5523A4C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:19:12PM +0300, Ioana Ciornei wrote:
> The piece of code which processes the command line arguments and
> populates NETIFS based on them is really unobvious. Rewrite it so that
> the intention is clear and the code is easy to follow.
> 
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index d8cc4c64148d..922cdaf2ceb9 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -466,18 +466,18 @@ if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
>  	NETIFS[p2]="$remote_netif"
>  	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
>  else
> -	count=0

AI generated review on Sashiko.dev suggests that initialising count should
be retained to ensure correct behaviour in the (unlikely) case that count
is already set (to a non-zero value) in the environment.

And this seems like a good idea to me.

> +	# Prime NETIFS from the command line, but retain if none given.
> +	if [[ $# -gt 0 ]]; then
> +		unset NETIFS
> +		declare -A NETIFS
>  
> -	while [[ $# -gt 0 ]]; do
> -		if [[ "$count" -eq "0" ]]; then
> -			unset NETIFS
> -			declare -A NETIFS
> -		fi
> -		count=$((count + 1))
> -		NETIFS[p$count]="$1"
> -		TARGETS[$1]="local:"
> -		shift
> -	done
> +		while [[ $# -gt 0 ]]; do
> +			count=$((count + 1))
> +			NETIFS[p$count]="$1"
> +			TARGETS[$1]="local:"
> +			shift
> +		done
> +	fi
>  fi
>  
>  ##############################################################################
> -- 
> 2.25.1
> 

