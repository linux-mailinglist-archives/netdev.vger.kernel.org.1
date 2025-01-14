Return-Path: <netdev+bounces-158261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36F3A11414
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F918166B54
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437962139BF;
	Tue, 14 Jan 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPXrMWei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF42135CB;
	Tue, 14 Jan 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893817; cv=none; b=RUSRhac3/hpgFV8ymS1hy7mNo4s9xYi0ri1S+9eEBCupwH1f3EA9wV4Od65HITgKuDpHbZ1NA4Xlpg8ATY+kmf9gnCWoCAalLX+2bsVB/Il5rtTMqm5BAhYFyTJAlkhcNUyULnT9lf6AMmy8+5Xtgz9Oh95gtVsoltVHVuwybzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893817; c=relaxed/simple;
	bh=Iu8yBQSLvGkiHBDJx3T9KQSV5ydXG/G9eF7XFC9rHA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YlL+YJ08AD3Axmv03zI60FcDRKOVmyMAxBpYWbp/pxkhakyeAr6CfKO9hUs5Uuv7dxHFmawizATA2Wu6hN31Iv9/AK8GwK6AkBuCQlYbeCilXLNwS3DMo7C0U/xCHkXjQy6SIdMYMhyfQLF4I1WuRo8dKXbo4nesChrKEGB/uCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPXrMWei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A68EC4CEE1;
	Tue, 14 Jan 2025 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736893816;
	bh=Iu8yBQSLvGkiHBDJx3T9KQSV5ydXG/G9eF7XFC9rHA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YPXrMWei8w4ymqSLQeOVyCZx/u8LQjsMSQYAbPHiiDnraJf/YpHHOBeKhecGZL5/C
	 SEV3/kH6eB6ACSS2rdxuptzwdgR1VpjD2HsAEh0Wq0C6NGfTyBW7e5060Rn1aJ10Tq
	 2dl/GGhP46ZuBPFSy7rLtoyV4iDzpqkAryo9P2EUrcdVnv2H9KCMJapwX6bkUOCkFp
	 yoVV0kzxxJUu62cKaxRmNcVfjlotwUmjQeF+PnUGmfBQizjD5GUDKy7QwDATHxlUng
	 yX3RS4PW2GgHctFbRM43SKPd12i+iU4IoCkO4EFpTcoLxNBs+QluDlc23rxaU7XLVa
	 2hEUrJADPLvRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F70380AA5F;
	Tue, 14 Jan 2025 22:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: phy: dp83822: Fix typo "outout" -> "output"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689383901.162948.7046290834387824823.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 22:30:39 +0000
References: <20250113091555.23594-1-colin.i.king@gmail.com>
In-Reply-To: <20250113091555.23594-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 09:15:55 +0000 you wrote:
> There is a typo in a phydev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/phy/dp83822.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: phy: dp83822: Fix typo "outout" -> "output"
    https://git.kernel.org/netdev/net-next/c/652aac7ecd33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



