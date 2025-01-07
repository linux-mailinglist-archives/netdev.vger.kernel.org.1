Return-Path: <netdev+bounces-155912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0DA04533
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF7E1887A55
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C41EB9F4;
	Tue,  7 Jan 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiTH3PNA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD92594AB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265223; cv=none; b=aUoXpLziQs6rnRXup/PWeIvUuERq98m4PpziqWJ7aQAq7yVu2+jA+decGc3aANGAVJNgGQRv9C/lSYSwcxpY1xpqmpRX+EArLtJjVU4adls4h6719SeCmgrgK4+nL6CCDZKKYOMXYq2tRTk+cUpX6AyQv75cGd5gBoZvzSz4JwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265223; c=relaxed/simple;
	bh=KHEOsM+lgd7DwlqBFttUIjWfmKS8DTJdQBiM3KppBTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZTDOtjPAbqT2URkQ1GWhZ28pcEfjS6aq4y+WA7MDGu9oCll5+M+Y8R3R3JDUNgSwX5vwVva88xUyte9Y3+Hu+7kUweLHCseE0VXckZL22wG9Dmk3zuf/yoWl3TG87l5yJ7MpSAlfy6GllCInf64wz5WVkG9RW5yR5wAhNepa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiTH3PNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C68C4CED6;
	Tue,  7 Jan 2025 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736265222;
	bh=KHEOsM+lgd7DwlqBFttUIjWfmKS8DTJdQBiM3KppBTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aiTH3PNAfbqxU1K2FfIbEmY/Mf3r8SpkVV+9/j4UlXBnmtyvFeH5WT9pF7l4GLfiX
	 Gbr0k0BN7kXNhLlch3Q9nbKgh9ybb6gNqoOfrIWbSds5mqCt/6NnR6B6EV2FQtzN45
	 WYt7i6Sybdml+gAO3ms6DQdFlYf6sGDYGgjzuTG5GKcgeOnUi6/SblY3SAR5WhPo3v
	 J/40I6hEOYnXXApkz9SJ02awRF1R/AW+Bage4liKXzCJi7EPSnirMEmkl7SUOF1iVu
	 hhP8yLpk6+PA0hb+nqoqRQNhe7G8MZP3GB30U3mGe2jzfcx1BH7NkRiwXmrT6NFiRO
	 0sb/0mVCUaUrg==
Message-ID: <a6fb6faf-8b2b-4a5c-a49a-f31edf1d208a@kernel.org>
Date: Tue, 7 Jan 2025 08:53:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v3] netlink: add IPv6 anycast join/leave
 notifications
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250107114355.1766086-1-yuyanghuang@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250107114355.1766086-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/25 4:43 AM, Yuyang Huang wrote:
> This change introduces a mechanism for notifying userspace
> applications about changes to IPv6 anycast addresses via netlink. It
> includes:
> 
> * Addition and deletion of IPv6 anycast addresses are reported using
>   RTM_NEWANYCAST and RTM_DELANYCAST.
> * A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
>   notifications.
> 
> This enables user space applications(e.g. ip monitor) to efficiently
> track anycast addresses through netlink messages, improving metrics
> collection and system monitoring. It also unlocks the potential for
> advanced anycast management in user space, such as hardware offload
> control and fine grained network control.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
> 
> Changelog since v2:
> - Remove unnecessary 0 initializations.
> - Remove unnecessary stack trace.
> 
> Changelog since v1:
> - Resolve merge conflicts.
> 
>  include/net/addrconf.h         |  3 +++
>  include/uapi/linux/rtnetlink.h |  8 +++++++-
>  net/ipv6/addrconf.c            |  6 +++---
>  net/ipv6/anycast.c             | 35 ++++++++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>




