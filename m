Return-Path: <netdev+bounces-62489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291082786E
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D5D1F238DD
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889955777;
	Mon,  8 Jan 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZy9zvII"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37E55C2E;
	Mon,  8 Jan 2024 19:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48014C433C9;
	Mon,  8 Jan 2024 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704741612;
	bh=0l6P9VORSHKX9C1VVcnePBrBJcdPlZqju9wqjY9MRyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FZy9zvIIzkrZvDsS+N8wwX5nFskP3q+p2uCn+Ovi+OxSt87RrC7a7vdbVzJ6ZA51Y
	 dNld5DcscSQbBXPI8d2psa2Xn0bP60pLjdFdI+J+dal5EJcwENA4efiGFloM/3Fw1z
	 sHOW8BIyMSjRPpq0tYUVm1EqZhe9JqsNHiueXzHxB9ahSdUOq9xSAlnefqVpb/83dR
	 MHoJc7lNwAuLRrKylFxTv4pAbYjK0TcGADidcale5kgBKhXx4Wziy8Rq9U1gZGFOCk
	 rYmjlJNX7sQBWNWpbG/eKwoJmwDPNpFKJuECS3ukSlUrKlsPjRAItliJkRuh2XjrlJ
	 E/NmHaYN05JLQ==
Message-ID: <716b825f-67b7-4d08-9bd6-41c9bc4deb3d@kernel.org>
Date: Mon, 8 Jan 2024 12:20:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/ipv6: Remove unnecessary pr_debug() logs
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, weiwan@google.com, kuba@kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com, "open list:NETWORKING [IPv4/IPv6]"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240108191254.3422696-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240108191254.3422696-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 12:12 PM, Breno Leitao wrote:
> In the ipv6 system, we have some logs basically dumping the name of the
> function that is being called. This is not ideal, since ftrace give it
> to us "for free". Moreover, checkpatch is not happy when touching that
> code:
> 
> 	WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Remove debug functions that only print the current function name.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ip6_fib.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

net-next is currently closed; repost in 2 weeks once it is re-opened.
You can add this to both patches:

Reviewed-by: David Ahern <dsahern@kernel.org>


