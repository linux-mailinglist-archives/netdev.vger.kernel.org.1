Return-Path: <netdev+bounces-145521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886419CFB95
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AD0B26351
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103A846F;
	Sat, 16 Nov 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkTYohWe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE936D;
	Sat, 16 Nov 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716030; cv=none; b=d7qOkq0jA5AmPe34a3+9MhPMJV4H9hKlb+1eBNaYloInIP2TmbUw+HImo3X1goBGFWcddzq+ZNjV2oemsaxrx+ciYsFJ46n/PF31NEaksPAaUcLacfG0dWRe8oiST1w7cwHcuERAt4a6z/kWI8xrBtLNzvnTWSkSfh+35rR5fNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716030; c=relaxed/simple;
	bh=bhgxwkHRViK3jkSy2IanwbEGS325jUf3R1U0Xjcn2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD6MYc2YmQYX79o6+WRlL9xZkwcoAA5pktbS3fYLqa6m0XSIL3cm4Okw+AAUZZo9Q3fnPJiPvP69SxAT4TMArbCoSi9P/EiV4XPsuOiCJNjFadq6v7LaTr50tO09EzSyHPQUXNyBG6Ez3B4yEc1jURnj7ltsQKBuc9bcVsLJgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkTYohWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396BEC4CECF;
	Sat, 16 Nov 2024 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731716029;
	bh=bhgxwkHRViK3jkSy2IanwbEGS325jUf3R1U0Xjcn2A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rkTYohWenM36KAYozGo5drV55cSOYn+FaiDGMMYmuG0Rj8wwKeQu6gN1NozLdf1Aj
	 6v+abKp+7tVtD3hqA887PIqohSe9m8q5RuQdZ83XeV3Og9d2maNoJJWELvUbCcuM+E
	 izHrGm6KZqjRMdoWEL2+Ixqt/cQKWvlUHyYsruG+y2MOdwK01L6Qu7CiPnaNwzzSR8
	 U69gFHvxh6n75yXtorPjFyXV/UMgkg9cSHmT6shq04kRyHi7b0hRgUb/uAKsjXCklA
	 qGcidtJ6fk4/ocCiWncRkBAebKh6/ftG4cTToUiyfl2okSiouNLynWSIdN6zh0Aeh4
	 R9qBhRKddP7VA==
Date: Fri, 15 Nov 2024 16:13:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ivan Delalande
 <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Davide
 Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net v2 5/5] net/netlink: Correct the comment on netlink
 message max cap
Message-ID: <20241115161348.517ed20d@kernel.org>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-5-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	<20241113-tcp-md5-diag-prep-v2-5-00a2a7feb1fa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 18:46:44 +0000 Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Since commit d35c99ff77ec ("netlink: do not enter direct reclaim from
> netlink_dump()") the cap is 32KiB.
> 
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

I'll apply this one already, looks obviously correct (tm)

