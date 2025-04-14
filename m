Return-Path: <netdev+bounces-182376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23313A88980
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2661172EDE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95827274668;
	Mon, 14 Apr 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/8TYjC1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4F270EA4
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650838; cv=none; b=XuLQ/Fl2fI+xR2H/Gxf37KWVYFq8cixfrckHoD8IAboLG55ko7OGIzrhNH1/iRv0w5XAKacqdEGYVVR5vd4c+6KmRkriM7tGsFLJXfKvEN29B6h8cttU3qY9ApHhvG7CW2XbtFaPCUp0qSlo+vA5+mgO5lrEJ5kE0RMa8Fb5RKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650838; c=relaxed/simple;
	bh=zyUpIVX0QCk3pxGqIW6VEAq8dDFWNrb9QmuSzx7bpo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmZK9De5TGyk3DaoWbKF6gzJDJ6K6K6VTFyr4mJJEJrhUOoSMWF+/CgUIirTGCAFGOI5xpVR6vmG+2usBUf4zZ8PfZjvp5MR7zN7WBN3mIrWCJijLQtogHtv5LkHVqSWi99aeVuM9uS0UR+aIbH/skB9pZccpSnbADP0f+5uD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/8TYjC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF17C4CEE2;
	Mon, 14 Apr 2025 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744650837;
	bh=zyUpIVX0QCk3pxGqIW6VEAq8dDFWNrb9QmuSzx7bpo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/8TYjC10L6yq2MmNG0Ktbb3noYudyNAjr1dhnjVPTpvhovP8yIXMHPG/LDMxa8tB
	 RN/S+IIIsRxo0E8YOpQX2V9zXUCgt3rQx8AAMw266AN7JAQnqiqec8KR1/naiwmbUf
	 MXEA0WeGsCYYN69zGa9IVaWdPLnBF8JYmF//zZUq3S5LHFQhoms6qOVBCp9P30Pfbq
	 R1mcH7+unkifz/IhIGLC3JQi2GDiMRfo3jyvc53a/95+20sObP3Ijy6+vT9xuzrl4l
	 JPxjZL6uXrTHjPoDSCNKGrjR5MTYf0JqAxxkWqnZnrc3w5mQqSz7yyy6OdGaSIHpjI
	 qKJpVYVmKsZzA==
Date: Mon, 14 Apr 2025 10:13:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [Question] Any config needed for packetdrill testing?
Message-ID: <20250414101348.497aa783@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <Z_0FA77jteipe4l-@fedora>
References: <Z_0FA77jteipe4l-@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 12:52:19 +0000 Hangbin Liu wrote:
> Hi Willem,
> 
> I tried to run packetdrill in selftest, but doesn't work. e.g.
> 
> # rpm -q packetdrill
> packetdrill-2.0~20220927gitc556afb-10.fc41.x86_64
> # make mrproper
> # vng --build \
>             --config tools/testing/selftests/net/packetdrill/config \
>             --config kernel/configs/debug.config
> # vng -v --run . --user root --cpus 4 -- \
>             make -C tools/testing/selftests TARGETS=net/packetdrill run_tests
> make: Entering directory '/home/net/tools/testing/selftests'
> make[1]: Nothing to be done for 'all'.
> TAP version 13                                                                                                                  1..66
> # timeout set to 45
> # selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt
> # TAP version 13
> # 1..2
> #
> not ok 1 selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt # TIMEOUT 45 seconds
> # timeout set to 45
> # selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt
> # TAP version 13
> # 1..2
> # tcp_blocking_blocking-connect.pkt:13: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actua
> l: 60 (0x3c)
> # script packet:  0.234272 . 1:1(0) ack 1
> # actual packet:  1.136447 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 3684156121 ecr 0,nop,wscale 8>
> # not ok 1 ipv4
> # ok 2 ipv6
> # # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 2 selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt # exit=1
> 
> All the test failed. Even I use ksft_runner.sh it also failed.
> 
> # ./ksft_runner.sh tcp_inq_client.pkt
> TAP version 13
> 1..2
> tcp_inq_client.pkt:17: error handling packet: live packet field ipv4_total_length: expected: 52 (0x34) vs actual: 60 (0x3c)
> script packet:  0.013980 . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
> actual packet:  1.056058 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 1154 ecr 0,nop,wscale 8>
> not ok 1 ipv4
> ok 2 ipv6
> # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> # echo $?
> 1
> 
> Is there any special config needed for packetdrill testing?

FWIW we don't do anything special for packetdrill in NIPA.
Here is the config and the build logs:

https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/75222/config
https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/77484/build/

