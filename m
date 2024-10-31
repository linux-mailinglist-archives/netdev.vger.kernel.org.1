Return-Path: <netdev+bounces-140682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19259B7939
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9717B285814
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA23199391;
	Thu, 31 Oct 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+QH2xz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE5178388;
	Thu, 31 Oct 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372425; cv=none; b=Rzk3XQ7PggjvQSNKqG4hcd7gCtUFLU1QoaVRXFtyP9gcu8NTPoV5eitxGPcPsXusvnooThfcsbHRV5lPYE8cnO04hPHoFDBrP+WisdpH1qlFbAqDICrrx9Gssr6I58C+o4gOUZXjSncKJBUI7kvoVrVfApVt6yvTZGKf3Z0mQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372425; c=relaxed/simple;
	bh=dMy1ltJq+QnOjjoxa6KOlJNq4aW6KUYa9aitnZai3jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=leAC0QsRQsDczDgVnIy2D+NuC6VO5qSKxrefHSQDi6ybq7tLRudLUASBzYXj0IZcXSjNxPBuVudFUba86Bci5ujjVtICAxiZAAPeWLg5L93EfEvTejwU9brGNkSkjEgUG4YYskWMU+WQBKrWry8rp+nlZTEqzetaFZfrdW9a7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+QH2xz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD6EC4FF16;
	Thu, 31 Oct 2024 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730372424;
	bh=dMy1ltJq+QnOjjoxa6KOlJNq4aW6KUYa9aitnZai3jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+QH2xz7f3GfO8X1TCUPCifkaAv9HHXGAbzrsb3TcO7bFh766XLnCHeE55YKeKeD6
	 CId6PRRZeC5CQgBaJcSMLt9qAKgpbphR9PPEd7lOJTlT6X6yT+Ld977TMuPsc1/f26
	 lFpKfNN5rXuZXZ8n0O6Ysve86uXjKSvgKo6aVqjmXxqIDcwJReLzWx44dV0JekPaMp
	 TOn7jzqEtd2HtuF5c34uMGKV/SEnya1YHyeePIbn2Iw4rFN4a2sWFyU3ClqVmS0Ctr
	 5Pc+EgAoK9CTlz0eTv3fFcyv2FaY6Sn0XHJCer1/9Fi8fU8AfZGOsw58ujgjsAWESi
	 pae40qaccCEPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC00380AC02;
	Thu, 31 Oct 2024 11:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173037243250.1928904.15859081868656315161.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 11:00:32 +0000
References: <20241030185633.34818-1-luiz.dentz@gmail.com>
In-Reply-To: <20241030185633.34818-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Oct 2024 14:56:33 -0400 you wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-23
    https://git.kernel.org/netdev/net/c/ee802a49545a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



