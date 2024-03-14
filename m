Return-Path: <netdev+bounces-79869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C088387BCD3
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F2A28446C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83A6FBB8;
	Thu, 14 Mar 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GekcRJPi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCA6F53D;
	Thu, 14 Mar 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419429; cv=none; b=CPHaz6x5CHQ8J27LkdBU+aXc9ma/aUQppHe5jU49jAcYlOoA8VvWdJcAS4LT7jIz61eyMwzTx9D4Hs5Nsc1RCnHSeDIbwm8ffAvBw8IUHK0VgGoy4heQEkHW//Bc94UhrzJnNZi1t8suqOKqe9V8cawE0fN3/nmkYQgCm8eFSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419429; c=relaxed/simple;
	bh=J2RgDspDz9zB2B0ZFrAgSC1an1n2rKhxw3KOCcNPe7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLjeCOGxUziMEdwzgvrFjEcPvqQmcOSQDOY34tBd/qrymKYKy36bHKLe+NoDktowWjt2xtXgyLvlwLBQOTJu96Ku+aoeOtyY6O40eeOwr0Qe080Aq40wTZMX9T7iNTeQk8ahNAUQ8uA3bmYmHWxSfLvtgrzBZCVHUYjI/Cjf7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GekcRJPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79286C433F1;
	Thu, 14 Mar 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710419428;
	bh=J2RgDspDz9zB2B0ZFrAgSC1an1n2rKhxw3KOCcNPe7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GekcRJPiaMgj7EkuWKYsLa2RAXOHqdf8JMlZdbxOBJ4cmNlY/ocbqOgPkKWTy1oDE
	 BS7pyOCPKZcW0m4Pwmy91EAqg8Ax01D8JCJqcT7dArDxEk2JX8J9IXcjL2ybcyITpy
	 cyNPiX81/vqnnUjXS5WN1eXwpPg05IyLPBmurdz9eRyFu1j0B05VbfIZzaSroDWizg
	 azY+ctbNRA0faEhYedtahoHq2eVkveub3cQgiPnLH5/T6t6J0sJ+GOkEnOBl13xYxD
	 5Pc36DJYy1CELgw3uR9/OTcwoKEl2C2IG3hZNOLtBxypF4BJ9kqiAkcV2hJ5a9sPNu
	 1vwMs7MXL6wxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6840FD95055;
	Thu, 14 Mar 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: networking: fix indentation errors in
 multi-pf-netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171041942842.26728.5742592401938580391.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 12:30:28 +0000
References: <20240313032329.3919036-1-kuba@kernel.org>
In-Reply-To: <20240313032329.3919036-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sfr@canb.auug.org.au, corbet@lwn.net,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Mar 2024 20:23:29 -0700 you wrote:
> Stephen reports new warnings in the docs:
> 
> Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected indentation.
> Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected indentation.
> 
> Fixes: 77d9ec3f6c8c ("Documentation: networking: Add description for multi-pf netdev")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/all/20240312153304.0ef1b78e@canb.auug.org.au/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] docs: networking: fix indentation errors in multi-pf-netdev
    https://git.kernel.org/netdev/net/c/1c6368679979

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



