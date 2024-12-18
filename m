Return-Path: <netdev+bounces-153056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF39F6AEC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C071641DA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718B1E0DED;
	Wed, 18 Dec 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGum1Dz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2F5FEE6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538814; cv=none; b=a2LmzKw9eK2nWVqF18VYaDAEvtDAzmMMcgBPtVh+jwDreB2+CnN7pTfa6oFXpjFs22z/OyRzQg4uquTKfW0tX+VwnKAR4UKJUTmS7YuEJT5XxA4XY3hSwz9FF9DLsLZBvnUJ4cmZS9bBBigvK/Q1Qe/Iz68QS4xJ4BqXEVRrSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538814; c=relaxed/simple;
	bh=4nMWwpV7wWB2MBTSP5Q8gpzpAyNs0Sv9gaBvFBVSEPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZtAURqLYCex9GdaeXGbVJWf75DiO8hqmf/U0oRKOVvFKXQzTlxNwF1o8sznNqkG9ENpu3ygLyf3hq+VEdaVfV4Mq9BAnbzwjpqDpTZcTijLi77p9shOBiBr3xvmf7riHkj0YAt/jXsBbhnr7wYUKb65HKtL0saEyFsS1z+Ubt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGum1Dz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B11C4CECD;
	Wed, 18 Dec 2024 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734538814;
	bh=4nMWwpV7wWB2MBTSP5Q8gpzpAyNs0Sv9gaBvFBVSEPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lGum1Dz/R/K/+cQZk1mdKKTQ/rBYn449ULKcR0XS951SVV5Tb5jQmN1vCMDtR5bDU
	 SlGXMnHde37Uuq3281yGAACAQqOAuGzgzIfppguIy0ZzIbgI8wyd9fJ/tpjdBhlRGF
	 Xj6pGVVKhlH2o05BzgBoaof1TUP2Iem/28eA3fX7Nq0PQ+p8+GQ2PBSQ+wiNtcNeEY
	 FOmQM/zQfL2uBlpUw4un9y4+Ft5xiHKYrHe04jFt0rgfPH5B1G+6/hdea+KqsxKTu3
	 uigiqpNm8NgQlALFfnw9T4e8FmB85nj4JpGgZVb9crZ+8nL0KujNKp3K4I7KvshILd
	 zpWj3h1IP7Jqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED63805DB1;
	Wed, 18 Dec 2024 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next,
 v6 1/2] iproute2: expose netlink constants in UAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173453883152.1662908.9000909666156273022.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 16:20:31 +0000
References: <20241211082453.3374737-1-yuyanghuang@google.com>
In-Reply-To: <20241211082453.3374737-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 maze@google.com, lorenzo@google.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 11 Dec 2024 17:24:52 +0900 you wrote:
> This change adds the following multicast related netlink constants to
> the UAPI:
> 
> * RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR: Netlink multicast
>   groups for IPv4 and IPv6 multicast address changes.
> * RTM_NEWMULTICAST and RTM_DELMULTICAST: Netlink message types for
>   multicast address additions and deletions.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v6,1/2] iproute2: expose netlink constants in UAPI
    (no matching commit)
  - [iproute2-next,v6,2/2] iproute2: add 'ip monitor maddress' support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=19514606dce3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



