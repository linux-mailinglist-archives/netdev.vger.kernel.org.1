Return-Path: <netdev+bounces-68004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620EA845933
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BA81C22A70
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD85D464;
	Thu,  1 Feb 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QU63Efcd"
X-Original-To: netdev@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842815CDDC;
	Thu,  1 Feb 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795194; cv=none; b=vC3Ish0eQIr3n0AQIJlD3z1NZ86Wrf+BQ2bzmikLFgST1fGltVi8neJQgZs0ihShoK2LHGM2lrunZM2J5vt+s4w6ybjGTxo3e0rHkWr1biAfQbz/bSz74c5SJfQZQpQ1veh4vmEODa9uenw6okPzqhU0Rq5m9eF7EL3T0jL53z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795194; c=relaxed/simple;
	bh=8HzbJjSDw40BQckfQ5DmQ1vt4SKQZRYZHqnq/H5QnUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHUbOuXGaInIl9VBYt8UEoK+xZcoWUS7qEQnzafHT/QXmV+RNcbjwA/gdl1V343XOh8TTinYnVYdUjMmuK9go7aCuMo/UJBgfYbcJiBoyRdDii1nNaNSge8p9vYWVNhJEAzv8q5RcDPMsQo/Prfai9Bl6zQO/iYHUqjohFb/3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QU63Efcd; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7DACA5C010F;
	Thu,  1 Feb 2024 08:46:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 08:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706795189; x=1706881589; bh=h0j94G65/WWfShGftOmEJm81l78Y
	K/dtlVWYptd7Nw8=; b=QU63EfcddcpKggujAZ3dlLkO4RJr9OJ4dSIJ8SJMokJQ
	r0zXto+BttGc6HYETAoBB6L0L6LABiRZuEZ+3LjBfhKdqE2e0GL6fo74zuEgCh0H
	/T78UteJGnq4pY02qaOOVaeCUjj9evFILvxo00IKdiuSmJ+EB/hztRNnnCznyQ8O
	TLmtG81SpclZoHXhnO3skxADs7mwcJPp+5qXaQ1n9Dfo8cmXpFMUTwauIn2o3xZj
	ix8QBdk+uv6NPy+WnaUsvAJFwEopSv7M9EmtU2JIwwzOnzH9DqvSPXkJRNlN13dr
	ynyNHxY5k48XaErkaR2OiGAdODxhTH5sHCCmQJSS3Q==
X-ME-Sender: <xms:taC7ZTCbbXrRqKAYQZElTtTGqBbzcXXsKypQ-0dJ-fcLZF4IGB-lkw>
    <xme:taC7ZZhPTpI_sHdevRe_I7YQjCX88AMjgKcyXcJg4Z78HN6hSOc3dbFOaWuHDRx55
    dkPz70rivk7kQs>
X-ME-Received: <xmr:taC7ZenLWs5gP8vOeXcti6QJHU1QrCYBG3J-cclSAsM6QFJGGE1m-QYxDwEj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpefgudekvdekvdefkedtfeduhedute
    ehiefgudfgueeiueeggfefjeetfeelhfdvkeenucffohhmrghinheplhhinhhugidruggv
    vhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:taC7ZVyUi73AnkzBiJrdorFkA-cGx5h8HL9NWfCzpCdk31dZAK4fgA>
    <xmx:taC7ZYSXzOS2KN5Pai1-_RXTOmiNvbzb5ehs_Ge7-bShghGMI6EgbA>
    <xmx:taC7ZYa30-Ha-ZGkMYk1c9cTbxrEbtATuy-sot9BP402PMHm1s3kTw>
    <xmx:taC7ZR4dVFYiSp06k050y1GqJuDnvVTwKgF1K52NDPwBMwi0mfpUsw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 08:46:28 -0500 (EST)
Date: Thu, 1 Feb 2024 15:46:23 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <Zbugr2V8cYdMlSrx@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
 <ZbedgjUqh8cGGcs3@shredder>
 <ZbeeKFke4bQ_NCFd@shredder>
 <20240129070057.62d3f18d@kernel.org>
 <ZbfZwZrqdBieYvPi@shredder>
 <20240129091810.0af6b81a@kernel.org>
 <ZbpJ5s6Lcl5SS3ck@shredder>
 <20240131080137.50870aa4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131080137.50870aa4@kernel.org>

On Wed, Jan 31, 2024 at 08:01:37AM -0800, Jakub Kicinski wrote:
> FWIW I started two new instances on bare metal one with the same kernel
> as the nested VM and one with debug options enabled.
> 
> selftests-net/test-bridge-neigh-suppress-sh
>  - fails across all, so must be the OS rather than the "speed"

Yes, it's something related to the OS. From the log below:

```
 COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
 Raw IPv6 socket: Operation not permitted
 TEST: ndisc6                                                        [FAIL]
     rc=1, expected 0
```

The test is supposed to be run as root so I'm not sure what this error
is about. Do you have something like AppArmor or SELinux running? The
program creates an IPv6 raw socket and requires CAP_NET_RAW.

> selftests-net/test-bridge-backup-port-sh
>   - passes on VM, metal-dbg
>   - fails on metal :S very reliably / every time:
> https://netdev.bots.linux.dev/contest.html?test=test-bridge-backup-port-sh
> 
>   # TEST: No forwarding out of swp1                    [FAIL]

Passes on all setups:

https://netdev-2.bots.linux.dev/vmksft-net-mp/results/446482/12-test-bridge-backup-port-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/446481/7-test-bridge-backup-port-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/446481/12-test-bridge-backup-port-sh/stdout

With this patch:

https://lore.kernel.org/netdev/20240201080516.3585867-1-idosch@nvidia.com/

Will submit v2 next week.

> selftests-net/drop-monitor-tests-sh 
>  - passes everywhere now

Nice, thanks

