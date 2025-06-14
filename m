Return-Path: <netdev+bounces-197793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBBDAD9E66
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701691787D3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D341D63C0;
	Sat, 14 Jun 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPOjPIOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD841C68A6
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749921094; cv=none; b=MMBiKMMJP1xQwadjKTwPSWIOgsqxHLaLxATyEzSkxqUnMlBFrac5nPanuexLeb422JoxTmZ+HnE/SF103lxEidX+aGsMVJqixrA/+PnhhWYkU3Qnx3l+GgMFhxT3Ti0+rm1dpZIYs00rMksca/b2ivgLXawINGNi5u+J546v3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749921094; c=relaxed/simple;
	bh=TmT0YVfoSuR4QGDRW1J1zcN4ZnpXw15MM4Vk/fX+3dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWKoxzDefEPC97F+1h+PCDSTveo+eegrfWIHAYhTt7EQ0w2WzYDkBJgkeKcNyHQ83enWEVxM5bjzNrvB3t1CD8c8nMvwqsBVNuz/4qhoRZnTxOBqygE/vcvcY6n+3AOB7GBV6OjUbSNxzdb2tnIWvaQn6HgvWqLTdmrOZJS2Umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPOjPIOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE685C4CEEB;
	Sat, 14 Jun 2025 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749921093;
	bh=TmT0YVfoSuR4QGDRW1J1zcN4ZnpXw15MM4Vk/fX+3dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPOjPIOCU8DUDfRCxK2takm5vvZtab8VnCwTJn3uIuL29GChaArT7zjDCsG+PPOaT
	 mnjWmzj49DaFyAFT8qeESF3iBJa+RUNMNhT93W9nKcJXJjuVjkaznqSgzOj4PaRy1S
	 eCLs7Qk9HTkGSBvqZTaT+Kjkxq4gvsiXd9G57aDPmrb5ePahldxCyvcsQTuxSXKvEF
	 5Z2WzfxtQsm2NBDrkVex5LoP9ckqFl7TJDBObhioYMGTXOWFQpinMt2x9eyuxChwp+
	 kueG3GoKB7ylCxyEEdvJY3B3R0sVhaOC6gSMuPy6WSF0VoQdp2cyUmqpROLMqgfmIJ
	 p3bTOPLAHdwuQ==
Date: Sat, 14 Jun 2025 18:11:30 +0100
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, donald.hunter@gmail.com,
	petrm@nvidia.com, razor@blackwall.org, daniel@iogearbox.net
Subject: Re: [PATCH net-next 2/2] selftests: net: Add a selftest for
 externally validated neighbor entries
Message-ID: <20250614171130.GA861417@horms.kernel.org>
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611141551.462569-3-idosch@nvidia.com>

On Wed, Jun 11, 2025 at 05:15:51PM +0300, Ido Schimmel wrote:
> Add test cases for externally validated neighbor entries, testing both
> IPv4 and IPv6. Name the file "test_neigh.sh" so that it could be
> possibly extended in the future with more neighbor test cases.
> 
> Example output:
> 
>  # ./test_neigh.sh
>  TEST: IPv4 "extern_valid" flag: Add entry                           [ OK ]
>  TEST: IPv4 "extern_valid" flag: Add with an invalid state           [ OK ]
>  TEST: IPv4 "extern_valid" flag: Add with "use" flag                 [ OK ]
>  TEST: IPv4 "extern_valid" flag: Replace entry                       [ OK ]
>  TEST: IPv4 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
>  TEST: IPv4 "extern_valid" flag: Replace with an invalid state       [ OK ]
>  TEST: IPv4 "extern_valid" flag: Transition to "reachable" state     [ OK ]
>  TEST: IPv4 "extern_valid" flag: Transition back to "stale" state    [ OK ]
>  TEST: IPv4 "extern_valid" flag: Forced garbage collection           [ OK ]
>  TEST: IPv4 "extern_valid" flag: Periodic garbage collection         [ OK ]
>  TEST: IPv6 "extern_valid" flag: Add entry                           [ OK ]
>  TEST: IPv6 "extern_valid" flag: Add with an invalid state           [ OK ]
>  TEST: IPv6 "extern_valid" flag: Add with "use" flag                 [ OK ]
>  TEST: IPv6 "extern_valid" flag: Replace entry                       [ OK ]
>  TEST: IPv6 "extern_valid" flag: Replace entry with "managed" flag   [ OK ]
>  TEST: IPv6 "extern_valid" flag: Replace with an invalid state       [ OK ]
>  TEST: IPv6 "extern_valid" flag: Transition to "reachable" state     [ OK ]
>  TEST: IPv6 "extern_valid" flag: Transition back to "stale" state    [ OK ]
>  TEST: IPv6 "extern_valid" flag: Forced garbage collection           [ OK ]
>  TEST: IPv6 "extern_valid" flag: Periodic garbage collection         [ OK ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

...

> diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh

...

> +################################################################################
> +# Utilities
> +
> +run_cmd()
> +{
> +	local cmd="$1"
> +	local out
> +	local stderr="2>/dev/null"
> +
> +	if [ "$VERBOSE" = "1" ]; then
> +		printf "COMMAND: $cmd\n"
> +		stderr=
> +	fi

Hi Ido,

shellcheck was recently added to NIPA and it warns about the above as follows.
Could you consider addressing this?

In tools/testing/selftests/net/test_neigh.sh line 21:
 		printf "COMMAND: $cmd\n"
                        ^---------------^ SC2059 (info): Don't use variables in the printf format string. Use printf '..%s..' "$foo".

> +
> +	out=$(eval $cmd $stderr)
> +	rc=$?
> +	if [ "$VERBOSE" -eq 1 ] && [ -n "$out" ]; then
> +		echo "    $out"
> +	fi
> +
> +	return $rc
> +}

...

> +################################################################################
> +# Main
> +
> +while getopts ":t:pvh" opt; do
> +	case $opt in
> +		t) TESTS=$OPTARG;;
> +		p) PAUSE_ON_FAIL=yes;;
> +		v) VERBOSE=$(($VERBOSE + 1));;
> +		h) usage; exit 0;;
> +		*) usage; exit 1;;
> +	esac
> +done

Likewise, shellcheck has the following to say about the above.

In tools/testing/selftests/net/test_neigh.sh line 318:
		v) VERBOSE=$(($VERBOSE + 1));;
                              ^------^ SC2004 (style): $/${} is unnecessary on arithmetic variables.

> +
> +require_command jq
> +
> +ip neigh help 2>&1 | grep -q "extern_valid"
> +if [ $? -ne 0 ]; then
> +   echo "SKIP: iproute2 ip too old, missing \"extern_valid\" support"
> +   exit $ksft_skip
> +fi
> +
> +trap exit_cleanup_all EXIT
> +
> +for t in $TESTS
> +do
> +	setup; $t; cleanup_all_ns;
> +done
> -- 
> 2.49.0
> 

-- 
pw-bot: cr

