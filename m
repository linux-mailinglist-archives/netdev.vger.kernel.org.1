Return-Path: <netdev+bounces-17338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28A751500
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CEB1C211A5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33C7C;
	Thu, 13 Jul 2023 00:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BC364
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7772CC433CA;
	Thu, 13 Jul 2023 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207023;
	bh=MavSjlGKcYn2yjRk0ozRodeYLLE4Kimk3wsFUBdCaBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l374Z/Jx/oLevkEyEUgXFRS1UEaGuSvQhDQpSOSVpxU1799HGz07YmC1rrwZa0Z04
	 97GmdZGlGCN83D9+3YOMwLMhh9PvtXZysEu6znGPZ+r3Ham/Yo9w2AsWhpCf44wrUU
	 ZuFe9uqd5Y6cUNiaosQ4fZw5FjlocFSfQI5abAmDGKxTjZjIEl8TfTzclaHCdKbebh
	 lLTr9uH5HcA7gMhYhqhZTTt3ALY3WepmV5QliV5XZ6QYxPdeSDUxEGu+PTFsXgu0cJ
	 JT4RRWUuKr0Pzd5ZWOFwE1Q7XLZPacyd6bcxdNF1Y5C8j4MDfyGlSSxbRdo9zuA0H0
	 QfI57maE7ii5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63207E29F44;
	Thu, 13 Jul 2023 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] mlxsw: Add port range matching support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168920702339.12941.13651311813642341195.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 00:10:23 +0000
References: <cover.1689092769.git.petrm@nvidia.com>
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 18:43:53 +0200 you wrote:
> Ido Schimmel writes:
> 
> Add port range matching support in mlxsw as part of tc-flower offload.
> 
> Patches #1-#7 gradually add port range matching support in mlxsw. See
> patch #3 to understand how port range matching is implemented in the
> device.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] mlxsw: reg: Add Policy-Engine Port Range Register
    https://git.kernel.org/netdev/net-next/c/f3b8bec7d29e
  - [net-next,02/10] mlxsw: resource: Add resource identifier for port range registers
    https://git.kernel.org/netdev/net-next/c/9f53a7602ac6
  - [net-next,03/10] mlxsw: spectrum_port_range: Add port range core
    https://git.kernel.org/netdev/net-next/c/b3eb04be7299
  - [net-next,04/10] mlxsw: spectrum_port_range: Add devlink resource support
    https://git.kernel.org/netdev/net-next/c/74d6786cf2dc
  - [net-next,05/10] mlxsw: spectrum_acl: Add port range key element
    https://git.kernel.org/netdev/net-next/c/d65f24c9fa69
  - [net-next,06/10] mlxsw: spectrum_acl: Pass main driver structure to mlxsw_sp_acl_rulei_destroy()
    https://git.kernel.org/netdev/net-next/c/898979c7238a
  - [net-next,07/10] mlxsw: spectrum_flower: Add ability to match on port ranges
    https://git.kernel.org/netdev/net-next/c/fe22f7410527
  - [net-next,08/10] selftests: mlxsw: Add scale test for port ranges
    https://git.kernel.org/netdev/net-next/c/45c5a384765b
  - [net-next,09/10] selftests: mlxsw: Test port range registers' occupancy
    https://git.kernel.org/netdev/net-next/c/0a1a818d8a1c
  - [net-next,10/10] selftests: forwarding: Add test cases for flower port range matching
    https://git.kernel.org/netdev/net-next/c/209218e4799b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



