Return-Path: <netdev+bounces-247233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DECF612D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 531B630312FD
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F774194C96;
	Tue,  6 Jan 2026 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntrkh5e0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5118FDBD;
	Tue,  6 Jan 2026 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659017; cv=none; b=UBCDiE6j1fie3XU0UVBO4NUvIq3IuF7iLjUdCTGJdXzSp/F2NQwNMW1ptVxjpFJd1xSJ0Kk0PMQbe55LinO252AKEUHb86Ik8RgnydUsoS8Zlo8uiKYnXxpm8brP/gZAKkBQ9wSzQlc8LwjklvV6xM2SIqSbfcuhUODDENxjmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659017; c=relaxed/simple;
	bh=4CFH24A7nD4o/ms2FkVY+4LBWnHh4HtO/x3xwT/UC6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qMWJEva5w6eTgNWBjnOvz1/rp1B3zkK/p3viV35Reg3+edbNOnK7QRcPSC9YbEfMQnBwKkky7uRIXBUYi9GCxFrGHD9IviEHFUyD8ZQesEfFrtqxMJoeFg+lbkmhsdHSaUEMnOtJoEugSeYSpGE86vjok54i0jNk5oSG8p4ZxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntrkh5e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276FFC116D0;
	Tue,  6 Jan 2026 00:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659017;
	bh=4CFH24A7nD4o/ms2FkVY+4LBWnHh4HtO/x3xwT/UC6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ntrkh5e0nRoVe+UU7SBBgIHJG0p0kc93+43GMUbtQXJoyYSE9uyO30iX9GFZb+epe
	 5+Qjy9ehM3btEdEspKBL4cW7+meQs1SYgtY+A5JqaINAxDsx4T1v62kiHY0IdtKDb/
	 V2lpzztRVXV8hwvIemnMspIu2NuHQvaOK0PdURisTDZQ492HvogigWfmlOCxegL1kQ
	 e0Lj4WT0aDQ/nUjZ0N7+m1Tlx9ShMXaxw4cIu/56lKP3VkCrYXtZ2LTSmxrDYEq6ov
	 vJ1SomDiRjA1uAxVKZsrQqXdSu0RBi9I+iImuDZ7e1ec+78uQIaNxXundFY1CF3kgX
	 HwZAgNUDso8qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787CC380A966;
	Tue,  6 Jan 2026 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv4: Improve martian logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765881502.1339098.67084176474742392.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:20:15 +0000
References: <20260101125114.2608-1-cve@cve.cx>
In-Reply-To: <20260101125114.2608-1-cve@cve.cx>
To: Clara Engler <cve@cve.cx>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Jan 2026 13:51:14 +0100 you wrote:
> At the current moment, the logs for martian packets are as follows:
> ```
> martian source {DST} from {SRC}, on dev {DEV}
> martian destination {DST} from {SRC}, dev {DEV}
> ```
> 
> These messages feel rather hard to understand in production, especially
> the "martian source" one, mostly because it is grammatically ambitious
> to parse which part is now the source address and which part is the
> destination address.  For example, "{DST}" may there be interpreted as
> the actual source address due to following the word "source", thereby
> implying the actual source address to be the destination one.
> 
> [...]

Here is the summary with links:
  - ipv4: Improve martian logs
    https://git.kernel.org/netdev/net-next/c/48a4aa9d9c39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



