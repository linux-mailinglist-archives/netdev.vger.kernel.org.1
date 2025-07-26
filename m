Return-Path: <netdev+bounces-210306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64FB12BDA
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3D117731B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ACA1DE894;
	Sat, 26 Jul 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l25QWs24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FC645
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753554859; cv=none; b=T9JCdtmbcBYAHlTcLCNlLEnt4x193u1Bcyg0JNE7Of34TeLDoGaS6wUB2c5P4yydbo2xiorkvPT28rfGz35HSbFIdRzXLTlNNeIkyZcObNYSx/oYaek4twk3csTz1wWcYfdWG2xPm6BlP8H4cxlGW2r3U1KiO5Jrs/6H4Cg6wTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753554859; c=relaxed/simple;
	bh=TdVarT2w24VT+L9Oo5Z5a7UVDVplK2lnEOffjeQf87k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqbsXkyyKTrqEafP2v1jpankgE/oBFIPIBhg8ezRaONp1jvVb3mDt8a0rmtnvhDxTOW4PXogzhFElQbqh3cT/kQ0/S5pfslB4H0EECeEWm8+U5Eimzxl3peP7mFsHw4UtqnAxOZ4WyzBwlymP3deoC9+aqllYbT0mVTq2Inju3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l25QWs24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6A2C4CEED;
	Sat, 26 Jul 2025 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753554858;
	bh=TdVarT2w24VT+L9Oo5Z5a7UVDVplK2lnEOffjeQf87k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l25QWs24U+iLNSw/gCXEYT1wFcAl2xa3qTGwaSrjEMstaIUfEUvRLs1WrowAF3d9E
	 sQJ2LP/LLMeQI659B9U7TBioi8oIiu0MsKoJPFssGqeqTO4yrM1MbzhX3cwgY2CaZ1
	 /YT/3WTtvkskncs9EF6JYa7T8RUtwBPItGKS/sBoN7u76t9VDpuTgsmwwqsIApqu4K
	 DBXMxLxf8etqHfHiKvbu9Sz5ypgCTNmtjjFZWnc4pPhiM/tlEsB5nR8e+wPi2S6xKp
	 x+6zqsdl9flSEw2Z1RcUyj31uLCQRfg6MYnB1IscWf+UfYklte2qAtEyHDMSOkYQzV
	 BthUYJj69zMXg==
Date: Sat, 26 Jul 2025 11:34:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net 0/4] ipv6: f6i->fib6_siblings and rt->fib6_nsiblings
 fixes
Message-ID: <20250726113417.1371e296@kernel.org>
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
References: <20250725140725.3626540-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 14:07:21 +0000 Eric Dumazet wrote:
> Series based on an internal syzbot report with a repro.
> 
> After fixing (in the first patch) the original minor issue,
> I found that syzbot repro was able to trigger a second
> more serious bug in rt6_nlmsg_size().
> 
> Code review then led to the two final patches.
> 
> I have not released the syzbot bug, because other issues
> still need investigations.

We should probably spend more time on tests that modify things
concurrently for the RCU conversions :$

