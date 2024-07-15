Return-Path: <netdev+bounces-111541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BE9317E0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1681C20E30
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E48125B9;
	Mon, 15 Jul 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFiYflHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AF10A24;
	Mon, 15 Jul 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058638; cv=none; b=RnPuqWb/q9T+ce2LLVnCWxBBFyS344IjGBjEqibwek+FjF3ZbwhiWKouiWOZPHApmAJ4GL2qw+ZlqiA4TuPRLjcxBorgYXTVythBjj4IxECWDjqItvF8WrU/hEplnZkyOaDQtTq8w756Knnv+O6PuPlRud02VGMT6EtYwNm8J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058638; c=relaxed/simple;
	bh=QssDV5F/1+NqZXTi1/6udd41BVsS8TRv09WruBusyuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=otGCDRGO7kAVke6MkPtGMTFDqVHTqkHg/wyV8nWbYRbuqN9JMVkML02qwL4Jt38nHoEbhGCBUIpDtO+jV+TXsDdOkQm+elj4bsgEMHgPWm1cw9QeDcHkBxFfYn2emvspaVvcBmVRjYlzSqyLliDKRu3iIn9bVkFhMmk+v2llbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFiYflHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75813C4AF12;
	Mon, 15 Jul 2024 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721058637;
	bh=QssDV5F/1+NqZXTi1/6udd41BVsS8TRv09WruBusyuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NFiYflHnSKyaBcS2UJhvHYNPwFANYviTqwuV2mfURnWlCck9mL4Q9rJSkyBB7G2rN
	 cxQgibfRxbzrN9x/X3Gh7V3YKESNd3Ss/mMjJ1/RwtI0t0RzrouTIpGHZhPb0K3Lvm
	 K9fhvuSYi17hL1xxaugFXY87FtGVctfnt9GeU4ZWUA/d9hbudl9LwMz0RgCMVaJ51G
	 r9YKnBmrWnF7+pHO269hRvUouA+mFdrYCkgAzhrIFVbOJfygobVR5CPtrHWloQogez
	 GgFOx6RPGD+bK55eZmsIUkuu0SbyY8WcUOp8U44n9TZIYdToWWnEug1fZqIQ6qsOhB
	 /RIWMefJtGCAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6460BC433E9;
	Mon, 15 Jul 2024 15:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-07-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105863740.27506.12607157949653999686.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 15:50:37 +0000
References: <20240715142543.303944-1-luiz.dentz@gmail.com>
In-Reply-To: <20240715142543.303944-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jul 2024 10:25:42 -0400 you wrote:
> The following changes since commit ecb1e1dcb7b5d68828c13ab3f99e399b4ec0c350:
> 
>   Merge branch 'introduce-en7581-ethernet-support' (2024-07-14 07:46:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-07-15
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-07-15
    https://git.kernel.org/netdev/net-next/c/cd9b6f4795e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



