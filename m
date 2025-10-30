Return-Path: <netdev+bounces-234211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D6C1DDEC
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629004E550C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80813A265;
	Thu, 30 Oct 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ7m8ghH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B28126C17
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783032; cv=none; b=P8j1LAdKP7UysZjHx+WkpeZR7jwpNQxnzqaFZgisvMqgUkTsRino06xCxdo4iQa2GKh5FDR9TbARrIP63HOElOVZUDyGlXhafjrjh6wbG9oyu0l7IF0YQFMS55LDcrYz/AvQ0dAEUQx25FCLKnzhYVCK5TenxALKQ552ajUsIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783032; c=relaxed/simple;
	bh=skroI1VKh5OM6Dv3AIDK6hEF/pTAByKB8Y8b3npTK9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HiC+poxcHAo9aHtdrrT97xsxcCkWVTD1IOAb4oIgblR9x2nAZ/U7QT+At3qCXY7PCGBqqIqwZauepDjTJkQRWFXtg7ZWz6VTMvX/yhAM3y3XYI1V9S+HGroUKgNFW5R3zN+USaMsshUbR8OlswJQxuY6G1HMGgHWjad7jXaXLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ7m8ghH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFDAC113D0;
	Thu, 30 Oct 2025 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761783032;
	bh=skroI1VKh5OM6Dv3AIDK6hEF/pTAByKB8Y8b3npTK9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZ7m8ghHe/mkwP7Qb2s/hk9E4VxMadOQCgIOqWVk/tX42t4cttl3QAB0Zjjl6ZDdY
	 +YhxjfvTlNrfkwYvkEO47w/J/8FU8QZIK+vJaC5Ol50YPFN0sCm6S+q2pjZe7tcEyD
	 4KnUNBi6PpmLY6llPnvuMcIbZbUlqp3gvzcY7k3/7TdqPLsAZta4P6uRLQfmZRLj3P
	 9xmfSWTY9kR24qqHl5Nvk6P6jk4aSSlfBGMUApFQYVPJtdLkuBc2Eyz8ed834UfW4R
	 fkkz2+yDw58KuNQzrVdikCUMgTD9n7RHeTUpkz+pElbOq5M9WRTUMMF3pdK3j2qlZc
	 HEL4iTJR0Hp7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F583A55EC2;
	Thu, 30 Oct 2025 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] devlink: fix devlink flash error reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178300924.3257162.1981164448450104191.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:10:09 +0000
References: <20251022122302.71766-1-ivecera@redhat.com>
In-Reply-To: <20251022122302.71766-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, jiri@resnulli.us

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 22 Oct 2025 14:23:02 +0200 you wrote:
> Currently, devlink silently exits when a non-existent device is specified
> for flashing or when the user lacks sufficient permissions. This makes it
> hard to diagnose the problem.
> 
> Print an appropriate error message in these cases to improve user feedback.
> 
> Prior:
> $ devlink dev flash foo/bar file test
> $ sudo devlink dev flash foo/bar file test
> $
> 
> [...]

Here is the summary with links:
  - [iproute2] devlink: fix devlink flash error reporting
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ab785eff0b1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



