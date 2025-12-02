Return-Path: <netdev+bounces-243137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9FC99E33
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 03:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 117EC4E1CCF
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E82255F52;
	Tue,  2 Dec 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utRkxK10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8FD18BC3D;
	Tue,  2 Dec 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642882; cv=none; b=oeIhIh3Xc5hxTHUGc2W9xKEG1kiS5SJm5rL9x4UWbT8SOdiNZgC72J2g4Xdu1tqn0im3VyzYWKqFVwOpiEexhU/AGQD95BVG2+YD0cNinBsxkwIWPe1Mxxvynal4QRE3xBXNzMFzbhXefqN0sxNjLLcVYRJJBjncn5cpbr42kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642882; c=relaxed/simple;
	bh=v8qi7NkTFV8KPyOV8XpNxjZc/5JAwY1LNiZNc6sPxVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUNrm58viv8mYm8dAn19wqcb3B9UpJAE8f4CgJSsnQP/AWqjuK9hesiUBe+W1S7JlVKLTDkQRdF08NWRm3pgA9FnMOzjpI8+miWrE9msPr7kZBk4UmtnH8goaVMhAWnNHqgn8rORA5Cyzt8eiYg27WhXg9u7FZZ5zd8fqMiEHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utRkxK10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D03C4CEF1;
	Tue,  2 Dec 2025 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642882;
	bh=v8qi7NkTFV8KPyOV8XpNxjZc/5JAwY1LNiZNc6sPxVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=utRkxK10MUKg7jz9qrTaRXpEd0NeKRYLirCC6O3XbsMayLNeJNkgH/ExiS+M+VzGY
	 9DE7Rt+r9ao+fAL8jnGcM4m/l0khqJDZpiFCxs8TFygUqg0kyT21Dmh7bFSPTNbh4J
	 nC59Ig3/DtOaod5R52e+E5keWnr6FQSkQjvkFANzuvXAUru9ZaoUkXH5GHJw+lLNVv
	 lqeXU03/iYo+1o8xHBtk3+XgntbmSSUBbcGmjvRhvgX9w5259paM9tvYqDX0OuQbPJ
	 KGkvKT/+1mh7+yZAcCsl759AHuvgTj/zollkQ33xeBobS1igVwwBtxzzdOShGQ0X0U
	 yKDKXa2VGYQDw==
Message-ID: <23baf995-080d-4457-b089-a88a317425d2@kernel.org>
Date: Mon, 1 Dec 2025 19:34:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-net 0/6] mptcp: new endpoint type and info flags
Content-Language: en-US
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 4:19 AM, Matthieu Baerts (NGI0) wrote:
> Here are some patches related to MPTCP, mainly to control features that
> will be in the future v6.18.
> 
> - Patch 1: add an entry in the MAINTAINERS file for MPTCP.
> 
> - Patch 2: fix two minor typos in the man page.
> 
> - Patch 3: add laminar endpoint support.
> 
> - Patches 4-6: display missing attributes & flags in 'ip mptcp monitor'.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (6):
>       MAINTAINERS: add entry for mptcp
>       man: mptcp: fix minor typos
>       mptcp: add 'laminar' endpoint support
>       mptcp: monitor: add 'server side' info
>       mptcp: monitor: add 'deny join id0' info
>       mptcp: monitor: support 'server side' as a flag
> 
>  MAINTAINERS         |  7 +++++++
>  ip/ipmptcp.c        | 20 +++++++++++++++++---
>  man/man8/ip-mptcp.8 | 20 ++++++++++++++++++--
>  misc/ss.c           |  2 ++
>  4 files changed, 44 insertions(+), 5 deletions(-)
> ---
> base-commit: 2a82227f984b3f97354e4a490d3f172eedf07f63
> change-id: 20251124-iproute-mptcp-laminar-2973adec2860
> 
> Best regards,

applied to iproute2-next.

Patches should always be against top of tree - no assumptions. I had to
fixup the first patch of this set which puts work on me.

