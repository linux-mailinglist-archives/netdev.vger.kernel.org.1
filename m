Return-Path: <netdev+bounces-205285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99151AFE0D7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE82E7B01AB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1026E152;
	Wed,  9 Jul 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYSjW75U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1721ABAC;
	Wed,  9 Jul 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044790; cv=none; b=rQcXzF6urYd6bJKGfoPVz8Q8Rcgsp+ZLr8k1uGrcp5GE73E4QJ2MbJZggBbfbIeCmPpRkyrN+OeCNYD17HOPjyAVGR0eTeCY/X9bcIKiD3/qyjLQ+ljHG9FY7vnAsjvu97tdVZgD/qrLYb9AHciGqq+uQ0dIfIMgEsNQ+DkBo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044790; c=relaxed/simple;
	bh=SBeultYsT9Kbc64yCGR/6hiyTPzJ8lgRnQ2ziEfS74k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ia7AlkSGnJoAsqGS0V/S1oMxsn2JG69nS8TgQ9KCUac9qShwcTfszK4kGG0RRso6wfDMXDnxtJKMxYwHVdFCX/lhimsyFpmkEZ4EtsebOoDvuudLU86K6Dh4VZOugezI2DTrItlKw/6wUUNlgVwyJJx9UFinL1qmoLyLgd7tXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYSjW75U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B413BC4CEF0;
	Wed,  9 Jul 2025 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044789;
	bh=SBeultYsT9Kbc64yCGR/6hiyTPzJ8lgRnQ2ziEfS74k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bYSjW75UOwakqAmSqDR1eZ5i3/L5BLb979LAn2AbCxz3/CaGmLWoStZegJEuON7/Z
	 F4DnHy8Wn8ole6wpXjzRdbTNmi/A/4KD1h0ap4IwWIuFhvQRfgdRKtJm/8ZJMaWWyp
	 UJ7rkzmeKvvITTPFbg3oNF7UvtATiKSD2lLvb/u7SWofQisI4gN4KONnbZyTjzZOor
	 kJOErazzfxOHz67VlSz1afTuw6ogmIpTo4sKxbocb3iIhP35chO8rAFC3A/WBtRSxJ
	 BkPolr40RkGvdTdYopJhXd1TDd8+JIJS+gYGwQgCq/EGsztTnb8C5aHKQKzdEkZyv5
	 4cK6SIZtQPqUw==
Message-ID: <da0f1340-34c5-4932-953e-25cad641db87@kernel.org>
Date: Wed, 9 Jul 2025 09:06:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] soft lockup in neigh_timer_handler in Linux kernel v6.12
To: Eric Dumazet <edumazet@google.com>, Luka <luka.2016.cs@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
 <CANn89i+7m8koanZk=47FEhmTHUmOmu-yfViRPayjUct+voQiEQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CANn89i+7m8koanZk=47FEhmTHUmOmu-yfViRPayjUct+voQiEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/07/2025 10:02, Eric Dumazet wrote:
> On Tue, Jul 8, 2025 at 12:54 AM Luka <luka.2016.cs@gmail.com> wrote:
>>
>> Dear Linux Kernel Maintainers,
>>
>> I hope this message finds you well.
>>
>> I am writing to report a potential vulnerability I encountered during
>> testing of the Linux Kernel version v6.12.
>>
>> Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
>>
>> Bug Location: neigh_timer_handler+0xc17/0xfe0 net/core/neighbour.c:1148
>>
>> Bug report: https://pastebin.com/06NiBtXm
>>
>> Entire kernel config: https://pastebin.com/MRWGr3nv
>>
>> Root Cause Analysis:
>>
>> A soft lockup occurs in the neighbor subsystem due to prolonged
>> execution within neigh_timer_handler(), where repeated neighbor entry
>> invalidation and associated routing operations (e.g.,
>> ipv4_link_failure() and arp_error_report()) lead to excessive CPU
>> occupation without yielding, triggering the kernel watchdog.
>>
>> At present, I have not yet obtained a minimal reproducer for this
>> issue. However, I am actively working on reproducing it, and I will
>> promptly share any additional findings or a working reproducer as soon
>> as it becomes available.
>>
>> Thank you very much for your time and attention to this matter. I
>> truly appreciate the efforts of the Linux kernel community.
> 
> Please stop sending duplicates, and 'analysis' AI generated.
> 
> If you really want to help, please provide a patch.


That's the same person which before was sending fake reports, based on
AI hallucination. Just in case - don't waste any time in reading the
reports.

Best regards,
Krzysztof

