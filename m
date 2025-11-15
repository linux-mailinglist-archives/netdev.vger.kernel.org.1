Return-Path: <netdev+bounces-238808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAFC5FD3E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A81E4E34B5
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AA15539A;
	Sat, 15 Nov 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Ntg0tY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744181C8606
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169830; cv=none; b=KYe3xR/mAOTFdRJcqTvXCe7Zy0VN/V8vE7Bp3c5A1f3dgupWF+vxE4EFc2LL/7UNkuS1C0iGSn9o19t32b4EqGQTYkK6VBG+eaOCJiww6cRiiChwisqrky4GYA0Hdhy7AlvBGpJHg5iRWcupaLHRGit1226l3qXvE7HH+JhLEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169830; c=relaxed/simple;
	bh=5M9DDMRp9ZaABfUGi83W6qVBPeeH+Auacx+4TmnSyqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SstBNSSNCxX7VB0LuLncRTIugKpo9HtgCxoCDbgiVEIKbmprOimMKX5btMyzN56guo3S9QdKVowLgsFMHk2EdczTKF6RRiZrSgf/41EI3wgySNI2q+B3BLXKY8wflZZSaYBjWdZsPFeT1xDBZEmy+6k1fkd1chxYReGW2WG7fDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Ntg0tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA41C4CEF1;
	Sat, 15 Nov 2025 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763169830;
	bh=5M9DDMRp9ZaABfUGi83W6qVBPeeH+Auacx+4TmnSyqA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=j/Ntg0tYJLUs2u+pnIZhoCa6sAqo7R8KcvHx5i887Rr9C9jCqVbWHhBfU+u+BgEOF
	 rht0DSeZa9wmcK1biQ3l20z1T6mbNqJdPm3hKXLIBQi9x3/EALz8om6UBiy0Fo+u+/
	 FIc3kFoFd04sF+qBdWFKjuttZYcGO0ucLiQykyDYYNHtE/k1096h1LWq0p588GUBZ5
	 WCd4g8+6jPFR8Fe0hXhKAw/yI20Dp8OmUcofgfk0U6fLZ7tkc119wUsGJxHhgCynHb
	 c4ye//AEX64j/oiOHk1seNMLbcWCStvI5DqA+37GLINh12huOQtgvaON5VlD4XX6Fc
	 K7ppYc+NZ2FnA==
Message-ID: <29a4c75c-cf32-467a-8f72-d9681823967e@kernel.org>
Date: Fri, 14 Nov 2025 18:23:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] genl: add json support
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20251108202310.31505-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251108202310.31505-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/25 1:22 PM, Stephen Hemminger wrote:
> Cleaup the old code and support for JSON.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  genl/ctrl.c          | 253 +++++++++++++++++++++++--------------------
>  genl/genl.c          |   8 +-
>  include/libnetlink.h |   2 +-
>  lib/libnetlink.c     |  87 +++++++++------
>  man/man8/genl.8      |  16 ++-
>  5 files changed, 210 insertions(+), 156 deletions(-)
> 

A lot of really long lines -- like > 100 columns.

