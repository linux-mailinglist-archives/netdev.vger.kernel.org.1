Return-Path: <netdev+bounces-224098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39054B80B5A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30BE7BACB1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D19341378;
	Wed, 17 Sep 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO82zLSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B17341374;
	Wed, 17 Sep 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123605; cv=none; b=XPqzIr9KXJVOltQahmzltTYZBcK+t5VegizWI739o8YE4Ekf5lYxEsVOoYUdWYdpAYSGiUlMIS6qSiNaMMHVj/6Q/9y4XPbf1iSzBazH1CB4v9qdQqa0PJpRhGzg69nrI7nCytsLziwkaG1xmQh5/8giXugF+842pNUVmhmgxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123605; c=relaxed/simple;
	bh=yN/U/jhwhDljjCnEG6NxhXzHQCHYjmUdn1DRxaE/3Hk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pU6xF9eNFrKjnkw8QzY5xIi4GPWdv+zmB5ycmYtot05SaJS7tAAsoJOq14kWwHXnF5rkBb54BoV9nA6W9F0KeJ98gwgU1dNWKXdWkKw5OSuEe5H/9PLfAz53XuOclhiaWx9qj4mw7WJERno5XCptLqxNJbPd805abBfPK2k5WSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO82zLSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A269C4CEE7;
	Wed, 17 Sep 2025 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123605;
	bh=yN/U/jhwhDljjCnEG6NxhXzHQCHYjmUdn1DRxaE/3Hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fO82zLSZNMmm7aqB8df19tB6ITe4K3DCVGGI2E4sc3NugRYrMdCtDY2M4gNtoy6DO
	 OtLo4sbtY4vZ4k9V2BYYzSteL+R0nK1BoFfJqA4gT2K2knEPiVyMAN69XzQ3dc5Xwq
	 j5SiSb2dCe2si917JJ/ZJUFJKB/82LyQX/Wd6kEWeVIFjZokI9ZiD9whLk3zkdaXCx
	 kIghApnHpoi5zY9sXK+T4nKRyvW4mNKU+FJm19+hR6nHbwvBLzbofJXPCjjQmkigvj
	 shzxnkyyb+FxiYGVS1kUsVlMX//+spuE5ElDFw6A9JWHp3wf3TsiUwy8P6Fqh1X7fp
	 qcT6Bzt5XryUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1339D0C20;
	Wed, 17 Sep 2025 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] mptcp: fix event attributes type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175812360603.2048620.7321956968651605409.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 15:40:06 +0000
References: <20250916-mptcp-attr-sign-v1-1-316aa96b93ca@kernel.org>
In-Reply-To: <20250916-mptcp-attr-sign-v1-1-316aa96b93ca@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, mptcp@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 16 Sep 2025 11:24:33 +0200 you wrote:
> The 'backup' and 'error' attributes are unsigned.
> 
> Even if, for the moment, >2^7 values are not expected, they should be
> printed as unsigned (%u) and not as signed (%d).
> 
> Fixes: ff619e4f ("mptcp: add support for event monitoring")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> [...]

Here is the summary with links:
  - [iproute] mptcp: fix event attributes type
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ccbd9b64d666

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



