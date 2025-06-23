Return-Path: <netdev+bounces-200280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526FAE4527
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7F7A3FEE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CB2472A2;
	Mon, 23 Jun 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB9MrurJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285F4C6E
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686234; cv=none; b=LnF0ciak6X2E9vsGfRSicxx/VIMdYIvNRsmxgLtXI1jPdkyv/l9Chpi08Djs7hKjMqQOThSII29Xt7RHlInrasV42Hd0EQSfvpBEx3OnQNRGEAyZVJFcB7W59vHTFDNLuT6j7yjanLm+cMg+JuXKVA6Jx6+I0+gzxIynjm92AuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686234; c=relaxed/simple;
	bh=58InhjZ/Xchsh2WLn7Skdn6Ru9MX59NMi5dTHwRNJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyhhHh5Od8k0XacKv7VupUruOsL3z8fSiT+pBVkQgJru7wWOT+yG7oD+PBbzITaokPraDuVqwlntLx3vG2xLge7PnZevS9wcbnUzcGSqSwWpj3wxiMYRH0AMnz5t0ZkfaGZXcUzSjLHlSmnAAR/osZ9gXHNPTcAIFwJkHlfkwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB9MrurJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E3C4CEF0;
	Mon, 23 Jun 2025 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750686234;
	bh=58InhjZ/Xchsh2WLn7Skdn6Ru9MX59NMi5dTHwRNJGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YB9MrurJ/6mVs7/g1EFT4/Z1WIloDNAaDomdOOPJhzLI6SjZ3hO+4mSlWvzzy9+ij
	 IgTFhAmxb0A2axqzvfUYU1Eqa/u5Ieyw+9LSMlkZLRlkPWQ3eV2Gs42Uy7XsZteTjA
	 tpcOU4d+iBHxb5UF3j6yD4own6nlEkLf3/0t2o0prPNs6sYVbDZI/g/zzeohVy22Ic
	 u2NB45nvttwqiOBQ4eVGrvnFk+lnJ1dvwBCSdbCOWtAT540tGVpU8CGVA+J61GYDU2
	 rN5xWZJeh8sP6zyVQrf0plxqd666Gmth0Yhg3mOQfCp4I1jxufFhQAwQCxWqOZtiBn
	 GvteOlKXptdSg==
Date: Mon, 23 Jun 2025 06:43:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
 stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Add tests for
 restrictions on netem duplication
Message-ID: <20250623064353.2c3e6cd5@kernel.org>
In-Reply-To: <20250622190344.446090-2-will@willsroot.io>
References: <20250622190344.446090-1-will@willsroot.io>
	<20250622190344.446090-2-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 19:05:31 +0000 William Liu wrote:
> Ensure that a duplicating netem cannot exist in a tree with other netems
> in both qdisc addition and change. This is meant to prevent the soft
> lockup and OOM loop scenario discussed in [1].

An existing test seems to be failing now, please adjust it:

# -----> prepare stage *** Could not execute: "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicate 100%"
# 
# -----> prepare stage *** Error message: "Error: netem: cannot mix duplicating netems with other netems in tree.
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=19> *** stderr ***
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 535, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 419, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/nipa-data/kernel/tools/testing/selftests/tc-testing/./tdc.py", line 267, in prepare_env
#     raise PluginMgrTestFail(
-- 
pw-bot: cr

