Return-Path: <netdev+bounces-65146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D7839588
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB71C25E4A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5735FF0C;
	Tue, 23 Jan 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpsF6rVT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833368005B;
	Tue, 23 Jan 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028669; cv=none; b=Dtyy78HBejjOvgz+5jHmIJOqi6U8F+CPU6TeNzk0bQD2pwGxEF763jPFO+xak42GMutgr0VpAb5F20T1bejE1Qt6pE8NJTMS36deaOfdh1NNMo0EXFoMDvXjh89RhJBC0dgUcypJqfTDoRblZCk5KdUnnmlNqgLL7keh8dpNUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028669; c=relaxed/simple;
	bh=LMBhR8JookI+8R1JOsGVB9zSCkMJzCkO8TEJo4by0ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1b3tgeWfl9XnjFDamLxdToKWbTviZQlK1U95NUhRtFY8hayvOT6YhV3GNnlqDl/AJcaXXov2Zr7q0m9xD/ZGiSuEd177+OKdtYJZr4yrJk9LTMbmdmbUUi6GedYL9LGGtYlwVxnOxlaP3SPWaKszjEkft1xVg3OMAHwGUQYEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpsF6rVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52D9C433C7;
	Tue, 23 Jan 2024 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028669;
	bh=LMBhR8JookI+8R1JOsGVB9zSCkMJzCkO8TEJo4by0ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZpsF6rVTPmjDBH8hnYd5GWVi66JYjmu1aO2woCzxHzhONNMKPfKtA9r5lbdqSerMD
	 yExPLpkq4ITriGf/A+gtEcy3JsatvyJ6qwqP6gJuYfahaow1VuHt8B67ntYvZ2PQBr
	 NBOHC+DjuYogR5QlqlxeI/RkMhLx+3c+cwiQ6KV8nakXGc6vRus/JyriB/wGSa//Rm
	 /kPA2B29r3aX3etiDIy572Zr0YBLcNfXCd76wLyXTMtvNZfRSE93AhO/GUufKi/KDg
	 xy9yHBgpAeWOloE8bus6D0nm84Xcfa4RNR+oYT1Ig6kD22FAZHS/z+10DDJEhg0AeZ
	 2WXMjQS+TTC+w==
Message-ID: <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
Date: Tue, 23 Jan 2024 09:51:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240123072010.7be8fb83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 8:20 AM, Jakub Kicinski wrote:
> On Tue, 23 Jan 2024 16:45:55 +0800 Hangbin Liu wrote:
>>> Over the merge window I spent some time stringing together selftest
>>> runner for netdev: https://netdev.bots.linux.dev/status.html
>>> It is now connected to patchwork, meaning there should be a check
>>> posted to each patch indicating whether selftests have passed or not.  
>>
>> Cool! Does it group a couple of patches together and run the tests or
>> run for each patch separately?
> 
> It groups all patches outstanding in patchwork (which build cleanly).
> I'm hoping we could also do HW testing using this setup, so batching
> is a must. Not 100% sure it's the right direction for SW testing but
> there's one way to find out :)
> 

Really cool. Thanks for spending time to make this happen.

Scanning the tests I wrote, I think most of the failures are config
related. e.g., fib-nexthops.sh needs MPLS and those config settings are
enabled in tools/testing/selftests/net/config.

Another one, fcnal-test, needs nettest built. From
https://netdev-2.bots.linux.dev/vmksft-net/results/432660/36-fcnal-test-sh:

# which: no nettest in
(/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)

It is in the Makefile, so how should that dependency be defined for this
new environment?

Finally, how can people replicate this setup to validate changes to get
everything work correctly?

