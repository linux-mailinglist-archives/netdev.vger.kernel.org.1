Return-Path: <netdev+bounces-175716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA8A67382
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C422C3BA4B2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379F20B7FA;
	Tue, 18 Mar 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8GB1wLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C920B7ED;
	Tue, 18 Mar 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299803; cv=none; b=dIJcOgv2PHgNbzf9bIhCYSMf90EnBH/kFR6KpXhWCIKjr4SZUVoxJlu9JcQMbfetAXvOcAbL/gn9OkWnscrhmZ6/7sU4NLPSin3F82+43V0e9qMapmIa9Q42u+LclIoTn5wr8P+w4xAGdian9ha4WabSeBml86H9JibIWxwTd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299803; c=relaxed/simple;
	bh=lPKQnEaxeMpRoKxtP34VPTk7ChHxFtWhDpKgIJTogW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FFFAlRIY3xE76i3//sZReOc0y9YBmojbKINZQWzGSzJpNXOWtJL6u+IU0ILScYUCuSh+ld9N6GAlwGEjQI/nDsIWDT/MrMMbYj4whHPtCdntvpqLbDE4CWFE9GzvJ1xvjLuH9NL5n1SGNwaHDE20XFDA0PIhV4njFopTsR/C36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8GB1wLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B02AC4CEDD;
	Tue, 18 Mar 2025 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299802;
	bh=lPKQnEaxeMpRoKxtP34VPTk7ChHxFtWhDpKgIJTogW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i8GB1wLHlxb2TWIaW/8FMxn1ZJvPG23frrKrVPgsbDM7d8ByZ7Bi5aVMD04vmzjsm
	 ID/BqZndgHxxhZaO0GefE72cYEK0qI6/k26ijOzTM5K/uDGkTz3P8QF79450A/HjRm
	 E5PYYSQYNNDO+TChoHPqqiiMAriDth+ZZ+EzmGflPFJad4Y/j8wT61Wm4NSvtafdFv
	 VskPNXfDhH/E1l8JFRzXd6q1eD2CP9k47WN3eEmilYg6ygrX52hhk+bp+BOqjfLRAW
	 xsEGtT/+kvKGV5+fpmt89UoYL5NfU9AE0e1TLVkRH6PPu9Frc+cJDn4Ijsqza6L+mf
	 ZM+vGMv0agbmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3679E380DBE8;
	Tue, 18 Mar 2025 12:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skbuff: Remove unused skb_add_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229983774.286709.3747894645484642907.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:10:37 +0000
References: <20250312063450.183652-1-yuehaibing@huawei.com>
In-Reply-To: <20250312063450.183652-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 14:34:50 +0800 you wrote:
> Since commit a4ea4c477619 ("rxrpc: Don't use a ring buffer for call Tx
> queue") this function is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/skbuff.h | 19 -------------------
>  1 file changed, 19 deletions(-)

Here is the summary with links:
  - [net-next] net: skbuff: Remove unused skb_add_data()
    https://git.kernel.org/netdev/net-next/c/24faa63bcea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



