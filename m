Return-Path: <netdev+bounces-76582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0C86E480
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C761F237A0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE0F6E2BD;
	Fri,  1 Mar 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXyP7Idi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074039FCF
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307373; cv=none; b=Ew/yjBB6BpbaZ0DO5AKVwNCg7tRnfPm7EqqX5g07/TQm9RfeHylikPjU3z3vwUSFJ/racKymbzNWrwjrNwBB2hEVhzUF6Gvur5CkTpvwgs6+a7SOa0UH41+khLLMghElRW0AmPtvP4f/+3Q1efaRr9jouO/mzPhnrNzt3vOPIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307373; c=relaxed/simple;
	bh=MyiR+nS/2RlFS9JPr1iP88/XmIuDYgmPMx7Ofk95oxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewjl4CI6Rl0oT3DXRESM7aWs7A4kfPM57wehZ7GrVu55D9Y8OUnPZuwxR2sDnac+0tOk1xUiS6TKX/LMKgGWxSSLT8DC/bgccw4cgxnZOrwVKdBt/0DspuPFJ8aNLWtnUwH/8fUBMQQqH0YLPBWS8/ZG7NzIJrQMZhUyugw36Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXyP7Idi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAAEC43390;
	Fri,  1 Mar 2024 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709307372;
	bh=MyiR+nS/2RlFS9JPr1iP88/XmIuDYgmPMx7Ofk95oxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GXyP7Idi5jPEjtlK7hB+iJkAHZGpaSW6MaDmtfKOdRHG3xoNeWvznbakgXD5Dgzzz
	 L15zuTNgd3q8eT8BqK4D6Xo2nwrGAhhME8kQTCm5c4cuZwNkxrzjppPMUmFuR5Krl1
	 yhCxYLS/H7bFMDohLD5uAPz4H7CHI1T1a8sTUKJZaaspAQaVI2PuFg2wDC2kQi79Ky
	 K/e5wQIYZ5/ZO6Q/SNbZSNJrPoNeKyWFccvJrcekyOUIJUJe+jgPFkLFFLsPDiwiGT
	 ePVGeO7Dr4XYQbwiYgi/BSKnDEgsRklIZBppTeU1XH9PsENZrKdgUFtp4JlV7zi/94
	 gof6/ycITUpeg==
Message-ID: <3442deb7-df7d-4ee5-98f0-fa708838a93c@kernel.org>
Date: Fri, 1 Mar 2024 08:36:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: nexthop: Add NHA_OP_FLAGS
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <0aa48cb15c1dbece33b6d090ff47f444852900e1.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <0aa48cb15c1dbece33b6d090ff47f444852900e1.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> In order to add per-nexthop statistics, but still not increase netlink
> message size for consumers that do not care about them, there needs to be a
> toggle through which the user indicates their desire to get the statistics.
> To that end, add a new attribute, NHA_OP_FLAGS. The idea is to be able to
> use the attribute for carrying of arbitrary operation-specific flags, i.e.
> not make it specific for get / dump.
> 
> Add the new attribute to get and dump policies, but do not actually allow
> any flags yet -- those will come later as the flags themselves are defined.
> Add the necessary parsing code.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Change OP_FLAGS to u32, enforce through NLA_POLICY_MASK
> 
>  include/uapi/linux/nexthop.h |  3 +++
>  net/ipv4/nexthop.c           | 24 ++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



