Return-Path: <netdev+bounces-18768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEB7589D2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3821C20E8A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C817ADF;
	Wed, 19 Jul 2023 00:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DD17ACE;
	Wed, 19 Jul 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6929C433C9;
	Wed, 19 Jul 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689724821;
	bh=qxxeeH4BpVPJRWJ4+RBZAoXm54CuQ1BuSkX6X7QPBno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aM26f95NosLZkRBrJfElkigefJKCG4RGcGm7yoQa0kV402AWkNwxeOcvbA5zBw1nu
	 LH8/v9SpSyraWj2UFraGByiTEAsRpdyNSfxBjcKwf2yisrg1rf+ffy1cE5ivVwkUhL
	 KCi1B5rnO8iIy5XRlANVrw5nNvzm4c7/6i12TsYvFy0QaR4PsXQlbG8PSZ5HSDf8MQ
	 sd+99fC9x5txVMyehtWqt5b+s4l6E1kWLYCqTRNR/oQ0v188B61pnv/5N8Q76OlOsm
	 Rif0k4UoJyFDOkm065tfBNTz4lEy/PdHz33ZoNduRd+mOmg4urmNR/1cWh3WhxrTv6
	 Bssl9fiykT76w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A7C8E22AE4;
	Wed, 19 Jul 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: tc: increase timeout and add missing
 kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972482162.23822.8375282604196078031.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 00:00:21 +0000
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 shuah@kernel.org, keescook@chromium.org, davem@davemloft.net,
 paulb@mellanox.com, marcelo.leitner@gmail.com, mptcp@lists.linux.dev,
 pctammela@mojatatu.com, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 23:16:43 +0200 you wrote:
> When looking for something else in LKFT reports [1], I noticed that the
> TC selftest ended with a timeout error:
> 
>   not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> 
> I also noticed most of the tests were skipped because the "teardown
> stage" did not complete successfully. It was due to missing kconfig.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: tc: set timeout to 15 minutes
    https://git.kernel.org/netdev/net/c/fda05798c22a
  - [net,2/3] selftests: tc: add 'ct' action kconfig dep
    https://git.kernel.org/netdev/net/c/719b4774a8cb
  - [net,3/3] selftests: tc: add ConnTrack procfs kconfig
    https://git.kernel.org/netdev/net/c/031c99e71fed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



