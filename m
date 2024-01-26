Return-Path: <netdev+bounces-66264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43783E275
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 20:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3302847A8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909F224DA;
	Fri, 26 Jan 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYJTXNA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2D2233B
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297140; cv=none; b=AXrDaupBqRFxtnXERfp1dMULteSh4KUmLVN3zOE1eubuxWBSMP0ZImIecso3kacP/fipV+JeSEWZXq50AEB8s0h1pv19qD4lzPE/YqNuGW0QpkXerKEQCfcW0GPqFbBjwOJ5NnZj5Bs6DEJJJhsArYnVe/BQbHuoQg7QZfVCSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297140; c=relaxed/simple;
	bh=jOyokAQDp1VEqbrR4LioCps4jtkm8Oe34Q3KLzVhDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnaxzopY2j6Asytknvsx3W4sBQnLf9sbbe7CXuuYEQv9Lc3Q46Y1J861xADQUTzKS/2JSfAE0jqtHf7KHoCHg3VICWiJur4ZvVf+Hw+JLAcH18mhShEtp6NdpD2TXcBIcUY+ymsSuFvfZem+/MlH+hzTsu3Q4IO0yEw5AOb3hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYJTXNA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362A3C433C7;
	Fri, 26 Jan 2024 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297139;
	bh=jOyokAQDp1VEqbrR4LioCps4jtkm8Oe34Q3KLzVhDmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYJTXNA06HHApQ77r8CAc24jqHII640ZUnHGhvQYn2ivM/QhAxqyFE9TNyDSL1KPh
	 ddTxUfpmFUBrbJwu0wW5o96qSmNM5z0z+BUTj6htO88dhNq7RqWAuC8CG3YzLdaejk
	 Rr6FEDDI9MABHgEmHZ+vVjHLkR/ck8QP7f/N9W6fbG01QVmiPGS2f7B/p1Tcv/+ktf
	 SxxtVVStluGB3/1IBdZrwa4bCvVWJBX54BZ7f6Au9Hq0eKWJNK7Mfe1y6FI9CZg6L4
	 tw3dBnVCuNsm6bXIiJRF2CEux7FPql3SvSJcF2JCqYIx9zPciDr+RkJeSbix6+m2yr
	 BWDGydfwE66ng==
Date: Fri, 26 Jan 2024 11:25:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config
 entries
Message-ID: <20240126112538.2a4f8710@kernel.org>
In-Reply-To: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 17:36:16 +0100 Petr Machata wrote:
> The config file contains a partial kernel configuration to be used by
> `virtme-configkernel --custom'. The presumption is that the config file
> contains all Kconfig options needed by the selftests from the directory.
> 
> In net/forwarding/config, many are missing, which manifests as spurious
> failures when running the selftests, with messages about unknown device
> types, qdisc kinds or classifier actions. Add the missing configurations.
> 
> Tested the resulting configuration using virtme-ng as follows:
> 
>  # vng -b -f tools/testing/selftests/net/forwarding/config
>  # vng --user root
>  (within the VM:)
>  # make -C tools/testing/selftests TARGETS=net/forwarding run_tests

Thanks a lot for fixing this stuff! The patch went into the
net-next-2024-01-26--18-00 branch we got: pass 94 / skip 2 / fail 15

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-26--18-00&executor=vmksft-forwarding&pw-y=0

Clicking thru a handful of the failures it looks like it's about a 50/50
split between timeouts and perf mismatch. 

BTW when it says: "WAIT TIMEOUT stdout" that means the runner got angry
because the test didn't print anything for 20 minutes. I'll bump this
timeout to an hour for the next branch, and lets see how many failures
we have left.

