Return-Path: <netdev+bounces-21704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA5576453A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BBB281FEC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2F1FCE;
	Thu, 27 Jul 2023 05:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1021FC5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F506C433CB;
	Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690434021;
	bh=6ZqyZTfrDHK1KcPgN9vpWEKlOV8I3D4LskAZkpLhZT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FMIrIvBmD3GGAyfwM2x7A8cOzBz4JzJQVhGPJwLJA/+qD4ynUGGCv3TUzJz04YyLQ
	 Lnry6rTJ4XYOKiYTIgEiBzhoWfc0vrVqYsqSr3TMJNyA8Cq4+oWF2SYvbXqW3ndHxA
	 ZV0UXEMlDCjyFzAkgSdaFpiNZUrZmx93XZXl7kSX3kj3aXwFZXelAQpm2YVWsSaABn
	 6JhrVA3M5e9KUqfaK1dRpQI3BqMFIgK32t1muWPIDgVCslcSi3eL8W5jJrvpeID1L2
	 2FOsEl4DNhCJHCeUWz/RyNLfjEGn+wwNmZv9aZCk3YOC58PAMEni59MQbkxjAuxtXK
	 DhCq0H6iX47AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84C5BC691F0;
	Thu, 27 Jul 2023 05:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlxsw: Speed up transceiver module EEPROM dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043402154.24382.13793232703356545994.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 05:00:21 +0000
References: <cover.1690281940.git.petrm@nvidia.com>
In-Reply-To: <cover.1690281940.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 14:04:00 +0200 you wrote:
> Ido Schimmel writes:
> 
> Old firmware versions could only read up to 48 bytes from a transceiver
> module's EEPROM in one go. Newer versions can read up to 128 bytes,
> resulting in fewer transactions.
> 
> Query support for the new capability during driver initialization and if
> supported, read up to 128 bytes in one go.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mlxsw: reg: Move 'mpsc' definition in 'mlxsw_reg_infos'
    https://git.kernel.org/netdev/net-next/c/68bf5100fadf
  - [net-next,2/5] mlxsw: reg: Add Management Capabilities Mask Register
    https://git.kernel.org/netdev/net-next/c/7447eda4065e
  - [net-next,3/5] mlxsw: reg: Remove unused function argument
    https://git.kernel.org/netdev/net-next/c/3930dcc5e404
  - [net-next,4/5] mlxsw: reg: Increase Management Cable Info Access Register length
    https://git.kernel.org/netdev/net-next/c/c8dbf67883db
  - [net-next,5/5] mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks
    https://git.kernel.org/netdev/net-next/c/1f4aea1f72da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



