Return-Path: <netdev+bounces-192902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B191AAC18D0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFD5007F3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2347E9;
	Fri, 23 May 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9Rfqgzf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39142BA49
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958441; cv=none; b=ZXVqI3jSQR0hQ+Us56vCN4g9Magdszzhk84ThtoLakHJkcmKr5SbHi8XaNgrJl7GP8qxsRE2obbqxcXPtgcIjOilK4y98u7pJTKDWQjp0xE42LlsvgkXjImzHF7Bavdr4GGEkyAIcpZh5+fmlOk8bVPE+aMKEkVGbI5onYgc1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958441; c=relaxed/simple;
	bh=wwgwN+X6FgCswo0NVMIOdqq1moMBIqY+x2Fhd2YL7Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjJOIEHtrqHnFijQkPWleiJ5qibTnRN6TaD3PWZ4+X9a3ivKE8uqLcqgutcTlpdsf+Wx03j5AwsJi1tev0EabDE1+cpX0wxN6IJOGUI7E3UZQYQmysPsaIgQyOai8Tx7R3EXqegfJ97HRbaIoW0IeqInCvqWgibTWvLhcaonQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9Rfqgzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881D9C4CEE4;
	Fri, 23 May 2025 00:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747958440;
	bh=wwgwN+X6FgCswo0NVMIOdqq1moMBIqY+x2Fhd2YL7Iw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o9RfqgzfDObQOm6lWf3RBInZmWeAJPGISII8V+ze0uZkIgkxgQsgi2Pm3l3Nrq0LR
	 r7GcVogMfMar1be6EmXQR4CKKT8LMTV3jdBqfGbruumfheGlzkh2bJToDY4DOk6I91
	 yP/mZgfGo2R1GPKjgx+xv2HsIHqCfHN3ztnIxVhr3Eg8jRsWfwhyR6i1T/1nQWj1eP
	 p6BS1RK5GXxWrGHAKJcT7cl22bTne42GiTXzvCWPEY7YnzrThMufj5AYnyXm++Tok3
	 Ssh9PxuLaB+jDnvP3ztCDFPQNbfcgjCKUPYnF2U8oTI5Je20kTBEUj9d6QgCutxMf1
	 NPXz6kga2iY0g==
Message-ID: <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org>
Date: Thu, 22 May 2025 18:00:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: Luca Boccassi <bluca@debian.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Yuyang Huang <yuyanghuang@google.com>
Cc: 1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 4:55 PM, Luca Boccassi wrote:
> On Thu, 22 May 2025 at 20:41, Adel Belhouane <bugs.a.b@free.fr> wrote:
>>
>> Package: iproute2
>> Version: 6.14.0-3
>> Severity: normal
>> X-Debbugs-Cc: bugs.a.b@free.fr
>>
>> Dear Maintainer,
>>
>> Having iproute2 >= 6.14 while running a linux kernel < 6.14
>> triggers this bug (tested using debian-13-nocloud-amd64-daily-20250520-2118.qcow2)
>>
>>     root@localhost:~# ip monitor
>>     Failed to add ipv4 mcaddr group to list
>>
>> More specifically this subcommand, which didn't exist in iproute2 6.13
>> is affected:
>>
>>     root@localhost:~# ip mon maddr
>>     Failed to add ipv4 mcaddr group to list
>>     root@localhost:~# ip -6 mon maddr
>>     Failed to add ipv6 mcaddr group to list
>>
>> causing the generic "ip monitor" command to fail.
>>
>> As trixie will use a 6.12.x kernel, trixie is affected.
>>
>> bookworm's iproute2/bookworm-backports is also affected since currently
>> bookworm's backport kernel is also 6.12.x
>>
>> Workarounds:
>> * upgrade the kernel to experimental's (currently) 6.14.6-1~exp1
>> * downgrade iproute2 to 6.13.0-1 (using snapshot.d.o)
>> * on bookworm downgrade (using snapshot.d.o)
>>   iproute2 backport to 6.13.0-1~bpo12+1
>>
>> Details I could gather:
>>
>> This appears to come from this iproute2 6.14's commit:
>>
>> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?h=v6.14.0&id=7240e0e40f8332dd9f11348700c0c96b8df4ca5b
>>
>> which appears to depend on new kernel 6.14 rtnetlink features as described
>> in Kernelnewbies ( https://kernelnewbies.org/Linux_6.14#Networking ):
>>
>> Add ipv6 anycast join/leave notifications
>>
>> with this (kernel 6.14) commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33d97a07b3ae6fa713919de4e1864ca04fff8f80
> 
> Hi Stephen and David,
> 
> It looks like there's a regression in iproute2 6.14, and 'ip monitor'
> no longer works with kernels < 6.14. Could you please have a look when
> you have a moment? Thanks!

were not a lot of changes, so most likely the multiaddress or anycast
address changes from Yuyang Huang. Please take a look.

