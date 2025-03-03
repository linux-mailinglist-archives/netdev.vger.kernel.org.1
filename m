Return-Path: <netdev+bounces-171424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC5A4CF5A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B027D16DCAF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B724C67B;
	Mon,  3 Mar 2025 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS3K0QuZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9524C668;
	Mon,  3 Mar 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044942; cv=none; b=kugSFCbO5a0mKAEY7R1YuOBnf/6Bzaj/+Qf4Cpab5n6MalRmATgOdme5DRDoZJQGjRZRZeOxALmv3TYQqdg4IJMUseZw4KMU0sr4fG7jO6LxGiY+Ek9T0Lj68CnG0fPNHqiJ2K6NKQ8b0iX88BhqeyTsoibY2hqAyl7L2eO0d1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044942; c=relaxed/simple;
	bh=RR4M7xc3WlgqOwAqXXCfJiCy9xxS4WWhMj1eJu+K6z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4/pWbf5rSWlOcuYT2ykBVELuatf1GNg41w8xk1SQTezJWc/Rbi10PSj9EBrE7eSAtXR4ba8drNQMYKR7vn6PD4bNnz67iFoLgH0W5oeVKfXyIHushITSAUUjNbQ7oHLbuH2csIc4q47OL93J4BsQQaEERnxN3B3cDWKEsVR2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS3K0QuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70792C4CEE8;
	Mon,  3 Mar 2025 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741044941;
	bh=RR4M7xc3WlgqOwAqXXCfJiCy9xxS4WWhMj1eJu+K6z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SS3K0QuZFwY9t8tMQX4XP0gbsvX177wi3niUjOgMv7AtayFtYGoAT9r2Bcs9Z2qzt
	 3CQC4fC1ytMPCfFxfSqfF7Y6VnL9L4KkADYfwADuooZ0OQ3+P5PzZQJiW+yKM1+7Lq
	 8NIiMrg9EGq+Gl0hMoo/UuK5UTVj0UmxstHKptauknc4tW7VVZMLvjnYIekAtK1lZS
	 Mw7JUewXLvnFA8iGOH4sH0Cz6aQ+Gj3KrIiE7l1KvMlacbTHYxZRIDrjqPEoIHqDeO
	 fMbxPZa6ApdQ5UVhgW/EUGc0tsIQ8WruD3aDj1v9JJiT6ea8+VvFHS114U0dUORLek
	 C8sNhoILvoOXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE73809A8F;
	Mon,  3 Mar 2025 23:36:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: report output format as TAP 13 in
 Python tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104497399.3745415.4226155545795108010.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 23:36:13 +0000
References: <20250228180007.83325-1-kuba@kernel.org>
In-Reply-To: <20250228180007.83325-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, matttbe@kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 10:00:07 -0800 you wrote:
> The Python lib based tests report that they are producing
> "KTAP version 1", but really we aren't making use of any
> KTAP features, like subtests. Our output is plain TAP.
> 
> Report TAP 13 instead of KTAP 1, this is what mptcp tests do,
> and what NIPA knows how to parse best. For HW testing we need
> precise subtest result tracking.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: report output format as TAP 13 in Python tests
    https://git.kernel.org/netdev/net-next/c/d110dbf1490b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



