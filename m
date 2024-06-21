Return-Path: <netdev+bounces-105505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A427911878
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB58B210A9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DB14290;
	Fri, 21 Jun 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJu/dmv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CC3207
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937029; cv=none; b=sf1RAsxBzuLid+3YrxQ35gFpfcE8tDCTB5pQc71epaCajS+qTVG+DM+DBElSbBB31GwbjsrXRQPf17dWDDBx7TC6vRxXxM70VHw9wAN1PmcXgykL0h5+YekA7187imSK57ynleBC7Zew+q1JAlpaRZrqqq0FZJs0/pUdCwBK8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937029; c=relaxed/simple;
	bh=X8zDz+rD5kpZYjrGkeBRsU5cpWFRg9LfncPi3bnZhGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=psyuG3TqgyCYLnYuESEgRSiwQ5MphFzn1XqMRWQbMaxoHlfpDlI8pVmG3K4bekOVBvi9lfZtOX7Gy+Fb5ORya7X7sOMlxBGJ/YQuYEacdQl/QEEXIUKzYg0GBE22D0/ToO9HOzFTY4s3q7QfGfoV69FPB93LEpfytQ6oMrv1sJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJu/dmv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 568B8C32786;
	Fri, 21 Jun 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718937028;
	bh=X8zDz+rD5kpZYjrGkeBRsU5cpWFRg9LfncPi3bnZhGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uJu/dmv6mZkSNaYmQkSQXt2hfM1EUbEF51hcKMx/j/bJ1GOoKZ5LgVMrnU4COuYKX
	 64r3JiChqRucy0EHFHqP/1nEmdekYKUxEJ12iCCkx4JIl1qpmn7ukIcZFYMVh9v62H
	 jrKIgP19VFKbi6jjGKm1uCTuEwZpmQED/dtSouqjlBg0DxgPINmEIjNgn5iuoAt2C2
	 YIWXRhijvHC9tnUJExpUijOCcPXz6eZ+yr7+AkXl6Dc1cxue9KBQgp9Kmc+39A//Nr
	 sbTrEO/ze7+AMkSeAJwpxI6azkQNkRMTU7c65P4Tn7rAbHJofXeb6yilapCT142FkY
	 /0lawlAar+axw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43FEEE7C4C8;
	Fri, 21 Jun 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next] nfc: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171893702827.2352.16615104679037190332.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 02:30:28 +0000
References: <20240619195631.2545407-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240619195631.2545407-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: krzk@kernel.org, kuba@kernel.org, oneukum@suse.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 21:56:31 +0200 you wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Here is the summary with links:
  - [next] nfc: Drop explicit initialization of struct i2c_device_id::driver_data to 0
    https://git.kernel.org/netdev/net-next/c/0d6b1eb660be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



