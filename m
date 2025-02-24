Return-Path: <netdev+bounces-169020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B703FA421A9
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B7188D34B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E90243369;
	Mon, 24 Feb 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY3e3h66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479A23BCE9
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404674; cv=none; b=JjwJfvD6kKH58pTTE0HLrCC6svaHlyWSPbOXp2ReN8FCU1S5bV1FRd8maOY53BlQ6VoJ/OH9BWgeqJZp50MbHiNwBeAKus6vchr9aCjz6+8+qFV8e63U8GIPuR+qsh6QOngjbTXyi5rXa6FdCAxK/c5lUlCPDNCU8NX3fTiRqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404674; c=relaxed/simple;
	bh=HX53bO0KAJksNvzKZN0MZEfaDlVJyjY4t4szONmBIY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X49dkRIITvrLy/3BouC1ZUwn1/neaLl56bZ2ecacFdHwIjlXgnMTQEyyYySGSHxWPRSwUKWU6ENHW8iWsk3VqYjAYEijNunRDaU4urtDOrnKAwEjaE0kHoOap8chDZ+BDeuachqXJOq14fACH5Is9u2Zb9sflpK48ycZnGR7d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY3e3h66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495BCC4CEE8;
	Mon, 24 Feb 2025 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740404673;
	bh=HX53bO0KAJksNvzKZN0MZEfaDlVJyjY4t4szONmBIY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rY3e3h66CPPftwVdWnsUU589FhcXb2eUVkTTNGlhvA2e/a5+uGe5AQ2818vKuJCZw
	 RPQj3kIW+hesN15v9kStypYtfzWZw7Im9cxUUhYPnnysB4dJ8gG0qcqSpsVeP9cJkX
	 kf9ZKoSszsXOBg8ctoIHv1zcZ0nrLSEXsN5MeH6hWULZkUj8swir8Q5AuBRVUjB9A/
	 63fAMFp0soit6Crx8EYjHqfJoQZmXSK9oKAXIhzUJ3Owbl2ZiyW1mNDCb/a5/XDSc3
	 kxi/ReMOWqpN4jy0f+NshX6rBxc8/uknMz/UPUbJVOtMb8gU8kadQq3PeuRy5QKaRt
	 tRdSzh5kOiHRA==
Date: Mon, 24 Feb 2025 13:44:30 +0000
From: Simon Horman <horms@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
Message-ID: <20250224134430.GA2858114@kernel.org>
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>

On Wed, Feb 19, 2025 at 06:07:58PM +0100, Pablo Martin Medrano wrote:
> After debugging the following output for big_tcp.sh on a board:
> 
> CLI GSO | GW GRO | GW GSO | SER GRO
> on        on       on       on      : [PASS]
> on        off      on       off     : [PASS]
> off       on       on       on      : [FAIL_on_link1]
> on        on       off      on      : [FAIL_on_link1]
> 
> Davide Caratti found that by default the test duration 1s is too short
> in slow systems to reach the correct cwd size necessary for tcp/ip to
> generate at least one packet bigger than 65536 (matching the iptables
> match on length rule the test evaluates)
> 
> This skips (with xfail) the aforementioned failing combinations when
> KSFT_MACHINE_SLOW is set. For that the test has been modified to use
> facilities from net/lib.sh.
> 
> The new output for the test will look like this (example with a forced
> XFAIL)
> 
> Testing for BIG TCP:
>       CLI GSO | GW GRO | GW GSO | SER GRO
> TEST: on        on       on       on                    [ OK ]
> TEST: on        off      on       off                   [ OK ]
> TEST: off       on       on       on                    [XFAIL]
> 
> Changes in v2:
> - Don't break the loop and use lib.sh facilities (thanks Peter Machata)
> - Rephrased the subject from "longer netperf session on slow machines"
>   as the patch is not configuring a longer session but skipping
> - Added tags and SOB and the Fixes: hash (thank you Davide Caratti)
> - Link to v1: https://lore.kernel.org/all/b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com/

Hi Pablo,

FWIIW, I think this can be moved to below the scissors ("---").

> Fixes: a19747c3b9b ("selftests: net: let big_tcp test cope with slow env")

Checkpatch complains that fixes tags should have 12 or more characters of
sha1 hash.

Fixes: a19747c3b9bf ("selftests: net: let big_tcp test cope with slow env")

Lastly, and most importantly, it seems that there is new feedback on a
predecessor of this patch, which probably needs to be addressed.

- Re: [PATCH net] selftests/net: big_tcp: longer netperf session on slow machines
  https://lore.kernel.org/all/20250221144408.784cc642@kernel.org/

> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Pablo Martin Medrano <pablmart@redhat.com>
> ---
>  tools/testing/selftests/net/big_tcp.sh | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

...

