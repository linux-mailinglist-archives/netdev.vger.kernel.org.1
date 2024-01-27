Return-Path: <netdev+bounces-66389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B783ECA8
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD15F1F2376C
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E21EB4B;
	Sat, 27 Jan 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSD0sSIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF81EB2F
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350226; cv=none; b=jsk4K7PQe2wbbBSZQdEkASUEfaEikjDmLaTnP+SiZypCf7pKCG1jKzJUXagkkWmZ5SzHKKa47/qmiyJgCBrTIQlTrhhGwYzg7SBviRTpZrJ66bhwIh0VzxztSp09RtSW2E1Ttej0VZUVAOWgGF1QoPFRA6dLtoCAJJqiiqasQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350226; c=relaxed/simple;
	bh=7+Ixi+uLrY4rm5M5+eNvtW2uIGEy4fDZVVpp7R8uXPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sbxtvbxueH6NyZlVKci8WrMWhC2razb/VPTJ1d8dK9ZhLrFfZRO5wO4jePvqqx1rdVskm+W5AC25kZBKVBhwlG81wiP3kU9GGapcVQ0HW9fkMHv6fUR33rXkS+qsZvghVvjp8WvQpkNZoVicFwCOAlS1aHCVGC+nlmm1tfLZvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSD0sSIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4BDCC433A6;
	Sat, 27 Jan 2024 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706350225;
	bh=7+Ixi+uLrY4rm5M5+eNvtW2uIGEy4fDZVVpp7R8uXPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mSD0sSIUBkAg7NR8q1221pI1J/wFPRk+amXVY9vFm5xKLXaHL1KmT9CWpiA9AcE9F
	 c3HHWFDx7s7Vge64HsHItTtlyO8fakGAEWE0/oTaYYvGQZJDQiVOEWx8vplJyWChAu
	 hhc0r91/YfvwTFfGcdhzvKxU4VQa5cE638rci8s7CeChBoD1k5XJK7T8MXwkephngj
	 5f25HGELIFaM2gRjutX3ufiK5bGyxCjvcTI+meiu4qe1T6xXOebFo2yFECO8BvOlF3
	 MIZu3CM4jpmSxsUWTNrAUhm8Kdh5IbqC3XUrmIuIKcOrikcDwtj5iVMky/ZiqOFjsG
	 kKqJkzonl89BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB381DFF760;
	Sat, 27 Jan 2024 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add connector headers to NETWORKING
 DRIVERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170635022576.6511.12040174660896603113.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 10:10:25 +0000
References: <20240124-connector-maintainer-v1-1-a9703202fd9a@kernel.org>
In-Reply-To: <20240124-connector-maintainer-v1-1-a9703202fd9a@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, adobriyan@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 09:16:22 +0000 you wrote:
> Commit 46cf789b68b2 ("connector: Move maintainence under networking
> drivers umbrella.") moved the connector maintenance but did not include
> the connector header files.
> 
> It seems that it has always been implied that these headers were
> maintained along with the rest of the connector code, both before and
> after the cited commit. Make this explicit.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Add connector headers to NETWORKING DRIVERS
    https://git.kernel.org/netdev/net/c/586e40aa883c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



