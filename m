Return-Path: <netdev+bounces-147462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC99D9A79
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7095B23DEA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B241D63C3;
	Tue, 26 Nov 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNSKr/1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB21D5ADA
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635276; cv=none; b=ctxAytrmhcBEnvXQba11464J5/uLuOHo4pFNZiOz2SPkdTYIuZUL5J43N+wsiLGHaW8mzbkKyJgZZOAM/pQ2TiZPWUCR+6GutaHHvdHUrgk3Nt98zpdB2prdX8BwfbdL+vf97h5CgNVobkBKjiOH4gzHL2RSRrZ4b0vjAe2Zj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635276; c=relaxed/simple;
	bh=kSlnmGcWpn3wVgV1/VZZD9dyaWFc4+6Tp2fuEEvavVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=et8E+mw8fl9g6ocWFozntwBJ1qzeVuNeTxYQwU+CWDQH2N/2H75cFEIOjWT18eXFzkWdaIu1STRewKLZmoDf4F0ve08e47lXKPQ6ChHdmRWg3cGS11BDkEqBUHSJ1gJum2TywR8xBCx6OCw0qjD1BbqrpSu6zFa6GJLf94SbaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNSKr/1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D232C4CECF;
	Tue, 26 Nov 2024 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635275;
	bh=kSlnmGcWpn3wVgV1/VZZD9dyaWFc4+6Tp2fuEEvavVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SNSKr/1RB1ybXH/4Xip4fvPnw4lApqCQZwfYzjRVFiTHThNUXIhPF4njGNiCKTsFk
	 qYkqStMeDWkLfZPNtwiD//ysvYPvr1rg5Hn/O4P9T2floOdEytkcKV56IeDZARLikG
	 7p0fPbYTIYHa3XAcgk3MAGbSxWYzaxFj7TjhupMmloFccs4zPE6OrQ4/DLKvhcoLY3
	 WLTAl9xLeXfsaxkLn7eB6M/G0SaZrm+BFR264Aso4X4oIfWOP36xJ9FVF5IltsiNHR
	 8Ya1hgdV5qasDA7NgxMwJDaYPZGg/LkcDf0Ju6xkcl3iLrJwkV/spt4gm/JZcoX9al
	 V2wrLV/kqBgVg==
Message-ID: <ecc5c683-0331-42a8-9061-3a4eef96e5bb@kernel.org>
Date: Tue, 26 Nov 2024 08:34:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/3] ipmr: add debug check for mr table cleanup
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stefan.wiehler@nokia.com
References: <cover.1732289799.git.pabeni@redhat.com>
 <64f267b5c0dd74f5bc8795b4ff868b5b103741da.1732289799.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <64f267b5c0dd74f5bc8795b4ff868b5b103741da.1732289799.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 8:40 AM, Paolo Abeni wrote:
> The multicast route tables lifecycle, for both ipv4 and ipv6, is
> protected by RCU using the RTNL lock for write access. In many
> places a table pointer escapes the RCU (or RTNL) protected critical
> section, but such scenarios are actually safe because tables are
> deleted only at namespace cleanup time or just after allocation, in
> case of default rule creation failure.
> 
> Tables freed at namespace cleanup time are assured to be alive for the
> whole netns lifetime; tables freed just after creation time are never
> exposed to other possible users.
> 
> Ensure that the free conditions are respected in ip{,6}mr_free_table, to
> document the locking schema and to prevent future possible introduction
> of 'table del' operation from breaking it.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix build errors with CONFIG_IP{,V6}_MROUTE_MULTIPLE_TABLES=n
> ---
>  net/ipv4/ipmr.c  | 14 ++++++++++++++
>  net/ipv6/ip6mr.c | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



