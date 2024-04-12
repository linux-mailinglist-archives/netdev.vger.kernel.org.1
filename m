Return-Path: <netdev+bounces-87237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 241DA8A23E0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8EEB236CB
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469A14016;
	Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti0HkGPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFF134CC
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890231; cv=none; b=qsV80yWxlum9b27EIa9WA6AJg4Q8DqvJmFhMFe8c83TOmAOn3WAW3dK9zGnlgKIwb1//3HBqVmhaGpPHYtiWoHgg+U0xuKyyL4XJ30YaXdSmtJ33zEBN2Oh695FTyhwMknEZUtHUXFt1FLLGya9hTUv1hg3FXkAKoU+W1kRa5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890231; c=relaxed/simple;
	bh=tSWlssvUOdNYHJS81xlt2hG0WFDJec0dNkgTSqzYrBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DEk0nE7qlGSZNUP7ttIkKVjiqMMQeDlSxTXQmcfEHolMUZ1HahsbIe7NRGUcGqa5idMpVSpTKW68TgaWSP7EUD7nsF5wbG0kFHfh4bpB7wLugVAOqH9Hj3kC3FfkImp7lhjY8zMR0aAU1dthnZf9546HupWJKN5keqThiogxpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti0HkGPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E35C072AA;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890231;
	bh=tSWlssvUOdNYHJS81xlt2hG0WFDJec0dNkgTSqzYrBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ti0HkGPvTFVMBJQq0sM11/wrO0M3rrJTKY0nKeluNmoL/cDOow7dWQ4vJJ3sGcABK
	 xgNu3rF1el9NKp3p7u/pbvxxSu3PTDsa+jkLzw7iRuIKXqoeRJJs/6nlXlbXTOaa7G
	 ZSEhxB9Ho+CaIKr0JlcsZdZA/Iu2yesrqJ6O+UNHDrbp780I75se6BwJWW9pWjhmTC
	 CAYijaxTPlOcTuzHhX+ruKSi9LX7oYzETt7uzxf5YcXoFMOgkjYJ5u+oGop42QXX32
	 G/8eYbdAyaY30/DfFwjedkXhc4qihWRVfJzSZGLNIxeI0TCaQA9BJLPGva7qfs+VoM
	 sP5zc4ttKyyAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4A75C433A2;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3] net/mlx5e: Expose the VF/SF RX drop counter on
 the representor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289023093.15367.25746390794985987.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 02:50:30 +0000
References: <20240410214154.250583-1-tariqt@nvidia.com>
In-Reply-To: <20240410214154.250583-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, cjubran@nvidia.com, ayal@nvidia.com,
 rrameshbabu@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 00:41:54 +0300 you wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Q counters are device-level counters that track specific
> events, among which are out_of_buffer events. These events
> occur when packets are dropped due to a lack of receive
> buffer in the RX queue.
> 
> [...]

Here is the summary with links:
  - [net-next,V3] net/mlx5e: Expose the VF/SF RX drop counter on the representor
    https://git.kernel.org/netdev/net-next/c/919b38a916b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



