Return-Path: <netdev+bounces-206422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B685B030F9
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFE93B3320
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22A1EFF9B;
	Sun, 13 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6vyCsOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75772626
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409184; cv=none; b=o2Pni24s4sFXzmIZ6j11ofF1r8oMHvIJshnbII1jKjf/c/1j4GrriySdYlVrLH600eFnpaiYW5A+A7ldaVeJWuBshd6Q1ALK+WDXsCzBqtXMHQf4VGpxiYotouqdSymU5zKMMH0XV9t9ehzqy+inlg7gaEleC9dxBnwnt3Cc7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409184; c=relaxed/simple;
	bh=qEHo4ELBv6MuDc3E6Epnk3Ae+dsw1bcAbTpSXgh30dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TID3WUkxC/5t8UNDSNYrfctZqfwoHgTKwMHAk7rsjXkcsy9pOE0HJEGBkLf9XfeT5hDLb+d1QBksazVffy5LcolP5JGWCKrpeOg4PRj2M4M4wm1Ff+wVrB/1L11FiwSSZN3XxeKeM9oZ8VqElB5zx+R1oku4iLB4VdNFDnquZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6vyCsOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B3AC4CEE3;
	Sun, 13 Jul 2025 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752409184;
	bh=qEHo4ELBv6MuDc3E6Epnk3Ae+dsw1bcAbTpSXgh30dc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f6vyCsOfwk0KeHHlTxi4wFejhqCyBFvC8j704jzo+EyTW/DRlTZhj5xy8lgqTPzrj
	 BCdK+vxqalPF6CsDjdB9Ga0KnN5IrNwdFrV+b37awwFNE5pNzfyCaEHnmWSEtG3EXN
	 vCtmYh3sMKHZoLmUjK/evJwVb1eY0Oto64wE/QxrB2F4KFyn5yoMRtPAXZYX4AxWtJ
	 MT7Rc4c0TNqHH6ImpVAu+CQz+eNUlPRrTyovtKCJiRhipd/5qtfKCgVa4Z+ouUFCwS
	 9B0E7vI7zpXccP/iL5CIbf1Wrzozd/9nbDm+DSEnepN5nzviRYX/mZxW3C6424tvjz
	 3sfSB+vrzMzoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1B383B276;
	Sun, 13 Jul 2025 12:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynl: process unknown for enum values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175240920551.2773717.15673778957888907336.git-patchwork-notify@kernel.org>
Date: Sun, 13 Jul 2025 12:20:05 +0000
References: <20250711170456.4336-1-donald.hunter@gmail.com>
In-Reply-To: <20250711170456.4336-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jstancek@redhat.com, arkadiusz.kubalewski@intel.com, sdf@fomichev.me,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Jul 2025 18:04:56 +0100 you wrote:
> Extend the process_unknown handing to enum values and flags.
> 
> Tested by removing entries from rt-link.yaml and rt-neigh.yaml:
> 
> ./tools/net/ynl/pyynl/cli.py --family rt-link --dump getlink \
>     --process-unknown --output-json | jq '.[0] | ."ifi-flags"'
> [
>   "up",
>   "Unknown(6)",
>   "loopback",
>   "Unknown(16)"
> ]
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools: ynl: process unknown for enum values
    https://git.kernel.org/netdev/net-next/c/8c2e602225f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



