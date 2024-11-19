Return-Path: <netdev+bounces-146094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D923A9D1EF0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A31F21F2A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455B14884D;
	Tue, 19 Nov 2024 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8aWcsya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992C145323;
	Tue, 19 Nov 2024 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987913; cv=none; b=rCvByBbaAWTFWg26ptSPT+cqqFfDHstvcjY/NEtaIFgFyIX2mbxZBfISdxLkFwFkPP+8M+AI1AcIzcv+OKzxIsO4/+AEf/R82zTeqVrY2YC6rt7peGgniMVyEYqAfz+VSqOzPwlbvL1KrKkyIVm8xqcngU+mHPBxniBn1LL1gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987913; c=relaxed/simple;
	bh=epo/FYAMDYLSt91Jul3hPLkqf7hc8VIzQZIw1LsmfAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI0m4v04iPJvCLxoEYUZH46pgUriepOukxYd4y6JYOP+qM6dJGCC0ver0mfQVQB4Dbg/4dh2ExLc6Li1b2ItNWaTNJ9/st+ZQ6wXvUfk0oPajgfvpjgzFZkO9ePjbxKg0lKQK8VApq5eamNn3Y9NE4eEHtcrpEn4TUEwIzdE9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8aWcsya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6475AC4CECF;
	Tue, 19 Nov 2024 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731987912;
	bh=epo/FYAMDYLSt91Jul3hPLkqf7hc8VIzQZIw1LsmfAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8aWcsyaZp0U9zZO+miuX+W+MFggnG2Jz1XSKZ7Ix8MsBlcJS42rXGyJIdlNc/bTx
	 G1RYy1oUK/mpKdBT45vdFWJ5Exk53uySEB55+ADKFyWDf0Kcr8/Gsliyd5QKAq+17N
	 F6pg0fgtlaMWgpW9GzrwSkijPN/sOpAFy570EPkMZshAcxGZHTz1kLjHLH0VE8DYp6
	 yNKkhvxcLVwVjGHQ7wRcqAOf0JbwzkzqfoZR79UYAlym67kpXKtx94prQQF/3V2YH+
	 cRQlW9uM7vad6jUtUR/viPtr5A+lpRijYJevE9fxORWe3toR4bFvROeizEsZRSdxcX
	 kabA7/iIdAWiA==
Date: Mon, 18 Nov 2024 19:45:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 0/5] net: fsl_pq_mdio: use devm
Message-ID: <20241118194511.338d8422@kernel.org>
In-Reply-To: <20241115204149.6887-1-rosenp@gmail.com>
References: <20241115204149.6887-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 12:41:44 -0800 Rosen Penev wrote:
> Various devm conversions to simplify probe and remove the remove
> function.
> 
> Tested on WatchGuard T10, where devm_platform_get_and_ioremap_resource
> was failing. Added a note why.

Hi Rosen, we're wrapping up our 6.13 material. We don't have enough
time to review everything that's already posted so I'll mark all our
outstanding patches as deferred. Please resend in 2 weeks.

