Return-Path: <netdev+bounces-159864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC7A17375
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B395B3A8D69
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6611EF0BE;
	Mon, 20 Jan 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQNtRtx+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FC1EF0B7;
	Mon, 20 Jan 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403809; cv=none; b=XdEpwLeLF6nBeeEbpZ3ON4eVtDOEmWVwvMG6Vgy8O/71bs1i+n0Agcp0dmzrFy1VTlUttq1MDaxpXCWbKkuYums+jGDFoI/berNPkpP08G1KssExIdBeeoR3bfnuXLpDqtR4H7H91xVofc6RfrOxejsv4RLoRm7nRwR7J2sGW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403809; c=relaxed/simple;
	bh=0+kLMHjQXlrwaqoWq9coxsnXXo7Xpz8HN4tvjDbT2SM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sXH+yRUW6fs6usqQkba3KE/BD4REIW7syFSZU8u6Cc8yMgKKQufgeHWhb2qkho6wbDfem+SirlslMhrVEG1xFpRzM2XXrf7C+m+4yTbk0dPRkbrqMf5/SbuJEAY18XnvVjIX3nhR7OhoHSm0s7rLCJsSIGuMD99lFGmGuOutGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQNtRtx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B762C4AF09;
	Mon, 20 Jan 2025 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403809;
	bh=0+kLMHjQXlrwaqoWq9coxsnXXo7Xpz8HN4tvjDbT2SM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQNtRtx+Hmz6CDl63NBoQXpCv1lD87+LJLnG2HQGVtj7cD2QewkzDiihoQ1f06860
	 s0URUPBWRG8UIq13eFEuSuSUk0PCzem5p73d4ZUTzky6f/0s8wR2A9FQlqYqfJei0C
	 4UwBUrGLqwz7BnQuepbxQnWSKo6l0HVfYFFAqrX3+/t9PgOInLAdiJ+9tbPuhA/zil
	 wErGyfp3oHA9VGxZSny4XLG0RMZcTQBwRLtitJLC0ZXHoQZEJe6qu6xgxFZ6Kqjp05
	 GErQPVZS1/z9ZOiOcQTToALNsrdBMFYICoLQNMf1YODSkll72mAMw8jbVzMbx1Q8Pg
	 o7S7Pd3wIt7Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEDB6380AA62;
	Mon, 20 Jan 2025 20:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: mii: Fix the Speed display when the network cable is
 not connected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740383349.3638218.5760828334489396524.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 20:10:33 +0000
References: <20250117094603.4192594-1-zhangxiangqian@kylinos.cn>
In-Reply-To: <20250117094603.4192594-1-zhangxiangqian@kylinos.cn>
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 17:46:03 +0800 you wrote:
> Two different models of usb card, the drivers are r8152 and asix. If no
> network cable is connected, Speed = 10Mb/s. This problem is repeated in
> linux 3.10, 4.19, 5.4, 6.12. This problem also exists on the latest
> kernel. Both drivers call mii_ethtool_get_link_ksettings,
> but the value of cmd->base.speed in this
> function can only be SPEED_1000 or SPEED_100 or SPEED_10.
> When the network cable is not connected, set cmd->base.speed
> =SPEED_UNKNOWN.
> 
> [...]

Here is the summary with links:
  - [v4] net: mii: Fix the Speed display when the network cable is not connected
    https://git.kernel.org/netdev/net-next/c/f6f2e946aa4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



