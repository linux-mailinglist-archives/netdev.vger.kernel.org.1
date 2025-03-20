Return-Path: <netdev+bounces-176486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55147A6A85A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F8F98239D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CC22617F;
	Thu, 20 Mar 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYDOANAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3E226165
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480432; cv=none; b=OF77pECnUrt4fImfWsPdVPgG4chFXRRs5RRXuvmzYmOf+hjw3Dgd7HoTnzidBMMkm1qSbY6NypcDxfAj70Mr7OatUYUrcr8zk/C9LtpdNtQYWLOwtPUB0sE/zUS8VXRhqwOoR0xz6DaXyW++5uf2Zsmeh1vPg1aRcxySdKgAJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480432; c=relaxed/simple;
	bh=FIGEszkndZKKx4q3IN7Id/WWWtKCe06mBAQ0OOZmY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FY2vKFf21RU0eOUv+MMR5HTgs5fk/cT79cXvL84v9AWRptgimfbfgfSxLekeKEYwCWXXQXuB0X+J2KemUm2Z79ftXIgpw/C64I9T60LG9b6MWydLz3rifqh+jZkVI6NmWXHoCALxlzFQNpr9XeCqYP7EKuCW4XGR9ckc5FIKVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYDOANAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CADFC4CEE3;
	Thu, 20 Mar 2025 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480431;
	bh=FIGEszkndZKKx4q3IN7Id/WWWtKCe06mBAQ0OOZmY1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XYDOANAdpxkBtVwcFr3MWp1VYX7EW+YSx1PdIbYR55o7WQTbHWP4NLcfeZ+UwagAr
	 BifWaU3vKxz1ZVNAHLrQvrhCIGopdier4PefYLVRyacqU0c0rcEqVUo1NMujC1eucr
	 g++76RQOTbOrdddwLcem3y9dAniBAXolCNyLMUkQQDHOqKgQK0EsvtfqEN6OwSW3cg
	 iFkoDyv3MkQKPKbYv9BflpEwWEjymAJ1WzzCjB3jFRNSeXCIGIld/m/5GW7zUjZVit
	 rSUW1fN5yxFU7ESJVHCwlmpUw8UYStDOEDuHNXo9hy2ZeNOImB0o1dYbh1zoU4wZcT
	 fDTBhhdFlzbwQ==
Message-ID: <c00f4147-1f64-410c-9b84-5882f9a4ea44@kernel.org>
Date: Thu, 20 Mar 2025 08:20:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/7] nexthop: Remove redundant group len check
 in nexthop_create_group().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-6-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> The number of NHA_GROUP entries is guaranteed to be non-zero in
> nh_check_attr_group().
> 
> Let's remove the redundant check in nexthop_create_group().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



