Return-Path: <netdev+bounces-114762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22605943FD6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0761F21E80
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAE13D510;
	Thu,  1 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwbrO6wH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488B42049;
	Thu,  1 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474032; cv=none; b=U9U/imgG/xDA9YmGFyVS+B+b/TFJqz6ew8scYkvwJ1mlDcOYSFkZHK8j8MJg6L4bSIIW7HiEpuQjJjEJxJT4kC/kflAAQSFIzcLcsHl2A/LDPxJeiSiIIDb/QUh+klM/ibj1XRzxY4Fa84HnJgRKHLbYWWWEDqmyebSv8fBfoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474032; c=relaxed/simple;
	bh=Ulsuwo6JX0StKa/83XS6uMQHzHubaYa4OFec5QRrMbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xe4TPelgqNhBzjP4yTPZNdmcZlcRuFejG/CMDNWDKQFYMNf1rNPaEoIOFMRzAajKxa1SKKNmbSvSqUFvLPKXBWnNMPYH0waARDV3dLgsJ1wdDjsSXf/iFjDVVepO0wN+YECB983Qq/TX41D7IYs6WJ3oE6/YPQHbXkwW7v27g38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwbrO6wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C006C32786;
	Thu,  1 Aug 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474032;
	bh=Ulsuwo6JX0StKa/83XS6uMQHzHubaYa4OFec5QRrMbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwbrO6wHvo24iUE8YxlJ3o4t892hTX7zcnOoZ/j8X2Yu7yFmqMnQlVhsbNeGTB8sr
	 SXBGup8cfyVnW15CuqNME3p4+SM5Q1UePKTGyVLbN0OBfEa4UPYDKp+7lebXiUkYoX
	 Sb/GzlhNHYjvM+ZBn2TgIVHryPXRwEveFvAq4yNDgxgGgyuHRRji2LmUm0mAz9QAl1
	 kXhtbbkJF8XjHuhiIVjF88YTTXSA7Er6U6na5zcPC2KqRAqPBMNTvoxxLdqsZnuPct
	 i08GJkFbupAhDjseQ/+y3XeFuz8DBOImuHy5GsCH23sDwmG6n+3cDQo3c5iU+Xu0M6
	 P5WLX6eHrGxmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 589A9C4332F;
	Thu,  1 Aug 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/mlx4: Add support for EEPROM high pages query
 for QSFP/QSFP+/QSFP28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247403235.15978.16457678129878308101.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:00:32 +0000
References: <b17c5336-6dc3-41f2-afa6-f9e79231f224@ans.pl>
In-Reply-To: <b17c5336-6dc3-41f2-afa6-f9e79231f224@ans.pl>
To: =?utf-8?q?Krzysztof_Ol=C4=99dzki_=3Cole=40ans=2Epl=3E?=@codeaurora.org
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, git@dan.merillat.org, moshe@nvidia.com,
 mkubecek@suse.cz, andrew@lunn.ch, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 17:49:53 -0700 you wrote:
> Enable reading additional EEPROM information from high pages such as
> thresholds and alarms on QSFP/QSFP+/QSFP28 modules.
> 
> "This is similar to commit a708fb7b1f8d ("net/mlx5e: ethtool, Add
> support for EEPROM high pages query") but given all the required logic
> already exists in mlx4_qsfp_eeprom_params_set() only s/_LEN/MAX_LEN/ is
> needed.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net/mlx4: Add support for EEPROM high pages query for QSFP/QSFP+/QSFP28
    https://git.kernel.org/netdev/net-next/c/9c26a1d0a01c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



