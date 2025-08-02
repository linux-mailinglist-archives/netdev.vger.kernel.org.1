Return-Path: <netdev+bounces-211434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF1B189EB
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808B958803D
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4733991;
	Sat,  2 Aug 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdQOJvQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951E2AD31
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094595; cv=none; b=tqUQ9KmzCKQqzCXEqUiMx25FAeiD5qwAWfaMTarO360hzyP370wP1zEYz0FrPkHUxXkI4hPGQP4Sj70oTq/j+Sg1p9Aeie1wptMZIsxqX5ZZ5qhsXSZSrAJM+52T6/DRadsGtUhujsnYQGgK9e4496ztDcWXqI2v7xSOTvJAtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094595; c=relaxed/simple;
	bh=+3g9//NHnsvKb01sYeHk0PzreoYY0nQJ/SmHnKQVJTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4uXdeByZ4bCOtSys09E/UCZMylZ9SM9JOIQ/HxgqwRwIfk2S89QG8GjF3kUzzE8/oTIhm3+Pimb/p1+SJMKRKo87OC/2U4weG8lWJBpD9ldPc8SLGEwU78E7xbwz2HhGbutqrS5QBq7JeopYFAeOdSfA01rp6ZxKJeYjZ3qC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdQOJvQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2505C4CEE7;
	Sat,  2 Aug 2025 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754094595;
	bh=+3g9//NHnsvKb01sYeHk0PzreoYY0nQJ/SmHnKQVJTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OdQOJvQpLVh0Zq6OFSvmbUSPJyN3FBfwBuH0mfVlJdyJfR44mQkpbMd01MM5S33CV
	 PNkHmR/3hP/KDbreyUH8akGOdcbSqouMnQ9/VJQIAFcq/uuaGbgHvaSCZ1KlCTfcFI
	 AhkPVJ9Scy7TK4DwT7DYMqswrERGql0ZXtkdBLpSIBb7W+l9YpqYbV2gI7Kiqfjiy5
	 68yCW2euGFieFZGVGX4JUX0BmdvFkHqWc1uam2+obrq4ZzyCFWKtjJRAc2G0ZYjslj
	 B0s4NdkrWFgB/4IV8BnOO6b384y3FvhdZsg+02h+6SbTb2frUCd+bzM8lI1gMlb3t1
	 TQJ3jH+9dNWVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD6383BF56;
	Sat,  2 Aug 2025 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/sched: taprio: enforce minimum value for
 picos_per_byte
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409461025.4171186.11925448552311801964.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:30:10 +0000
References: <20250728173149.45585-1-takamitz@amazon.co.jp>
In-Reply-To: <20250728173149.45585-1-takamitz@amazon.co.jp>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org, kuniyu@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, olteanv@gmail.com, takamitz@amazon.com,
 syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Jul 2025 02:31:49 +0900 you wrote:
> Syzbot reported a WARNING in taprio_get_start_time().
> 
> When link speed is 470,589 or greater, q->picos_per_byte becomes too
> small, causing length_to_duration(q, ETH_ZLEN) to return zero.
> 
> This zero value leads to validation failures in fill_sched_entry() and
> parse_taprio_schedule(), allowing arbitrary values to be assigned to
> entry->interval and cycle_time. As a result, sched->cycle can become zero.
> 
> [...]

Here is the summary with links:
  - [v3,net] net/sched: taprio: enforce minimum value for picos_per_byte
    https://git.kernel.org/netdev/net/c/ae8508b25def

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



