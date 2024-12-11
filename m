Return-Path: <netdev+bounces-150937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30759EC223
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B29163B66
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B41FE44A;
	Wed, 11 Dec 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob7gNB92"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA61FDE38;
	Wed, 11 Dec 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884225; cv=none; b=Qo+NHZ3ROkTHjMUbPGFnXroIzdmtcIbnDO2wUd2rnoBcWL5Ph/7ve69xvDsKi4p8VdP0JNJszYjnozvYWiH9Nhe4f8g1WP1iJJHVQ9K0caCbkDgmT3YUB5xUze5P+rp62b3AxBCR3QIqEcttHU1HEBjM4h5OBVzdHoZ0T5BFmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884225; c=relaxed/simple;
	bh=pc2MQPbAvIERSWwlHw2ybqImM0rR2QI5xFBUQeZKNKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHId/6dme6m+i/UF8dxZCkskX5WPEz6WTB7eRG9RE02uJGzG8LMYnCVvtcudFgxJ0MzvckWqG5+M31+c38WIZ0jc6s2+1DkUWgUNcBL0maC7zjxwz80QUUcfLq3ZSwmVq/9KJKbmhKIcET9bjJjPHuYfSk1P5qYLz07KTiB6nCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob7gNB92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D0C4CED6;
	Wed, 11 Dec 2024 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884225;
	bh=pc2MQPbAvIERSWwlHw2ybqImM0rR2QI5xFBUQeZKNKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ob7gNB92DRcxXT1bEF1Q5UPS6fX5MLJD8xbS/O9p4/VsRKRHoTc43jmilra82EmxI
	 Ex/ir95bwZVb4pYhmpPRsiGVs9DuMTM9w+M4iVIP1kCYjwJF/VkQmEvx66ICnxn1cx
	 9fdQuv+Ji0NBak1/dBMNqRU67gOl86DLsucK47C0qYHdmB/vSZQvcIuMo93xwHfvSt
	 WPdqtVLSq7fgsovOhJ3kZocgbXIr4CcBzVW3gyMa7hOERGRhcZqVzvYfZVluQtSQIx
	 QrB1ZTx6x+Lp7lJOInJMlmX+9fSgKcQMWDiBIHrxObS1JdoSZrLKyIq9L9vtoRa/wZ
	 xdg1O/Iz6rJfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715D4380A954;
	Wed, 11 Dec 2024 02:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hinic: Fix typo in dev_err message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388424100.1090195.1669181628771165715.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:30:41 +0000
References: <20241209124804.9789-1-algonell@gmail.com>
In-Reply-To: <20241209124804.9789-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: cai.huoqing@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Dec 2024 14:47:30 +0200 you wrote:
> There is a typo in dev_err message: fliter -> filter.
> Fix it via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: hinic: Fix typo in dev_err message
    https://git.kernel.org/netdev/net-next/c/6bb6ab852c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



