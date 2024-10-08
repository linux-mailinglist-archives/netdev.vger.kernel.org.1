Return-Path: <netdev+bounces-132921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA10993BA0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE19E283898
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8136AA1;
	Tue,  8 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIDiF6dL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051520ED;
	Tue,  8 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346827; cv=none; b=fjpqS8LOlq8KAsK0EiahdHBaseVfccMAm7DjPn8R8uwK10fYaZPrwTcJGMc0Bx/0dJytB2j+jiK0s3xzYsB8FJr/jDz3MMPbPq7y8aYsNVVUPDFDltiFhTR9FE2QE7O6g7jWH8m4t8nUZxC0XM5cnDtxwvOQJ6WpELbuw/tcWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346827; c=relaxed/simple;
	bh=Q6766DG4cdHnSnIF+A+ih2RPc+QKp2dbPZAGXtcQcR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VBfaS+HBHS2XIrc82aQxv7hYDncdRrGg3Njev7XfIW8a29mfG6ROwNFOriPquXidTHpPk+Typzq4ioKj1kqmwqfVDWmBTIXxnUytFvleU8xcSbMILmorHxOBKv76ztOclPYmdQjxKvUko2jIhVVCr3PUjpxcvMILf+NBGeAgPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIDiF6dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE91C4CEC6;
	Tue,  8 Oct 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346827;
	bh=Q6766DG4cdHnSnIF+A+ih2RPc+QKp2dbPZAGXtcQcR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IIDiF6dLEl+ECBfiqqtpt0B9x6Gj78IeYaNMeKU8n4gBia9jwiWWTHIOMnvr73epn
	 v4uuj1eTCzW5lDkWraUhX9GwUEF4uxGmgG+93TD+g9akzuNiIYOc+Fn22x0uF8Jyni
	 nAi8Koff6ciCxNb57jQ6QdRqSft/17o69xCNAp0a5soF8jfB93LPERPyUxH6EW7bR6
	 ak/pBJaqaOsLsrXm61BwDM8ENWIVZdx5V5vmcyYRpT3SMTjDoR3aHFL4szGWBML5Fp
	 lXYHsfNZRB7F0hgHV5lQJQXTLngSauJHVxihzwL/mPS8s6/bzu+HU78/aDwxA9mLMx
	 zBBClnUamWEbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2C3803262;
	Tue,  8 Oct 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834683125.26998.2164850499316241911.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:20:31 +0000
References: <20241004210124.4010321-1-luiz.dentz@gmail.com>
In-Reply-To: <20241004210124.4010321-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 17:01:24 -0400 you wrote:
> The following changes since commit 500257db81d067c1ad5a202501a085a8ffea10f1:
> 
>   Merge branch 'ibmvnic-fix-for-send-scrq-direct' (2024-10-04 12:04:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-04
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-04
    https://git.kernel.org/netdev/net/c/f61060fb29e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



