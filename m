Return-Path: <netdev+bounces-64520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4E835902
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 01:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020FFB216DA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87372367;
	Mon, 22 Jan 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIJCCUcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE1364
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705883917; cv=none; b=gEe9IdQFzQZ4g5NGkkWYld9Nk+e3ckxB4SE6tInZROjsOFp7fHNMslXo2zNoG3FE0xmoCMTG+3Hhgvn0hTEZBWJIZagPiMaYy6Ak9iYy3HE817D7g65WvcH6gMoK4473oSUpEMBZ+iMIyKuUKakUAYeYSXMEdk45dlL0fBN1W5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705883917; c=relaxed/simple;
	bh=qiMfI6DGLmqJD+Wo4MISOB5vKezrAIIkMn4CqKsTD6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6Uo9lXfX9zUwjLBqrr0GoQux28KJAPo/xbIhaMDJCH9uJQdUGa4son00qxTQd6pIG16UhA1eLl0hRwTCcXcfnoi12Lf0nTMy2ipsq4a7/sbsSO+ppciGO6OKGL0+/0KwK7Wkez4gJJvcBjReY6TIY0un8mFnGJs3bsZU0fKUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIJCCUcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C1CC43390;
	Mon, 22 Jan 2024 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705883917;
	bh=qiMfI6DGLmqJD+Wo4MISOB5vKezrAIIkMn4CqKsTD6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIJCCUccor1ZPXHFfYymiAyibn42BP53pQCGSreZMLBITcjfcy84FnZrK9E2ii2zX
	 edLVL+5NXOTM0aJxav07G6XIdZgeOvCuxTm1by9ziRGNVtmT2Mc3KnhlLN1upHaaML
	 REv2I3CsKadIiRfx4jfe90+paeoI2vHXGrkbAbOzqQhsapSw6EVlkCx6JYmIUdY/qt
	 DmYWOrfEY+bf03KhyEDD2PuQ6h4nz1DAv72nylGEIhkdlEGL68qzdZJKRBL/q+4pil
	 /CCW5RAOjI7t9O3bkNFNX3gKvEWqqaN/AyNg604dkUxAxf3u27g0mWz6z3BXa7rEnD
	 sAQt719d7DGxA==
Message-ID: <9c01855e-fc0b-4bad-8522-232b71617121@kernel.org>
Date: Sun, 21 Jan 2024 17:38:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Having trouble with VRF and ping link local ipv6 address.
To: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>
Cc: David Ahern <dsahern@gmail.com>
References: <6f0c873e-8062-4148-74c2-50f47c75565f@candelatech.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <6f0c873e-8062-4148-74c2-50f47c75565f@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/21/24 5:29 PM, Ben Greear wrote:
> Hello,
> 
> I am trying to test pinging link-local IPv6 addresses across a VETH
> pair, with each VETH
> in a VRF, but having no good luck.

This is covered by ipv6_ping_vrf in
tools/testing/selftests/net/fcnal-test.sh As I recall you can run just
those tests with `-t ping6` and see the commands with -v. -P will pause
after each test so you can see the setup and run the ping command manually.

> 
> Anyone see what I might be doing wrong?
> 
> 
> [root@ ]# ip -6 addr show dev rddVR5
> 161: rddVR5@rddVR4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> noqueue master _vrf15 state UP group default qlen 1000
>     inet6 fe80::8088:c8ff:fe31:16ea/64 scope link
>        valid_lft forever preferred_lft forever
> 
> [root@ ]# ip -6 addr show dev rddVR4
> 160: rddVR4@rddVR5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> noqueue master _vrf14 state UP group default qlen 1000
>     inet6 fe80::d064:9eff:fead:2156/64 scope link
>        valid_lft forever preferred_lft forever
> 
> [root@ ]# ip -6 route show table 15
> anycast fe80:: dev rddVR5 proto kernel metric 1024 pref medium
> local fe80::8088:c8ff:fe31:16ea dev rddVR5 proto kernel metric 0 pref
> medium
> fe80::/64 dev rddVR5 proto kernel metric 256 pref medium
> fe80::/64 dev rddVR5 metric 1024 pref medium
> ff00::/8 dev rddVR5 metric 256 pref medium
> 
> [root@ ]# ip -6 route show table 14
> local fe80::d064:9eff:fead:2156 dev rddVR4 proto kernel metric 0 pref
> medium
> fe80::/64 dev rddVR4 proto kernel metric 256 pref medium
> multicast ff00::/8 dev rddVR4 proto kernel metric 256 pref medium
> 
> [root@ ]# ip vrf exec _vrf15 ping -6 fe80::d064:9eff:fead:2156

LLAs are local to a device. Give it a device context (%<dev name> after
the address).




