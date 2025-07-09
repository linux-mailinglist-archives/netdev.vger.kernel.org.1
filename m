Return-Path: <netdev+bounces-205194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B1AFDC44
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C294E6AB7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683C10957;
	Wed,  9 Jul 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY0ieNNu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06A1F948;
	Wed,  9 Jul 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020389; cv=none; b=SxzcKCBZfj/t/sV3jSy2RUIycY/IK51OyTreVGo9ROTJoyniX2yzP6ISTvj3Lu0qkZRHcN7TOH1DqSSlUn+7gd/nWCz4oiHuUIZO82TQDrax8kdTP18qGxR34MuZo/10Ig91Iw3A89+Kp35rHpkOG/tSAoa4lS0e9eXYsN8lPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020389; c=relaxed/simple;
	bh=v/nB2GgBn6O41u7c1Ro7V1Hpmn8qRlodUdQFWYOnF0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rXBmo3aSdm9SveWkwnyP1qN9hhVu7gFN6tPoojEEAJXoS9+ZbB2gmqsh7z9bk3o5RqrSkoZPM4es6yWBnNJu3u5RZ50/ODawAMHwreoZIxdBsC6KbPqfMIjNdLmlIERPy0h2Oa0WQ4pDefG57RLhNSn+9fmJnj600TmJ7LrBRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY0ieNNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC5C4CEED;
	Wed,  9 Jul 2025 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752020388;
	bh=v/nB2GgBn6O41u7c1Ro7V1Hpmn8qRlodUdQFWYOnF0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZY0ieNNur62rcbKM7jWXWvkoD+obcpPKsjvq08QMHd4Go+eoVqItTQ9c5HerJykkn
	 NUerlhVbTvTy7XYPLthIobuiivp+FfSij3TYbM5RCgy5aS03XfLiTkQAsb7dqKKdJ8
	 RKk0I4K3ZpLUhtE+zUVjdOyvbuOZOIvm7p8UdRyANSGI5eeSFzfYGi1rgpN3+cEnsu
	 N1aSUjXLXcNA0PTc4bdSPR7qG76GBfP0oVTZBXIG3bmOJ61kD+kti1hiQPDj2beiVE
	 6dJcHaNhMrBJKpiCH8yN/7+VkUMicbAShZChxPDJCFgxhFQvL3Lg7Vm46o2yhp+cG1
	 e+oHSaeXB0lHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7129D380DBEE;
	Wed,  9 Jul 2025 00:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] eth: fbnic: Add firmware logging support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202041127.172847.7768220901270765799.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 00:20:11 +0000
References: <20250702192207.697368-1-lee@trager.us>
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
To: Lee Trager <lee@trager.us>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kees@kernel.org, gustavoars@kernel.org,
 sanman.p211993@gmail.com, mohsin.bashr@gmail.com, suhui@nfschina.com,
 vadim.fedorenko@linux.dev, horms@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, jacob.e.keller@intel.com,
 andrew@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 12:12:06 -0700 you wrote:
> Firmware running on fbnic generates device logs. These logs contain useful
> information about the device which may or may not be related to the host.
> Logs are stored in a ring buffer and accessible through DebugFS.
> 
> Lee Trager (6):
>   eth: fbnic: Fix incorrect minimum firmware version
>   eth: fbnic: Use FIELD_PREP to generate minimum firmware version
>   eth: fbnic: Create ring buffer for firmware logs
>   eth: fbnic: Add mailbox support for firmware logs
>   eth: fbnic: Enable firmware logging
>   eth: fbnic: Create fw_log file in DebugFS
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] eth: fbnic: Fix incorrect minimum firmware version
    https://git.kernel.org/netdev/net-next/c/dd62e960a755
  - [net-next,2/6] eth: fbnic: Use FIELD_PREP to generate minimum firmware version
    https://git.kernel.org/netdev/net-next/c/e48f6620ee81
  - [net-next,3/6] eth: fbnic: Create ring buffer for firmware logs
    https://git.kernel.org/netdev/net-next/c/c2b93d6beca8
  - [net-next,4/6] eth: fbnic: Add mailbox support for firmware logs
    https://git.kernel.org/netdev/net-next/c/2e972f32ae5f
  - [net-next,5/6] eth: fbnic: Enable firmware logging
    https://git.kernel.org/netdev/net-next/c/ecc53b1b46c8
  - [net-next,6/6] eth: fbnic: Create fw_log file in DebugFS
    https://git.kernel.org/netdev/net-next/c/432407c86993

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



