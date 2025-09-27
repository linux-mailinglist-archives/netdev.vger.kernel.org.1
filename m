Return-Path: <netdev+bounces-226911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40FCBA6136
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EEF4A5E0B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D762E1F00;
	Sat, 27 Sep 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuShYXzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624272E11AA;
	Sat, 27 Sep 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988294; cv=none; b=l2pAX+THleAYErZRbQAFSdL0a39VKeZLFo39TOBTWdos+ILtSeIW7TcZW8k6dkz8ZJ82ff9OSDU7PfHCyoXWA10aRDwgIy/MVrVixHSuV/6ZBdZQvTrSsPnhJgkPKH14JjUIW8Wzhq067nYlUgCtb9o5JK5ibVKZOxYqI0ntLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988294; c=relaxed/simple;
	bh=cKzCgOePCTT0/LFtdUTfpCpD/99k18i3atihjnw/Ta4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zo5adYFiTkejT1kyaQHAyZ5QM8M2kF35RlbyrNZacqKrmfoFCFqUxzIS6G/fk5cVAdxDK2dYamidXiCMXNWpwAvOqXTUy+v/Kg0F2r4rp6cxowjr/hVL8DD1kENvnMmksCU+jS089fFpdIiXyHGVBEwQOfNRFHE0evJ8j9zGs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuShYXzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0130C4CEE7;
	Sat, 27 Sep 2025 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758988293;
	bh=cKzCgOePCTT0/LFtdUTfpCpD/99k18i3atihjnw/Ta4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TuShYXzcqt9YX4V8QwYjpdouHtGAeQn6mmvC3vk68RzAXapJq3/oXHNtWzD0vD8bi
	 rvcpX3+ATA2cMD4xD1qQDsi3FwkB/vS4aHNLjkh9S8zM/LShZrxOvRaKvz5++DcWAm
	 meIRJzgO99RQAK/9yhkkJCmWx2PZv2ODT84drryEDppjMatkPbVapn2iqRueUW+FOW
	 vAaeJoSzc3UtwfccAq4z2f8uRDGMsQgif1+km8bHHbP3J4BmVBKBdSUxYBc1l0GsDB
	 Bghm0o9WzJarMcM7jNC5d9JmxwoUUHZoUbEV8yrgateFxFa0g6RC5Su36CzgQT1i+x
	 KzvEvi9y1acYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC339D0C3F;
	Sat, 27 Sep 2025 15:51:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-09-22
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175898828885.278003.6901521200536343898.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 15:51:28 +0000
References: <20250922143315.3007176-1-luiz.dentz@gmail.com>
In-Reply-To: <20250922143315.3007176-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 10:33:15 -0400 you wrote:
> The following changes since commit b65678cacc030efd53c38c089fb9b741a2ee34c8:
> 
>   ethernet: rvu-af: Remove slash from the driver name (2025-09-19 17:00:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-22
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-09-22
    https://git.kernel.org/bluetooth/bluetooth-next/c/3491bb7dae5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



