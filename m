Return-Path: <netdev+bounces-65222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D400839B3F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73EC1C20C42
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A639848;
	Tue, 23 Jan 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJPfuzz5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EB4C67;
	Tue, 23 Jan 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045967; cv=none; b=tuv1O/3Lig6y2PQT870y8XX9NlDk3vsgUx2pbSo+K90DcTkBQuji/y/9+xjZNaZCmFoqCUE9qYrj5UugrzNIlgq3kaUGOjewoQb9QvCzSlxFhiyO58UdQyDDR3zqcKJtTr/BxuKQ7IiYikRUg6L8HHpK/CDiuW2hd8E8GDv4gWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045967; c=relaxed/simple;
	bh=12DaKj8qRBTlO68I4P8DGOXXTtnkesO6+YCEGyEfx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHA7ULTLUvvo2hwZfmL6UUHFv4atiPB8i6wc7r2u3iZgBYudD9D6HfVJuqGNO0rtSHEMxzs5PKof/c+Sk5RszZkOalOSv1CzoWspK9j3BgMMF/PRk/izZWGP4IKzUDvr2s1S3i3qV1UytpjtHpDkqb/LOW+vqgGGW/XFaUZCL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJPfuzz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D04C433C7;
	Tue, 23 Jan 2024 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706045966;
	bh=12DaKj8qRBTlO68I4P8DGOXXTtnkesO6+YCEGyEfx+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dJPfuzz5+zWvvU3jKH0tShnDih4HWlJbP3cNACaXRnK+LL0KBivTA3niZfPckPQIN
	 AxGO4/B2b0Qy8CNkmvWgLswlXtNJo5LLNpJyD0I1S64rhAtwJnaF6HHY+tWkTLaJ6R
	 mgii9al+3s+yM95XLsmOuXLYTW3sloI60MYlx1YqmIISKQOFQADPCQbT+2d6zHiupy
	 jKyBfEsPIcTGIBwfdkBesiGe3AyU3MRtAzD+kbT8M02TidlECoffH0hIbWYfTxKHEo
	 +ZmqwARoLwC/tA1jaBtDN3wRgOJU6uhtHjivYJkwlI1hk9fPfJyXxEXnSjYw14E6A9
	 0a3yh/KQQMOZA==
Date: Tue, 23 Jan 2024 13:39:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123133925.4b8babdc@kernel.org>
In-Reply-To: <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 09:51:07 -0700 David Ahern wrote:
> Really cool. Thanks for spending time to make this happen.
> 
> Scanning the tests I wrote, I think most of the failures are config
> related. e.g., fib-nexthops.sh needs MPLS and those config settings are
> enabled in tools/testing/selftests/net/config.
> 
> Another one, fcnal-test, needs nettest built. From
> https://netdev-2.bots.linux.dev/vmksft-net/results/432660/36-fcnal-test-sh:
> 
> # which: no nettest in
> (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
> 
> It is in the Makefile, so how should that dependency be defined for this
> new environment?

We run the tests with 

  make -C tools/testing/selftests TARGETS=net run_tests

the binary is there:

$ ls tools/testing/selftests/net/nettest
tools/testing/selftests/net/nettest

The script does:

if ! which nettest >/dev/null; then                                             
        PATH=$PWD:$PATH                                                         
        if ! which nettest >/dev/null; then                                     
                echo "'nettest' command not found; skipping tests"              
                exit $ksft_skip                                                 
        fi                                                                      
fi   

But that's not exactly the message that gets printed up top.
Is it coming from lib.sh? Not sure..

> Finally, how can people replicate this setup to validate changes to get
> everything work correctly?

You can run the exact scripts the CI runs, they are pretty standalone.
But they don't do any magic, really, I'd start by trying the steps I
outlined in
https://lore.kernel.org/all/20240123093834.23ea172a@kernel.org/
and if you can't repro the failure LMK, I'll share more instructions
on replicating exactly.

