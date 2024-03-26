Return-Path: <netdev+bounces-82205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D589B88CA20
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601BA1F81782
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDD13D533;
	Tue, 26 Mar 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJqXVN6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E113D528;
	Tue, 26 Mar 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472542; cv=none; b=cUIMAn2f3RIcyVZVZoqUJcIypw2PgfjlcnH7bwfXUNRejuccp0QpLen1HfEWBqa/tNkFMFA+lq5yq3IcmpjczTCJY05SXGnp0OdD/6qFu+SEprFCdsYn7GV3zw/yoD7/P4567E7bIIbJFcBSTCIrV5ojtsaqs+PLrwI9V74MadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472542; c=relaxed/simple;
	bh=o5QNpHgBmscUL7nafvXWlTtMo6ETkFbO2P7BD8OWaqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDvmJk0MlWpWnE8MIs+rvXXVca0qxVFXXMZq8Mjel192o0ROQGKHAunteqC5mRi1smgPZizDVXkg/1LIcVWopB4vUANbc1iJeMlLHGmnL2wUiHJbM31jhg1kYzQBhfCPYYA3rLduWTk+YLdN+/1HwMg3RfRLSOJELIC9WW8xOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJqXVN6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351ADC433C7;
	Tue, 26 Mar 2024 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472541;
	bh=o5QNpHgBmscUL7nafvXWlTtMo6ETkFbO2P7BD8OWaqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJqXVN6gAqTJtRW3lrAE8W592DbHU3oIy2g9S9MHrn0HozAy+utKG6pxkCmjqL9A4
	 ktFujnQithqpifl3PSNcbTv6aHLAmyHrYWGSrOr2EnERP8GsB3/9O2+sUKXwVXj4YQ
	 4pcO/RT9hzJ1JURaVlnIpyZ2PDUB3gKxuOIni/usHDeIZPLP8+SaBBaA5WYL3dU25y
	 S+jGo5YTt+Aldr+Mr79/56vJijvueyjhOSGHL7W1IY9p5XDfkdd6MbN2yeL8wVUBim
	 10HiXlKsqS2h4utQmeFI7bNT18VCuJNyp01VHY+yABt0lTEpTqoEDCQFSpDE52mqgU
	 NRmqeFzcm5K1w==
Message-ID: <07677234-6440-407e-9b01-55f86028af66@kernel.org>
Date: Tue, 26 Mar 2024 18:02:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] VirtioFS instead of 9p
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
References: <20240325064234.12c436c2@kernel.org>
 <34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
 <20240325184237.0d5a3a7d@kernel.org>
 <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
 <20240326072332.08546282@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240326072332.08546282@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:23, Jakub Kicinski wrote:
> On Tue, 26 Mar 2024 11:27:17 +0100 Matthieu Baerts wrote:
>>> "All you need is to install" undersells it a little :)
>>>
>>> It's not packaged for silly OS^w^w AWS Linux.  
>>
>> Thank you for having tried! That's a shame "virtiofsd" is not packaged!
>>
>>> And the Rust that comes with it doesn't seem to be able to build it :(  
>> Did you try by installing Rust (rustc, cargo) via rustup [1]? It is even
>> possible to get the offline installer if it is easier [2]. With rustup,
>> you can easily install newer versions of the Rust toolchain.
>>
>> [1] https://www.rust-lang.org/learn/get-started
>> [2] https://forge.rust-lang.org/infra/other-installation-methods.html
> 
> I know, I know, but there's only so many minutes ;)

I like your idea from the bi-weekly meeting of using Docker (or similar)
for that. It looks like virtiofsd is in Debian testing (not in stable
yet) and in Ubuntu 23.10 (what we are using for the MPTCP CI, from a
Docker image).

- https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
-
https://github.com/multipath-tcp/mptcp_net-next/blob/export/.github/workflows/tests.yml#L78

>> Do you need a hand to update the wiki page?
> 
> Yes please! I believe it's a repo somewhere, but not sure if it's easy
> to send PRs against it. If PRs are not trivial feel free to edit the
> wiki directly.

There is a repo [1], but we cannot send PRs [2] :-/

So I just did a few modifications [3] (thanks for letting me doing
that), feel free to review :)

[1] https://github.com/linux-netdev/nipa.wiki.git
[2] https://github.com/orgs/community/discussions/50163
[3]
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style/_history

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


