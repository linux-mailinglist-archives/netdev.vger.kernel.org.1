Return-Path: <netdev+bounces-239666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A2C6B2E3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41182366D97
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DA33C190;
	Tue, 18 Nov 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpC2E5RT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FE27B4E1;
	Tue, 18 Nov 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489918; cv=none; b=QYDfsAi/OHjd3auI14ejD/3gOfFs08qIoTJJ8hht8WwQlr/paDTGELvlXr6SDsBuJphm/2zs5D4OZplOGaOho4RtvnlkUHERuMGAvEE1rnLOzPu7dfRHOzqjNsYCMBFznGvzjA+jkub0QjVTEM9udAFc7WkeH+8vGwFdaj1ylx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489918; c=relaxed/simple;
	bh=MTOZH+w8AIufbNBuaeJ47Bc4EfM9FZ2OsV28593CwRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5uI9wDY/OTflCEin6blT2w8TtOtY647LOiDzWeNALUpj9vOjW2GQixn1RLzP5oN/3LcWkHBVJkAeJ2J01tatC1TYah3tjWbpWxhALscBLIloy1TQuNYx9kaFqFdJfnloqvOlAymApIe33l3/61ZpPM98FOLcOcTXzvUsQRT47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpC2E5RT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2CC116B1;
	Tue, 18 Nov 2025 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489917;
	bh=MTOZH+w8AIufbNBuaeJ47Bc4EfM9FZ2OsV28593CwRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OpC2E5RTOZL8WPOqdLS7+R8fEKSktWzoc5Dd+UZ/gCKZ/HQFPqkVnHF0d9fexDIRN
	 PmZTS/qZeRUlndmLbpMRtG3KeanzZ1zaFKqmrYsmYcGhQz4uUuWOlBXWaJ4qsqRsEA
	 iq8C7BpsUwLVqGHM3LM7InjNjgeYcDa5MeTRv4KZ9ESfZ9TWW7P7VyKoh9jfI1mNCt
	 61Si+ayzZxq0KM+0qIuBspBXlsOLSTxuG1lW8MFjGMTklKPxe0sEGuzhW28iXnZAu2
	 pFpUmOX8gVWlQM8ILFbohdtClyrjOE2Y8hSdTAcdNlZEqE1836MWVhu+5TGO3OO+hG
	 p6be1YU9uHeSQ==
Message-ID: <07f075bd-46a7-4298-953f-d0540759d694@kernel.org>
Date: Tue, 18 Nov 2025 11:18:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
Content-Language: en-US
To: azey <me@azey.net>
Cc: nicolasdichtel <nicolas.dichtel@6wind.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
 <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
 <19a969f919b.facf84276222.4894043454892645830@azey.net>
 <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
 <19a97dce5fc.10e4ece0319525.6646442146487396729@azey.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <19a97dce5fc.10e4ece0319525.6646442146487396729@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 9:47 AM, azey wrote:
> On 2025-11-18 17:04:38 +0100,  David Ahern <dsahern@kernel.org> wrote:
>> There is really no reason to take a risk of a regression. If someone
>> wants ecmp with device only nexthops, then use the new nexthop infra to
>> do it.
> 
> My initial reason was that device-only ECMP via `ip route` works with IPv4
> but not IPv6, so I thought it'd make sense to unify functionality - but if
> this is final I won't argue any further.
> 

There was a push many years ago to align v4 and v6 as much as possible.
Certain areas - like ipv6 multipath - proved to be too difficult and
ended up causing regressions.

