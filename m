Return-Path: <netdev+bounces-18945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1F7592A2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F6E281698
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFA12B63;
	Wed, 19 Jul 2023 10:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7C125C8;
	Wed, 19 Jul 2023 10:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 208FBC433C9;
	Wed, 19 Jul 2023 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689762022;
	bh=vf8HyJJMrc8y7a7IGPiDvWuMwVrymE8dAVACw2+VXLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dyPvgc7QPw92aTMqOMCFf0EVygxyojg/kI76uXPrVf0yXopJTOOw98lV/L4NSn+uM
	 aiHrCeLetjHDC6LImN7FStfe20PaCqqqoS5vEloINk9sRfZSte3N0XX1OYCNALUY3j
	 Gz0Iw9hAs5SHbKzfYEa6p5rwnh+Ouj1I5/ERYOFMuuN/FQDsIzZb/oB6VyV9spijCp
	 XW/3S7UgTEEU/RKI4atORf03n1N6zkbdHtttu7AAnaU3hxlZrji3382yGicDMzfeEa
	 CqRPbZPMRrkK65sdBeB6Xb47afXkp40enwisLphkCSfUCSv7hZrTFsDi03F2SF5o4v
	 dR6MxgixWCQtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03177E21EFE;
	Wed, 19 Jul 2023 10:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] selftests: mptcp: format subtests results
 in TAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976202200.10961.989071815064643315.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 10:20:22 +0000
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 15:21:20 +0200 you wrote:
> The current selftests infrastructure formats the results in TAP 13. This
> version doesn't support subtests and only the end result of each
> selftest is taken into account. It means that a single issue in a
> subtest of a selftest containing multiple subtests forces the whole
> selftest to be marked as failed. It also means that subtests results are
> not tracked by CI executing selftests.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] selftests: mptcp: connect: don't stop if error
    https://git.kernel.org/netdev/net-next/c/edbc16c43b27
  - [net-next,02/13] selftests: mptcp: userspace pm: don't stop if error
    https://git.kernel.org/netdev/net-next/c/e141c1e8e4c1
  - [net-next,03/13] selftests: mptcp: userspace_pm: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/8320b1387a15
  - [net-next,04/13] selftests: mptcp: userspace_pm: uniform results printing
    https://git.kernel.org/netdev/net-next/c/e198ad759273
  - [net-next,05/13] selftests: mptcp: userspace_pm: reduce dup code around printf
    https://git.kernel.org/netdev/net-next/c/d8463d81652d
  - [net-next,06/13] selftests: mptcp: lib: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/c4192967e62f
  - [net-next,07/13] selftests: mptcp: connect: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/dd350f46e35e
  - [net-next,08/13] selftests: mptcp: pm_netlink: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/d85555ac11f9
  - [net-next,09/13] selftests: mptcp: join: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/7f117cd37c61
  - [net-next,10/13] selftests: mptcp: diag: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/ce9902573652
  - [net-next,11/13] selftests: mptcp: simult flows: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/675d99338e7a
  - [net-next,12/13] selftests: mptcp: sockopt: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/9e86a297796b
  - [net-next,13/13] selftests: mptcp: userspace_pm: format subtests results in TAP
    https://git.kernel.org/netdev/net-next/c/f589234e1af0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



