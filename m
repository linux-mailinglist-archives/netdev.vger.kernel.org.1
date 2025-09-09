Return-Path: <netdev+bounces-221029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30CB49E9E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7221BC2248
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4B1E32D3;
	Tue,  9 Sep 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7hhlXoR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921B1459F6;
	Tue,  9 Sep 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380820; cv=none; b=g8cUkfJj6GikyLm40qsbxIONK9CHkN+RryJoDhtJMjslnEKwm+t7xYHwCqjeZ4pUMkRZnBnslK3HuSNQIXA/O4EcAqXLiyM7ulup1c9yh9aoHP/MvC2DsjwPA9BnZ15mlJM0SpGNHizJjnl97izyOkm5X2W+9deGdFE9OlGpybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380820; c=relaxed/simple;
	bh=JWY40T+xFS/QMidUqEsrbTv2SAlhFd15ICGtPB88jUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQRvRIw8kqnaZxLViuecwq+zvFnYbv7xtdpSzt05o81i7VXqQZ0CU2iukeFovvfWTTCVGSgh5S2thIBIWuc+m1bTUVVYKUSjB4CHlY/OF99J/TJDmpi5cBI4d6hDJfkVkb3dVGPHfleLqgfiYoaMtZYFQOUMbgI/gQOGi56Ff3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7hhlXoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E63C4CEF1;
	Tue,  9 Sep 2025 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757380819;
	bh=JWY40T+xFS/QMidUqEsrbTv2SAlhFd15ICGtPB88jUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a7hhlXoRJrA4JbdT3eFd7Av5zb1DTadw1IBxWE51P/4orB7lyDFeSjK7zx74P0fhV
	 VnFDoXpvUo2eZLGrsOBbcTzIU9c+oRAgw3Qq/7najFpzrZ2Y/VSru5WJVJ5OE5Eohd
	 3Rfu6iy6JnvY1Je5HnznkHn3d/qQQtMK+U4VVIR8jpMXpJ2bJV+N3dX6A/3YMeQhYG
	 Co/zsHQo9xmrNfpNloF5TNgNy1feWdCmcdhW5CyqxB70AwWvHhurQiYs/wKSo3VJBj
	 Tx0OFWlZ3RrMAF0GjDd94M0Kf4T4agHy7YmEueqde9qxrXTec5hj9n3gsPPxZWyXeD
	 ZoUrjWDupr68Q==
Date: Mon, 8 Sep 2025 18:20:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/net: fix unused return value warnings in
 ksft.h
Message-ID: <20250908182018.28d9ff10@kernel.org>
In-Reply-To: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
References: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Sep 2025 23:59:28 +0800 Nai-Chen Cheng wrote:
> The write() and read() system calls in ksft_ready() and ksft_wait()
> functions return values that were not being checked, causing complier
> warnings with GCC.

Is it just a GCC warning or rather a combination of GCC and some
misguided glibc decorator to force check the return of read/write?
Naming the compiler versions and the warning flag which enables
this would be useful. We don't see it building with normal warning
level today.

> Fix the warnings by casting the return values to void to indicate that
> ignoring them is intentional.

> ret = read(fd, &byte, sizeof(byte));
> (void)ret;

Can you not cast the read() to void directly?
-- 
pw-bot: cr

