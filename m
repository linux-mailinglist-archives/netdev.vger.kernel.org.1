Return-Path: <netdev+bounces-284792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPHhEZEj+2mQWwMAu9opvQ
	(envelope-from <netdev+bounces-284792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A676E4D9AA5
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD6D9300D15D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BEE368275;
	Wed,  6 May 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="rf3U4Sl6"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3113469E0
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066318; cv=pass; b=UbBv6X0kFgRAtLFP01vDJILeMWImF45wYD8CZ6HV66wRyrXA8bGtjhdtYtgE4p7emGSZG7dl2QZfO08HqSe7pUkdn1ADtaDBR1yEz9YTWVfUOdbmL4cZg8QyRlSSa3mcu1G9g/UnREgMRq1Y6h0h4CRwMb3w+m6PQYYJpyeY1Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066318; c=relaxed/simple;
	bh=1ssYjzuVWIdnYCaye4Kkr2TBcRhyyFLVRe3BgMhzN9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QecEwfUQAMHRFnusP5t6hPOTv9X8rm6l0XOmM2mmY81B79iBjRHSIYkkPTPldsrXb8N0xYyBcDmARCC4kHxQ9Oj7b5j97enmjlKcNnUdb/V8LvgwCQVSK1O3OQya7mVGrn924H0pCOJ2RhTutungiYFfsoAao05mqFM0vLI9dfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=rf3U4Sl6; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1778066288; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NH8i/ogrQV6CNFuplDlVjzlqJnE3m42v9ZyhUyyoDHVwQuOzNWuusuV8s2cJMVQ9i8tKmvGcjTiYH0uYzzIax/vqmULpCYm0kGMqWgM3uKL6jbVcDhzceaP8zwoEiijKOqz19T8KPxgv9EPkTLt4vKDsAcfeI7+HqpslaSyU9u8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778066288; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R3oPaIkp4nS29Lkr8+uLYS7keKwoJxX56jFTR99zYkc=; 
	b=S1B+7Unp/Qb/7x5Eaq23RzbH4RMSpP61R4Nwgy/Wpmozj3SjySZ2dlukh3ft9piL2q1NfZ3OXPU79C0Ncl+C2j3pT+ufk63hBq1ctjwzvk98BqWCRJC9P757glRMAdYmv1CqF+getvBEeHUjDh3QV2p4kp3J/XI6/tl1CfzrGoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778066288;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=R3oPaIkp4nS29Lkr8+uLYS7keKwoJxX56jFTR99zYkc=;
	b=rf3U4Sl6pHdRN5zX7JwsYkz4r7FuU03iw8/D2CiBWUtD7BLUNPXcEcGPDdaAvyDy
	P0cg1Ag1yqqIe5M34+CVPP5uCYgY0EJLiySF+wrmZJwLCxaqIfZcgZ1Vgpl1GfAAtB6
	h/RvEQOw2vA+80GkaS3Syva7+5Wf3wEKwFTftghGxfKg99UDj/2Lrg0aNAWTVbohzpR
	wDUK5R7/Lfikc0xtwx33rCWNxGn38vHMQVYlz9xXCYPfcLtZlpSwxgmRpxDJkpBAltX
	uzFoxScWZZV2n2jUqqzj95tWAQQgJjdPcfEB0vLbK2yi6XrwPplhoeGtqJK6KUVg2c+
	wIkiAwTa7A==
Received: by mx.zohomail.com with SMTPS id 17780662844593.1625433326158827;
	Wed, 6 May 2026 04:18:04 -0700 (PDT)
Message-ID: <7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
Date: Wed, 6 May 2026 13:18:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
 <20260505172234.3348a81b@kernel.org> <20260505172317.089fb380@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260505172317.089fb380@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: A676E4D9AA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,machnikowski.net:dkim,machnikowski.net:mid]



On 06/05/2026 02:23, Jakub Kicinski wrote:
> On Tue, 5 May 2026 17:22:34 -0700 Jakub Kicinski wrote:
>> On Tue, 5 May 2026 09:36:30 +0200 Maciek Machnikowski wrote:
>>> On 04/05/2026 19:07, Jakub Kicinski wrote:  
>>>> On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:    
>>>> Doesn't seem to pass on netdevsim for us:
>>>>
>>>> # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
>>>> # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
>>>> # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
>>>> # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
>>>> # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
>>>> # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
>>>> # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
>>>> # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
>>>> # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>
>>>> Anything we need to do?    
>>>
>>> Can you share the config file you used? Seems the PTP clock was not
>>> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?  
>>
>> You have to add it to the relevant config.
>>
>> Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system
> 
> Sorry, wrong link, this:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
I did follow the guid, ran the test on the vng environment and it still
passed the test. Is there more debuggability on the CI system? Can you
share the .config file it generated while running the test? Or the
commands it tries to run so I can verify them locally?


The commands I ran were:

make mrproper
vng --build  --config tools/testing/selftests/drivers/net/netdevsim/config
vng -v --run . --user root --cpus 4 -- tools/testing/selftests/net/ptp.py

The tests were done on the ARM64 Fedora 44 with the default kernel
6.19.14-300.fc44.aarch64 running inside the Parallels Desktop VM.

