Return-Path: <netdev+bounces-65333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF7883A145
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C5F2833EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D0CA7A;
	Wed, 24 Jan 2024 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2GE0/Qs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DAFC155;
	Wed, 24 Jan 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073625; cv=none; b=NOGfRVXrK75M9/dpSqzgp/X8ZyotZkSfe0pPM34YbK46RJbdRvYhVBqjJek6YSYH/8Efo/KP677YvkR8AJUMrik+gVzxLpCV8X/HkylSvrVVrZS3JPDMS20IGj5dl12zY2A0YSKUn8/39iBp5lDm1C0tLcZxQAElFC95f6gIHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073625; c=relaxed/simple;
	bh=1W8TfZj8wGevQJsmTnSNOTVde9ENHGHXiAOCqamjxhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz8Yr0D3eZYZHK0Ebn4zWgcmXdQyhLPSqi/BtQi1B2/nX/A8NCRrOdqmsuNDdnfNKK+nUGGlaKagQqruKwo3ZBfAuU7ThEOcG8C/ann5ZVNHGUcYbLLoPs7Iu3aOrLu+V5Z4CBrIIAouyNAYfxstuGNk6uSgrpQMhZr3O6CNHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2GE0/Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1FCC433C7;
	Wed, 24 Jan 2024 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706073624;
	bh=1W8TfZj8wGevQJsmTnSNOTVde9ENHGHXiAOCqamjxhc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i2GE0/QsknhSIWFoox+nPRPHFu0aJUjg87UWq/QCSTYCTCDpj+XlEnRLmSq7OwkNN
	 V2TVzK/uIqUaPr3WBuhVMl9eB7dwE1i3UJvm7fjfbRb4yRGSnWzbMsLnv/4HvwHvAE
	 AJ5kJaVwAUNlDuMPM/UR1jZgWnhdpwG2LR96kdJWLvNqEZPiTyM0X//0jYajDsJXuV
	 teph5wdOh4tPXEeNQ+qx7Flro9eXP+r7jgZ4RvG+e3I9sL57CglWAv67tvCwCwSCFZ
	 Ksu4OGxkZ9J3dGfLdp+jnFRqY6/l/JuMpP2pLm6FQNpz31ehi7UtCyF59y2zHsKWbw
	 QQZJF0KLuN9Bg==
Message-ID: <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
Date: Tue, 23 Jan 2024 22:20:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <20240123133925.4b8babdc@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240123133925.4b8babdc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 2:39 PM, Jakub Kicinski wrote:
> On Tue, 23 Jan 2024 09:51:07 -0700 David Ahern wrote:
>> Really cool. Thanks for spending time to make this happen.
>>
>> Scanning the tests I wrote, I think most of the failures are config
>> related. e.g., fib-nexthops.sh needs MPLS and those config settings are
>> enabled in tools/testing/selftests/net/config.
>>
>> Another one, fcnal-test, needs nettest built. From
>> https://netdev-2.bots.linux.dev/vmksft-net/results/432660/36-fcnal-test-sh:
>>
>> # which: no nettest in
>> (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
>>
>> It is in the Makefile, so how should that dependency be defined for this
>> new environment?
> 
> We run the tests with 
> 
>   make -C tools/testing/selftests TARGETS=net run_tests

thanks for the tip to direclty run the tests.

> 
> the binary is there:
> 
> $ ls tools/testing/selftests/net/nettest
> tools/testing/selftests/net/nettest
> 
> The script does:
> 
> if ! which nettest >/dev/null; then                                             
>         PATH=$PWD:$PATH                                                         
>         if ! which nettest >/dev/null; then                                     
>                 echo "'nettest' command not found; skipping tests"              
>                 exit $ksft_skip                                                 
>         fi                                                                      
> fi   


This fixes the PATH problem:

diff --git a/tools/testing/selftests/net/fcnal-test.sh
b/tools/testing/selftests/net/fcnal-test.sh
index a8ad92850e63..0c5ac117155d 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -37,6 +37,8 @@
 #
 # server / client nomenclature relative to ns-A

+PATH=$PWD:$PWD/tools/testing/selftests/net:$PATH
+
 VERBOSE=0

 NSA_DEV=eth1

but given the permutations it does, the script needs lot more than 45
seconds. This does the trick, but not sure how to bump the timeout for a
specific test.

diff --git a/tools/testing/selftests/kselftest/runner.sh
b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..9e7dcb728249 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -9,7 +9,7 @@ export per_test_logging=

 # Defaults for "settings" file fields:
 # "timeout" how many seconds to let each test run before failing.
-export kselftest_default_timeout=45
+export kselftest_default_timeout=3600

 # There isn't a shell-agnostic way to find the path of a sourced file,
 # so we must rely on BASE_DIR being set to find other tools.


