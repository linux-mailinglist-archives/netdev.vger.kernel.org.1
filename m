Return-Path: <netdev+bounces-149869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D39E7DD3
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B521886900
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEF7C2C9;
	Sat,  7 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv6ePFOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA018638
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536214; cv=none; b=qNfUg96yH9EgpLk/9w1uVEmpy6uN5MY06k1K8tvrk+Vl+1OZDhIwrKKG3bVcH6aXCAa6s/KVx+hK8Euh7uujtygrnA7+tCBgm3jzEEvHlnVOEIwYcYRY5dLZl7S6uTf3zgx87MFUb7xMnBXpenWnjY3YOWQRh+ThuasWdaBwwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536214; c=relaxed/simple;
	bh=CokcmhJG5zPtpxGVvlgmSdQ1A4ZGrwynW1VXk3fGv3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TVkwsuojH6Fj9a5rWeU5R35xzDMhEH0MYXC0zZIHSBJPFsyTRto5Zzm1vWH+ogL4tIdg5LKckfPEm0sucRbGgDoPd5XDiNOLMoEGVpzF2wRkb1aaTsh74nx+5GJjMgYqtu0RhwCVohfRG0ICJ842A0RaH0UQcOeKnRMjtBV7vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv6ePFOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A38C4CED1;
	Sat,  7 Dec 2024 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536214;
	bh=CokcmhJG5zPtpxGVvlgmSdQ1A4ZGrwynW1VXk3fGv3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cv6ePFOylEPxy+D01MCefIOcPqG5gvbqTs6heHXEfOuScbvzoMaIecZFcjywBsaQX
	 +w66KiAew8ZBsJpVFxPlflLRgihpcU+u0jAUOpwhr9qnGH3vy9Hc0WinVP601tgD/b
	 pDFXUVYUo12FLRWHhzN0AGQo7VCmmElTo5FdfYxPAiTIsEjlAC0zZw0MN+PHLkH9cH
	 W3Gb7RvEtey3rxTLIuqnxnIl9JtiR3JMBiMjYFPkJ8QsoETQ/M2fYz4ysP6wSrvgXe
	 CEuxh46y/ZeT6s/0fMTyunA7Xeg9VAmEw1xuMyQUgrKx9Y4LkLjSAEJZG4Vx8YG9Uo
	 WQ9Ka3V/qliow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713C2380A95C;
	Sat,  7 Dec 2024 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353622925.2870054.7390682435717227700.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 01:50:29 +0000
References: <20241204215918.1692597-1-michael.chan@broadcom.com>
In-Reply-To: <20241204215918.1692597-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 13:59:16 -0800 you wrote:
> There are 2 bug fixes in this series.  This first one fixes the issue
> of setting the gso_type incorrectly for HW GRO packets on 5750X (Thor)
> chips.  This can cause HW GRO packets to be dropped by the stack if
> they are re-segmented.  The second one fixes a potential division by
> zero crash when dumping FW log coredump.
> 
> Hongguang Gao (1):
>   bnxt_en: Fix potential crash when dumping FW log coredump
> 
> [...]

Here is the summary with links:
  - [net,1/2] bnxt_en: Fix GSO type for HW GRO packets on 5750X chips
    https://git.kernel.org/netdev/net/c/de37faf41ac5
  - [net,2/2] bnxt_en: Fix potential crash when dumping FW log coredump
    https://git.kernel.org/netdev/net/c/fab4b4d2c903

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



