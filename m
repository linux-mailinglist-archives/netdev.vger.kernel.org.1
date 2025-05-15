Return-Path: <netdev+bounces-190592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF51AB7B8B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FD31B66CC5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BB278160;
	Thu, 15 May 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di+/Ldz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FB1BF58
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275775; cv=none; b=GjWpif0ldGfS9PmCLyL1lbTJAH+rPeq0JQNpNQaOgU48CwhBBF9e8uI7YrFGpdvjiLT6AK158Z40baDh2YnabQoYhnp/sQ1IQh/wsUZ5TFpGuw7E2xcA959r2c+NF4IUjwgmYZ8DK07eY6yQ+3eO/Jjc99N1S5HcWhcZRnjfHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275775; c=relaxed/simple;
	bh=LW6wznzn5rfxOIxQRtUA1eK9B/X0OktYjDx/oMMbKDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhViTkfnL3tYvtSFYLZ51lf8l0UwuohvCboOG6QgpJ8bb8qRB8yR4uU6hoG94IBDVHpjLT+0RSSs/I0QeNySixIedzJ9P2T6t8Kzy+9GD1EdTvTTMG9sAEKXbqpY1QZDQFuZdTzw2ULfPqgNdbl0K6dvp5l7QR9Fl6sdksw1zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di+/Ldz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA76C4CEE3;
	Thu, 15 May 2025 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747275775;
	bh=LW6wznzn5rfxOIxQRtUA1eK9B/X0OktYjDx/oMMbKDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Di+/Ldz3+Tt54KmNzE1Da1YYYP/z7xx3tQvKBpI4fddshnfRI8zFJ4ViBvD1zhg8W
	 bOGvJwWyneylUSByN6DzOUA7X4IlcRltTEsBz8K3q27dH7McpjhvkP74BFEHiDfYlM
	 szxzc6nlqjXqWGgnArbO31e+KdJVOYShGyStEuLhMnovDyyioiPBLRHPdQrjSZcvbs
	 t42/B/X0NmgLiZYg155eRw97XSmIKLt6aDAPFGUy+jXvfx4unZxjsGQNVwFajgDXHn
	 p9VgsunuLnF1LCZZoAlq/yxcbZXU18r1A0qJ21tK99/k6dfBYnLsJK5qYibJHJMpw2
	 /jlKtp8rBFTBg==
Date: Wed, 14 May 2025 19:22:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free
 RTM_NEWROUTE series.
Message-ID: <20250514192254.3673b035@kernel.org>
In-Reply-To: <20250515020944.19464-1-kuniyu@amazon.com>
References: <20250514184502.22f4c4e6@kernel.org>
	<20250515020944.19464-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 19:05:16 -0700 Kuniyuki Iwashima wrote:
> I think I was able to reproduce it with SO_PASSRIGHTS series
> with virtme-ng (but not with normal qemu with AL2023 rootfs).
> 
> After 2min, virtme-ng showed the console.

Yup! That's what I saw. Thanks for investigating!

